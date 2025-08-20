#include "pt4.h"
using namespace std;

void Solve()
{
    Task("File36");
    char filename[256];
    GetS(filename); // 获取文件名
    
    // 1. 读取原始文件内容
    FILE *f = fopen(filename, "rb");
    if (!f) {
        PutS("File not found!");
        return;
    }
    
    // 获取文件大小并计算整数数量
    fseek(f, 0, SEEK_END);
    long file_size = ftell(f);
    rewind(f);
    
    int num_count = file_size / sizeof(int);
    int *numbers = (int*)malloc(file_size);
    
    // 读取所有整数
    size_t read_count = fread(numbers, sizeof(int), num_count, f);
    fclose(f);
    
    if (read_count != num_count) {
        PutS("File read error!");
        free(numbers);
        return;
    }
    
    // 2. 追加内容到文件
    f = fopen(filename, "ab"); // 以二进制追加模式打开
    if (!f) {
        PutS("Cannot open file for writing!");
        free(numbers);
        return;
    }
    
    // 写入原始数据
    size_t write_count = fwrite(numbers, sizeof(int), num_count, f);
    fclose(f);
    free(numbers);
    
    if (write_count != num_count) {
        PutS("File write error!");
    }
}
