#relweights()函数，计算预测变量的相对权重
relweights <- function(fit,...){
  R <- cor(fit$model)    #得到数据集的相关系数
  nvar <- ncol(R)  #求数据集的列数
  rxx <- R[2:nvar, 2:nvar] #得到只含预测变量的数据集
  rxy <- R[2:nvar, 1] #得到x和y关系系数的向量
  svd <- eigen(rxx)  #求预测变量矩阵的特征值和特征向量
  evec <- svd$vectors #得到特征向量
  ev <- svd$values #得到特征值
  delta <- diag(sqrt(ev)) #得到对角值为特征值开方的对角矩阵
  lambda <- evec %*% delta %*% t(evec) #AxA^T模式，具体知识不记得
  lambdasq <- lambda ^ 2
  beta <- solve(lambda) %*% rxy
  rsquare <- colSums(beta ^ 2)
  rawwgt <- lambdasq %*% beta ^ 2
  import <- (rawwgt / rsquare) * 100
  import <- as.data.frame(import)
  row.names(import) <- names(fit$model[2:nvar])
  names(import) <- "Weights"
  import <- import[order(import),1, drop=FALSE]  #import的值按从小到大的顺序排列
  dotchart(import$Weights, labels=row.names(import),
           xlab="% of R-Square", pch=19,
           main="Relative Importance of Predictor Variables",
           sub=paste("Total R-Square=", round(rsquare, digits=3)),
           ...)
  return(import)
}
#relweights函数的应用
states <- as.data.frame(state.x77[,c("Murder", "Population",
                                     "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Income + Illiteracy + Frost, data = states)
relweights(fit)
#由图可知各个预测变量对模型的解释程度（R平方=0.567）
#可以看出，Illiteracy解释了59%的R平方，所以Illiteracy有最大的相对重要性，
#其次是Frost, Population, Income