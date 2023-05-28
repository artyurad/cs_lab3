#!/bin/bash

ml icc

# Виконуємо компіляцію програми
icc myprogram.cpp -o myprogram

# Вимірюємо час роботи некомпільованої програми
echo "Вимірюємо час роботи некомпільованої програми:"
time for ((i=0; i<1000; i++)); do
    ./myprogram
done

# Виконуємо оптимізовану компіляцію для кожного рівня оптимізації
optimizations=("O1" "O2" "O3")
for opt in "${optimizations[@]}"; do
    # Компілюємо з оптимізацією
    icc -${opt} myprogram.cpp -o myprogram_opt${opt}

    # Вимірюємо час роботи оптимізованої програми
    echo "Вимірюємо час роботи програми з оптимізацією -${opt}:"
    time for ((i=0; i<1000; i++)); do
        ./myprogram_opt${opt}
    done
done

# Отримуємо перелік розширень процесору
echo "Перелік розширень процесору:"
flags=$(cat /proc/cpuinfo | grep flags | uniq | cut -d ":" -f 2)

# Компілюємо окремі варіанти оптимізованої програми для кожного розширення
for flag in $flags; do
    # Компілюємо з оптимізацією
    icc -$flag myprogram.cpp -o myprogram_opt_$flag

    # Вимірюємо час роботи оптимізованої програми
    echo "Вимірюємо час роботи програми з оптимізацією $flag:"
    time for ((i=0; i<1000; i++)); do
        ./myprogram_opt_$flag
    done
done
