# =====================================================
# 動漫圖片收集腳本  (個人收藏用)
# 來源1：各作品官方網站免費配布的桌布／美術設定
# 來源2：wallhaven.cc  （已強制 SFW 過濾 purity=100）
# 特色：SHA-256 內容比對，同一張圖絕不會重複進資料夾
# =====================================================

# ---- 每個關鍵字抓幾頁 (1頁=24張)，想要更多就調大 ----
$Pages = 3

$ErrorActionPreference = "Continue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Base = "D:\Wayne Project\Game Material"

$ok = 0
$skip = 0
$dup = 0
$fail = 0

# ============ 步驟 1：掃描既有檔案，建立指紋索引 ============
Write-Host ""
Write-Host "[1/3] 掃描資料夾裡已經有的圖..." -ForegroundColor Cyan
$hashIndex = @{}
if (Test-Path $Base) {
    $existing = Get-ChildItem -Path $Base -Recurse -File | Where-Object { $_.Extension -match "^\.(jpg|jpeg|png|gif)$" }
    foreach ($f in $existing) {
        try {
            $h = (Get-FileHash -Algorithm SHA256 -Path $f.FullName).Hash
            if (-not $hashIndex.ContainsKey($h)) { $hashIndex[$h] = $f.Name }
        } catch { }
    }
}
Write-Host "      已存在 $($hashIndex.Count) 張不重複的圖" -ForegroundColor DarkGray

# ============ 共用下載函式（含指紋比對）============
function Save-Image {
    param([string]$Url, [string]$Folder, [string]$Name)
    $dir = Join-Path $Base $Folder
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $out = Join-Path $dir $Name
    if (Test-Path $out) { return "skip" }
    $ext = [System.IO.Path]::GetExtension($Name)
    $tmp = Join-Path $env:TEMP ("wpdl_" + [guid]::NewGuid().ToString() + $ext)
    try {
        Invoke-WebRequest -Uri $Url -OutFile $tmp -UseBasicParsing -TimeoutSec 90
    } catch {
        if (Test-Path $tmp) { Remove-Item $tmp -Force -ErrorAction SilentlyContinue }
        return "fail"
    }
    if (-not (Test-Path $tmp)) { return "fail" }
    if ((Get-Item $tmp).Length -lt 2048) { Remove-Item $tmp -Force -ErrorAction SilentlyContinue; return "fail" }
    $h = (Get-FileHash -Algorithm SHA256 -Path $tmp).Hash
    if ($hashIndex.ContainsKey($h)) {
        Remove-Item $tmp -Force -ErrorAction SilentlyContinue
        return "dup"
    }
    Move-Item -Path $tmp -Destination $out -Force
    $hashIndex[$h] = $Name
    return "ok"
}

function Report {
    param([string]$Result, [string]$Label)
    switch ($Result) {
        "ok"   { Write-Host "  + $Label" -ForegroundColor Green;    $script:ok = $script:ok + 1 }
        "skip" { Write-Host "  . $Label (檔名已存在)" -ForegroundColor DarkGray; $script:skip = $script:skip + 1 }
        "dup"  { Write-Host "  = $Label (重複的圖，已丟棄)" -ForegroundColor Yellow; $script:dup = $script:dup + 1 }
        "fail" { Write-Host "  x $Label (下載失敗)" -ForegroundColor Red;  $script:fail = $script:fail + 1 }
    }
}

# ============ 步驟 2：官方桌布 ============
Write-Host ""
Write-Host "[2/3] 下載官方配布桌布 (102 張)..." -ForegroundColor Cyan
$official = @(
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2026/07/n.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_001.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2026/04/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_002.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2026/03/g-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_003.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2026/03/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_004.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2026/02/g1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_005.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2026/02/g2.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_006.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2026/01/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_007.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/12/g-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_008.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/12/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_009.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/10/g-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_010.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/10/g1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_011.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/10/g2.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_012.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/10/g3.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_013.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/10/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_014.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/09/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_015.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/09/g1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_016.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/09/g2.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_017.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/05/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_018.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_019.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2024/12/g-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_020.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2024/12/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_021.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_022.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2024/10/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_023.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2024/09/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_024.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/12/g-2.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_025.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/12/g-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_026.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g-v-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_027.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/12/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_028.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/12/g.jpeg"; F = "葬送的芙莉蓮"; N = "official_frieren_029.jpeg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_2.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_030.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/11/g-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_031.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_3.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_032.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/11/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_033.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_4.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_034.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/a.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_035.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_5.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_036.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/g-2.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_037.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_038.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/g.jpeg"; F = "葬送的芙莉蓮"; N = "official_frieren_039.jpeg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_6.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_040.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/dchara.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_041.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_7.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_042.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/09/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_043.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_8.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_044.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/09/f_g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_045.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_9.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_046.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/09/himmel_action.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_047.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/09/heiter_action.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_048.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/09/eisen_action.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_049.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_050.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_10.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_051.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g12.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_052.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g8.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_053.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_11.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_054.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g7.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_055.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g6.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_056.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g5-1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_057.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g4.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_058.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_12.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_059.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g11.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_060.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g10.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_061.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g9.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_062.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g3.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_063.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g2.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_064.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/08/g1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_065.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/CS1.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_066.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/CS6.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_067.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/CS13.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_068.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/CS11.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_069.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/CS3.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_070.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/CS4.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_071.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_05_%E7%8E%8B%E9%83%BD_%E8%AC%81%E8%A6%8B%E3%81%AE%E9%96%93_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_072.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/FRN_01_038_%E7%8E%8B%E9%83%BD_%E5%9F%8E%E4%B8%8B%E7%94%BA_%E5%BA%83%E5%A0%B4%E3%81%AE%E5%B1%8B%E5%8F%B01_%E5%A4%9C_%E6%99%B4%E3%82%8CR.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_073.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_04_%E7%8E%8B%E9%83%BD%E5%91%A8%E8%BE%BA_%E6%A9%8B%E3%81%AE%E8%A2%82_%E6%9C%9D_%E6%99%B4%E3%82%8C.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_074.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_07_%E7%8E%8B%E9%83%BD-%E5%9F%8E%E9%96%80%E5%89%8D_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_075.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_06_%E7%8E%8B%E9%83%BD_%E6%95%99%E4%BC%9A_%E5%86%85%E9%83%A8_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_076.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo003_03_%E3%82%BF%E3%83%BC%E3%82%AF%E5%9C%B0%E6%96%B9-%E8%96%AC%E8%8D%89%E5%AE%B6%E3%81%AE%E5%AE%B6_%E7%A7%8B_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_077.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/FRN_02_286_%E5%9B%9E%E6%83%B3_%E5%BB%83%E6%95%99%E4%BC%9A-%E8%8A%B1%E7%95%91_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_078.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo004_01_%E4%BA%A4%E6%98%93%E9%83%BD%E5%B8%82%E3%83%B4%E3%82%A1%E3%83%AB%E3%83%A0_%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B5%E3%83%AA%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%83%E3%83%97%E3%81%AE%E5%BA%97%E5%85%882_%E6%98%BC_%E6%99%B4%E3%82%8CR.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_079.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo004_03_%E4%BA%A4%E6%98%93%E9%83%BD%E5%B8%82%E3%83%B4%E3%82%A1%E3%83%AB%E3%83%A0_%E4%B8%98%E3%81%AE%E4%B8%8A%E3%81%AE%E3%82%AB%E3%83%95%E3%82%A7.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_080.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo006_01_%E3%82%B0%E3%83%A9%E3%83%B3%E3%83%84%E6%B5%B7%E5%B3%A1_%E6%9D%91_%E6%B5%B7%E5%B2%B8%E7%B7%9A_%E5%86%AC_%E6%98%BC_%E6%9B%87%E3%82%8A.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_081.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo006_02_%E3%82%B0%E3%83%A9%E3%83%B3%E3%83%84%E6%B5%B7%E5%B3%A1_%E6%9D%91_%E3%83%91%E3%83%B3%E5%B1%8B%E3%81%A8%E8%BF%91%E3%81%8F%E3%81%AE%E9%80%9A%E3%82%8A_%E5%86%AC_%E6%98%BC_%E6%9B%87%E3%82%8A.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_082.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo006_04_%E3%82%B0%E3%83%A9%E3%83%B3%E3%83%84%E6%B5%B7%E5%B3%A1_%E6%9D%91_%E6%B3%A2%E6%AD%A2%E5%A0%B4_%E5%86%AC_%E6%97%A5%E3%81%AE%E5%87%BA.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_083.jpg" }
  @{ U = "https://frieren-anime.jp/wp-content/uploads/2023/10/bo010_03_%E3%83%AA%E3%83%BC%E3%82%B2%E3%83%AB%E5%B3%A1%E8%B0%B7_%E6%9D%91%E5%A4%96%E3%82%8C%E3%81%AE%E5%B4%96_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg"; F = "葬送的芙莉蓮"; N = "official_frieren_084.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2106/kimetsu_wp_2106_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2106.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2105/kimetsu_wp_2105_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2105.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2104/kimetsu_wp_2104_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2104.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2103/kimetsu_wp_2103_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2103.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2102/kimetsu_wp_2102_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2102.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2101/kimetsu_wp_2101_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2101.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2012/kimetsu_wp_2012_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2012.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2011/kimetsu_wp_2011_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2011.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2010/kimetsu_wp_2010_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2010.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2009/kimetsu_wp_2009_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2009.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2008/kimetsu_wp_2008_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2008.jpg" }
  @{ U = "https://kimetsu.com/comics/special/wallpaper/img/2007/kimetsu_wp_2007_pc.jpg"; F = "鬼滅之刃"; N = "official_kimetsu_cal_2007.jpg" }
  @{ U = "https://www.ufotable.com/kmt_wallpaper/img/bg01.jpg"; F = "鬼滅之刃"; N = "official_ufotable_bg_01.jpg" }
  @{ U = "https://www.ufotable.com/kmt_wallpaper/img/bg02.jpg"; F = "鬼滅之刃"; N = "official_ufotable_bg_02.jpg" }
  @{ U = "https://www.ufotable.com/kmt_wallpaper/img/bg03.jpg"; F = "鬼滅之刃"; N = "official_ufotable_bg_03.jpg" }
  @{ U = "https://www.ufotable.com/kmt_wallpaper/img/bg04.jpg"; F = "鬼滅之刃"; N = "official_ufotable_bg_04.jpg" }
  @{ U = "https://www.ufotable.com/kmt_wallpaper/img/bg05.jpg"; F = "鬼滅之刃"; N = "official_ufotable_bg_05.jpg" }
  @{ U = "https://www.ufotable.com/kmt_wallpaper/img/bg07.jpg"; F = "鬼滅之刃"; N = "official_ufotable_bg_06.jpg" }
)
foreach ($it in $official) {
    Report (Save-Image $it.U $it.F $it.N) $it.N
    Start-Sleep -Milliseconds 250
}

# ============ 步驟 3：wallhaven 桌布 ============
Write-Host ""
Write-Host "[3/3] 從 wallhaven 搜尋補充 (SFW 過濾已開啟)..." -ForegroundColor Cyan
$whJobs = @(
  @{ F = "名偵探柯南"; Q = @("detective conan", "case closed conan", "conan edogawa") }
  @{ F = "葬送的芙莉蓮"; Q = @("frieren", "frieren beyond journeys end") }
  @{ F = "鬼滅之刃"; Q = @("demon slayer", "kimetsu no yaiba") }
  @{ F = "迪士尼經典"; Q = @("disney", "disney castle", "mickey mouse") }
  @{ F = "獨自升級"; Q = @("solo leveling", "sung jinwoo") }
)
foreach ($job in $whJobs) {
    Write-Host ""
    Write-Host "  --- $($job.F) ---" -ForegroundColor Magenta
    $n = 0
    foreach ($q in $job.Q) {
        for ($p = 1; $p -le $Pages; $p++) {
            $api = "https://wallhaven.cc/api/v1/search?q=" + [uri]::EscapeDataString($q) + "&purity=100&categories=111&page=" + $p
            try { $resp = Invoke-RestMethod -Uri $api -TimeoutSec 45 } catch { continue }
            if ($null -eq $resp.data) { continue }
            foreach ($item in $resp.data) {
                $n = $n + 1
                $ext = [System.IO.Path]::GetExtension($item.path)
                if ([string]::IsNullOrEmpty($ext)) { $ext = ".jpg" }
                $name = "wh_" + $item.id + $ext
                Report (Save-Image $item.path $job.F $name) $name
                Start-Sleep -Milliseconds 250
            }
            Start-Sleep -Milliseconds 1500
        }
    }
}

# ============ 總結 ============
Write-Host ""
Write-Host "=================================================" -ForegroundColor Yellow
Write-Host "  新增 $ok 張" -ForegroundColor Green
Write-Host "  跳過 $skip 張（檔名已存在）" -ForegroundColor DarkGray
Write-Host "  重複 $dup 張（內容相同，已自動丟棄）" -ForegroundColor Yellow
Write-Host "  失敗 $fail 張" -ForegroundColor Red
Write-Host "-------------------------------------------------" -ForegroundColor Yellow
Write-Host "  資料夾現況：" -ForegroundColor Yellow
Get-ChildItem -Path $Base -Directory | ForEach-Object {
    $c = (Get-ChildItem -Path $_.FullName -File | Where-Object { $_.Extension -match "^\.(jpg|jpeg|png|gif)$" }).Count
    Write-Host ("    {0,-16} {1,4} 張" -f $_.Name, $c) -ForegroundColor White
}
Write-Host "=================================================" -ForegroundColor Yellow
Write-Host ""
Read-Host "按 Enter 關閉"
