#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>
#define SIZE 60
int hash[59] = {5320,4940,4615,8733,14145,13455,12285,10395,10395,10500,10100,3232,3200,11100,11211,11615,12650,4290,4524,3712,3680,12765,11988,12744,11918,3232,3584,12768,12654,10878,10584,10908,11009,4796,1408,3136,11466,13572,3712,3584,12096,10476,11737,12705,11550,11330,3296,3200,10100,9797,9700,3200,3200,11100,11211,11615,5290,5750,1250};

int count(char* s, int start, int end)
{
    int sum = 1;
    for (int i = start; i < end; i++)
        sum *= s[i];
    return sum;
}

int checksum(char* s)
{
    for (int i = 0; i + 2 <= SIZE; i++)
        if (count(s, i, i + 2) != hash[i])
            return 1;
    return 0;
}

int main()
{
    char s[60];
    printf("Hint: flag is \"FLAG{...}\" format.\n");
    //read(0, s, 60);
    s[0] = 'F';
    s[1] = 'L';
    s[2] = 'A';
    s[3] = 'G';
    s[4] = '{';
    for (int i = 5; i < 59; i++) {
        s[i] = hash[i - 1] / s[i - 1];
    }
    printf("%s\n", s);
    if (checksum(s))
        printf("You passed.");
    else
        printf("Maybe try again?");
}

