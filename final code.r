###Neuron as a continuous time markov chain : the transition probability matrix depends on the input(only transition from the armed state(0 state ) depends on the input. Also transition rates depend on the input.)###	
	#############################################################################################################################################################################################
result <- data.frame('rate when input is zero' = rep(0,length(seq(0.05,0.095,0.005))),'rate when input is non-zero'= rep(0,length(seq(0.05,0.095,0.005))),row.names = seq(0.05,0.095,0.005))
i = 1
for (c_0 in seq(0.05,0.095,0.005))
{

a = 10
b = 20
 #0.08 #constant y value

 #(1 / (b-a)) - c_0
r0 <- 0.01
y_t<-function(t,a,b,c)
{
	if (t >=a & t<=b)
	{
		return (c)
	}
	else
	{
		return (0)
	}
}

probability_fired_armed<-function(c_0,t,a,b,r0)
{	
	if (t >=a & t<=b)
	{
		return(c_0 * 10)
	}
	else
	{
		return(r0 * 10)
	}
}
rate<-function(time,a,b,average_recov_time,input)
{
	if (time>=a & time<=b)
	{
		return(c(1 / (0.12 - input),1 / average_recov_time))
	}
	else
	{
		return(c(1 / average_recov_time,1 / average_recov_time))
	}
}
	


pdf(paste( 'constant_y = ', sub( '.','.',c_0, fixed = TRUE ), '.pdf', sep = '' ),paper = 'special', height = 8.4, width = 16)
states<-c(0,1)
average_recovery_time = 0.1 
recovery_rate = 1/0.1
X0<- 0 #initial state
X<-X0
#rates<- c(1 / (0.12 - c_0) ,1/average_recovery_time)

time = 0
fire_time<-NULL
recovery_period<-NULL

while(time[length(time)]<= b + 10)
{
	rates <- rate(time[length(time)],a,b,average_recovery_time,c_0)
	#print(rates)
	if(X[length(X)]==0)
	
	{
		time = c(time,time[length(time)] + rexp(1,rates[1]))
		p_t<-probability_fired_armed(c_0,time[length(time)],a,b,r0)	
		X <-c(X, sample(c(0,1),1,prob = c(1-p_t,p_t)))

	
		if (X[length(X)]==1)
		{
			fire_time<-c(fire_time,time[length(time)])
		}
	}
	if (X[length(X)]==1)
	{
		time = c(time,time[length(time)] + rexp(1,rates[2]))
		X <-c(X, sample(c(0,1),1,F,prob = c(1,0)))
		recovery_period <- c(recovery_period,time[length(time)] - time[length(time)-1])
	
	}
}

result [i,1]<-sum(fire_time<=10 | fire_time >= 20)/sum(time<=10|time>=20)
result[i,2]<-sum(fire_time>=10 & fire_time <= 20)/sum(time>=10&time<=20)
plot.new()

plot.window(xlim = c(0,30),ylim = c(0,2))
title(main = paste("Neuron Firing Pattern for constant input = ", c_0),xlab = "Time", ylab = "Fire / Not Fire")
axis(1)
axis(2)

points(fire_time,rep(1,length(fire_time)),col = 'black',pch = 19,main = paste("Neuron fire pattern for input = ", c_0))

dev.off()
i<-i+1
}
#time[1:which(time>=a)[1] - 1]
#X[1:which(time>=a)[1] - 1]
#sum(fire_time<a|fire_time>b)
#sum(fire_time>10)/sum(time>10)

#time<-seq(0,21,0.0001)





#time_fire<-function(t,y,r0)
#{

#	return(rexp(1,y(t)+r0))
#}


#time_recovery <-rexp(1,1)
	
#y is a function of t but we can make it independant by making the value of y constant for range of T: a<=t<=b

#X_0 = 1






 
