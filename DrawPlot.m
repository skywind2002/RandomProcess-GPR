function [] = DrawPlot(mu, var, x_train, y_train, x_test, y_test)
    %  根据给定的数据作图
    upperBoundTest = mu + 1.96 * sqrt(var);
    lowerBoundTest = mu - 1.96 * sqrt(var); % 1.96为95 %置信度区间
    upper = zeros(1, length(x_train) + length(x_test));
    lower = zeros(1, length(x_train) + length(x_test));
    upper(x_test) = upperBoundTest;
    upper(x_train) = y_train;
    lower(x_test) = lowerBoundTest;
    lower(x_train) = y_train;

    plot(x_train, y_train, 'r');
    hold on;
    plot(x_test, (upperBoundTest + lowerBoundTest) / 2, 'b');
    plot(x_test, y_test, 'r');
    %对置信度区间染色
    fill([x_test, x_test(end:-1:1)], [upperBoundTest, lowerBoundTest(end:-1:1)], 'b', 'facealpha', 0.3);
    hold off;
end
