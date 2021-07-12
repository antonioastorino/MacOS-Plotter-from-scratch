#include "c/datahandler.h"
#include <limits.h>

void max_min(double* data, size_t num_of_elements, double *max, double *min)
{
    *max = LLONG_MIN;
    *min = LLONG_MAX;
    for (size_t i = 0; i < num_of_elements; i++)
    {
        if (data[i] > *max)
        {
            *max = data[i];
        }
        if (data[i] < *min)
        {
            *min = data[i];
        }
    }
}

void fit_in_range(double* in_data, size_t num_of_elements, double range_min, double range_max,
                  double* out_data)
{
    double max, min;
    max_min(in_data, num_of_elements, &max, &min);
    double range = max - min;
    for (size_t i = 0; i < num_of_elements; i++)
        out_data[i] = ((in_data[i] - min) / range) * (range_max - range_min) + range_min;
}