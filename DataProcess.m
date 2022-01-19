function [x_train, x_test, y_train, y_test] = DataProcess(filepath, split_ratio)
    %  ReadCsv函数，用于读取文件夹中的CSV股价文件
    csv = readtable(filepath);
    price = csv.Close_Last; % 读取股价，这是个cell类型的数组
    ch = (char(price)); % 转为数值类型的数组，作为y
    y = str2num(ch(:, 2:end)); % 去掉最前面一个碍事的$符号
    y = y - mean(y(:)); %归一化
    len = length(price); % 获取股价数组的长度
    x = 1:len; % 横坐标x就是天数，取为自然数列

    %接下来进行train和test的分裂，参数为split_ratio
    %由于股价预测是时间序列类型的预测，因此并不需要进行shuffle
    x_train = x(1:ceil(len * split_ratio));
    x_test = x(ceil(len * split_ratio) + 1:end);
    y_train = y(1:ceil(len * split_ratio));
    y_test = y(ceil(len * split_ratio) + 1:end);
end
