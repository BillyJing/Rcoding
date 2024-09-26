#Week 2 
#Tidy data and data wrangling
# 什么是整洁的数据
# 1、每一列是一个变量（一个参数）
# 2、每一行是一个观测（一个数据）

df1 <- data.frame (
  name = c("小明", "小红", "小刚","小李"),
  midterm = c(100, 90, 95, 50),
  final = c(60, 100, 95, 30)
)

df1

df2 <- data.frame (
  name = c("midterm", "final"),
  xiaoMing = c(100, 90),
  xiaoHong = c(60, 100),
  xiaoGang = c(70, 25)
)
df2

#需要避免
#融合单元格
#重复的/无意义的列名（列）
#注释/多余的信息
#空行


#package dplyr
install.packages("dplyr")
#package tidyverse
install.packages("tidyverse")

#dplyr是tidyverse的一个子集
#tidyverse包括dplyr ggplot and etc.

library(tidyverse)
library(dplyr)
#常用函数
#select() filter() arrange() mutate() summarise()

#help fucntion
#当不确定某个函数怎么用的时候 help()
help(select)

#导入starwar数据集
data("starwars")


#了解数据集
head(starwars)
names(starwars)


#selsct()
#通过名称筛选所需列
help("select")

#常见的select函数用法
select(starwars,name, height,mass)
select(starwars,-name)
select(starwars, name, starts_with("skin"))
select(starwars, name, ends_with("color"))
select(starwars, name, contains("color"))

#%>% 管道符
#将前面的结果传到后面做输入

starwars %>% select(name, height, mass) %>% select(-height)

#filter()按条件筛选行
filter(starwars, species == "Droid")
filter(starwars, skin_color != "gold")
# and & vs. or|
filter(starwars, species == "Droid" & skin_color == "gold")
filter(starwars, species == "Droid" | skin_color == "gold")

#arrange() 根据某列数据进行排序 默认升序
arrange(starwars,height)
arrange(starwars, desc(height))

#mutate()根据已有的数据，通过运算添加列
starwars %>%
  select(name, height, mass) %>%
  mutate(bmi = mass / ((height / 100)  ^ 2))

#distinct() 不重复的值
print(distinct(starwars,species),n=38)

#count()计算出现次数/frequency table
count(starwars, species)

#summarise()
summarise(starwars, 
          min_ht = min(height,na.rm = TRUE),
          avg_ht = mean(height,na.rm = TRUE),
          med_ht = median(height,na.rm = TRUE),
          max_ht = max(height,na.rm = TRUE),
          sd_ht = sd(height,na.rm = TRUE))


#group_by
starwars %>%
  group_by(species) %>%
  summarise(
    mass = mean(mass, na.rm = TRUE)
  )


#Data type and class
#character > double > integer > logical
typeof(1.7)

#数据类型转化as.character(), as.numeric(), as.integer() and as.logical()

#matrices, lists, data frames

#arrays, factors and dates

#arrays collection of matrices
M1 <- matrix(c(1, 4, 3, 6, 2, 3), 
             nrow = 2, ncol = 3)
M2 <- matrix(c(6, 2, 5, 1, 4, 3), 
             nrow = 2, ncol = 3)
array_matrix <- array(c(M1, M2), 
                      dim = c(2, 3, 2))
array_matrix

#factor 类型变量
x <- factor(c("BS", "MS", "PhD", "MS"))

factor(starwars$species)

#date
install.packages("lubridate")
library(lubridate)
#ymd(), dmy(), mdy()
ymd(20240926) 
ymd("2024 September 26") 
ymd("2024sep26") 
ymd("2024/09/26") 

#year(), month(), yday(), mday(), wday(), difftime()

t1 <- ymd(20240926) 
t2 <- ymd(20241002)

year(t1)
month(t2)
yday(t1)
mday(t2)
wday(t1,label = TRUE)
difftime(t1,t2,units = "days")
#时区
Sys.timezone()
with_tz(now(), "UTC")
with_tz(now(), "Etc/GMT-10")

#ggplot
#散点图，折线图，条形图，直方图
#install.packages("ggplot2")
#install.packages("datasauRus")
library(ggplot2)
library(datasauRus)
data(datasaurus_dozen)
head(datasaurus_dozen)

ggplot(datasaurus_dozen, aes(x = x, y = y, colour = dataset))+
  geom_point()+
  theme(legend.position = "none")+
  facet_wrap(~dataset, ncol = 3)

#散点图
ggplot(data = starwars, aes(x = height, y = mass))+
  geom_point()


#折线图，通常用来表示一个量随时间变化的规律
ggplot(data = ,aes(x = , y = )) +
  geom_line()

#条形图，通常用于对比频率，ggplot中geo_bar()可以对一个分类变量自动统计频数
ggplot(data = starwars, aes(x = hair_color))+
  geom_bar()

#直方图与条形图类似，不过反映的是连续取值的数值变量的分布
ggplot(data = starwars, aes(x = height,fill = sex))+
  geom_histogram()



