#define N 5
#define LEFT ((i + N - 1) % N)
#define RIGHT ((i + 1) % N)
#define THINKING 0
#define HUNGRY 1
#define EATING 2
#define TRUE 1
int state[N];
#include <semaphore.h>

sem_t mutex;
sem_t s[N];
void philosopher(int i)
{
    while (TRUE)
    {
        Think();
        takeChpStcks(i);
        Eat();
        putChpStcks(i);
    }
}
void takeChpStcks(i)
{
    wait(mutex);
    state[i] = HUNGRY;
    safeToEat(i);
    signal(mutex);
    wait(s[i]);
}
void safeToEat(i)
{
    if ((state[i] == HUNGRY) &&
        (state[LEFT] != EATING) &&
        (state[RIGHT] != EATING))
    {
        state[i] = EATING;
        signal(s[i]);
    }
}
void putChpStcks(i)
{
    wait(mutex);
    state[i] = THINKING;
    safeToEat(LEFT);
    safeToEat(RIGHT);
    signal(mutex);
}
