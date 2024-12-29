def hex18tofloat(hex18: str):
    hex18 = hex18.strip()
    binary_num = bin(int(hex18, 16))[2:].zfill(18)
    sign_bit = binary_num[:2]
    value_bits = binary_num[2:]
    if sign_bit == "11":
        # 负数的情况下，先取反再加一
        inverted_bits = ''.join('1' if bit == '0' else '0' for bit in value_bits)
        value = -(int(inverted_bits, 2) + 1) / 2 ** 14
    else:
        value = int(value_bits, 2) / 2 ** 14
    value = "{:.6f}".format(value)
    return value


def hex2float(hex_num: str) -> str:
    """
    将25位宽的16进制数转换成对应的定点小数
    :param
        hex_num: 25位16进制数
    :return: 定点小数
    """
    # 将16进制数转换为25位宽的二进制字符串
    hex_num = hex_num.strip()
    hex_num = hex_num[1:]
    # if len(hex_num) > 7:
    #     if hex_num[0] == 'f':
    #         hex_num = '1' + hex_num[2:]
    #     else:
    #         hex_num = '0' + hex_num[2:]

    binary_num = bin(int(hex_num, 16))[2:].zfill(25)
    # 提取符号位和剩下的23位数
    sign_bit = binary_num[:2]
    value_bits = binary_num[2:]
    # 解释符号位并计算最终结果
    if sign_bit == "11":
        # 负数的情况下，先取反再加一
        inverted_bits = ''.join('1' if bit == '0' else '0' for bit in value_bits)
        value = -(int(inverted_bits, 2) + 1) / 2 ** 22
    else:
        value = int(value_bits, 2) / 2 ** 22

    value = "{:.6f}".format(value)
    return value


def vivado_data_hex2float(vivado_output_path: list) -> list:
    """
    处理vivado的输出，将输出的25位宽的16进制数转换成定点小数
    :param
        vivado_output_path: 存储vivado输出的i值和q值路径
    :return 转换成定点小数后的i值和q值路径
    """
    # 打开文件
    i_values = []
    q_values = []
    with open(vivado_output_path[0], "r") as file_i:
        # 读取文件内容
        lines = file_i.readlines()
        for hex_data in lines:
            i_values.append(str(hex2float(hex_data)))
    with open(vivado_output_path[1], "r") as file_q:
        # 读取文件内容
        lines = file_q.readlines()
        for hex_data in lines:
            q_values.append(str(hex2float(hex_data)))

    file_i_float = vivado_output_path[0][:-4] + '_float.txt'
    file_q_float = vivado_output_path[1][:-4] + '_float.txt'
    # 打开文件以写入模式
    with open(file_i_float, "w") as file_i:
        for i in i_values:
            file_i.write(i + "\n")

    with open(file_q_float, "w") as file_q:
        for q in q_values:
            file_q.write(q + "\n")
    return [file_i_float, file_q_float]


def dvb_compare(vivado_output_path: list, matlab_output_path: list, begin: int, end: int) -> float:
    """
    对比vivado输出和matlab输出，返回差值
    :param
        vivado_output_path: 存储vivado输出的i值和q值路径
        matlab_output_path: 存储matlab输出的i值和q值路径
        num: 指定比较的数量
    :return: 对比差值
    """
    # 处理vivado的i值和q值，转换成定点小数
    vivado_output_float_path = vivado_data_hex2float(vivado_output_path)
    delta, delta_i, delta_q = 0, 0, 0
    vivado_float_i, vivado_float_q = [], []
    matlab_float_i, matlab_float_q = [], []
    # 读取vivado的i值和q值
    with open(vivado_output_float_path[0]) as vivado_i:
        lines = vivado_i.readlines()
        for i in lines:
            vivado_float_i.append(float(i))
    with open(vivado_output_float_path[1]) as vivado_q:
        lines = vivado_q.readlines()
        for q in lines:
            vivado_float_q.append(float(q))
    # 读取matlab的i值和q值
    with open(matlab_output_path[0]) as matlab_i:
        lines = matlab_i.readlines()
        for i in lines:
            matlab_float_i.append(float(i))
    with open(matlab_output_path[1]) as matlab_q:
        lines = matlab_q.readlines()
        for q in lines:
            matlab_float_q.append(float(q))

    # 计算i值的差值
    try:
        # if len(vivado_float_i) == len(matlab_float_i):
        #     raise ValueError("vivado和matlab的输出长度不同!")
        # else:
        for i in range(begin, end):
            delta_i = delta_i + abs(vivado_float_i[i - begin] - matlab_float_i[i])
    except ValueError as e:
        print(e)

    # 计算q值的差值
    try:
        # if len(vivado_float_q) != len(matlab_float_q):
        #     raise ValueError("vivado和matlab的输出长度不同!")
        # else:
        for i in range(begin, end):
            delta_q = delta_q + abs(vivado_float_q[i - begin] - matlab_float_q[i])
    except ValueError as e:
        print(e)

    # delta = delta_i + delta_q
    delta = delta_i
    # delta = delta / (33372*2)
    return delta


def dvb_data_generate(path):
    head = '01000111'
    # with open(path, 'w') as file:
    #     # 57152/1504
    #     for i in range(38):
    #         for j in range(len(head)):
    #             file.writelines(head[j] + '\n')
    #         for k in range(1504 - len(head)):
    #             file.writelines('0' + '\n')
    # with open(path, 'w') as file:
    #     for i in range(38):
    #         for j in range(47):
    #             for k in range(len(head)):
    #                 file.writelines(head[k] + '\n')
    #             for t in range(32 - len(head)):
    #                 file.writelines('0' + '\n')
    data_list = []
    data_list.append('01000111000000000000000000000000')
    for num in range(1, 47):
        # data = bin(num)[2:].zfill(32)[::-1]
        data = bin(num)[2:].zfill(8) + bin(0)[2:].zfill(24)
        data_list.append(data)
    with open(path, 'w') as file:
        for i in range(38):
            for j in range(47):
                for k in range(32):
                    file.writelines(data_list[j][k] + '\n')


def coe_generate(path):
    # with open(path, 'w') as file:
    #     file.writelines('memory_initialization_radix = 16;\n')
    #     file.writelines('memory_initialization_vector =\n')
    #     cnt = 1
    #     i = 1
    #     while i <= 1786:
    #         if cnt > 47:
    #             cnt = 1
    #             continue
    #         elif cnt == 1:
    #             data = '00000047,\n'
    #         else:
    #             data = '00000000,\n'
    #         cnt = cnt + 1
    #         i = i + 1
    #         file.writelines(data)
    data_list = []
    data_list.append('00000047')
    for num in range(1, 47):
        data = hex(0)[2:].zfill(6) + hex(num)[2:].zfill(2)
        data_list.append(data)
    with open(path, 'w') as file:
        file.writelines('memory_initialization_radix = 16;\n')
        file.writelines('memory_initialization_vector =\n')
        for i in range(38):
            for j in range(47):
                file.writelines(data_list[j] + ',\n')


def read_dat_file(path):
    arr = []
    with open(path, 'r') as file:
        lines = file.readlines()
        for data in lines:
            arr.append(data)
    return arr


def read_bin_data(path, out_path):
    fir_i_val = []
    with open(path, 'rb') as file:
        data = file.read()
        num = len(data.strip())
        for i in range(0, num, 4):
            str_1 = format(data[i], '02x')
            str_2 = format(data[i + 1], '02x')
            str_3 = format(data[i + 2], '02x')
            str_4 = format(data[i + 3], '02x')
            val = str_4 + str_3 + str_2 + str_1
            fir_i_val.append(val)

    with open(out_path, 'w') as file:
        for val in fir_i_val:
            file.writelines(val[3:] + '\n')


if __name__ == "__main__":
    # simulink_data = read_dat_file('dat/dataOut_re_expected.dat')
    # simulink_data_float = []
    # for data in simulink_data:
    #     simulink_data_float.append(float(hex18tofloat(data.strip())))
    # matlab_data = read_dat_file('matlab_data/matlab_out_re1.txt')
    # # print(simulink_data_float[2])
    # # print(matlab_data[2])
    # for i in range(0, len(matlab_data)):
    #     if abs(simulink_data_float[i] - float(matlab_data[i])) > 0.01:
    #         print(i)
    # for i in range(len(simulink_data_float)):
    #     if abs(float(simulink_data_float[i]) - float(matlab_data[1])) < 0.0001:
    #         print(i)

    vivado_output_path = ['verilog_data/verilog_out_i.txt', 'verilog_data/verilog_out_q.txt']
    matlab_output_path = ['matlab_data/matlab_out_i_1.txt', 'matlab_data/matlab_out_i_1.txt']
    # delta = dvb_compare(vivado_output_path, matlab_output_path, 0, 33372)
    # print(delta)

    bit_path = 'dat/pktBitsIn.dat'
    start_path = 'dat/pktStartIn.dat'
    end_path = 'dat/pktEndIn.dat'
    valid_path = 'dat/pktValidIn.dat'
    fstart_path = 'dat/frameStartIn.dat'
    fend_path = 'dat/frameEndIn.dat'
    bits = read_dat_file(bit_path)
    starts = read_dat_file(start_path)
    ends = read_dat_file(end_path)
    valids = read_dat_file(valid_path)
    fstarts = read_dat_file(fstart_path)
    fends = read_dat_file(fend_path)

    # with open('dat/pktIn.dat', 'w') as file:
    #     for i in range(len(bits)):
    #         pkts = bits[i].strip() + starts[i].strip() + ends[i].strip() + valids[i].strip() + fstarts[i].strip() + \
    #                fends[i].strip()
    #         file.writelines(pkts + '\n')

    # with open('dat/frameEndIn.dat') as file:
    #     lines = file.readlines()
    #     cnt = 1
    #     for data in lines:
    #         if data.strip() == "1":
    #             print(cnt)
    #             break
    #         cnt = cnt + 1
    data = read_dat_file('dat/pktIn.dat')
    with open('dat/pktIn_new.dat', 'w') as file:
        file.writelines("memory_initialization_radix = 2;\n")
        file.writelines("memory_initialization_vector\n")
        for i in range(42131):
            file.writelines(data[i].strip() + '\n')
    # -------------------------------------------------------------
    # path1 = 'verilog_data/verilog_output_q.txt'
    # path2 = 'verilog_data/dataOut_im_expected.dat'
    # data1, data2 = [], []
    # with open(path1, 'r') as file1:
    #     lines = file1.readlines()
    #     for data in lines:
    #         data1.append(data)
    # with open(path2, 'r') as file2:
    #     lines = file2.readlines()
    #     cnt = 0
    #     for data in lines:
    #         if cnt >= 104:
    #             data2.append(data)
    #         cnt = cnt + 1
    # for i in range(len(data2)):
    #     if data1[i] != data2[i]:
    #         print(i)
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    # path1 = 'F:\\ProjectFileFolder\\MatlabProject\\dvb\\data_in_new.txt'
    # path2 = 'verilog_data/data_in_1.txt'
    # path1 = 'verilog_data/verilog_out_i.txt'
    # path2 = 'fpga_data/fir_i.txt'
    # path1 = 'dat/dataOut_re_expected.dat'
    # path2 = 'fpga_data/fir_out.txt'
    # data1, data2 = [], []
    # with open(path1, 'r') as file1:
    #     lines = file1.readlines()
    #     for data in lines:
    #         data1.append(data.strip())
    # with open(path2, 'r') as file2:
    #     lines = file2.readlines()
    #     for data in lines:
    #         data2.append(data.strip())
    # for i in range(len(data2)):
    #     if data1[i + 130000 - 1] != data2[i]:
    #         print(i)
    # -------------------------------------------------------------
    # read_bin_data('fpga_data/dvbs2_matlab_test_04.txt', 'fpga_data/fir_i_4.txt')
    # read_bin_data('fpga_data/dvbs2_matlab_test_05.txt', 'fpga_data/fir_i_5.txt')
    # read_bin_data('fpga_data/dvbs2_matlab_test_06.txt', 'fpga_data/fir_i_6.txt')
    # read_bin_data('fpga_data/dvbs2_matlab_test_08.txt', 'fpga_data/fir_i_8.txt')
    # read_bin_data('fpga_data/dvbs2_matlab_test_09.txt', 'fpga_data/fir_i_9.txt')
    # fir_3 = read_dat_file('fpga_data/fir_i_4.txt')
    # fir_4 = read_dat_file('fpga_data/fir_i_5.txt')
    # fir_5 = read_dat_file('fpga_data/fir_i_6.txt')
    # fir_8 = read_dat_file('fpga_data/fir_i_8.txt')
    # fir_9 = read_dat_file('fpga_data/fir_i_9.txt')
    # fir_out = []
    # for data in fir_3:
    #     fir_out.append(data)
    # for data in fir_4:
    #     fir_out.append(data)
    # for data in fir_5:
    #     fir_out.append(data)
    # for data in fir_8:
    #     fir_out.append(data)
    # for data in fir_9:
    #     fir_out.append(data)
    # with open('fpga_data/fir_out.txt', 'w') as file:
    #     for i in range(len(fir_out)):
    #         file.writelines(fir_out[i])

    # -------------------------------------------------------------
    # dvb_data_generate('verilog_data/data_in_3.txt')
    # coe_generate('input_data1.coe')
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    # with open('dat/pktStartIn.dat', 'r') as file:
    #     lines = file.readlines()
    #     cnt = 0
    #     for data in lines:
    #         if data.strip() == '1':
    #             cnt = cnt + 1
    #     print(cnt)
    # bits = []
    # with open('dat/pktBitsIn.dat', 'r') as file:
    #     lines = file.readlines()
    #     for data in lines:
    #         bits.append(data.strip())
    # with open('dat/bits_in.txt', 'w') as file:
    #     for bit in bits[19:42131]:
    #         file.writelines(bit + '\n')
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    # fir_i_val = []
    # with open('fpga_data/dvbs2_v10_test_02.txt', 'rb') as file:
    #     data = file.read()
    #     num = len(data.strip())
    #     for i in range(0, num, 4):
    #         str_1 = format(data[i], '02x')
    #         str_2 = format(data[i + 1], '02x')
    #         str_3 = format(data[i + 2], '02x')
    #         str_4 = format(data[i + 3], '02x')
    #         val = str_4 + str_3 + str_2 + str_1
    #         fir_i_val.append(val)
    #
    # with open('fpga_data/fir_i_2.txt', 'w') as file:
    #     for val in fir_i_val:
    #         file.writelines(val[3:] + '\n')
    # -------------------------------------------------------------

    # vivado_output_path = ['test_data/fir_i.txt', 'test_data/fir_i.txt']
    # matlab_output_path = ['data/matlab_i_out.txt', 'data/matlab_q_out.txt']
    # delta = dvb_compare(vivado_output_path, matlab_output_path, 0, 2000)
    # print(delta)
    # a = 0.0001716015521910002 + 0.0005963002768150028
    # print(a)
