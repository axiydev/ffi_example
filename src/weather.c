//
// Created by Axmadjon on 23.08.2021.
//
#include <string.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>

typedef struct ThreeDaysForecast ThreeDaysForecast;

double get_temp() {
    return 87.0f;
}

char *get_type_wether() {
    char *forecast = "sunny";
    char *forecast_m = malloc(strlen(forecast));
    strcpy(forecast_m, forecast);
    return forecast_m;
}

double fahrenheit_to_celsius(double temperature) {
    return (5.0f / 9.0f) * (temperature - 32);
}

struct ThreeDaysForecast {
    double day_before;
    double today;
    double tomorrow;
};

//function return struct
struct ThreeDaysForecast get_three_days_forecast(bool use_weather) {
    struct ThreeDaysForecast common_weather;
    common_weather.day_before = 87.0f;
    common_weather.today = 60.0f;
    common_weather.tomorrow = 70;
    if (use_weather) {
        common_weather.day_before = fahrenheit_to_celsius(common_weather.day_before);
        common_weather.today = fahrenheit_to_celsius(common_weather.today);
        common_weather.tomorrow = fahrenheit_to_celsius(common_weather.tomorrow);
    }

    return common_weather;
}

int sum(int a, int b) {
    return a + b;
}