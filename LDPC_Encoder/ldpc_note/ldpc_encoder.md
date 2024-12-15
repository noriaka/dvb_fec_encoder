#### I. DVB-S2 Encoding Algorithm

---

码字：
$$\begin{equation*} c=[i_{0},i_{1},i_{2}\cdots i_{k-1}, p_{o},p_{1}\cdots p_{n-k-1)}] \tag{1}\end{equation*}$$
校验：
$$\begin{equation*} H_{(n-k) \times n} \cdot c = 0 \tag{2}\end{equation*}$$

---

1. Tanner图：
   
    + $VN$: variable nodes, n
    + $CN$: check nodes, n - k
    + $IN$: information nodes, k
    + $PN$: parity nodes, n - k

2. Tanner图由$VN$和$CN$构成，校验矩阵$H$中$(i, j)$的值为1，则$CN_i$和$VN_j$之间有边

3. $VN$包含$PN$和$IN$，$IN$则根据公式分成360组，其中$L=360$，同一组内Tanner图的边数相同
   $$\begin{equation*} t=\frac {k}{L} \tag{3}\end{equation*}$$

4. 协议中规定了校验矩阵中每个分组的第一列值为1的行数，代表了$CN$节点和$IN_0$的边数，其余359个$IN_i$节点和$CN$的边由以下公式计算得出，其中$i\varepsilon\{0,1,...,L-1\}$，$w=n-k$，$q=(n-k)/L$
   $$\begin{align*} \begin{cases} \displaystyle |a_{0}+i\cdot q|_{n-k} \\ \displaystyle |a_{1}+i\cdot q|_{n-k} \\ \displaystyle \vdots \\ \displaystyle |a_{w-1}+i\cdot q|_{n-k} \end{cases} \tag{4}\end{align*}$$
   同时可用Tanner图表示该运算：
   ![alt text](1717556646904.png)

5. 协议中的表有以下规律，其中$W=t_1*w_1+t_2*w_2$：
   ![alt text](1717557343625.png)
   ![alt text](1717557370777.png)

6. 校验矩阵的形式：
   ![alt text](1717557541659.png)

---

#### II. Repeat and Accumulate Encoding

---

1. 校验矩阵结构：
   $$\begin{equation*} \textbf {H}_{(n-k)\times n}=[\textbf {A}_{\left ({n-k}\right)\times k}~~\textbf {B}_{\left ({n-k}\right)\times \left ({n-k}\right)}] \tag{6}\end{equation*}$$
   $$\begin{align*} &\hspace {-1pc}\textbf {H}_{(n-k)\times n} \\ &=\left [{\begin{matrix} a_{0,0}& \cdots & a_{0,k-1}& 1& 0& 0& \cdots & 0& 0\\ a_{1,0}& \cdots & a_{1,k-1}& 1& 1& 0& \cdots & 0& 0\\ a_{2,0}& \cdots & a_{2,k-1}& 0& 1& 1& \cdots & 0& 0\\ \vdots & \ddots & \vdots & \vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\ a_{n-k-2,0}& \cdots & a_{n-k-2,~k-1}& 0& 0& 0& \cdots & 1& 0\\ a_{n-k-1,0}& \cdots & a_{n-k-1,~k-1}& 0& 0& 0& \cdots & 1& 1\\ \end{matrix}}\right] \\ \normalsize \tag{7}\end{align*}$$
2. 校验位计算，根据公式$H·c^T=0$得到：
   $$\begin{align*} \begin{matrix}(a_{0,0}i_{0}+a_{0,1}i_{1}+\ldots +a_{0,k-1}i_{k-1})+p_{0}=0\\ (a_{1,0}i_{0}+a_{1,1}i_{1}+\ldots +a_{1,k-1}i_{k-1}+p_{0})+p_{1}=0\\ \vdots \\ {(a}_{n-k-1,0}i_{0}+a_{n-k-1,1}i_{1}+\ldots \,\,+a_{n-k-1,K-1}i_{k-1}+\\ +p_{n-k-2})+p_{n-k-1}=0\\ \end{matrix} \tag{8}\end{align*}$$
   同时由于在$GF(2)$域中$x+x=0$，则：
   $$\begin{align*} \begin{matrix} p_{0}=(a_{0,0}i_{0}+a_{0,1}i_{1}+\ldots \,\,+a_{0,k-1}i_{k-1})\\ p_{1}={(a}_{1,0}i_{0}+a_{1,1}i_{1}+\ldots \,\,+a_{1,k-1}i_{k-1})\,\,+p_{0}\\ \vdots \\ p_{n-k-1}=(a_{n-k-1,0}i_{0}+a_{n-k-1,1}i_{1}+\ldots \,\,+\\ +a_{n-k-1,k-1}i_{k-1})+p_{n-k-2}\\ \end{matrix} \tag{9}\end{align*}$$
   设，其中$r\varepsilon\{0,1,...,n-k-1\}$：
   $$\begin{equation*} \textbf {S}_{1\times (n-k)}=\textbf {i}_{k}\cdot \textbf {A}_{k\times \left ({n-k}\right)}^{T}=\left [{~s_{0},~s_{1}\ldots s_{n-k-1}}\right] \tag{10}\end{equation*}$$
   $$\begin{align*} s_{r}=a_{r,0}i_{0}+a_{r,1}i_{1}+\ldots \,\,+a_{r,k-1}i_{k-1}=\,\,\sum _{j=0}^{k-1}{i_{j}~\cdot a_{r,j}} \\{}\tag{11}\end{align*}$$
   代入后简化为：
   $$\begin{align*} \begin{matrix}p_{0}=s_{0}\\ p _{1}=s_{1}+p_{0}=s_{1}+s_{0}\\ p _{2}=s_{2}+p_{1}=s_{2}+s_{1}+s_{0}\\ \vdots \\ p _{n-k-1}=s_{n-k-1}+p_{n-k-2}=s_{n-k-1}+s_{n-k-2}+\\ +\cdots +s_{1}+s_{0}\\ \end{matrix} \tag{12}\end{align*}$$
   因此校验位计算公式为：
   $$\begin{equation*} p_{i}=\sum _{r=0}^{i~}s_{r}=s_{i}+s_{i-1}+\cdots +s_{1}+s_{0} \tag{14}\end{equation*}$$
3. LDPC编码步骤分为两步：即$s_r$的计算和$s_r$的累加，因此也被称为不规则重复累加码 [Irregular Repeat Accumulate (IRA) code]
4. 这样直接编码速度慢，没有利用A矩阵稀疏的特性

---

#### III. Vectorised IRA Coding

---

1. $s_r$计算，设$IN(r)$为连接到$CN_r$的$IN$节点集合，则可计算得到：
   
```python
# 初始化s[r]
for r in range(0, n-k):
    s[r] = 0
for r in range(0, n-k):
    # 遍历H中第r行值为1的列数
    for z in IN[r]:
        s[r] = s[r] + i[z]
```

2. 由于这样计算是先遍历行后遍历列，逐个计算出$s_r$，在计算的时候需要知道$IN$的全部信息，所以不便于硬件实现，于是改变遍历顺序先列后行，同时设$CN(c)$为连接到$IN_c$的$CN$节点集合：
```python
# 初始化s[r]
for r in range(0, n-k):
   s[r] = 0

for c in (0, k-1):
   # 遍历H中第c列值为1的行数
   for r in CN(c):
      s[r] = s[r] + i[c]
```

3. 考虑到代码的循环性，使用L度并行来提高吞吐量，于是设：
   $$\begin{equation*} \textbf {i}_{m}=\left [{i_{360m},~i_{360m+1},~i_{360m+2},~\ldots i_{360m+359}}\right] \tag{17}\end{equation*}$$
   其中$m\varepsilon\{0,1,...,t-1\}$，则公式(10)变为：
   $$\begin{equation*} {\textbf {S}\prime }_{1\times (N-K)}=\,\,\left [{\textbf {S}_{0},~\textbf {S}_{1},~\ldots,~\textbf {S}_{q-1}}\right] \tag{18}\end{equation*}$$
   其中$S_j$为一个360 bit的向量，$j\varepsilon\{0,1,...,q-1\}$：
   $$\begin{equation*} \textbf {S}_{j}=[s_{j},s_{j+q},s_{j+2q,}\ldots s_{j+359q}] \tag{19}\end{equation*}$$
   此时设$\textbf{S}_M$为：
   $$\begin{align*} \textbf {S}_{M}=\left [{\begin{matrix}\textbf {S}_{0}\\ \textbf {S}_{1}\\ \vdots \\ \textbf {S}_{q-1}\\ \end{matrix}}\right]=\left [{\begin{matrix}s_{0}&s_{q}&\cdots &s_{359q}\\ s _{1}&s_{1+q}&\cdots &s_{359q+1}\\ \vdots &\vdots &\ddots &\vdots \\ s _{q-1}&s_{2q-1}&\cdots &s_{360q-1}\\ \end{matrix}}\right] \tag{20}\end{align*}$$

4. 计算时我们需要通过$CN(c)$来得到$CN(c+j)$，这里的$j\varepsilon\{1,2,...,L-1\}$。当$CN_r$连接到$IN_c$时，有$r\varepsilon CN(c)$，则$|r+j \cdot q|_{n-k}\varepsilon CN(c+j)$。同时因为$L=360$，所以需同时计算360个值即$[s_r,s_{|r+q|_{n-k}},s_{|r+2q|_{n-k}},...,s_{|r+359q|_{n-k}}]$，然而其中$r\varepsilon \{0,1,...,n-k-1\}$，因此计算出的向量并不能和$\textbf{S}_M$中的行向量对应。要将它们进行对应则要找到$s_r$在$\textbf{S}_M$中的位置，然后将输入的$\textbf{i}_m$进行适当的循环右移来计算得到，具体算法如下：

```python
# q = (n-k)/L, t = k/L, L=360
for r in range(0, n-k):
   s[r] = 0

for m in range(0, t):
   # 获取每个分组中第一列值为1的索引r
   for r in CN(c=360*m):
      # 计算分组中所有列
      s[r] = s[r] + i[360*m]
      s[(r+q)%(n-k)] = s[(r+q)%(n-k)] + i[360*m+1]
      s[(r+2*q)%(n-k)] = s[(r+2*q)%(n-k)] + i[360*m+2]
      ...
      s[(r+359*q)%(n-k)] = s[(r+359*q)%(n-k)] + i[360*m+359]

# 初始化SM矩阵
SM = np.zeros((q, L), dtype=int)
for m in range(0, t):
   for r in CN(c=360*m):
      # 找到sr在矩阵中的位置(j, x)
      j = r % q
      x = r // q
      # 将输入数据i进行循环右移x位后与矩阵的第j行相加
      SM[j] = SM[j] + (i[-x:] + i[:-x])
```

5. 校验位计算：首先设$\textbf{S}_C$为：
   $$\begin{align*} \textbf {S}_{C}=\left [{\begin{matrix}\sum _{i=0}^{q-1}s_{i}&\sum _{i=q}^{2q-1}s_{i}&\sum _{i=2q}^{3q-1}s_{i}&\cdots &\sum _{i=359q}^{360q-1}s_{i}\\ \end{matrix}}\right] \tag{21}\end{align*}$$
   由于$\textbf{S}_C$是对矩阵$\textbf{S}_M$每列的累加和即对$S_j$的累加，因此计算时不需考虑第$j$行，同时需注意两者的运算可以并行执行,算法如下：

```python
# 初始化SC向量
for i in range(0, 360):
   SC[i] = 0

for m in range(0, t):
   for r in CN(c=360*m):
      # 计算偏移位数x
      x = r // q
      SC = SC + (i[-x:] + i[:-x])
```

接着设矩阵$\textbf{L}_{L\times L}$为下三角矩阵并进行运算：
$$\begin{align*} \textbf {L}=\left [{\begin{matrix}1&\quad 0&\quad 0&\quad \ldots &\quad 0&\quad 0\\ 1&\quad 1&\quad 0&\quad \ldots &\quad 0&\quad 0\\ 1&\quad 1&\quad 1&\quad \ldots &\quad 0&\quad 0\\ \vdots &\quad \vdots &\quad \vdots &\quad \ddots &\quad \vdots &\quad \vdots \\ 1&\quad 1&\quad 1&\quad \ldots &\quad 1&\quad 0\\ 1&\quad 1&\quad 1&\quad \ldots &\quad 1&\quad 1\\ \end{matrix}}\right]_{L\times L} \tag{22}\end{align*}$$

$$\begin{align*} \begin{matrix} &\hspace {-12pc}\textbf {L}\cdot \textbf {S}_{C}^{T} \\ &=\left [{\begin{matrix}\sum _{i=0}^{q-1}s_{i}&\sum _{i=0}^{2q-1}s_{i}&\sum _{i=0}^{3q-1}s_{i}&\cdots &\sum _{i=0}^{360q-1}s_{i}\\ \end{matrix}}\right]^{T}~\end{matrix} \tag{23}\end{align*}$$

然后可将结果转置后逻辑右移得到校验向量的初始状态：
$$\begin{align*} \textbf {P}_{init}&=\left [{\begin{matrix}0&\sum _{i=0}^{q-1}s_{i}&\sum _{i=0}^{2q-1}s_{i}&\cdots & \sum _{i=0}^{359q-1}s_{i}\\ \end{matrix}}\right] \\ &=\left [{\begin{matrix}0&p_{q-1}&p_{2q-1}&\cdots &p_{359q-1}\\ \end{matrix}}\right]\tag{24}\end{align*}$$

最后根据公式(14)可以得到：
$$\begin{align*} \begin{cases} \displaystyle \begin{matrix}[p_{0} p_{q} \cdots p_{359q}]= \\ =[0 p_{(q-1)} \cdots p_{(359q-1)}]+[s_{0} s_{q} \cdots s_{359q}]\end{matrix} \\ \displaystyle \begin{matrix}[p_{1} p_{(q+1)} \cdots p_{(359q+1)}]= \\ =[p_{0} p_{q} \cdots p_{359q}]+[s_{1} s_{(1+q)} \cdots s_{(1+359q)}]\end{matrix}\\ \displaystyle \begin{matrix}[p_{2} p_{(q+2)} \cdots p_{(359q+2)}]= \\ =[p_{1} p_{(q+1)} \cdots p_{(359q+1)}]+[s_{2} s_{(2+q)} \cdots s_{(2+359q)}]\end{matrix} \\ \displaystyle \vdots \\ \displaystyle \begin{matrix}[p_{(q-1)} p_{(2q-1)} \cdots p_{(n-k-1)}]= \\ =[p_{(q-2)} p_{(2q-2)} \cdots p_{(n-k-2)}]+ [s_{(q-1)} s_{(2q-1)} \cdots s_{(n-k-1)}]\end{matrix} \end{cases} \\{}\tag{25}\end{align*}$$

设$\textbf{P}_j$为：
$$\begin{align*} \textbf {P}_{j}=\left [{\begin{matrix}p_{j}&p_{j+q}&p_{j+2q}&\cdots &p_{j+359q}\\ \end{matrix}}\right] \tag{26}\end{align*}$$
则上述运算可简化为：
$$\begin{align*} \begin{cases} \displaystyle P_{0}=\textbf{P}_{init}=[0 p_{q-1} p_{2q-1} \cdots p_{359q-1}]\\ \displaystyle P_{j}=S_{j}+P_{j-1} \end{cases} \tag{27}\end{align*}$$
同样设矩阵$\textbf{P}_M$为：
$$\begin{align*} \textbf {P}_{M}&= \\ \left [{\begin{matrix}\textbf {P}_{0}\\ \textbf {P}_{1}\\ \textbf {P}_{2}\\ \vdots \\ \textbf {P}_{q-1}\\ \end{matrix}}\right]&=\left [{~\begin{matrix}p_{0}&p_{q}&p_{2q}&\ldots &p_{359q}\\ p _{1}&p_{q+1}&p_{2q+1}&\ldots &p_{359q+1}\\ p _{2}&p_{q+2}&p_{2q+2}&\ldots &p_{359q+2}\\ \vdots &\vdots &\vdots &\ddots &\vdots \\ p _{q-1}&p_{2q-1}&p_{3q-1}&\ldots &p_{N-K-1}\\ \end{matrix}}\right]_{q \times L} \tag{28}\end{align*}$$
其中$P_j$的计算算法如下：

```python
PM[0] = P_init
for j in (1, q):
   PM[j] = SM[j] + PM[j-1]
```

6. 以上计算存在两个问题：
    + 校验位初始向量$\textbf{P}_{init}$需要通过$\textbf{S}_C$得到，而$\textbf{S}_C$又需要等所有的$S_j$计算完成才能计算出
    + 每次并行计算得到的$L=360$个校验位未按正常顺序输出，需要增加一个排序操作

---

#### IV. Vectorized Quasi-Cyclic Encoding

---

|$code rate$| $t_1$ | $w_1$ | $t_2$ | $w_2$ | $t_1+t_2$| $q$| $L/q$ |
| :-------: | :---: | :---: | :---: | :---: |:--------:|:--:| :---: |
|    1/3    |   20  |   12  |   40  |   3   |    60    | 120|   3   |
|    1/2    |   36  |   8   |   54  |   3   |    90    | 90 |   4   |
|    3/5    |   36  |   12  |   72  |   3   |    108   | 72 |   5   |
|    2/3    |   12  |   13  |  108  |   3   |    120   | 60 |   6   |
|    3/4    |   15  |   12  |  120  |   3   |    135   | 45 |   8   |
|    4/5    |   18  |   11  |  126  |   3   |    144   | 36 |   10  |
|    5/6    |   15  |   13  |  135  |   3   |    150   | 30 |   12  |
|    8/9    |   20  |   4   |  140  |   3   |    160   | 20 |   18  |
|    9/10   |   18  |   4   |  144  |   3   |    162   | 18 |   20  |

$t_{1_{sum}}=20+36+36+12+15+18+15+20+18=190$
$t_{2_{sum}}=40+54+72+108+120+126+135+140+144=939$ 
