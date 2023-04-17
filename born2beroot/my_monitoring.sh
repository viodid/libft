ram_usage=$(free -m | awk '/Mem:/ { print $3}')
ram_total=$(free -m | awk '/Mem:/ { print $2}')
percentage=$(free -m | awk '/Mem:/ { print $3/$2 * 100.0}')
wall "
  #Architecture: $(uname -a)
  #CPU physical: $(grep "^processor" /proc/cpuinfo | wc -l)
  #vCPU: $(grep "^processor" /proc/cpuinfo | wc -l)
  #Memory Usage: ${ram_usage}MiB/${ram_total}MiB ${percentage}
"
