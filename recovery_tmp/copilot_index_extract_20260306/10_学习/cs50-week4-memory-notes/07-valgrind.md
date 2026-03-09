## 7）Valgrind（读法 + Windows 怎么用）

### 7.1 Windows 现实：建议用 WSL2

Valgrind 主要跑在 Linux。你在 Windows 学 CS50，建议：

* **WSL2 + Ubuntu**（最接近课程命令，省心）
* 替代方案：Dr. Memory（输出风格不同）

### 7.2 WSL2 下的最常用命令（直接复制）

```bash
clang -g -O0 -Wall -Wextra -o prog prog.c
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./prog
```

### 7.3 三步读 Valgrind（固定套路，永远不乱）

1. 看错误类型关键词

   * `Invalid write of size X`：越界写/野指针/释放后使用
   * `Invalid read of size X`：越界读/野指针
   * `definitely lost`：确定泄漏（malloc 没 free）
   * `uninitialised value`：使用未初始化数据
2. 找发生行：`at ... file.c:LINE`（去看那行怎么访问数组/指针）
3. 找分配行：`alloc'd by ... file.c:LINE`（看 malloc 的大小是不是算错）

### 7.4 你截图那种报错怎么翻译

* `Invalid write of size 4`：写了 4 字节（常见是 int）
* `0 bytes after a block of size 12`：分配了 12 字节（≈3 个 int），写到了末尾外面（典型写了第 4 个：`a[3]`）
* `definitely lost: 12 bytes`：malloc 了但没 free

---

### 实践模板：复现 Valgrind 典型报错（配合 phonebook-pro）

**前提**
- 在 WSL2 里进入项目目录：`cd phonebook-pro`

**复现命令**

```bash
# 基本编译
make

# 经典 Invalid write (12 bytes block)
make clean && make EXTRA_CFLAGS='-DPB_DEMO_BUG_INT_OOB=1'
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./phonebook list

# definitely lost (leak)
make clean && make EXTRA_CFLAGS='-DPB_DEMO_BUG_LEAK=1'
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./phonebook list

# name 分配越界（size 1 write）
make clean && make EXTRA_CFLAGS='-DPB_DEMO_BUG_NAME_ALLOC_OOB=1'
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./phonebook list
```

---