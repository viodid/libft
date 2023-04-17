ram_usage=$(free -m | awk '/Mem:/ { print $3}')
ram_total=$(free -m | awk '/Mem:/ { print $2}')
percentage=$(free -m | awk '/Mem:/ { print $3/$2 * 100.0}')
disk_usage=$(df -h | grep /$  | awk '{ print $3}')
disk_total=$(df -h | grep /$  | awk '{ print $2}')
disk_percentage=$(df -h | grep /$  | awk '{ print $5}')
wall "
  #Architecture: $(uname -a)
  #CPU physical: $(grep "^processor" /proc/cpuinfo | wc -l)
  #vCPU: $(grep "^processor" /proc/cpuinfo | wc -l)
  #Memory Usage: ${ram_usage}MiB/${ram_total}MiB (${percentage}%)
  #Disk Usage: ${disk_usage}/${disk_total} (${disk_percentage}%)

"
