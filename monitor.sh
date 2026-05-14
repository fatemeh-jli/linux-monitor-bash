#!/bin/bash


while true; do
  clear
  echo "System Resource Monitoring"
  echo "--------------------------"
  echo "Choose resource to monitor:"
  echo "1) CPU"
  echo "2) RAM"
  echo "3) Disk"
  echo "4) Show All"
  echo "5) Exit"
  echo -n "Enter your choice [1-5]: "
  read choice

case $choice in
1)
  echo "Monitoring CPU usage..."
  CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  COUNT=$(echo "$CPU / 2" | bc)
  BAR=$(printf "%0.s#" $(seq 1 $COUNT))
  echo -e "CPU Usage: [$BAR] $CPU%"

if (( $(echo "$CPU > 80" | bc -l) )); then
echo "WARNING: High CPU usage!"
else
echo "CPU usage is normal."
  fi
  ;;
2)
  echo "Monitoring RAM usage..."
  MEM=$(free | grep Mem)
  USED=$(echo $MEM | awk '{print $3}')
  TOTAL=$(echo $MEM | awk '{print $2}')
  PERCENT=$(echo "$USED*100/$TOTAL" | bc)
  COUNT=$(echo "$PERCENT / 2" | bc)
  BAR=$(printf "%0.s#" $(seq 1 $COUNT))
  echo -e "RAM Usage: [$BAR] $PERCENT%"

if (( PERCENT > 80 )); then
echo "WARNING: High RAM usage!"
else
echo "RAM usage is normal."
  fi
  ;;
3)
  echo "Monitoring Disk usage..."
  USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
  COUNT=$(echo "$USAGE / 2" | bc)
  BAR=$(printf "%0.s#" $(seq 1 $COUNT))
  echo -e "Disk Usage: [$BAR] $USAGE%"

if (( USAGE > 80 )); then
echo "WARNING: Disk space is almost full!"
else
echo "Disk space is sufficient."
  fi
  ;;
4)
  echo "Monitoring All resources..."
  CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  COUNT=$(echo "$CPU / 2" | bc)
  BAR=$(printf "%0.s#" $(seq 1 $COUNT))
  echo -e "CPU Usage:  [$BAR] $CPU%"
 
if (( $(echo "$CPU > 80" | bc -l) )); then
echo "WARNING: High CPU usage!"
else
echo "CPU usage is normal."
  fi
  echo ""
  MEM=$(free | grep Mem)
  USED=$(echo $MEM | awk '{print $3}')
  TOTAL=$(echo $MEM | awk '{print $2}')
  PERCENT=$(echo "$USED*100/$TOTAL" | bc)
  COUNT=$(echo "$PERCENT / 2" | bc)
  BAR=$(printf "%0.s#" $(seq 1 $COUNT))
  echo -e "RAM Usage:  [$BAR] $PERCENT%"
if (( PERCENT > 80 )); then
echo "WARNING: High RAM usage!"
else
echo "RAM usage is normal."
  fi
  echo ""
  USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
  COUNT=$(echo "$USAGE / 2" | bc)
  BAR=$(printf "%0.s#" $(seq 1 $COUNT))
  echo -e "Disk Usage: [$BAR] $USAGE%"
if (( USAGE > 80 )); then
echo "WARNING: Disk space is almost full!"
else
echo "Disk space is sufficient."
  fi
  ;;
5)
  echo "Exiting."
  exit 0
  ;;
*)
  echo "Invalid! Please enter a number between 1 and 5."
            ;;
  esac

  echo ""
  read -p "Press Enter to continue..."
done
