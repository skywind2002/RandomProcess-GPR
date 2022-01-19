function [param] = Train(x_train, y_train, paramInit, argsnum, bound, logspace_flag, name)
    % 采取暴力方法,取很多组初始值一个个优化
    argsSearchTable = zeros(length(paramInit), argsnum);

    for i = 1:length(bound) / 2 %生成大量随机参数
        lowerBound = bound(2 * i - 1); %下界
        upperBound = bound(2 * i); %上界

        if logspace_flag == 1
            logArray = linspace(log(lowerBound), log(upperBound), argsnum);
            tmpArray = exp(logArray);
        else
            tmpArray = linspace(lowerBound, upperBound, argsnum);
        end

        tmpArray = tmpArray(randperm(length(tmpArray))); %随机打乱
        argsSearchTable(i, :) = tmpArray;
    end

    %对生成的随机参数每个进行优化搜索
    fmin = Inf; %初始化最小值变量

    for i = 1:argsnum
        param0 = argsSearchTable(:, i); %优化初值
        H = @(param)KernelLoss(x_train, y_train, param, name); %构造优化用的函数指针
        [tmpargs, fval] = fminunc(H, param0); %优化问题

        if fval < fmin && fval > 0 %避免奇异情况
            fmin = fval;
            argsmin = tmpargs;
        end

    end

    disp(fmin)
    param = argsmin;
end
