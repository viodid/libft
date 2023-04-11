ram_usage=$(free -m | awk '/Mem:/ { print $3}')
echo ram_usage
wall "
  #Architecture: $(uname -a)
  #CPU physical: $(egrep "^processor" /proc/cpuinfo | wc -l)
  #vCPU: $(egrep "^processor" /proc/cpuinfo | wc -l)
  #Memory Usage: $(free -m | awk '/Mem:/ { print $3}')MiB/$(free -m | awk '/Mem:/ { print $2}')MiB
"
