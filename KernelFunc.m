function result = KernelFunc(x1, x2, param, name)
    %  核函数计算,name指示不同的核函数类型
    %  函数会根据name和超参数param计算出向量x1和向量x2之间的协方差
    %  具体公式可以看实验报告
    switch name
        case "eqk"

            if (length(param) == 2) %平方指数核函数
                Distance = (x1.^2)' + (x2.^2) - 2 * x1' * x2;  % L2范数
                result = param(2)^2 * exp(-0.5 * Distance / (param(1)^2));
            else
                disp("参数个数与核函数不匹配!");
                return;
            end

        case "pk"

            if (length(param) == 3) %L1范数周期核函数
                Distance = abs(x1' - x2);  % L1范数
                result = Distance * pi / param(3);
                result = 2 * sin(result).^2 / (param(1))^2;
                result = param(2) * exp(-result);
            else
                disp("参数个数与核函数不匹配!");
                return;
            end

        case "lpk"

            if (name == "lpk" && length(param) == 4) %混合周期核函数
                Distance1 = abs(x1' - x2);  % L1范数
                Distance2 = (x1.^2)' + (x2.^2) - 2 * x1' * x2; % L2范数
                pk = Distance1 * pi / param(3);  
                pk = 2 * sin(pk).^2 / (param(2)^2);  % PK部分
                eqk = 1 ./ (2 * param(1)^2) * Distance2;  % EQK部分
                result = param(4) * exp(-pk - eqk);  % 混合
            else
                disp("参数个数与核函数不匹配!");
                return;
            end

        otherwise
            disp("无效的核函数!")
            return;
    end

end
