#ifndef DATA_HEADER_H
#define DATA_HEADER_H
#include "definitions.h"
#include <ctype.h>

#if defined __cplusplus
extern "C"
{
#endif
    /*
    `out_data` is a translated and scaled version of `in_data` such that it fits between `range_min`
    and `range_max`.
    */
    void fit_in_range(const double* in_data, const size_t num_of_elements, const double range_min,
                      const double range_max, double* out_data);
    void moving_average(const double* in_data, const size_t num_of_elements,
                        const size_t window_size, double* out_data);

#if TEST == 1
    void test_datahandler();
#endif

#if defined __cplusplus
};
#endif

#endif