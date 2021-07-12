#ifndef LOGGER_H
#define LOGGER_H

#define LOG_LEVEL 5

#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#if defined __cplusplus
extern "C"
{
#endif
// Remove full path from file name.
#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)

// Log level definition.
#define LOG_LEVEL_TRACE 5
#define LOG_LEVEL_DEBUG 4
#define LOG_LEVEL_INFO 3
#define LOG_LEVEL_WARN 2
#define LOG_LEVEL_ERROR 1


    void get_datetime(char*, const size_t);

    void init_logger(const char*, const char*);

    FILE* get_log_out_file();
    FILE* get_log_err_file();

#define CHECK_LOG_LENGTH(args...)                                                                  \
    char log_message[1024];                                                                        \
    if (snprintf(log_message, 1024, args) > 1023)                                                  \
    {                                                                                              \
        fprintf(get_log_err_file(), "WARN: the following log message is longer "                   \
                                    "that maximum allowed (1024 bytes).\n");                       \
        fflush(get_log_err_file());                                                                \
    }

#if LOG_LEVEL >= LOG_LEVEL_TRACE
#define LOG_TRACE(args...)                                                                         \
    {                                                                                              \
        char datetime[25];                                                                         \
        get_datetime(datetime, 25);                                                                \
        CHECK_LOG_LENGTH(args)                                                                     \
        fprintf(get_log_out_file(), "%s - TRACE - %s:%d - %s\n", datetime, __FILENAME__, __LINE__, \
                log_message);                                                                      \
        fflush(get_log_out_file());                                                                \
    }
#else
#define LOG_TRACE(args...)
#endif

#if LOG_LEVEL >= LOG_LEVEL_DEBUG
#define LOG_DEBUG(args...)                                                                         \
    {                                                                                              \
        char datetime[25];                                                                         \
        get_datetime(datetime, 25);                                                                \
        CHECK_LOG_LENGTH(args)                                                                     \
        fprintf(get_log_out_file(), "%s - DEBUG - %s:%d - %s\n", datetime, __FILENAME__, __LINE__, \
                log_message);                                                                      \
        fflush(get_log_out_file());                                                                \
    }
#else
#define LOG_DEBUG(args...)
#endif

#if LOG_LEVEL >= LOG_LEVEL_INFO
#define LOG_INFO(args...)                                                                          \
    {                                                                                              \
        char datetime[25];                                                                         \
        get_datetime(datetime, 25);                                                                \
        CHECK_LOG_LENGTH(args)                                                                     \
        fprintf(get_log_out_file(), "%s - INFO - %s:%d - %s\n", datetime, __FILENAME__, __LINE__,  \
                log_message);                                                                      \
        fflush(get_log_out_file());                                                                \
    }
#else
#define LOG_INFO(args...)
#endif

#if LOG_LEVEL >= LOG_LEVEL_WARN
#define LOG_WARN(args...)                                                                          \
    {                                                                                              \
        char datetime[25];                                                                         \
        get_datetime(datetime, 25);                                                                \
        CHECK_LOG_LENGTH(args)                                                                     \
        fprintf(get_log_err_file(), "%s - WARN - %s:%d - %s\n", datetime, __FILENAME__, __LINE__,  \
                log_message);                                                                      \
        fflush(get_log_err_file());                                                                \
    }
#else
#define LOG_WARN(args...)
#endif

#if LOG_LEVEL >= LOG_LEVEL_ERROR
#define LOG_ERROR(args...)                                                                         \
    {                                                                                              \
        char datetime[25];                                                                         \
        get_datetime(datetime, 25);                                                                \
        CHECK_LOG_LENGTH(args)                                                                     \
        fprintf(get_log_err_file(), "%s - ERROR - %s:%d - %s\n", datetime, __FILENAME__, __LINE__, \
                log_message);                                                                      \
        fflush(get_log_err_file());                                                                \
    }
#else
#define LOG_ERROR(args...)
#endif

#if defined __cplusplus
};
#endif
#endif