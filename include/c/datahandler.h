#ifndef DATA_HEADER_H
#define DATA_HEADER_H
#include <ctype.h>

#if defined __cplusplus
extern "C"
{
#endif

    void fit_in_range(double* in_data, size_t num_of_elements, double range_min, double range_max,
                      double* out_data);

#if defined __cplusplus
};
#endif

#endif