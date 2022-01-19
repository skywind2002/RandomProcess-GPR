function [muList, sigmaList] = ShortPredict(x_train, y_train, x_test, y, param, name)
    % 短时预测函数，长时的太不准确了
    % 针对每个时间，用它前面的数据来预测当天
    xSeq = x_train;
    ySeq = y_train';
    % 一路扫描获取mu和var
    muList = [];
    sigmaList = [];

    for i = 1:length(x_test)
        x = x_test(i); %对每一个x_test中的x分别预测
        %公式和长时的GPR一样，只不过x是一维的
        KXX = KernelFunc(xSeq, xSeq, param, name);
        Kxx = KernelFunc(x, x, param, name);
        KxX = KernelFunc(x, xSeq, param, name);
        mu = KxX * inv(KXX) * ySeq';
        var = Kxx - KxX * inv(KXX) * KxX';
        muList = [muList, mu];
        sigmaList = [sigmaList, var];
        xSeq = [xSeq(2:end), x];
        %ySeq=[ySeq(2:end),normrnd(mu,var/3)];   %利用已经预测出来的值进行迭代
        ySeq = [ySeq(2:end), y(x)]; %利用当日的测量数据进行迭代
    end

end
