#pragma once
#include <stdlib.h>
#include <stdio.h>

typedef size_t Size;

typedef struct Collector{
    void (*func)();
    Size AcSize;
    Size GarbageSize;
    void** Garbage;
} Collector;

Collector Garbage_Collector;

void Collector_Init(){
    if((void*)Garbage_Collector.Garbage) free((void*)Garbage_Collector.Garbage);
    Garbage_Collector.Garbage = (void**)calloc(Garbage_Collector.GarbageSize,sizeof(void*));
    Garbage_Collector.AcSize = (Size)0;
}

void Collector_Flush(){
    for(int i = 0;i<Garbage_Collector.AcSize;i++){
        printf("Free: %i\n",i);
        if(Garbage_Collector.Garbage[i]) free(Garbage_Collector.Garbage[i]);
        Garbage_Collector.Garbage[i] = NULL;
    }
    Collector_Init();
}

void Collector_Exit(){
    Collector_Flush();
    if((void*)Garbage_Collector.Garbage) free((void*)Garbage_Collector.Garbage);
}

void SafeAlloc(void **Pointer,Size size){
    if((*Pointer)){
        free((*Pointer));
        *Pointer = NULL;
    }
    *Pointer = (void*)malloc(size);
    if(!Pointer){
        printf("Couldn't allocate Memory...\n");
    }
}

void *Alloc(Size size){
    if(Garbage_Collector.AcSize>=Garbage_Collector.GarbageSize){
        Collector_Flush();
    }
    void *Ptr = (void*)malloc(size);
    if(!Ptr){
        goto Error;
    }
    Garbage_Collector.Garbage[Garbage_Collector.AcSize] = Ptr;
    Garbage_Collector.AcSize++;
    return Ptr;
    Error:{
        printf("Couldn't allocate Memory...\n");
        return NULL;
    }
}

void Collector_Main(void (*func)(),Size size){
    Garbage_Collector.func = func;
    Garbage_Collector.GarbageSize = size;
    Collector_Init();
    Garbage_Collector.func();
    Collector_Exit();
}
