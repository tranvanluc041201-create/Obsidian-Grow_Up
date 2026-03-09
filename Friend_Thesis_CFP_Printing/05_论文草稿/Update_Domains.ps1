# WPS Writer 自动更新域脚本
# 功能：自动打开论文、更新所有域、另存为新版本

param(
    [string]$InputFile = "C:\obsidian\Vault\Friend_Thesis_CFP_Printing\05_论文草稿\论文全文_学校规范排版稿_MASTER_r30.docx",
    [string]$OutputFile = "C:\obsidian\Vault\Friend_Thesis_CFP_Printing\05_论文草稿\论文全文_学校规范排版稿_MASTER_r30_UPDATED.docx"
)

Write-Host "=== WPS Writer 自动更新域脚本 ===" -ForegroundColor Green
Write-Host "输入文件: $InputFile" 
Write-Host "输出文件: $OutputFile" 
Write-Host ""

# 检查输入文件
if (-not (Test-Path $InputFile)) {
    Write-Error "❌ 输入文件不存在: $InputFile"
    exit 1
}

# 防止覆盖原文件
if ($InputFile -eq $OutputFile) {
    Write-Error "❌ 输入和输出文件不能相同（防止覆盖原文件）"
    exit 1
}

try {
    Write-Host "🚀 启动 WPS..." -ForegroundColor Yellow
    $wps = New-Object -ComObject "Kwps.Application"
    $wps.Visible = $true  # 显示WPS窗口，便于观察
    
    Write-Host "📂 打开文档..." -ForegroundColor Yellow
    $doc = $wps.Documents.Open($InputFile)
    
    if (-not $doc) {
        throw "无法打开文档"
    }
    
    Write-Host "⏳ 等待文档加载..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    
    # 方法1: 更新所有域 (SelectAll + Update)
    Write-Host "🔄 更新全文域..." -ForegroundColor Yellow
    try {
        $wps.Selection.WholeStory()  # 全选 (Ctrl+A)
        $wps.Selection.Fields.Update()  # 更新域 (F9效果)
        Write-Host "✅ 全文域更新完成" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ 方法1失败，尝试方法2..." -ForegroundColor Yellow
    }
    
    # 方法2: 遍历所有域并更新
    Write-Host "🔄 遍历更新所有域对象..." -ForegroundColor Yellow
    try {
        $fieldCount = $doc.Fields.Count
        Write-Host "   发现 $fieldCount 个域"
        for ($i = 1; $i -le $fieldCount; $i++) {
            try {
                $doc.Fields.Item($i).Update()
            } catch {
                # 忽略单个域更新失败
            }
        }
        Write-Host "✅ 域对象更新完成" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ 方法2也失败: $_" -ForegroundColor Red
    }
    
    # 方法3: 更新目录 (Table of Contents)
    Write-Host "🔄 更新目录..." -ForegroundColor Yellow
    try {
        $tocCount = $doc.TablesOfContents.Count
        Write-Host "   发现 $tocCount 个目录"
        for ($i = 1; $i -le $tocCount; $i++) {
            try {
                $doc.TablesOfContents.Item($i).Update()
                Write-Host "   目录 $i 已更新" -ForegroundColor Green
            } catch {
                Write-Host "   ⚠️ 目录 $i 更新失败" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "⚠️ 目录更新失败: $_" -ForegroundColor Yellow
    }
    
    # 方法4: 打印预览触发更新（强制刷新所有域）
    Write-Host "🔄 使用打印预览强制刷新..." -ForegroundColor Yellow
    try {
        $doc.PrintPreview()
        Start-Sleep -Milliseconds 500
        $doc.ClosePrintPreview()
        Write-Host "✅ 打印预览刷新完成" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ 打印预览方法失败: $_" -ForegroundColor Yellow
    }
    
    # 再次更新目录
    Write-Host "🔄 再次更新目录..." -ForegroundColor Yellow
    try {
        for ($i = 1; $i -le $doc.TablesOfContents.Count; $i++) {
            $doc.TablesOfContents.Item($i).Update()
        }
        Write-Host "✅ 目录二次更新完成" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ 二次更新失败: $_" -ForegroundColor Yellow
    }
    
    # 保存为新文件
    Write-Host "💾 另存为新文件..." -ForegroundColor Yellow
    try {
        # WPS保存格式: 16 = wdFormatDocumentDefault (docx)
        $doc.SaveAs2($OutputFile, 16)
        Write-Host "✅ 保存成功: $OutputFile" -ForegroundColor Green
    } catch {
        # 尝试旧版SaveAs
        try {
            $doc.SaveAs($OutputFile)
            Write-Host "✅ 保存成功 (SaveAs): $OutputFile" -ForegroundColor Green
        } catch {
            throw "保存失败: $_"
        }
    }
    
    # 关闭文档
    Write-Host "🔒 关闭文档..." -ForegroundColor Yellow
    $doc.Close()
    
    Write-Host ""
    Write-Host "=== ✅ 自动化完成 ===" -ForegroundColor Green
    Write-Host "输出文件: $OutputFile" -ForegroundColor Cyan
    
} catch {
    Write-Host ""
    Write-Host "=== ❌ 自动化失败 ===" -ForegroundColor Red
    Write-Host "错误: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "可能原因：" -ForegroundColor Yellow
    Write-Host "1. WPS 未安装或版本不支持 COM 接口"
    Write-Host "2. 文件被其他程序占用"
    Write-Host "3. 文件路径包含特殊字符"
    Write-Host ""
    Write-Host "建议：请使用手动操作指南 (WPS_更新域操作指南.md)"
    
} finally {
    # 清理 COM 对象
    if ($doc) { [System.Runtime.Interopservices.Marshal]::ReleaseComObject($doc) | Out-Null }
    if ($wps) { 
        try { $wps.Quit() } catch {}
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($wps) | Out-Null 
    }
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}
