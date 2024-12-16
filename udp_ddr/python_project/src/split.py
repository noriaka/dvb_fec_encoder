paktIn_bin_file = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/datain/pktIn_bin.dat'
paktIn_hex_file = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/datain/pktIn_hex.dat'
paktIn_file = 'D:/Workspace/Pycharm_project/udp_tx/udp_tx/datain/pktIn.dat'
def split(paktIn_bin_file,paktIn_hex_file,paktIn_file):
    with open(paktIn_bin_file, 'r') as f_in,open(paktIn_hex_file, 'w') as f_hexout:
        bin_lines = f_in.readlines()
        for line in bin_lines:
            f_hexout.write(str(hex(int(line,2))[2:].zfill(2)))
            f_hexout.write('\n')
        f_hexout.close()
        f_in.close()
    with open(paktIn_file, 'w') as f_out,open(paktIn_hex_file, 'r') as f_hexout:
        hex_lines = f_hexout.readlines()
        count=0
        len_cnt=0
        split_bytes = ''
        for line in hex_lines:
            count+=1
            len_cnt+=1
            split_bytes=line.strip()+split_bytes
            if count == 7:
                f_out.write(split_bytes)
                f_out.write('\n')
                split_bytes = ''
                count=0
            else:
                if len_cnt==len(hex_lines):
                    for i in range(7-count):
                        split_bytes = '00' +  split_bytes
                    f_out.write(split_bytes)
                    f_out.write('\n')
                    split_bytes = ''
        f_out.close()
        print("Finish!")
split(paktIn_bin_file,paktIn_hex_file,paktIn_file)