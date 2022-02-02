clc;
clear;

% hyperparam  超参数抉择，主要有数据来源，参数搜索方式，组数，核函数
filename = "1Y.csv";
filepath = "./data/" + filename;
split_ratio = 0.1;

logspace_flag = 1; %参数搜索时是否采用对数空间
argsnum = 100; %参数搜索组数
kernel_name = ['eqk']; %有eqk,pk,lpk三种选择，具体来源https://peterroelants.github.io/posts/gaussian-process-kernels/
% 参考文献A tutorial on Gaussian process regression: Modelling, exploring, and exploiting functions[J]. Journal of Mathematical Psychology, 2018, 85:1-16

switch kernel_name %根据不同的核函数选择初始参数
    case "eqk" %平方指数核的参数[l,sigma],以及对应的搜索上下限
        paramInit = [1, 10];
        bound = [1e-1, 1e3, 1e-1, 1e2];
    case "pk"
        paramInit = [1, 10, 10]; %周期核的参数[l,sigma,p],以及对应的搜索上下限
        bound = [1e-1, 1e3, 1e-1, 1e3, 5, 1e2];
    case "lpk"
        paramInit = [1, 0.1, 10, 10]; %局部周期核的参数[lse,lp,p,sigma],以及对应的搜索上下限
        bound = [1e-1, 1e3, 1e-1, 1e3, 5, 1e3, 1e-1, 1e3];
    otherwise
        disp("核函数错误!");
        return; %终止整个程序的运行
end

%preprocessing  分离测试集和训练集
[x_train, x_test, y_train, y_test] = DataProcess(filepath, split_ratio);
y = [y_train; y_test];

%train  蛮力法获取最优参数
param = Train(x_train, y_train, paramInit, argsnum, bound, logspace_flag, kernel_name);

%predict 根据最优参数进行预测
%[mu_test, cov_test, sigma_test] = Predict(x_train, y_train, x_test, param, kernel_name); %长期预测，效果不佳
[mu_test,sigma_test]=ShortPredict(x_train,y_train,x_test,y,param,kernel_name);
%短期预测 效果良好

%draw  画图
DrawPlot(mu_test, sigma_test, x_train, y_train, x_test, y_test);
