def binary_to_hex(binary_str):
    # 检查输入字符串的长度
    length = len(binary_str)
    # 确保长度是 4 的倍数
    if length % 4 != 0:
        # 计算需要补零的数量
        padding_length = 4 - (length % 4)
        # 在前面补零
        binary_str = '0' * padding_length + binary_str

    # 初始化十六进制字符串
    hex_str = ''

    # 每四位二进制转换为一个十六进制字符
    for i in range(0, len(binary_str), 4):
        # 取出四位二进制
        four_bits = binary_str[i:i + 4]
        # 转换为十六进制
        hex_char = hex(int(four_bits, 2))[2:]  # 转换并去掉 '0x'
        hex_str += hex_char
    return hex_str


def circular_right_shift(bits, shift):
    shift = shift % len(bits)  # 确保移位在有效范围内
    return bits[-shift:] + bits[:-shift]  # 循环右移


def generate_sc(width):
    bits_default = ''.join('10'[(i % 2)] for i in range(width))
    map_table = []
    # map_table = [16, 306, 267, 143, 353]
    with open('map_table_atsc_6_15.txt', 'r') as file:
        lines = file.readlines()
        for line in lines:
            val_arr = line.strip().split(' ')
            map_table.append(val_arr)
    xor_result = '0' * len(bits_default)
    for table in map_table:
        for shift in table:
            if int(shift) >= 360:
                print(shift)
                break
            shifted_bits = circular_right_shift(bits_default, int(shift))  # 循环右移
            xor_result = ''.join('1' if (xor_result[i] != shifted_bits[i]) else '0' for i in range(len(bits_default)))
    xor_result = binary_to_hex(xor_result)
    return xor_result


def lpdc_compare(path1, path2):
    ldpc_out = []
    with open(path1, 'r') as file:
        bits = file.readlines()
        i = 0
        bit_arr = ''
        for bit in bits:
            if (i < 17):
                bit_arr += bit.strip()
                i = i + 1
            else:
                bit_arr += bit.strip()
                ldpc_out.append(binary_to_hex('0' + bit_arr))
                # ldpc_out.append('0' + bit_arr)
                bit_arr = ''
                i = 0
    # cnt = 0
    # for data in ldpc_out:
    #     if data != ldpc_out[0]:
    #         print(cnt)
    #         break
    #     cnt = cnt + 1
    fpga_ldpc_out = []
    with open(path2, 'r') as file:
        lines = file.readlines()
        for line in lines:
            fpga_ldpc_out.append(line.strip())
    print(ldpc_out)
    print(fpga_ldpc_out)
    for i in range(1440):
        if ldpc_out[i] != fpga_ldpc_out[i]:
            print(i)
            break
    if (i == 1440 - 1):
        print('完全匹配！')


if __name__ == "__main__":
    # generate_sc()
    # print(generate_sc(360))
    matlab_ldpc_data_path = 'matlab_ldpc_data/matlab_ldpc_data_6_15.txt'
    fpga_ldpc_data_path = 'fpga_ldpc_data/fpga_ldpc_data_6_15.txt'
    lpdc_compare(matlab_ldpc_data_path, fpga_ldpc_data_path)
