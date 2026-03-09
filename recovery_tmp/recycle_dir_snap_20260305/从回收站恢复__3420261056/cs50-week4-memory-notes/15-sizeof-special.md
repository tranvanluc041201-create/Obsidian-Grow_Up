# sizeof 数组 vs 指针专项练习

*创建时间：2026-02-21*  
*来源：诊断测试盲区专项*  
*难度：L2（概念区分）*

---

## 🎯 核心认知

### 本质区别

```c
char s[] = "abc";     // s 是数组（编译时确定大小）
char *p = "abc";      // p 是指针（存地址，大小固定）
```

| 表达式 | 结果 | 解释 |
|--------|------|------|
| `sizeof(s)` | 4 | 数组总大小：'a','b','c','\0' = 4字节 |
| `sizeof(p)` | 8 | 指针大小：64位系统 = 8字节 |
| `strlen(s)` | 3 | 字符串长度（不含'\0'） |
| `strlen(p)` | 3 | 同上 |

---

## 📐 关键规则

### 规则1：sizeof数组 = 元素个数 × 元素大小

```c
int arr[5];
printf("%zu\n", sizeof(arr));      // 20 (5 × 4字节)
printf("%zu\n", sizeof(arr[0]));    // 4 (int大小)
printf("%zu\n", sizeof(arr)/sizeof(arr[0]));  // 5 (数组元素个数)
```

### 规则2：数组名在sizeof中不退化

```c
void func(int arr[]) {
    printf("%zu\n", sizeof(arr));   // 8！不是20
}
// 数组传参会退化为指针
```

### 规则3：指针sizeof恒为地址大小

```c
char *pc;
int *pi;
double *pd;

sizeof(pc);  // 8 (64位)
sizeof(pi);  // 8 (64位)
sizeof(pd);  // 8 (64位)
// 所有指针大小相同，与指向类型无关
```

---

## 📝 练习题（3道递进）

### 第1题：基础区分

```c
#include <stdio.h>
int main() {
    int arr[10];
    int *p = arr;
    
    printf("%zu\n", sizeof(arr));   // ?
    printf("%zu\n", sizeof(p));     // ?
    printf("%zu\n", sizeof(*p));    // ?
    return 0;
}
```

**答案**：40, 8, 4

**解析**：
- `sizeof(arr)` = 10 × 4 = 40（数组总大小）
- `sizeof(p)` = 8（指针大小）
- `sizeof(*p)` = sizeof(int) = 4（指针指向的类型大小）

---

### 第2题：函数参数陷阱

```c
#include <stdio.h>
void print_size(int arr[]) {
    printf("In func: %zu\n", sizeof(arr));
}

int main() {
    int arr[10];
    printf("In main: %zu\n", sizeof(arr));
    print_size(arr);
    return 0;
}
```

**输出**：
```
In main: 40
In func: 8
```

**解析**：数组传参会退化为指针，`arr[]` 实际就是 `int *arr`。

---

### 第3题：二维数组

```c
#include <stdio.h>
int main() {
    int arr[3][4];
    int (*p)[4] = arr;  // 数组指针
    
    printf("%zu\n", sizeof(arr));    // ?
    printf("%zu\n", sizeof(arr[0])); // ?
    printf("%zu\n", sizeof(p));      // ?
    printf("%zu\n", sizeof(*p));     // ?
    return 0;
}
```

**答案**：48, 16, 8, 16

**解析**：
- `sizeof(arr)` = 3 × 4 × 4 = 48（整个二维数组）
- `sizeof(arr[0])` = 4 × 4 = 16（第一行大小）
- `sizeof(p)` = 8（指针大小）
- `sizeof(*p)` = 16（p指向一行，即4个int）

---

## 💡 记忆口诀

> **sizeof看定义，不看值**  
> **数组看元素，指针看地址**  
> **传参会退化，sizeof失效**

---

## 🔗 关联知识点

- 指针退化：`03-pointers-null.md`
- 数组指针：`02-memory-model.md`
- 错题本：`02_Memory_Address/2.1 二维数组传参的地址计算-v1.1.md`

---

*练习完成标志：能独立解释上述3题*
