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

	###00:01:02:03:04:05中的:全部替换成-
	MAC1="00:01:02:03:04:05"
	MAC1=${MAC1//:/-}
	echo $MAC1

	###00:01:02:03:04:05中的第一个:替换成-
	MAC2="00:01:02:03:04:05"
	MAC2=${MAC2/:/-}
	echo $MAC2

:<<!
	${file#*/}:       拿掉第一条/及其左边的字符串
	${file##*/}:    拿掉最后一条/及其左边的字符串
	${file#*.}:       拿掉第一个.及其左边的字符串
	${file##*.}:    拿掉最后一个.及其左边的字符串
	${file%/*}:     拿掉最后条/及其右边的字符串
	${file%%/*}: 拿掉第一条/及其右边的字符串
	${file%.*}:    拿掉最后一个.及其右边的字符串
	${file%%.*}: 拿掉第一个.及其右边的字符串
!
	###test:id:0001 取值0001
	str="test:id:0001"
	str=${str##*:}
	echo $str
}

test1

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

