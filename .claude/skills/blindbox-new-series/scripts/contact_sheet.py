import os
import sys
import json
from PIL import Image, ImageDraw

# Usage:
#   python3 contact_sheet.py <Image/<folder>> <out_dir> [start_index]
#
# Generates numbered thumbnail contact sheets (8 columns, 64 images per
# sheet) for every image directly inside <Image/<folder>>, so they can be
# reviewed quickly instead of opening each file individually. Non-image
# files (.txt, .ps1, .bat, etc.) are skipped automatically.
#
# Prints "INDEX <i> <filename>" for every file so the caller can map a
# picked index back to its filename without re-listing the directory
# (the order is stable: sorted() on the filtered filename list).

IMAGE_EXTS = (".jpg", ".jpeg", ".png", ".webp", ".bmp")
THUMB = 140
COLS = 8
PER_SHEET = 64

def main():
    src_folder = sys.argv[1]
    out_dir = sys.argv[2]
    start_index = int(sys.argv[3]) if len(sys.argv) > 3 else 0

    files = sorted(f for f in os.listdir(src_folder) if f.lower().endswith(IMAGE_EXTS))
    os.makedirs(out_dir, exist_ok=True)

    for i, f in enumerate(files):
        print(f"INDEX {i} {f}")

    for sheet_start in range(start_index, len(files), PER_SHEET):
        chunk = files[sheet_start:sheet_start + PER_SHEET]
        rows = (len(chunk) + COLS - 1) // COLS
        sheet = Image.new("RGB", (COLS * THUMB, rows * (THUMB + 16)), (20, 20, 20))
        draw = ImageDraw.Draw(sheet)
        for i, fname in enumerate(chunk):
            idx = sheet_start + i
            path = os.path.join(src_folder, fname)
            try:
                im = Image.open(path).convert("RGB")
                im.thumbnail((THUMB, THUMB))
            except Exception:
                im = Image.new("RGB", (THUMB, THUMB), (60, 0, 0))
            r, c = divmod(i, COLS)
            x = c * THUMB + (THUMB - im.width) // 2
            y = r * (THUMB + 16) + (THUMB - im.height) // 2
            sheet.paste(im, (x, y))
            draw.text((c * THUMB + 2, r * (THUMB + 16) + THUMB), str(idx), fill=(255, 255, 0))
        out_path = os.path.join(out_dir, f"sheet_{sheet_start:04d}.jpg")
        sheet.save(out_path, quality=75)
        print(f"SHEET {out_path}")

if __name__ == "__main__":
    main()
