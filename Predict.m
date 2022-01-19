function [mu, cov, sigma] = Predict(x_train, y_train, x_test, param, name)
    %   根据训练数据x_train,y_train,测试数据x_test和核函数name,参数param
    %   生成测试数据的预测值的均值mu，协方差cov和方差var
    %   高斯过程回归的核心公式执行

    KXX = KernelFunc(x_train, x_train, param, name);
    KxX = KernelFunc(x_test, x_train, param, name);
    Kxx = KernelFunc(x_test, x_test, param, name); %用核函数计算协方差矩阵

    mu = (KxX * inv(KXX) * y_train)'; % 高斯条件均值
    cov = Kxx - KxX * inv(KXX) * KxX'; %高斯条件协方差
    sigma = (diag(cov))';
end
