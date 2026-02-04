#include <stdio.h>
#define N 10 // 注意,宏定义后面不需要;另外,宏定义的字母一般推荐用大写的
void choose(int b[]);
int main(void)
{
  int i, a[10];
  for (i = 0; i < N; i++)
  {
    scanf("%d", &a[i]);
  }
  choose(a);
  for (i = 0; i < N; i++)
  {
    printf("%d ", a[i]);
  }
  return 0;
}
void choose(int b[])
{
  int k, t, i, j;
  for (i = 0; i < N - 1; i++) // 最后一个不用交换,所以到n-2(<N-1)
  {
    k = i; // 定位一开始的就是最小,因此处按从小到大排
    for (j = i + 1; j < N; j++)
    {
      if (b[k] > b[j])
      {
        k = j; // 定位更小的下标
      }
    }
    t = b[i];
    b[i] = b[k];
    b[k] = t;
  }
}
