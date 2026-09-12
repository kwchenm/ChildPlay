import os
from PIL import Image

SRC = "Image"
DST = "assets/blindbox-photos"
MAXDIM = 1400
QUALITY = 84

PICKS = {
    "conan": {
        "folder": "名偵探柯南",
        "regular": [
            ("wh_0pqpx9.jpg", "江戶川柯南"),
            ("wh_ogxy75.png", "怪盜基德"),
            ("wh_k89m86.png", "毛利蘭"),
            ("wh_d8598j.png", "怪盜基德・現身"),
            ("wh_dgjljg.jpg", "怪盜基德・預告函"),
            ("wh_e88yjo.jpg", "事件現場"),
            ("wh_j5le8w.jpg", "偵探天團"),
            ("wh_q62zdl.jpg", "少年偵探團"),
            ("wh_r29k97.jpg", "名偵探對決"),
            ("wh_rdgg2w.png", "工藤新一與毛利蘭"),
            ("wh_vmlkj5.jpg", "怪盜基德與中森青子"),
            ("wh_wyg2gq.jpg", "夏日回憶・新一與蘭"),
            ("wh_0p6kzp.jpg", "偵探對決・烈焰追擊"),
            ("wh_1kwegv.jpg", "偵探事務所日常"),
            ("wh_1p9x2g.jpg", "怪盜基德・零的策略"),
            ("wh_2yk2gy.jpg", "名偵探全員大集合"),
            ("wh_3km9e9.jpg", "黑衣組織・雙眸"),
            ("wh_43k193.jpg", "案件檔案牆"),
            ("wh_4v8jjl.jpg", "怪盜基德・夜色追蹤"),
            ("wh_85w56k.png", "米花町街景"),
            ("wh_8gg3lo.jpg", "電玩遊樂場"),
            ("wh_8ow28j.jpg", "柯南與基德"),
            ("wh_g71ol7.png", "神秘身影"),
            ("wh_lqp6xr.jpg", "怪盜基德・窗邊剪影"),
            ("wh_o5ldxl.jpg", "新一與蘭・門前"),
            ("wh_rq7vq1.png", "黑衣組織・冷酷凝視"),
            ("wh_vm8grm.jpg", "名偵探柯南劇場版"),
            ("wh_w58p57.png", "推理瞬間"),
            ("wh_z8j1vv.jpg", "名偵探柯南・電影特報"),
            ("wh_zxj9eo.jpg", "偵探對決・雷霆一擊"),
        ],
        "hidden": ("wh_x1xy9l.jpg", "全員集合・名偵探柯南"),
    },
    "sololeveling": {
        "folder": "獨自升級",
        "regular": [
            ("wh_1pxmxg.jpg", "影之君主 成振宇"),
            ("wh_2y5kgy.jpg", "暗影軍團統帥"),
            ("wh_2yp2xx.png", "覺醒的獵人"),
            ("wh_3lyy69.png", "最強獵人"),
            ("wh_5y7yk1.png", "都市獵人"),
            ("wh_851mmy.jpg", "影之軍隊"),
            ("wh_85l3rj.jpg", "雪地狩獵者"),
            ("wh_8ggjqy.png", "覺醒者之力"),
            ("wh_9o82j8.jpg", "暗影使者"),
            ("wh_e7615k.png", "劍聖"),
            ("wh_kxk6kd.jpg", "劍舞獵人 車海仁"),
            ("wh_qzegld.png", "金色巨獸獵人"),
            ("wh_1p7w6w.png", "暗黑征服者"),
            ("wh_1qkqy9.png", "白色騎士"),
            ("wh_28vz36.png", "覺醒之力・成振宇"),
            ("wh_7jje13.png", "赤紅獵人"),
            ("wh_85wp2k.png", "銀白劍聖"),
            ("wh_exqrd8.jpg", "靜謐凝視"),
            ("wh_g7652e.png", "煙霧行者"),
            ("wh_l3xz2p.png", "孤高身影"),
            ("wh_l8wgp2.jpg", "紫電覺醒"),
            ("wh_po8yvj.jpg", "赤劍疾風"),
            ("wh_qz8qq7.jpg", "獵人公會全員"),
            ("wh_qzeg75.jpg", "赤藍對峙"),
            ("wh_qzg8gl.jpg", "疾馳追跡"),
            ("wh_rdpxkq.png", "影之軍隊・降臨"),
            ("wh_v9jz53.png", "橙電斬擊"),
            ("wh_vqw79l.jpg", "都市黃昏獵人"),
            ("wh_x62ggo.jpg", "傳說降臨・海報"),
            ("wh_x6ywxz.png", "白雪劍舞"),
        ],
        "hidden": ("wh_poo7w9.png", "影之將軍 貝魯"),
    },
    "frieren": {
        "folder": "葬送的芙莉蓮",
        "regular": [
            ("frieren_047.jpg", "希姆爾"),
            ("frieren_048.jpg", "海塔"),
            ("frieren_049.jpg", "艾森"),
            ("frieren_055.jpg", "修塔爾克"),
            ("frieren_056.jpg", "費倫"),
            ("official_frieren_037.jpg", "芙莉蓮"),
            ("official_frieren_003.jpg", "芙莉蓮・日常"),
            ("official_frieren_004.jpg", "芙莉蓮・旅途"),
            ("official_frieren_008.jpg", "聖誕限定芙莉蓮"),
            ("official_frieren_016.jpg", "萬聖節限定芙莉蓮"),
            ("frieren_007.jpg", "芙莉蓮與同伴"),
            ("frieren_008.jpg", "新年和服芙莉蓮"),
            ("frieren_001.jpg", "首映紀念海報"),
            ("frieren_002.jpg", "旅途夥伴群像"),
            ("frieren_004.jpg", "夕陽下的隊伍"),
            ("frieren_009.jpg", "聖誕節費倫"),
            ("frieren_010.jpg", "萬聖節群像"),
            ("frieren_011.jpg", "費倫與芙莉蓮"),
            ("frieren_016.jpg", "旅途中的四人"),
            ("frieren_017.jpg", "魔法練習"),
            ("frieren_018.jpg", "學院日常群像"),
            ("frieren_023.jpg", "沙灘旅途"),
            ("frieren_025.jpg", "冬日新年賀"),
            ("frieren_028.jpg", "SEIN"),
            ("frieren_041.jpg", "旅人四人組"),
            ("frieren_050.jpg", "修塔爾克與費倫"),
            ("frieren_052.jpg", "森林旅途"),
            ("frieren_066.jpg", "古老城鎮"),
            ("frieren_068.jpg", "教堂彩窗"),
            ("frieren_071.jpg", "遠方城堡"),
        ],
        "hidden": ("wh_gwdyeq.jpg", "千年魔法・覺醒芙莉蓮"),
    },
    "disney": {
        "folder": "迪士尼經典",
        "regular": [
            ("wh_0q6ge7.jpg", "米奇經典剪影"),
            ("wh_4gjjxl.jpg", "米奇星空之旅"),
            ("wh_4drgwj.jpg", "米奇夥伴大集合"),
            ("wh_5ykwp3.jpg", "動物方城市:兔子警官與狐狸"),
            ("wh_lykmgr.jpg", "動物方城市:好搭檔"),
            ("wh_5g2p21.jpg", "小熊維尼與小豬"),
            ("wh_dgx6xo.jpg", "王國之心三劍客"),
            ("wh_3q62m6.jpg", "飛哥與小佛"),
            ("wh_gpolge.jpg", "星際寶貝:莉蘿與史迪奇"),
            ("wh_l85m2q.jpg", "阿拉丁神燈精靈"),
            ("wh_8x6j1o.jpg", "米奇與米妮"),
            ("wh_3q5976.jpg", "溫馨家庭時光"),
            ("wh_0j168y.jpg", "王國之心・徽章"),
            ("wh_0j367m.jpg", "王國之心・夥伴集合"),
            ("wh_2133g6.png", "精靈之舞"),
            ("wh_21ez5g.jpg", "小美人魚幻想"),
            ("wh_2y6oem.jpg", "玩具工坊"),
            ("wh_3kpxy3.jpg", "冰上溜冰的米奇"),
            ("wh_3lxv39.jpg", "溫馨家庭晚餐"),
            ("wh_3qqvvd.jpg", "小兔邦尼"),
            ("wh_42w229.jpg", "米奇衝浪"),
            ("wh_45pjv3.jpg", "復古電視米奇"),
            ("wh_4dp1w3.jpg", "米奇滑板剪影"),
            ("wh_4grj27.jpg", "米奇經典圖示"),
            ("wh_4o1kgm.jpg", "王國之心・心之光"),
            ("wh_4xelrz.jpg", "王國之心・繽紛鑰匙劍"),
            ("wh_5dwx21.jpg", "長髮公主・天燈之夜"),
            ("wh_76olqy.jpg", "冰雪奇緣・冰晶之戰"),
            ("wh_7prp2e.jpg", "王國之心・雪境冒險"),
            ("wh_8g3l2k.jpg", "綠龍幻境"),
        ],
        "hidden": ("wh_e8zwzl.jpg", "王國之心・傳說鑰匙劍使者"),
    },
    "kimetsu": {
        "folder": "鬼滅之刃",
        "regular": [
            ("kimetsu_calendar_2007.jpg", "竈門炭治郎"),
            ("kimetsu_calendar_2008.jpg", "竈門禰豆子"),
            ("kimetsu_calendar_2010.jpg", "我妻善逸"),
            ("kimetsu_calendar_2011.jpg", "嘴平伊之助"),
            ("kimetsu_calendar_2101.jpg", "冨岡義勇"),
            ("kimetsu_calendar_2102.jpg", "胡蝶忍"),
            ("wh_8g59jj.jpg", "禰豆子・竹口封印"),
            ("wh_3q9rgd.jpg", "鬼殺隊・覺醒之眼"),
            ("wh_vq6d1l.jpg", "紅色劍士"),
            ("wh_w5q3e6.jpg", "雷之呼吸・全集中"),
            ("wh_yxr5xg.png", "鬼殺隊出陣"),
            ("wh_zpmokw.jpg", "業炎之刃"),
            ("kimetsu_calendar_2009.jpg", "竈門炭治郎(月曆版)"),
            ("kimetsu_calendar_2012.jpg", "我妻善逸(月曆版)"),
            ("kimetsu_calendar_2103.jpg", "嘴平伊之助(月曆版)"),
            ("kimetsu_calendar_2104.jpg", "冨岡義勇(月曆版)"),
            ("kimetsu_calendar_2105.jpg", "胡蝶忍(月曆版)"),
            ("wh_3qkl9y.png", "蝶戀之舞"),
            ("wh_5g2z39.jpg", "雪夜劍士"),
            ("wh_5g82m9.png", "花蝶精靈"),
            ("wh_6dg136.jpg", "覺醒之眼・鬼殺隊"),
            ("wh_7pl9qy.jpg", "雙劍齊舞・櫻花"),
            ("wh_851dzk.png", "熱血對決"),
            ("wh_d6ow6j.jpg", "鬼殺隊小隊集合"),
            ("wh_exr1rr.jpg", "森林中的劍士"),
            ("wh_gp69l3.png", "緋紅疾風斬"),
            ("wh_l8owvp.jpg", "全集中・堅定意志"),
            ("wh_lyyjvy.png", "闇夜羽翼"),
            ("wh_o5e3e9.jpg", "鬼殺隊・傳說集結"),
            ("wh_p972d9.png", "市松花紋劍士"),
        ],
        "hidden": ("wh_3lew26.png", "鬼殺隊・柱合會議"),
    },
    "pikmin": {
        "folder": "皮克敏",
        "regular": [
            ("wh_01l8d1.jpg", "森林中的皮克敏"),
            ("wh_0qpxjl.jpg", "大亂鬥皮克敏隊"),
            ("wh_13xek1.jpg", "任天堂明星大亂鬥"),
            ("wh_1kzgl1.jpg", "皮克敏圖鑑"),
            ("wh_1p6jmv.jpg", "草原上的小隊"),
            ("wh_211r1g.jpg", "藤蔓花紋邊框"),
            ("wh_2yx11y.png", "繽紛皮克敏群"),
            ("wh_39o9g3.jpg", "大亂鬥夥伴們"),
            ("wh_3lk2o3.jpg", "明星大亂鬥集合"),
            ("wh_429yx6.jpg", "百人亂鬥"),
            ("wh_42dp8y.jpg", "收藏公仔展示櫃"),
            ("wh_45peq7.jpg", "紅皮克敏行軍"),
            ("wh_4g2jme.jpg", "藤蔓上的隊伍"),
            ("wh_4vo77m.jpg", "奧利馬與紅皮克敏"),
            ("wh_4xeg6l.jpg", "準備開戰"),
            ("wh_7jegge.jpg", "白皮克敏特寫"),
            ("wh_d88l6l.jpg", "皮克敏圖鑑牆"),
            ("wh_gpo15d.jpg", "雪地探險"),
            ("wh_jx3kxp.png", "花朵皮克敏花束"),
            ("wh_lyqx1l.jpg", "數字徽章皮克敏"),
            ("wh_nkjdq1.jpg", "你會成為我們的隊長嗎"),
            ("wh_nm7oy8.jpg", "大亂鬥角色群像"),
            ("wh_o5kmk5.jpg", "夜光花田"),
            ("wh_qrr1zq.jpg", "紫皮克敏行軍"),
            ("wh_rqqkrm.jpg", "紅皮克敏過橋"),
            ("wh_vqld78.jpg", "黃皮克敏與王冠"),
            ("wh_xlwjeo.jpg", "彩虹皮克敏排排站"),
            ("wh_yxzoj7.jpg", "奇幻森林之旅"),
            ("wh_zm2opw.jpg", "amiibo公仔陣列"),
            ("wh_zm67go.jpg", "大亂鬥DX紀念卡"),
        ],
        "hidden": ("wh_zyo11j.jpg", "傳說隊長・蘋果探險記"),
    },
}

def process(src_path, dst_path):
    im = Image.open(src_path)
    im = im.convert("RGB")
    w, h = im.size
    if max(w, h) > MAXDIM:
        scale = MAXDIM / max(w, h)
        im = im.resize((max(1, int(w*scale)), max(1, int(h*scale))), Image.LANCZOS)
    os.makedirs(os.path.dirname(dst_path), exist_ok=True)
    im.save(dst_path, "JPEG", quality=QUALITY, optimize=True)
    return os.path.getsize(dst_path)

manifest_out = {}
total_bytes = 0
for series_id, cfg in PICKS.items():
    folder = cfg["folder"]
    entries = []
    for i, (fname, label) in enumerate(cfg["regular"]):
        src = os.path.join(SRC, folder, fname)
        dst_name = f"{i+1:02d}.jpg"
        dst = os.path.join(DST, series_id, dst_name)
        size = process(src, dst)
        total_bytes += size
        entries.append({"file": dst_name, "label": label})
    hfname, hlabel = cfg["hidden"]
    hsrc = os.path.join(SRC, folder, hfname)
    hdst = os.path.join(DST, series_id, "hidden.jpg")
    size = process(hsrc, hdst)
    total_bytes += size
    manifest_out[series_id] = {"regular": entries, "hidden": {"file": "hidden.jpg", "label": hlabel}}
    print(series_id, "done,", len(entries), "regular + 1 hidden")

print("TOTAL BYTES:", total_bytes, "(~%.1f MB)" % (total_bytes/1024/1024))

import json
with open(os.path.join(DST, "manifest.json"), "w", encoding="utf-8") as f:
    json.dump(manifest_out, f, ensure_ascii=False, indent=1)
