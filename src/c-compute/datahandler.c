#include "c/datahandler.h"
#include <limits.h>

void max_min(double* data, size_t num_of_elements, double* max, double* min)
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

#if TEST == 1
void test_datahandler()
{
    PRINT_BANNER;
    double test_data[10] = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19};
    double out_data[10]  = {0};
    fit_in_range(test_data, 10, 11.0f, 20.0f, out_data);
    ASSERT_EQ(out_data[0], 11.0f, "First element correct.");
    ASSERT_EQ(out_data[4], 15.0f, "Fifth element correct.");
    ASSERT_EQ(out_data[9], 20.0f, "Last element correct.");
}

#endif