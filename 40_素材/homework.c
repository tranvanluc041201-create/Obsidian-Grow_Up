#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// TODO: 声明 my_strdup 函数
// 参数：const char *s（要复制的字符串）
// 返回值：char *（新分配的内存地址）
// 功能：malloc 分配足够的内存，把 s 的内容复制过去，返回新地址
char *my_strdup(const char *s);
int main(void)
{
  char original[] = "Hello, CS50!";

  // TODO: 调用 my_strdup，复制 original
  char *copy = my_strdup(original);

  // 验证复制成功
  printf("Original: %s\n", original);
  printf("Copy:     %s\n", copy);

  // 修改 copy，不应该影响 original
  copy[0] = 'h';
  printf("After modify copy:\n");
  printf("Original: %s\n", original); // 应该还是 Hello\n    printf("Copy:     %s\n", copy);      // 应该是 hello\n
  // TODO: 释放内存
  free(copy);
  copy = NULL;
  return 0;
}

// TODO: 实现 my_strdup 函数
// 提示：
// 1. 用 strlen 获取长度
// 2. malloc 分配 len+1 个字节（为什么+1？）
// 3. 用 strcpy 复制内容
// 4. 返回新指针
char *my_strdup(const char *s)
{
  char *c;
  int i;
  c = malloc(strlen(s) + 1); // 这个我不熟
  for (i = 0; i < strlen(s); i++)
  {
    c[i] = s[i];
  }
  c[i] = '\0';
  return c;
}
/*我思路有问题:
1.先声明
2.再实现
要求:把一个字符串复制到新分配的内存
先将字符串地址得到,再用这个地址去申请内存(地址作为钥匙),
3.目前疑惑的点:
我给original申请了内存,并将其地址给了copy,这说明他们共用一个地址
但是我应该将这个字符串的地址给copy,然后用它去申请内存*/