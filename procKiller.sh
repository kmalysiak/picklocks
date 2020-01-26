#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Nie podano frazy do wyszukania procesu"
  exit 1
fi

var=$(pgrep -av grep | grep $1)

procCount=$(pgrep -c $1)

if [ $procCount = 1 ]; then
  procPid=$(echo $var | awk '{ print $1}')
  procName=$(echo $var | awk '{ print $2}')
  echo "Znaleziono jeden proces z PID " $procPid " i komendą " $procName
  while true; do
    read -p "Zabić? y/n." yn
    case $yn in
    [Yy]*)
      kill -9 $procPid
      if [ $(pgrep -c $1) = 0 ]; then
        echo "Proces ubity!"
      else
        echo "Procesu nie da się ubić. Wychodzę."
      fi
      break
      ;;
    [Nn]*)
      echo "Wychodzę bez ubijania."
      exit 1
      ;;
    *) ;;
    esac
  done

else
  echo "Znaleziono procesów :" $(pgrep -c $1) " a powinien być 1. Sprawdź ręcznie lub zmień frazę wyszukiwania"
fi
