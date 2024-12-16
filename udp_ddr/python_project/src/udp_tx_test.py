# #8字节/包   1字节(非数据)
# #63:58 保留  57 0-数据包为空包 1-数据包非空  56 0-请求PC发空数据包 1-请求PC发有效数据  55:0数据
# #63:57 保留  57 0-数据包为空包 1-数据包非空  56 0-PC未发完全部数据 1-PC已发完全部数据  55:0数据

import socket
import sys
from time import sleep
# 设置目标IP地址和端口号
target_ip = "192.168.137.2"  # 替换为FPGA开发板的IP地址
target_port = 8002           # 替换为FPGA开发板的端口号
# file_path = 'E:/UDP_python/bchDec/bch.dat'  # 文件路径
file_path = '../datain/pktIn.dat'
file_out_im_matlab = '../datain/dataOut_im_expected.dat'
file_out_re_matlab = '../dataout/dataOut_re_expected_delete.dat'
file_out_im_fpga = '../dataout/fpag_out_im.dat'
file_out_re_fpga = '../dataout/fpag_out_re.dat'
# file_out_im_fpga1 = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/dataout/fpag_out_re1.dat'
local_port = 8001
control_byte0 = 0x00
control_byte1 = 0x80
control_byte2 = 0x01
control_byte3 = 0x02
total_size =  100
rx_count = 0

def send_file_udp(file_path, file_out_im_fpga,file_out_re_fpga,file_out_im_matlab,file_out_re_matlab, target_ip, target_port):
    buffer_size = 7  # 0-6字节为数据
    hex_buffer = ""
    print("------------------Start sending data------------------")
    rx_count = 0
    dataout_len = 0
    dataout_count = 0
    with open(file_out_im_matlab,'r') as f_len:
        dataout_len = len(f_len.readlines())
        print(dataout_len)
        f_len.close()
    with open(file_path, 'r') as file:
        num = len(file.readlines())
    try:
        # 创建UDP socket
        udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        udp_socket.setsockopt(socket.SOL_SOCKET,socket.SO_RCVBUF,65535)
        udp_socket.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 65535)
        udp_socket.bind(('', local_port))
        udp_socket.settimeout(10)  # 设置接收超时为5秒
        data_len_packet = bytearray(8)
        data_len_packet = bytearray.fromhex(hex(dataout_len).strip('0x').zfill(16))
        data_len_packet[0] = control_byte3
        udp_socket.sendto(data_len_packet, (target_ip, target_port))
        with open(file_path, 'r') as file:
            count = 0
            new_packet = bytearray(total_size*8)
            id = 0
            max_id = 0
            for line in file:
                line = line.strip()  # 去掉每行的换行符
                data = bytearray.fromhex(line)
                count += 1
                if count%100000==0:
                    progress = round((count/num)*100,2)
                    print("download:{}%".format(progress))
                    sleep(1)
                id += 1
                max_id = max(id,max_id)
                # print("id:",id)
                # print("count:",count)
                # 当hex_buffer的长度超过14个字符(7个字节)时，进行发送
                # 创建一个8字节的数组，将第8字节设置为控制信息
                new_packet[id*8-7:id*8-1] = data
                if count ==1:
                    new_packet[id * 8 - 8] = control_byte2
                else:
                    new_packet[id*8-8] = control_byte0
                # new_packet[id * 8 - 8] = control_byte0
                if (count == num):
                    new_packet[id*8-8] = control_byte1  # PC端已发完全部数据
                    # with open(file_send_path, 'a') as f_send:
                    #     f_send.write('data_end:'+new_packet[:id*8].hex()+'\n')  # 写入数据部分
                    udp_socket.sendto(new_packet[:id*8], (target_ip, target_port))
                    print("download：100%")
                    print("Sending data is complete!")
                    file.close()
                    break
                if (id == total_size):
                    # print("new_packet.hex():",new_packet.hex())
                    # with open(file_send_path, 'a') as f_send:
                    #     f_send.write('data:'+new_packet[:total_size*8].hex()+'\n')  # 写入数据部分
                    udp_socket.sendto(new_packet[:total_size*8], (target_ip, target_port))
                    new_packet=bytearray(total_size*8)
                    id = 0
                    sleep(0.0001)
            file.close()
        new_received_packet_im = ""
        new_received_packet_re = ""
        print("------------------Start receiving data------------------")
        while True:
            try:
                received_packet, _ = udp_socket.recvfrom(8)
                new_received_packet_im = new_received_packet_im + received_packet[::-1].hex()[11:16]+"\n"
                new_received_packet_re = new_received_packet_re + received_packet[::-1].hex()[5:10]+"\n"
                if (dataout_count == int(dataout_len/4)) or (dataout_count == 2*int(dataout_len/4)) or (dataout_count == 3*int(dataout_len/4)) or (dataout_count == dataout_len):
                    progress = round((dataout_count/dataout_len)*100,2)
                    print("Receive:{}%".format(progress))
                dataout_count+=1
                if dataout_count == dataout_len:
                    print("Receiving data is complete!")
                    break
            except socket.timeout:
                # print("Receive timed out, no response from FPGA.")
                print("Receiving data is complete!")
                break
    except Exception as e:
        print(f"Error: {e}")
    finally:
        udp_socket.close()
        print("------------------Start writting data------------------")
        # print(len(new_received_packet_im.hex())/16)
        with open(file_out_im_fpga, 'w') as f_im:
            f_im.write(new_received_packet_im)
            f_im.close()
        with open(file_out_re_fpga, 'w') as f_re:
            f_re.write(new_received_packet_re)
            f_re.close()
        print("Writting data is complete!")
    # 用法示例
# def hexTobits(file_bit_out_fpga,file_out_fpga):
#     print("------------------Start data processing------------------")
#     with open(file_bit_out_fpga, 'w') as f:
#         pass
#     with open(file_out_fpga, 'r') as file_out:
#         for line in file_out:
#             line = line.strip()  # 去掉每行的换行符
#             line=line[::-1]
#             with open(file_bit_out_fpga, 'a') as f:
#                 for byte in line:
#                     bits = bin(int(byte,16))[2:].zfill(4)
#                     for i in range(4,0,-1):
#                         f.write(bits[i-1] + '\n')
#     f.close()
#     file_out.close()
#     print("Complete the data processing!")
def compare(file_data_out_fpga,file_data_out_matlab):
    count=0
    error_rate = 0
    error_line = 0
    with open(file_data_out_fpga, 'r') as f_fpga,open(file_data_out_matlab,'r') as f_matlab:
        fpag_lines = f_fpga.readlines()
        matlab_lines= f_matlab.readlines()
        for i in range(len(matlab_lines)):
            chunk1 = fpag_lines[i].strip()
            chunk2 = matlab_lines[i].strip()
            if chunk1!=chunk2:
                count+=1
                error_line = i
                break
        error_rate = (count / len(fpag_lines)) * 100

        f_fpga.close()
        f_matlab.close()
    return error_line, error_rate
def data_compare(file_data_out_im_fpga,file_data_out_re_fpga,file_data_out_im_matlab,file_data_out_re_matlab):
    im_error_rate = 0
    re_error_rate = 0
    im_error_line = 0
    re_error_line = 0
    print("Complete the comparison!")
    im_error_line, im_error_rate = compare(file_data_out_im_fpga,file_data_out_im_matlab)
    re_error_line, re_error_rate = compare(file_data_out_re_fpga, file_data_out_re_matlab)
    print(f"Im error line：{im_error_line}")
    print(f"Im error rate: {im_error_rate}%")
    print(f"Re error line：{re_error_line}")
    print(f"Re error rate: {re_error_rate}%")
    print("Complete the comparison!")
send_file_udp(file_path, file_out_im_fpga,file_out_re_fpga,file_out_im_matlab,file_out_re_matlab,target_ip, target_port)
# data_compare(file_out_im_fpga, file_out_re_fpga, file_out_im_matlab, file_out_re_matlab)

