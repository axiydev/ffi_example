//
// Created by Axmadjon on 23.08.2021.
//
#include <string.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>

double get_temp(){
   return 87.0f;
}

char* get_type_wether(){
     char* forecast = "sunny";
     char* forecast_m = malloc(strlen(forecast));
     strcpy(forecast_m, forecast);
     return forecast_m;
}

int sum(int a,int b){
   return a+b;
}