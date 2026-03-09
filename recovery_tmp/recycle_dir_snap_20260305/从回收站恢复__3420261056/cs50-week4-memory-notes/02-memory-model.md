## 2）内存模型（你脑子里要有这张图）
### 2.1 RAM vs Disk（volatile--易失 vs persistent）
- **RAM（易失）**：程序运行时的变量(栈)/数组/malloc(堆) 的块都在 RAM；程序退出后就没意义
	- AKA:运行内存--电脑的16g或者32g
- **Disk（持久）**：文件在磁盘上，程序退出后仍存在，下次还能读
	- 电脑的C盘和D盘

```text
[Run #1]
RAM: name="Alice" number="111"  ---> fprintf/fwrite --->  Disk: phonebook.csv 追加一行
程序结束：RAM 清空；Disk 文件仍在

[Run #2]
RAM: name="Bob" number="222"    ---> 继续追加/读取 --->    Disk 文件累积保存
```

---
