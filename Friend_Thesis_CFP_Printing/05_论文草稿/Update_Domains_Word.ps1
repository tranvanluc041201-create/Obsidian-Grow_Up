# Word 自动更新域脚本 (Microsoft Word)
# 注意：需要安装 Microsoft Word，WPS 不完全兼容

param(
    [string]$InputFile = "C:\obsidian\Vault\Friend_Thesis_CFP_Printing\05_论文草稿\论文全文_学校规范排版稿_MASTER_r30.docx",
    [string]$OutputFile = "C:\obsidian\Vault\Friend_Thesis_CFP_Printing\05_论文草稿\论文全文_学校规范排版稿_MASTER_r30_WORD_UPDATED.docx"
)

Write-Host "=== Microsoft Word 自动更新域脚本 ===" -ForegroundColor Green

# 检查输入文件
if (-not (Test-Path $InputFile)) {
    Write-Error "❌ 输入文件不存在"
    exit 1
}

try {
    Write-Host "🚀 启动 Microsoft Word..." -ForegroundColor Yellow
    $word = New-Object -ComObject "Word.Application"
    $word.Visible = $true
    $word.ScreenUpdating = $false  # 关闭屏幕刷新，加快速度
    
    Write-Host "📂 打开文档..." -ForegroundColor Yellow
    $doc = $word.Documents.Open($InputFile, $false, $true)  # Open(路径, 格式, 只读)
    
    # 更新所有域 (关键！)
    Write-Host "🔄 更新全文域..." -ForegroundColor Yellow
    $doc.Fields.Update()  # 更新所有域
    Write-Host "   更新了 $($doc.Fields.Count) 个域" -ForegroundColor Green
    
    # 更新目录
    Write-Host "🔄 更新目录..." -ForegroundColor Yellow
    foreach ($toc in $doc.TablesOfContents) {
        $toc.Update()
        Write-Host "   目录已更新" -ForegroundColor Green
    }
    
    # 更新题注
    Write-Host "🔄 更新题注..." -ForegroundColor Yellow
    foreach ($cap in $doc.CaptionLabels) {
        try { $cap.Update() } catch {}
    }
    
    # 全选更新 (确保)
    $word.Selection.WholeStory()
    $word.Selection.Fields.Update()
    
    # 保存为新文件
    Write-Host "💾 另存为新文件..." -ForegroundColor Yellow
    $doc.SaveAs2($OutputFile, 16)  # 16 = wdFormatDocumentDefault
    
    Write-Host "✅ 完成！输出: $OutputFile" -ForegroundColor Green
    
} catch {
    Write-Host "❌ 错误: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "可能原因：" -ForegroundColor Yellow
    Write-Host "1. 未安装 Microsoft Word（只有 WPS）"
    Write-Host "2. Word 正在运行其他文档"
    Write-Host "3. 文件被占用"
} finally {
    if ($doc) { $doc.Close($false) }
    if ($word) { $word.Quit() }
    [GC]::Collect()
}
