#ifndef __OCT_FPGA_HPP__
#define __OCT_FPGA_HPP__

#include <string.h>
#include <xrt/xrt_device.h>
#include <xrt/xrt_bo.h>
#include <xrt/xrt_kernel.h>
#include <experimental/xrt_ip.h>

typedef unsigned long uint64_t;
typedef unsigned int uint32_t;
typedef unsigned short uint16_t;

typedef struct {
    uint32_t their_ip;
    uint16_t their_port;
    uint16_t my_port;
} socket_type;

// Number of bytes per UDP packet
const unsigned int BYTES_PER_PACKET     = 1408;
// ARP control registers in UDP kernel
const unsigned int ARP_DISCOVERY        = 0x3010;
const unsigned int ARP_IP_ADDR_OFFSET   = 0x3400;
const unsigned int ARP_MAC_ADDR_OFFSET  = 0x3800;
const unsigned int ARP_VALID_OFFSET     = 0x3100;
// Self network inforation registers
const unsigned int IP_ADDR_OFFSET       = 0x0018;
const unsigned int GATEWAY_OFFSET       = 0x001C;
const unsigned int MAC_ADDR_OFFSET      = 0x0010;
const unsigned int NUM_SOCKETS_HW       = 0x2210;
const unsigned int UDP_OFFSET           = 0x2000;

class cmac{
private:
    char ip_name[64];
    bool arp_valid = {0};
    xrt::ip inst;
    xrt::device* belonging_device;
    xrt::uuid* belonging_uuid;

public:
    cmac(xrt::device& belonging_device, xrt::uuid& belonging_uuid, const char* ip_name){
        strcpy(this->ip_name, ip_name);
        this->inst = xrt::ip(belonging_device, belonging_uuid, this->ip_name);
    }
    
    // get tx status
    unsigned int get_tx_status(){
        this->inst.read_register(0x0200); // redundent read for some reason..
        return this->inst.read_register(0x0200);
    }
    // get rx status
    unsigned int get_rx_status(){
        this->inst.read_register(0x0204); // redundent read for some reason..
        return this->inst.read_register(0x0204);
    }
};

class network_layer{
private:
    char ip_name[64];
    xrt::ip inst;
    xrt::device* belonging_device;
    xrt::uuid* belonging_uuid;
    bool is_self_ip_address_set;
    bool arp_valid[256];
public:
    network_layer(xrt::device& belonging_device, xrt::uuid& belonging_uuid, const char* ip_name){
        strcpy(this->ip_name, ip_name);
        this->inst = xrt::ip(belonging_device, belonging_uuid, this->ip_name);
        is_self_ip_address_set = false;
    }

    // set self ip address
    int set_self_ip(uint32_t ip, uint64_t mac, uint32_t gateway){
        inst.write_register(MAC_ADDR_OFFSET, (uint32_t)(mac & 0xFFFFFFFF));
        inst.write_register(MAC_ADDR_OFFSET + 4, (uint32_t)((mac >> 32) & 0xFFFFFFFF));
        inst.write_register(IP_ADDR_OFFSET, ip);
        inst.write_register(GATEWAY_OFFSET, gateway);
        is_self_ip_address_set = true;
        return 0;
    }    

    // get number of hardware sockets
    int get_hardware_sockets_number(){
        return inst.read_register(NUM_SOCKETS_HW);
    }

    // set socket
    int set_socket(int id, socket_type socket_info ){ 
        if (is_self_ip_address_set == false){
            return -1;
        }
        uint32_t their_ip_offset = 0x10 + id * 8;
        uint32_t their_port_offset = their_ip_offset + 16 * 8;
        uint32_t my_port_offset = their_port_offset + 16 * 8;

        inst.write_register(UDP_OFFSET + their_ip_offset, socket_info.their_ip);
        inst.write_register(UDP_OFFSET + their_port_offset, socket_info.their_port);
        inst.write_register(UDP_OFFSET + my_port_offset, socket_info.my_port);
        return 0;
    }

    // enable socket
    int enable_socket(int id){
        if (is_self_ip_address_set == false){
            return -1;
        }
        if (id == -1) {
            int num_of_sockets = get_hardware_sockets_number();
            for (int i = 0; i < num_of_sockets; i++){
                uint32_t their_ip_offset = 0x10 + i * 8;
                uint32_t valid_offset = their_ip_offset + 16 * 8 * 3;

                inst.write_register(UDP_OFFSET + valid_offset, false);
            }
        }
        else{
            uint32_t their_ip_offset = 0x10 + id * 8;
            uint32_t valid_offset = their_ip_offset + 16 * 8 * 3;

            inst.write_register(UDP_OFFSET + valid_offset, true);
        }
        return 0;
    }
    
    // disable socket
    int disable_socket(int id){
        if (is_self_ip_address_set == false){
            return -1;
        }

        uint32_t their_ip_offset = 0x10 + id * 8;
        uint32_t valid_offset = their_ip_offset + 16 * 8 * 3;

        inst.write_register(UDP_OFFSET + valid_offset, false);

        return 0;
    }

    // ARP 
    void arp_discover(){
        // clear
        for (int i = 0; i < 64; i++){ // 256 entry, one take one byte
            inst.write_register(ARP_VALID_OFFSET + (i << 2), 0);
            arp_valid[i] = false;
        }

        // trigger arp
        inst.write_register(ARP_DISCOVERY, 0);
        inst.write_register(ARP_DISCOVERY, 1);
        inst.write_register(ARP_DISCOVERY, 0);

        for (int i = 0; i < 64; i++){
            uint32_t val = inst.read_register(ARP_VALID_OFFSET + (i << 2));
            for (int j = 0; j < 4; j++){
                bool valid_entry = val & 1;
                if (valid_entry){
                    printf("ARP valid entry found at %d\n", i * 4 + j);
                    arp_valid[i * 4 + j] = true;
                }
                val = val >> 8;
            }
        }
    }
};

#endif
