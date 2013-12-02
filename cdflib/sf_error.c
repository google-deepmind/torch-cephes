#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include "sf_error.h"

const char *sf_error_messages[] = {
    "no error",
    "singularity",
    "underflow",
    "overflow",
    "too slow convergence",
    "loss of precision",
    "no result obtained",
    "domain error",
    "invalid input argument",
    "other error",
    NULL
};

static int print_error_messages = 0;

int sf_error_set_print(int flag)
{
    int old_flag = print_error_messages;
    print_error_messages = flag;
    return old_flag;
}

int sf_error_get_print()
{
    return print_error_messages;
}

void sf_error(char *func_name, sf_error_t code, char *fmt, ...)
{
    char msg[2048], info[1024];
    va_list ap;

    if (!print_error_messages) {
        return;
    }

    if (func_name == NULL) {
        func_name = "?";
    }

    if ((int)code < 0 || (int)code >= 10) {
        code = SF_ERROR_OTHER;
    }

    if (fmt != NULL && fmt[0] != '\0') {
        va_start(ap, fmt);
        vsnprintf(info, 1024, fmt, ap);
        va_end(ap);
        snprintf(msg, 2048, "scipy.special/%s: (%s) %s",
                      func_name, sf_error_messages[(int)code], info);
    }
    else {
        snprintf(msg, 2048, "scipy.special/%s: %s",
                      func_name, sf_error_messages[(int)code]);
    }

    /* TODO: get Lua wrapper to read this msg, rather than printf */
    printf(msg);

}
