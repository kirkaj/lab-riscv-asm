## Постановка задачи
Получить общее представление о системе команд RISC-V путём решения несложной
прикладной задачи. Выполнить следующие действия:
* Разработать алгоритм решения задачи согласно варианту. 
* Реализовать код алгоритма на Си и языка ассемблера RISC-V ISA, полученный исходный код сохранить в репозитории.
* Скомпилировать Си-код используя riscv-компилятор. Получить дамп-файл из скомпилированного исполняемого файла вашей программы. Сохранить дамп-файл в репозитории.
* Оформить отчет о проделанной работе и результатах в виде README.md файла.
* Продемонстрировать результаты работы в симуляторе Venus

## Вариант задания

Вариант задания | Описание
--------------- | -------------
11 | Найти строчку в матрице с минимальной суммой элементов. (N = 5, M = 3)

## Ход работы
В рамках выполнения задачи осуществили настройку и предустановку необходимого инструментария, включая настройку окружения, репозитория, установку собранного RISC-V C компилятора, утилиты objdump. 
Ознакомились с прилагаемым к методическим указаниям руководству по ассемблеру и соответствующей спецификацией.

Выполнили разработку алгоритма. Исходный код алгоритма на языке ассемблера представлен в листинге ниже.
~~~asm
.data
N:
.word 5
M:
.word 3
matrix:
.word 0, -5, 1, 1, 0
.word 2, 2, 2, -20, 0
.word 1, 1, 1, 0, 0
result:
.word 0
minValue:
.word 0

.text

main:
la a2, N
la a3, M
la a4, matrix
la a5, minValue
la a6, result
call process
la a2, M
la a3, result
call print
call exit

print:
addi a0, x0, 1
lw a1, 0(a6)
ecall
ret

exit:
addi a0, x0, 10
ecall

process:
lw t1, 0(a2) 
lw t2, 0(a3) 
addi t4, x0, 0

init:
addi t5, x0, 0
addi t3, x0, 0
cycle:
lw t6, 0(a4)
addi a4, a4, 4
add t5, t5, t6 
addi t3, t3, 1
blt t3, t1, cycle
beqz t4, ifBody
lw t0, 0(a5)
bge t5,t0,cycleCon
ifBody:
sw t5, 0(a5)
sw t4, 0(a6)
cycleCon:
addi t4, t4, 1
blt t4, t2, init
ret
~~~

Согласно разработанному алгоритму был написан код на Си, представленный ниже.

~~~C
#include <stdio.h>
#define M 5
#define N 3

void process(int n,int m,int matrix[M][N],int *result)
{
    int rowSum=0;
    int minValue=0;
    for (int i=0;i<M;++i){
        for (int j=0;i<N;++j){
            rowSum+=matrix[i][j];
        }
        if(i==0||rowSum<minValue)
        {
            minValue=rowSum;
            result=i;
        }
        rowSum=0;
    }
}

void main(int argc, char** argv)
{
    int matrix[M][N];
    int result=0;

    for (int i=0;i<M;++i){
        for (int j=0;j<N;++j){
            scanf("%d",&matrix[i][j]);
        }
    }

    process(N,M,matrix,result);

    for (int i=0;i<M;++i){
        printf("%d", result);
    }

    return 0;
}
~~~

Компиляция разработанного кода для RISC-V осуществлена с помощью команды 
~~~
$ riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32  program.c -o prog_result.elf
~~~

Был получен файл дампа с помощью команды
~~~
$ riscv64-unknown-elf-objdump -D program.c > prog_dump.dump
~~~

## Результаты работы

* **program.S** - программа на RISC-V ASM
* **program.c** - программа на Си
* **prog_result.elf** - скомпилированный object-файл
* **prog_dump.dump** - дамп-файл программы на Си

## Сборка
Сборка работы на Си в полностью настроенном окружении выполняется с использованием GNU Make. Для осуществления сборки, находясь в каталоге с `Makefile` необходимо выполнить команду:
```
make
```
