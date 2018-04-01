#!/bin/bash
#own justocer
echo "--- Hardware ---" > task4_1.out
lscpu|grep "Model name"| sed 's/Model name/CPU/' | sed 's/\s\+/ /' >> task4_1.out
dmidecode | grep "Maximum Capacity" | sed 's/^[ \t]*//' | sed 's/Maximum Capacity/RAM/' >> task4_1.out
{ echo "Motherbooard:"; cat /sys/devices/virtual/dmi/id/product_name || echo unknown; cat /sys/devices/virtual/dmi/id/product_version; } | sed ':a;N;s/\n/ /;ba' >> task4_1.out
{ echo "System Serial Number:"; cat /sys/devices/virtual/dmi/id/product_serial || echo unknown; } | sed ':a;N;s/\n/ /;ba' >> task4_1.out 
echo "--- System ---" >> task4_1.out
lsb_release -a | grep "Description" | sed 's/\s\+/ /' | sed 's/Description/OS Distribution/'  >> task4_1.out
{ echo "Kernel version:"; uname -a | cut -d" " -f3; } | sed ':a;N;s/\n/ /;ba' >> task4_1.out
dumpe2fs $(mount | grep 'on / ' | awk '{print $1}') | grep 'Filesystem created:' | sed 's/:[ \t]*/: /' >> task4_1.out 
{ echo "Hostname:"; hostname; } | sed ':a;N;s/\n/ /;ba' >> task4_1.out
{ echo "Uptime:"; uptime -p; } | sed ':a;N;s/\n/ /;ba' >> task4_1.out
{ echo "Processes running:"; ps aux | wc -l; } | sed ':a;N;s/\n/ /;ba' >> task4_1.out
{ echo "User logged in:"; users | wc -w; } | sed ':a;N;s/\n/ /;ba' >> task4_1.out
echo "--- Network ---" >> task4_1.out
#it's really trap, now is a good and faster solver, but later i'll be feel myself fool if see that code
#next code is searching some info and with sed choose what we need
cnt=`ls /sys/class/net | wc -w`
case $cnt in 1)
{ echo 'Iface #1'; ip a | grep -w "1:" | sed  's/^1:\(.*\):.*/\1/'; echo ':'; dich=`ip a | grep -w "1:" | sed  's/^1: \(.*\):.*/\1/'`; ip a show $dich | grep -w "inet" | awk '{ print $2}'; } | sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
;;
#for 2 interfaces
2)
{ echo 'Iface #1'; ip a | grep -w "1:" | sed  's/^1: \(.*\):.*/\1/'; echo ':'; dich=`ip a | grep -w "1:" | sed  's/^1: \(.*\):.*/\1/'`; ip a show $dich | grep -w "inet" | awk '{ print $2}'; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
 { echo 'Iface #2'; ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'; echo ':'; dich2=`ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'`; ip a show $dich2 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
;;
#for 3 interfaces
3)
{ echo 'Iface #1'; ip a | grep -w "1:" | sed  's/^1:\(.*\):.*/\1/'; echo ':'; dich=`ip a | grep -w "1:" | sed  's/^1: \(.*\):.*/\1/'`; ip a show $dich | grep -w "inet" | awk '{ print $2}'; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
 { echo 'Iface #2'; ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'; echo ':'; dich2=`ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'`; ip a show $dich2 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba'  | sed 's/ :[ \t]*/: /' >> task4_1.out
{ echo 'Iface #3'; ip a | grep -w "3:" | sed  's/^3: \(.*\):.*/\1/'; echo ':'; dich3=`ip a | grep -w "3:" | sed  's/^3: \(.*\):.*/\1/'`; ip a show $dich3 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
;;
#Johnny, mother fucker, blank spaces are in the trees, in the trees!
4)
{ echo 'Iface #1'; ip a | grep -w "1:" | sed  's/^1:\(.*\):.*/\1/'; echo ':'; dich=`ip a | grep -w "1:" | sed  's/^1: \(.*\):.*/\1/'`; ip a show $dich | grep -w "inet" | awk '{ print $2}'; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
 { echo 'Iface #2'; ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'; echo ':'; dich2=`ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'`; ip a show $dich2 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
{ echo 'Iface #3'; ip a | grep -w "3:" | sed  's/^3: \(.*\):.*/\1/'; echo ':'; dich3=`ip a | grep -w "3:" | sed  's/^3: \(.*\):.*/\1/'`; ip a show $dich3 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
{ echo 'Iface #4'; ip a | grep -w "4:" | sed  's/^4: \(.*\):.*/\1/'; echo ':'; dich4=`ip a | grep -w "4:" | sed  's/^4: \(.*\):.*/\1/'`; ip a show $dich4 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
;;
[5-10])
{ echo 'Iface #1'; ip a | grep -w "1:" | sed  's/^1:\(.*\):.*/\1/'; echo ':'; dich=`ip a | grep -w "1:" | sed  's/^1: \(.*\):.*/\1/'`; ip a show $dich | grep -w "inet" | awk '{ print $2}'; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
 { echo 'Iface #2'; ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'; echo ':'; dich2=`ip a | grep -w "2:" | sed  's/^2: \(.*\):.*/\1/'`; ip a show $dich2 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
{ echo 'Iface #3'; ip a | grep -w "3:" | sed  's/^3: \(.*\):.*/\1/'; echo ':'; dich3=`ip a | grep -w "3:" | sed  's/^3: \(.*\):.*/\1/'`; ip a show $dich3 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
{ echo 'Iface #4'; ip a | grep -w "4:" | sed  's/^4: \(.*\):.*/\1/'; echo ':'; dich4=`ip a | grep -w "4:" | sed  's/^4: \(.*\):.*/\1/'`; ip a show $dich4 | grep -w "inet" | awk '{ print $2}' || echo unknown; } |sed ':a;N;s/\n/ /;ba' | sed 's/ :[ \t]*/: /' >> task4_1.out
echo "i\'m lazy, sorry" >> task4_1.out
;;
esac
#delete blank spaces
#sed 's/:[ \t]*/:/'  tsk4_1.out >> task4_1.out
