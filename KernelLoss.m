function loss=KernelLoss(x,y,param,name)
  % 计算当前参数的Loss函数，以此作为优化的标准
  K=KernelFunc(x,x,param,name)+1e-8*eye(length(x));  % 1e-8为噪声大小
  loss=y*inv(K)*y'/2+log(abs(det(K)))/2;
end