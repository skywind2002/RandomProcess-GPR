filename="1M.csv";
filepath="./data/"+filename;
split_ratio=0.5;

kernel_name='eqk';   %有eqk,pk,lpk三种选择，具体来源https://peterroelants.github.io/posts/gaussian-process-kernels/
% 参考文献A tutorial on Gaussian process regression: Modelling, exploring, and exploiting functions[J]. Journal of Mathematical Psychology, 2018, 85:1-16

switch kernel_name
    case "eqk"  %平方指数核的参数[l,sigma],以及对应的搜索上下限
        param=[1.16,12];
        bound=[1e-1,1e3,1e-1,1e2];
    case "pk"
        param=[1.16,12,10];  %周期核的参数[l,sigma,p],以及对应的搜索上下限
        bound=[1e-1,1e3,1e-1,1e3,5,1e2];
    case "lpk"
        param=[1.12,0.1,19,16.1];  %局部周期核的参数[lse,lp,p,sigma],以及对应的搜索上下限
        bound=[1e-1,1e3,1e-1,1e3,5,1e3,1e-1,1e3];
    otherwise
        disp("核函数错误!");
        return;  %终止整个程序的运行
end

[x_train,x_test,y_train,y_test]=DataProcess(filepath,split_ratio);

a=[1 2]
b=[2 3]
result=KernelFunc(a,b,kernel_name,param);

