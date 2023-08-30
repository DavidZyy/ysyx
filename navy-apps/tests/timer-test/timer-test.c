#include <stdio.h>
#include <sys/time.h>
#include <unistd.h>
#include "NDL.h"

int main() {
    int start_time, current_time; //seconds
    start_time =  NDL_GetTicks();// 获取初始时间

    while (1) {
        current_time = NDL_GetTicks(); // 获取当前时间
        int elapsed_time = current_time - start_time;

        if (elapsed_time >= 1) { // 检查是否过去了 0.5 秒
            printf("Time elapsed: %d seconds\n", elapsed_time);
            start_time = NDL_GetTicks();
        }

        // 这里可以添加其他逻辑

        // usleep(10000); // 等待 0.01 秒，以免忙等待
    }

    return 0;
}
