#ifndef DEFINITIONS_H
#define DEFINITIONS_H

// Log level.
#define LOG_LEVEL 5
// Run in unit test mode.
#define TEST 0

#include <stdio.h>
#include <string.h>

#if TEST == 1
#define ASSERT_EQ(value_1, value_2, message)                                                       \
    if (value_1 == value_2)                                                                        \
    {                                                                                              \
        printf("\n> \e[32mPASS\e[0m\t %s\n", message);                                             \
    }                                                                                              \
    else                                                                                           \
    {                                                                                              \
        printf("\n> \e[31mFAIL\e[0m\t %s\n", message);                                             \
        fprintf(stderr, "\n> Err - Test failed.\n%s:%d : left != right\n", __FILE__, __LINE__);    \
    }

#define PRINT_BANNER                                                                               \
    printf("\n");                                                                                  \
    for (size_t i = 0; i < strlen(__FUNCTION__) + 12; i++)                                         \
    {                                                                                              \
        printf("=");                                                                               \
    }                                                                                              \
    printf("\n-- TEST: %s --\n", __FUNCTION__);                                                    \
    for (size_t i = 0; i < strlen(__FUNCTION__) + 12; i++)                                         \
    {                                                                                              \
        printf("=");                                                                               \
    }                                                                                              \
    printf("\n");                                                                                  \
    size_t counter = 0;

#define PRINT_TEST_TITLE(title) printf("\n------- T:%lu < %s > -------\n", ++counter, title);
#endif
#endif
