ram_usage=$(free -m | awk '/Mem:/ { print $3}')
ram_total=$(free -m | awk '/Mem:/ { print $2}')
percentage=$(echo "scale=2; $ram_usage / $ram_total" | bc)
echo $percentage
wall "
  #Architecture: $(uname -a)
  #CPU physical: $(grep "^processor" /proc/cpuinfo | wc -l)
  #vCPU: $(grep "^processor" /proc/cpuinfo | wc -l)
  #Memory Usage: ${ram_usage}MiB/${ram_total}MiB ${percentage}
"
