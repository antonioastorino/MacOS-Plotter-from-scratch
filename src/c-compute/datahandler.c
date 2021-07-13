#include "c/datahandler.h"
#include <limits.h>

void max_min(const double* data, size_t num_of_elements, double* max, double* min)
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

void fit_in_range(const double* in_data, const size_t num_of_elements, const double range_min,
                  const double range_max, double* out_data)
{
    double max, min;
    max_min(in_data, num_of_elements, &max, &min);
    double range = max - min;
    for (size_t i = 0; i < num_of_elements; i++)
        out_data[i] = ((in_data[i] - min) / range) * (range_max - range_min) + range_min;
}

void moving_average(const double* in_data, const size_t num_of_elements, const size_t window_size,
                    double* out_data)
{
    // No average computed for the first `(window_size - 1)` elements.
    double average_in_window     = 0;
    double first_value_in_window = 0;
    for (size_t i = 0; i < window_size - 1; i++)
    {
        out_data[i] = in_data[i];
        // Start storing the average;
        average_in_window += in_data[i] / window_size;
    }

    // Compute the average.
    for (size_t i = window_size - 1; i < num_of_elements; i++)
    {
        /*
        Remove the contribution from the previous first element and add the contribution from the
        last element in the window.
        */
        double last_value_in_window = in_data[i] / window_size;
        average_in_window = average_in_window - first_value_in_window + last_value_in_window;
        out_data[i]       = average_in_window;
        // Update the first value.
        first_value_in_window = in_data[i - window_size + 1] / window_size;
    }
}

#if TEST == 1
void test_datahandler()
{
    PRINT_BANNER;
    PRINT_TEST_TITLE("fit_in_range()");
    const size_t num_of_elements            = 10;
    const double test_data[num_of_elements] = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19};
    double out_data[num_of_elements]        = {0};
    fit_in_range(test_data, num_of_elements, 11.0f, 20.0f, out_data);
    ASSERT_EQ(out_data[0], 11.0f, "First element correct.");
    ASSERT_EQ(out_data[4], 15.0f, "Fifth element correct.");
    ASSERT_EQ(out_data[9], 20.0f, "Last element correct.");

    PRINT_TEST_TITLE("moving_average() - window size: 1");
    moving_average(test_data, num_of_elements, 1, out_data);
    for (size_t i = 0; i < num_of_elements; i++)
    {
        ASSERT_EQ(out_data[i], test_data[i], "unchanged as expected");
    }
    PRINT_TEST_TITLE("moving_average() - window size: 2");
    moving_average(test_data, num_of_elements, 2, out_data);
    ASSERT_EQ(out_data[0], test_data[0], "First element unchanged.")
    for (size_t i = 1; i < num_of_elements; i++)
    {
        ASSERT_EQ(out_data[i], (double)(i * 2), "Correct average,");
    }
    PRINT_TEST_TITLE("moving_average() - window size: 3");
    moving_average(test_data, num_of_elements, 3, out_data);
    ASSERT_EQ(out_data[0], test_data[0], "First element unchanged");
    ASSERT_EQ(out_data[1], test_data[1], "Second element unchanged");
    ASSERT_EQ(out_data[2], 3.0f, "Third element not 0");
}

#endif