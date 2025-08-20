#include "pt4.h"
using namespace std;

void Solve()
{
    Task("File9");
    char filename1[256], filename2[256];
    GetS(filename1);
    GetS(filename2);
    
    // 尝试打开文件1
    FILE *f = fopen(filename1, "rb");
    int use_file1 = 0;
    
    if (f) {
        use_file1 = 1;
    } else {
        // 尝试打开文件2
        f = fopen(filename2, "rb");
        if (!f) {
            PutS("Neither file exists!");
            return;
        }
    }
    
    // 读取所有double数据
    fseek(f, 0, SEEK_END);
    long file_size = ftell(f);
    rewind(f);
    
    int num_count = file_size / sizeof(double);
    double *numbers = (double*)malloc(file_size);
    fread(numbers, sizeof(double), num_count, f);
    fclose(f);
    
    // 准备写入数据
    double output[2] = {numbers[num_count-1], numbers[0]};
    
    // 写入另一个文件
    FILE *out_f = fopen(use_file1 ? filename2 : filename1, "wb");
    fwrite(output, sizeof(double), 2, out_f);
    fclose(out_f);
    
    free(numbers);
}
