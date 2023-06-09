#!/bin/bash

ml icc


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
lscpu | grep Flags

# Компілюємо окремі варіанти оптимізованої програми для розширень
for flag in sse2 sse3 ssse3 sse4.1 sse4.2 avx ATOM_SSE4.2 ATOM_SSSE3
do
    # Компілюємо з оптимізацією
    icc -x$flag myprogram.cpp -o myprogram_opt_$flag

    # Вимірюємо час роботи оптимізованої програми
    echo "Вимірюємо час роботи програми з оптимізацією $flag:"
    time for ((i=0; i<1000; i++)); do
        ./myprogram_opt_$flag
    done
done
