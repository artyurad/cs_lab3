#include <iostream>
#include <chrono>

const int ARRAY_SIZE = 10000000;

int main() {
    int array[ARRAY_SIZE];

    // Ініціалізація масиву
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        array[i] = i;
    }

    // Обчислення суми елементів масиву
    int sum = 0;
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        sum += array[i];
    }

    return 0;
}
