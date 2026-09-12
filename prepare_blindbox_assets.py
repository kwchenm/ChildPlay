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
        ],
        "hidden": ("wh_3lew26.png", "鬼殺隊・柱合會議"),
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
