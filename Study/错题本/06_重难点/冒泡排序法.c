#include <stdio.h>
#define N 10
void bubble(int b[]);
int main(void)
{
  int i, a[10];
  for (i = 0; i < N; i++)
  {
    scanf("%d", &a[i]);
  }
  bubble(a);
  for (i = 0; i < N; i++)
  {
    printf("%d ", a[i]);
  }
  return 0;
}
void bubble(int b[])
{
  int i, j, t;
  for (i = 0; i < N - 1; i++) // 最后一个不用换
  {
    for (j = i + 1; j < N - i - 1; j++) // 下面有j+1,为了防止数组越界得让N-1,减去i是因为前面i轮有几个数已经排到最底下了,不需要再和下面几个"最大"的比了
    {
      if (b[j] > b[j + 1])
      {
        int t = b[j];
        b[j] = b[j + 1];
        b[j + 1] = t;
      }
    }
  }
}
