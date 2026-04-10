#include <stdio.h>

#if __cplusplus < 201703L
#error "bad cmake compiler setting; require C++ 17 or greater for projects"
#endif

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;
    printf("Hello World!\n");
    return 0;
}
