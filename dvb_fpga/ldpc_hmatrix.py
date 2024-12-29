import numpy as np
import matplotlib.pyplot as plt


# ATSC  - 6/15, 9/15, 10/15, 12/15
# DVBS2 - 2/5,  3/5,  2/3,   4/5


def IntToBinStr(num, bit_len):
    str_bin = bin(num)[2:].zfill(bit_len)
    return str_bin


def GenerateCoeFile(map_table, output_path, output_txt_path):
    max_len = 6
    default_str = '0000000000000000'
    with open(output_path, 'w') as file:
        file.writelines('memory_initialization_radix = 16;\n')
        file.writelines('memory_initialization_vector =\n')
        for table in map_table:
            len_table = len(table)
            str_res = ''
            for i in range(len_table):
                str_num1 = IntToBinStr(table[i][0], 7)
                str_num2 = IntToBinStr(table[i][1], 9)
                # if i != len_table - 1:
                #     str_num = str_num1 + str_num2 + '1'
                # else:
                #     str_num = str_num1 + str_num2 + '0'
                str_num = str_num1 + str_num2
                str_res = str_res + str_num
            for i in range(max_len - len_table):
                str_res = str_res + default_str
            hex_val = hex(int(str_res, 2))[2:].zfill(4 * 6)
            # print(hex_val)
            file.writelines(hex_val + ',\n')
    cnt = 0
    with open(output_txt_path, 'w') as file:
        for table in map_table:
            len_table = len(table)
            str_res = ''
            for i in range(len_table):
                str_num1 = IntToBinStr(table[i][0], 7)
                str_num2 = IntToBinStr(table[i][1], 9)
                str_num = str_num1 + str_num2
                str_res = str_res + str_num
            for i in range(max_len - len_table):
                str_res = str_res + default_str
            hex_val = hex(int(str_res, 2))[2:].zfill(4 * 6)
            str_hex = f'bram[{cnt}] <= 96\'h' + hex_val + ';'
            file.writelines(str_hex + '\n')
            cnt = cnt + 1


def PlotMatrix(matrix):
    x_coords, y_coords = np.nonzero(matrix)
    plt.figure(figsize=(12, 8))
    plt.scatter(y_coords, x_coords, s=1, marker='o')
    plt.title("Scatter Plot of Rearranged Matrix with 1s at Specified Positions")
    plt.xlabel("Column Index")
    plt.ylabel("Row Index")
    plt.gca().invert_yaxis()
    plt.xticks([0, 360])
    plt.axis('equal')
    plt.show()


def GetHMatrixMap(code_rate: str, type: str) -> list[list[int]]:
    if type == 'atsc':
        path_name = 'atsc_' + code_rate + '.txt'
    else:
        path_name = 'dvbs2_' + code_rate + '.txt'
    matrix_map = []
    with open(path_name) as file:
        lines = file.readlines()
        for line in lines:
            col_idx = []
            for idx in line.strip().split(' '):
                col_idx.append(int(idx))
            matrix_map.append(col_idx)
    return matrix_map


def GetHMatrixMapTable(code_rate: str, type: str):
    code_rate_dic = {
        '5_15': 23040,  # 16_45
        '6_15': 25920,
        '1_2': 7200,  # 4_9 test
        '2_5': 6480,  # test
        '3_5': 9720,  # test
        '5_6': 13320
    }
    matrix_map = GetHMatrixMap(code_rate, type)
    n = 64800
    # n = 16200
    k = code_rate_dic[code_rate]
    r = n - k
    t = int(k / 360)
    q = int(r / 360)
    print(t, q)

    matrix_group = []
    rearranged_matrix_group = []
    for group in range(t):
        matrix = np.zeros((r, 360), dtype=np.int8)
        row_idx_list = matrix_map[group]
        for col in range(360):
            for row in row_idx_list:
                shifted_row = (row + col * q) % r
                matrix[shifted_row, col] = 1
        matrix_group.append(matrix)
        # rearrang
        rearranged_matrix = np.zeros_like(matrix)
        for i in range(q):
            rearranged_matrix[i * (r // q):(i + 1) * (r // q), :] = matrix[i::q, :]
        rearranged_matrix_group.append(rearranged_matrix)

    matrix_map_table = []
    for i in range(q):
        matrix_map_table.append([])
    for idx in range(len(rearranged_matrix_group)):
        for i in range(q):
            for j in range(360):
                if rearranged_matrix_group[idx][i * 360][j] == 1:
                    matrix_map_table[i].append([idx, j])
                    # print(f"{i}:{idx}:{j}")
    # print(matrix_map_table)
    # for data in matrix_map_table:
    #     print(data)
    return matrix_map_table

    # max_len = 0
    # idx = 0
    # i = 0
    # for m in matrix_map_table:
    #     if max_len < len(m):
    #         max_len = len(m)
    #         idx = i
    #     i = i + 1
    # print(max_len, idx)
    # print(matrix_map_table[44])

    # PlotMatrix(rearranged_matrix_group[63])


if __name__ == "__main__":
    map_table = GetHMatrixMapTable('6_15', 'atsc')
    # GenerateCoeFile(map_table, 'atsc_6_15.coe', 'atsc_6_15.dat')
    print(len(map_table))
    # for m in map_table:
    #     print(m)
    with open('map_table_atsc_6_15.txt', 'w') as file:
        for m in map_table:
            val = ''
            for item in m:
                val += str(item[1]) + ' '
            file.writelines(val + '\n')

    # Matrix dimensions
    # rows = 1800
    # cols = 360
    #
    # k = 14400
    # r = 1800
    # q = 5

    # rows = 9000
    # cols = 360
    #
    # k = 7200
    # r = 9000
    # q = 25
    #
    # matrix = np.zeros((rows, cols), dtype=int)
    # initial_ones = [20, 712, 2386, 6354, 4061, 1062, 5045, 5158]
    # # initial_ones = [0, 1558, 712, 805]
    #
    # for col in range(cols):
    #     for row in initial_ones:
    #         shifted_row = (row + col * q) % rows
    #         matrix[shifted_row, col] = 1
    #
    # rearranged_matrix = np.zeros_like(matrix)
    # for i in range(q):
    #     rearranged_matrix[i * (rows // q):(i + 1) * (rows // q), :] = matrix[i::q, :]

    # for i in range(q):
    #     for j in range(cols):
    #         if (rearranged_matrix[i * 360][j] == 1):
    #             print(f"{i}:{j}")

    # rearranged_matrix_group = []
    # rearranged_matrix_group.append(rearranged_matrix)
    # matrix_map_table = []
    # for i in range(q):
    #     matrix_map_table.append([])
    # for idx in range(len(rearranged_matrix_group)):
    #     for i in range(q):
    #         for j in range(360):
    #             if rearranged_matrix_group[idx][i * 360][j] == 1:
    #                 matrix_map_table[i].append([idx, j])
    #                 print(f"{i}:{idx}:{j}")
    # x_coords, y_coords = np.nonzero(rearranged_matrix)

    # plt.figure(figsize=(12, 8))
    # plt.scatter(y_coords, x_coords, s=1, marker='o')
    # plt.title("Scatter Plot of Rearranged Matrix with 1s at Specified Positions")
    # plt.xlabel("Column Index")
    # plt.ylabel("Row Index")
    # plt.gca().invert_yaxis()
    # plt.xticks([0, 360])
    # plt.axis('equal')
    # plt.show()
