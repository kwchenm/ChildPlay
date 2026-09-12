# 官方桌布下載腳本
# 來源：各作品官方網站免費配布的桌布 / 美術設定
# 用途：個人桌布使用

$ErrorActionPreference = "Continue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Base = "D:\Wayne Project\Game Material"
$ok = 0; $skip = 0; $fail = 0

function Get-Img($Url, $Folder, $Name) {
  $dir = Join-Path $Base $Folder
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  $out = Join-Path $dir $Name
  if (Test-Path $out) { Write-Host "  [跳過] $Name" -ForegroundColor DarkGray; $script:skip++; return }
  try {
    Invoke-WebRequest -Uri $Url -OutFile $out -UseBasicParsing -TimeoutSec 60 `
      -Headers @{ "User-Agent" = "Mozilla/5.0"; "Referer" = "https://www.google.com/" }
    Write-Host "  [完成] $Name" -ForegroundColor Green; $script:ok++
  } catch {
    Write-Host "  [失敗] $Name  ($($_.Exception.Message))" -ForegroundColor Red; $script:fail++
  }
  Start-Sleep -Milliseconds 400
}

Write-Host ""
Write-Host "=== 葬送的芙莉蓮 (84 張) ===" -ForegroundColor Cyan
Get-Img "https://frieren-anime.jp/wp-content/uploads/2026/07/n.jpg" "葬送的芙莉蓮" "frieren_001.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2026/04/g.jpg" "葬送的芙莉蓮" "frieren_002.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2026/03/g-1.jpg" "葬送的芙莉蓮" "frieren_003.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2026/03/g.jpg" "葬送的芙莉蓮" "frieren_004.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2026/02/g1.jpg" "葬送的芙莉蓮" "frieren_005.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2026/02/g2.jpg" "葬送的芙莉蓮" "frieren_006.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2026/01/g.jpg" "葬送的芙莉蓮" "frieren_007.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/12/g-1.jpg" "葬送的芙莉蓮" "frieren_008.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/12/g.jpg" "葬送的芙莉蓮" "frieren_009.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/10/g-1.jpg" "葬送的芙莉蓮" "frieren_010.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/10/g1.jpg" "葬送的芙莉蓮" "frieren_011.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/10/g2.jpg" "葬送的芙莉蓮" "frieren_012.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/10/g3.jpg" "葬送的芙莉蓮" "frieren_013.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/10/g.jpg" "葬送的芙莉蓮" "frieren_014.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/09/g.jpg" "葬送的芙莉蓮" "frieren_015.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/09/g1.jpg" "葬送的芙莉蓮" "frieren_016.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/09/g2.jpg" "葬送的芙莉蓮" "frieren_017.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/05/g.jpg" "葬送的芙莉蓮" "frieren_018.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g.jpg" "葬送的芙莉蓮" "frieren_019.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2024/12/g-1.jpg" "葬送的芙莉蓮" "frieren_020.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2024/12/g.jpg" "葬送的芙莉蓮" "frieren_021.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_1.jpg" "葬送的芙莉蓮" "frieren_022.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2024/10/g.jpg" "葬送的芙莉蓮" "frieren_023.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2024/09/g.jpg" "葬送的芙莉蓮" "frieren_024.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/12/g-2.jpg" "葬送的芙莉蓮" "frieren_025.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/12/g-1.jpg" "葬送的芙莉蓮" "frieren_026.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g-v-1.jpg" "葬送的芙莉蓮" "frieren_027.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/12/g.jpg" "葬送的芙莉蓮" "frieren_028.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/12/g.jpeg" "葬送的芙莉蓮" "frieren_029.jpeg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_2.jpg" "葬送的芙莉蓮" "frieren_030.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/11/g-1.jpg" "葬送的芙莉蓮" "frieren_031.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_3.jpg" "葬送的芙莉蓮" "frieren_032.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/11/g.jpg" "葬送的芙莉蓮" "frieren_033.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_4.jpg" "葬送的芙莉蓮" "frieren_034.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/a.jpg" "葬送的芙莉蓮" "frieren_035.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_5.jpg" "葬送的芙莉蓮" "frieren_036.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/g-2.jpg" "葬送的芙莉蓮" "frieren_037.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/g.jpg" "葬送的芙莉蓮" "frieren_038.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/g.jpeg" "葬送的芙莉蓮" "frieren_039.jpeg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_6.jpg" "葬送的芙莉蓮" "frieren_040.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/dchara.jpg" "葬送的芙莉蓮" "frieren_041.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_7.jpg" "葬送的芙莉蓮" "frieren_042.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/09/g.jpg" "葬送的芙莉蓮" "frieren_043.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_8.jpg" "葬送的芙莉蓮" "frieren_044.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/09/f_g.jpg" "葬送的芙莉蓮" "frieren_045.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_9.jpg" "葬送的芙莉蓮" "frieren_046.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/09/himmel_action.jpg" "葬送的芙莉蓮" "frieren_047.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/09/heiter_action.jpg" "葬送的芙莉蓮" "frieren_048.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/09/eisen_action.jpg" "葬送的芙莉蓮" "frieren_049.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g.jpg" "葬送的芙莉蓮" "frieren_050.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_10.jpg" "葬送的芙莉蓮" "frieren_051.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g12.jpg" "葬送的芙莉蓮" "frieren_052.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g8.jpg" "葬送的芙莉蓮" "frieren_053.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_11.jpg" "葬送的芙莉蓮" "frieren_054.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g7.jpg" "葬送的芙莉蓮" "frieren_055.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g6.jpg" "葬送的芙莉蓮" "frieren_056.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g5-1.jpg" "葬送的芙莉蓮" "frieren_057.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g4.jpg" "葬送的芙莉蓮" "frieren_058.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2025/03/g_c_12.jpg" "葬送的芙莉蓮" "frieren_059.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g11.jpg" "葬送的芙莉蓮" "frieren_060.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g10.jpg" "葬送的芙莉蓮" "frieren_061.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g9.jpg" "葬送的芙莉蓮" "frieren_062.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g3.jpg" "葬送的芙莉蓮" "frieren_063.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g2.jpg" "葬送的芙莉蓮" "frieren_064.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/08/g1.jpg" "葬送的芙莉蓮" "frieren_065.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/CS1.jpg" "葬送的芙莉蓮" "frieren_066.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/CS6.jpg" "葬送的芙莉蓮" "frieren_067.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/CS13.jpg" "葬送的芙莉蓮" "frieren_068.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/CS11.jpg" "葬送的芙莉蓮" "frieren_069.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/CS3.jpg" "葬送的芙莉蓮" "frieren_070.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/CS4.jpg" "葬送的芙莉蓮" "frieren_071.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_05_%E7%8E%8B%E9%83%BD_%E8%AC%81%E8%A6%8B%E3%81%AE%E9%96%93_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg" "葬送的芙莉蓮" "frieren_072.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/FRN_01_038_%E7%8E%8B%E9%83%BD_%E5%9F%8E%E4%B8%8B%E7%94%BA_%E5%BA%83%E5%A0%B4%E3%81%AE%E5%B1%8B%E5%8F%B01_%E5%A4%9C_%E6%99%B4%E3%82%8CR.jpg" "葬送的芙莉蓮" "frieren_073.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_04_%E7%8E%8B%E9%83%BD%E5%91%A8%E8%BE%BA_%E6%A9%8B%E3%81%AE%E8%A2%82_%E6%9C%9D_%E6%99%B4%E3%82%8C.jpg" "葬送的芙莉蓮" "frieren_074.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_07_%E7%8E%8B%E9%83%BD-%E5%9F%8E%E9%96%80%E5%89%8D_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg" "葬送的芙莉蓮" "frieren_075.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo001_06_%E7%8E%8B%E9%83%BD_%E6%95%99%E4%BC%9A_%E5%86%85%E9%83%A8_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg" "葬送的芙莉蓮" "frieren_076.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo003_03_%E3%82%BF%E3%83%BC%E3%82%AF%E5%9C%B0%E6%96%B9-%E8%96%AC%E8%8D%89%E5%AE%B6%E3%81%AE%E5%AE%B6_%E7%A7%8B_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg" "葬送的芙莉蓮" "frieren_077.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/FRN_02_286_%E5%9B%9E%E6%83%B3_%E5%BB%83%E6%95%99%E4%BC%9A-%E8%8A%B1%E7%95%91_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg" "葬送的芙莉蓮" "frieren_078.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo004_01_%E4%BA%A4%E6%98%93%E9%83%BD%E5%B8%82%E3%83%B4%E3%82%A1%E3%83%AB%E3%83%A0_%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B5%E3%83%AA%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%83%E3%83%97%E3%81%AE%E5%BA%97%E5%85%882_%E6%98%BC_%E6%99%B4%E3%82%8CR.jpg" "葬送的芙莉蓮" "frieren_079.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo004_03_%E4%BA%A4%E6%98%93%E9%83%BD%E5%B8%82%E3%83%B4%E3%82%A1%E3%83%AB%E3%83%A0_%E4%B8%98%E3%81%AE%E4%B8%8A%E3%81%AE%E3%82%AB%E3%83%95%E3%82%A7.jpg" "葬送的芙莉蓮" "frieren_080.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo006_01_%E3%82%B0%E3%83%A9%E3%83%B3%E3%83%84%E6%B5%B7%E5%B3%A1_%E6%9D%91_%E6%B5%B7%E5%B2%B8%E7%B7%9A_%E5%86%AC_%E6%98%BC_%E6%9B%87%E3%82%8A.jpg" "葬送的芙莉蓮" "frieren_081.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo006_02_%E3%82%B0%E3%83%A9%E3%83%B3%E3%83%84%E6%B5%B7%E5%B3%A1_%E6%9D%91_%E3%83%91%E3%83%B3%E5%B1%8B%E3%81%A8%E8%BF%91%E3%81%8F%E3%81%AE%E9%80%9A%E3%82%8A_%E5%86%AC_%E6%98%BC_%E6%9B%87%E3%82%8A.jpg" "葬送的芙莉蓮" "frieren_082.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo006_04_%E3%82%B0%E3%83%A9%E3%83%B3%E3%83%84%E6%B5%B7%E5%B3%A1_%E6%9D%91_%E6%B3%A2%E6%AD%A2%E5%A0%B4_%E5%86%AC_%E6%97%A5%E3%81%AE%E5%87%BA.jpg" "葬送的芙莉蓮" "frieren_083.jpg"
Get-Img "https://frieren-anime.jp/wp-content/uploads/2023/10/bo010_03_%E3%83%AA%E3%83%BC%E3%82%B2%E3%83%AB%E5%B3%A1%E8%B0%B7_%E6%9D%91%E5%A4%96%E3%82%8C%E3%81%AE%E5%B4%96_%E6%98%BC_%E6%99%B4%E3%82%8C.jpg" "葬送的芙莉蓮" "frieren_084.jpg"
Write-Host ""
Write-Host "=== 鬼滅之刃 (24 張) ===" -ForegroundColor Cyan
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2106/kimetsu_wp_2106_pc.jpg" "鬼滅之刃" "kimetsu_001.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2105/kimetsu_wp_2105_pc.jpg" "鬼滅之刃" "kimetsu_002.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2104/kimetsu_wp_2104_pc.jpg" "鬼滅之刃" "kimetsu_003.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2103/kimetsu_wp_2103_pc.jpg" "鬼滅之刃" "kimetsu_004.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2102/kimetsu_wp_2102_pc.jpg" "鬼滅之刃" "kimetsu_005.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2101/kimetsu_wp_2101_pc.jpg" "鬼滅之刃" "kimetsu_006.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2012/kimetsu_wp_2012_pc.jpg" "鬼滅之刃" "kimetsu_007.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2011/kimetsu_wp_2011_pc.jpg" "鬼滅之刃" "kimetsu_008.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2010/kimetsu_wp_2010_pc.jpg" "鬼滅之刃" "kimetsu_009.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2009/kimetsu_wp_2009_pc.jpg" "鬼滅之刃" "kimetsu_010.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2008/kimetsu_wp_2008_pc.jpg" "鬼滅之刃" "kimetsu_011.jpg"
Get-Img "https://kimetsu.com/comics/special/wallpaper/img/2007/kimetsu_wp_2007_pc.jpg" "鬼滅之刃" "kimetsu_012.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/bg01.jpg" "鬼滅之刃" "kimetsu_ufotable_013.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/bg02.jpg" "鬼滅之刃" "kimetsu_ufotable_014.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/bg03.jpg" "鬼滅之刃" "kimetsu_ufotable_015.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/bg04.jpg" "鬼滅之刃" "kimetsu_ufotable_016.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/bg05.jpg" "鬼滅之刃" "kimetsu_ufotable_017.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/bg07.jpg" "鬼滅之刃" "kimetsu_ufotable_018.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/01.jpg" "鬼滅之刃" "kimetsu_ufotable_019.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/02.jpg" "鬼滅之刃" "kimetsu_ufotable_020.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/03.jpg" "鬼滅之刃" "kimetsu_ufotable_021.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/04.jpg" "鬼滅之刃" "kimetsu_ufotable_022.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/05.jpg" "鬼滅之刃" "kimetsu_ufotable_023.jpg"
Get-Img "https://www.ufotable.com/kmt_wallpaper/img/06.jpg" "鬼滅之刃" "kimetsu_ufotable_024.jpg"

Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "完成 $ok 張 / 跳過 $skip 張 / 失敗 $fail 張" -ForegroundColor Yellow
Write-Host "存放位置：$Base" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Read-Host "按 Enter 關閉"
