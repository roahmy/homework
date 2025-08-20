#include "pt4.h"

void Solve() {
    Task("File54");
    
    // 1. 获取输出文件名 S（由输入给出）
    char output_filename[256];
    GetS(output_filename);
    char input_filename[256];
    GetS(input_filename);
    // 2. 打开归档文件（假设文件名为 "archive.dat"）
    FILE* archive = fopen(input_filename, "rb");
    
    if (!archive) {
        return;
    }
    
    // 3. 读取文件数量 N（归档文件的第一个整数）
    int N;
    if (fread(&N, sizeof(int), 1, archive) != 1) {
        fclose(archive);
        return;
    }
    
    // 检查 N 是否合法（题目要求 N ≤ 4）
    if (N < 1 || N > 6) {
        fclose(archive);
        return;
    }
    
    // 4. 读取每个文件的大小（接下来的 N 个整数）
    int file_sizes[8]; // 存储每个文件的整数数量
    if (fread(file_sizes, sizeof(int), N, archive) != N) {
        fclose(archive);
        return;
    }
    
    // 5. 计算每个文件的平均值
    double averages[8] = {0}; // 存储每个文件的平均值
    for (int i = 0; i < N; i++) {
        double sum = 0;
        int num;
        
        // 读取当前文件的所有整数并累加
        for (int j = 0; j < file_sizes[i]; j++) {
            if (fread(&num, sizeof(int), 1, archive) != 1) {
                fclose(archive);
                return;
            }
            sum += num;
        }
        
        // 计算平均值
        averages[i] = sum / file_sizes[i];
    }
    fclose(archive); // 关闭归档文件
    
    // 6. 将平均值写入输出文件 S（二进制格式）
    FILE* output = fopen(output_filename, "wb");
    if (!output) {
        return;
    }
    
    // 写入所有平均值
    fwrite(averages, sizeof(double), N, output);
    fclose(output);
    
   
}