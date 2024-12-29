% p = dvbs2ldpc(2/5);
% disp(length(p));
data = load("F:\FileFolder\Graduation_Project\DVB-S2-FPGA\Project\Matlab_Project\atsc-long\H-n64800-k25920.mat");
p1 = logical(data.H);
% disp(length(p1));
% spy(p1);
cfg = ldpcEncoderConfig(p1);
% disp(cfg);

% 设定信息位的数量
numBits = cfg.NumInformationBits;

% 生成重复的二进制序列
infobits = repmat([1; 0], ceil(numBits / 2), 1);  % 生成足够的长度
infobits = infobits(1:numBits);  % 截取到所需长度
disp(length(infobits));
% infobits = randi([0 1],cfg.NumInformationBits,1);
enc = ldpcEncode(infobits,cfg);
% disp(length(enc));
% disp(enc);

fileID = fopen('F:\FileFolder\Graduation_Project\DVB-S2-FPGA\Git\dvb_fpga\matlab_ldpc_data\ldpc_atsc_6_15.txt', 'w');

% 将每个元素写入文件
fprintf(fileID, '%d\n', enc);

% 关闭文件
fclose(fileID);