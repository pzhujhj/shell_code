# !bin/sh

flag=0
TIMEOUT=${1:-60}
TIME=0

#####${}的特殊用法总结
test1()
{
	vid=123456789
	vid=${vid:0:4} #表示取vid的前4个数据
	echo $vid
	vid="abcdeffdg"
	vid=${vid:5} #表示取第5后面的数据
	echo $vid

	### $1如果为空m取值start的值,如果不为空m取值$1的值
	start=6
	m=${1:-$start} 
	echo $m
}

##trap 捕捉信号 trap commond signal-list
trap sighandle SIGUSR1 

sighandle() {
	flag=1
}

while [ $flag == "0" ];do
	value=`cat $PWD/1.txt`
	[ "$value" == "1" ] && {
		echo "come"	
		kill -SIGUSR1 $$
	}

	TIME=$((TIME+1))
	[ "$TIME" -gt "$TIMEOUT" ] && {
		echo "time out"
		break
	}

	sleep 1
done

test1
