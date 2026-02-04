// 题目:输入一个数n,,求斐波那契数列的前n项素数的和
#include <stdio.h>

int main()
{
  int n,
      a[100] = {1, 1}, i, j, sum = 0;
  scanf("%d", &n);
  for (i = 2; i < n; i++)
  {
    a[i] = a[i - 1] + a[i - 2];
  }
  if (n >= 2)
  {
    sum = sum + a[2] + a[3]; // a[2]和a[3]都是素数,为了提高效率,减少判断素数的时间,单独拎出来判断这两个
  }
  for (i = 4; i < n; i++)
  {
    for (j = 2; j * j <= a[i]; j++)
    {
      if (a[i] % j == 0)
      {
        break; // 一旦发现有因子即为合数,直接下一次循环,就不用继续循环了
      }
    }
    if (j * j > a[i])   // 没有发现因子即为素数
      sum = sum + a[i]; // 但必须有if(j*j>a[i])这个判断,因为不论上面是否执行break,这一行都会执行
                        // 所以没有这个判断的话,,素数也会被加进来
                        // 大脑debug时一定要分类讨论,这样更有逻辑
  }
  printf("%d", sum);
  return 0;
}