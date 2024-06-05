import numpy as np


def array_to_poly(array_val: list) -> list:
    """
    将数组转成多项式
    :param array_val: 数组
    :return: 多项式
    """
    list_poly = []
    for i in range(len(array_val)):
        res = 0
        for j in range(len(array_val[i])):
            res += 2 ** array_val[i][j]
        list_poly.append(int_to_binary(res))
    return list_poly


def multi_poly(poly_a: list, poly_b: list) -> list:
    """
    按二进制运算规则计算两个多项式相乘
    :param poly_a: 多项式a
    :param poly_b: 多项式b
    :return: 两个多项式乘积
    """
    if len(poly_a) == 1 and poly_a[0] == 0:
        return list(poly_b)
    if len(poly_b) == 1 and poly_b[0] == 0:
        return list(poly_a)

    poly_temp = []
    for i in range(len(poly_a)):
        if poly_a[i] != 0:
            delta = len(poly_a) - 1 - i
            temp = list(poly_b)
            for j in range(delta):
                temp.append(0)
            poly_temp.append(temp)

    list_temp = [0]
    for poly in poly_temp:
        list_temp = exor_poly(list_temp, poly)
    poly_c = list(list_temp)
    return poly_c


def exor_poly(poly_a: list, poly_b: list) -> list:
    """
    按二进制运算规则计算两个多项式异或
    :param poly_a: 多项式a
    :param poly_b: 多项式b
    :return: 异或结果
    """
    poly_c = []
    delta = 0
    if len(poly_a) > len(poly_b):
        delta = len(poly_a) - len(poly_b)
        for i in range(delta):
            poly_b.append(0)
        for j in range(len(poly_b) - 1, delta - 1, -1):
            poly_b[j] = poly_b[j - delta]
        for k in range(delta):
            poly_b[k] = 0
    else:
        delta = len(poly_b) - len(poly_a)
        for i in range(delta):
            poly_a.append(0)
        for j in range(len(poly_a) - 1, delta - 1, -1):
            poly_a[j] = poly_a[j - delta]
        for k in range(delta):
            poly_a[k] = 0
    for s in range(len(poly_a)):
        poly_c.append(poly_a[s] ^ poly_b[s])
    return poly_c


def binary_to_int(bin_arr: list) -> int:
    """
    将二进制数组转成十进制数
    :param bin_arr: 二进制数组
    :return: 转换结果
    """
    result = 0
    for i in range(len(bin_arr) - 1, -1, -1):
        result += bin_arr[len(bin_arr) - 1 - i] * (2 ** i)
    return result


def int_to_binary(num: int) -> list:
    """
    将十进制数转成二进制数组
    :param num: 十进制数
    :return: 二进制数组
    """
    bin_arr = []
    str_num = bin(num)[2:]
    for s in str_num:
        bin_arr.append(1 if s == '1' else 0)
    return bin_arr


def get_gx_by_t(gx_arr: list, t: int) -> list:
    """
    根据纠错位数返回不同的生成多项式gx
    :param gx_arr: 生成多项式数组
    :param t: 纠错位数
    :return: 生成多项式 g_r-1, ..., g_0
    """
    poly_list = array_to_poly(gx_arr)
    poly_temp = [0]
    for i in range(t):
        poly_temp = multi_poly(poly_temp, poly_list[i])
    gx = poly_temp[1:]
    return gx


def dot_ndarray(arr_a: np.ndarray, arr_b: np.ndarray):
    """
    按二进制规则计算两个ndarray的点乘
    :param arr_a: ndarray A
    :param arr_b: ndarray B
    :return: 点乘结果
    """
    arr_c = []
    cnt = len(arr_a)
    for i in range(cnt):
        arr_c.append(arr_a[i] * arr_b[i])
    res = 0
    for val in arr_c:
        res = res ^ val
    return res


def multi_matrix(matrix_a: np.ndarray, matrix_b: np.ndarray):
    """
    计算两个矩阵相乘
    :param matrix_a: 矩阵A
    :param matrix_b: 矩阵B
    :return: 相乘结果
    """
    r = matrix_a.shape[0]
    matrix_c = np.zeros((r, r)).astype(int)
    for i in range(r):
        for j in range(r):
            matrix_c[i][j] = dot_ndarray(matrix_a[i], matrix_b[:, j])
    return matrix_c


def get_gx_matrix(gx_arr, n):
    r = len(gx_arr)
    gx_matrix = np.zeros((r, r)).astype(int)
    for i in range(r):
        gx_matrix[i, 0] = gx_arr[i]
        if i + 1 < r:
            gx_matrix[i, i + 1] = 1
    gx_res_matrix = gx_matrix
    for i in range(n - 1):
        gx_res_matrix = multi_matrix(gx_res_matrix, gx_matrix)
    return gx_res_matrix


if __name__ == '__main__':
    init_gx = [
        [16, 5, 3, 2, 0],
        [16, 8, 6, 5, 4, 1, 0],
        [16, 11, 10, 9, 8, 7, 5, 4, 3, 2, 0],
        [16, 14, 12, 11, 9, 6, 4, 2, 0],
        [16, 12, 11, 10, 9, 8, 5, 3, 2, 1, 0],
        [16, 15, 14, 13, 12, 10, 9, 8, 7, 5, 4, 2, 0],
        [16, 15, 13, 11, 10, 9, 8, 6, 5, 2, 0],
        [16, 14, 13, 12, 9, 8, 6, 5, 2, 1, 0],
        [16, 11, 10, 9, 7, 5, 0],
        [16, 14, 13, 12, 10, 8, 7, 5, 2, 1, 0],
        [16, 13, 12, 11, 9, 5, 3, 2, 0],
        [16, 12, 11, 9, 7, 6, 5, 1, 0]
    ]
    t = 8
    gx = get_gx_by_t(init_gx, t)
    # for i in gx:
    #     print(i, end='')
    r = 4
    g = [1, 0, 0, 1]
    matrix = np.zeros((r, r)).astype(int)

    for i in range(r):
        matrix[i, 0] = g[i]
        if i + 1 < r:
            matrix[i, i + 1] = 1
    matrix.astype(int)
    print(matrix[0])
    print(matrix[3])
    print(dot_ndarray(matrix[0], matrix[3]))
    print(matrix.shape[0])
    print(get_gx_matrix(gx, 2))
