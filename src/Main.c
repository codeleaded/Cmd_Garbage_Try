#include "Memory.h"

void Main(){
    for(int j = 0;j<10;j++){
        for(int i = 0;i<200;i++){
            char *Ptr = (char*)Alloc(16);
            printf("i: %i - ",i);
            printf("s: %s | ",Ptr);
        }
        printf("\n");
    }
}

int main(){
    Collector_Main(Main,200);
    return 0;
}