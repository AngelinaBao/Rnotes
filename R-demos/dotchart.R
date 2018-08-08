x <- mtcars[order(mtcars$mpg),]#����mpg�ӵ͵��߶�mtcars��������
x$color[x$cyl == 4] <- "Black" #����һ���ַ�����color��x�У�����cyl ��ֵ�ֱ�
#��color��ֵΪ"Black"��"Red"��"Blue"
x$color[x$cyl == 6] <- "Red"
x$color[x$cyl == 8] <- "Blue"
x$cyl <- factor(x$cyl) #����ֵ����cyl ת��Ϊ���ӣ��������groups���õ�cyl, ��groups����ѡ��һ������
dotchart(x$mpg, labels = rownames(x),
         groups = x$cyl,
         main = "Dotchart Of Miles per Gallon for Different Car Type",
         xlab = "Miles Per Gallon",
         color = x$color,
         gcolor = "Black",
         cex = .7,
         pch = 19
)