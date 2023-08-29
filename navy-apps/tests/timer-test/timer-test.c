#include <stdio.h>
#include <sys/time.h>
#include <unistd.h>

int main() {
    struct timeval start_time, current_time;
    gettimeofday(&start_time, NULL); // 获取初始时间

    while (1) {
        gettimeofday(&current_time, NULL); // 获取当前时间
        int elapsed_time = (current_time.tv_sec - start_time.tv_sec);

        if (elapsed_time >= 1) { // 检查是否过去了 0.5 秒
            printf("Time elapsed: %d seconds\n", elapsed_time);
            gettimeofday(&start_time, NULL); // 重置初始时间
        }

        // 这里可以添加其他逻辑

        // usleep(10000); // 等待 0.01 秒，以免忙等待
    }

    return 0;
}
