import os
tot_m, used_m, free_m = map(int,os.popen('free -t -m').readlines()[-1].split()[1:])
cpu_percentage = str(round(float(os.popen('''grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' ''').readline()),2))
cpu_percentage1 = str(round(float(os.popen('''grep 'cpu0 ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' ''').readline()),2))
cpu_percentage2 = str(round(float(os.popen('''grep 'cpu1 ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' ''').readline()),2))
cpu_percentage3 = str(round(float(os.popen('''grep 'cpu2 ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' ''').readline()),2))
cpu_percentage4 = str(round(float(os.popen('''grep 'cpu3 ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' ''').readline()),2))


print cpu_percentage
print cpu_percentage1
print cpu_percentage2
print cpu_percentage3
print cpu_percentage4
