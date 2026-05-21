import re
from colorsys import rgb_to_hls

# TokyoNight Storm palette
PALETTE = {
    "black": "#1d202f",
    "red": "#f7768e",
    "green": "#9ece6a",
    "yellow": "#e0af68",
    "blue": "#7aa2f7",
    "magenta": "#bb9af7",
    "cyan": "#7dcfff",
    "white": "#a9b1d6",
    "bright_black": "#414868",
    "bright_red": "#ff899d",
    "bright_green": "#9fe044",
    "bright_yellow": "#faba4a",
    "bright_blue": "#8db0ff",
    "bright_magenta": "#c7a9ff",
    "bright_cyan": "#a4daff",
    "bright_white": "#c0caf5",
}


def hex_to_rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i : i + 2], 16) for i in (0, 2, 4))


def is_gray(r, g, b, threshold=12):
    return max(r, g, b) - min(r, g, b) <= threshold


def remap_semantic(hex_color):
    r, g, b = hex_to_rgb(hex_color)
    # detect gray/white/black by saturation
    if is_gray(r, g, b):
        # lightness cutoff
        l = (max(r, g, b) + min(r, g, b)) / 2
        if l < 40:
            return PALETTE["black"]
        elif l < 120:
            return PALETTE["bright_black"]
        elif l < 200:
            return PALETTE["white"]
        else:
            return PALETTE["bright_white"]

    # hue-based mapping
    # convert to HLS for hue classification
    h, l, s = rgb_to_hls(r / 255, g / 255, b / 255)
    h_deg = h * 360

    if 0 <= h_deg < 20 or h_deg >= 340:
        return PALETTE["red"]
    if 20 <= h_deg < 70:
        return PALETTE["yellow"]
    if 70 <= h_deg < 160:
        return PALETTE["green"]
    if 160 <= h_deg < 200:
        return PALETTE["cyan"]
    if 200 <= h_deg < 260:
        return PALETTE["blue"]
    if 260 <= h_deg < 340:
        return PALETTE["magenta"]

    return PALETTE["white"]


HEX_RE = re.compile(r"#[0-9a-fA-F]{6}")


def remap_line(line, in_icon_section):
    if not in_icon_section:
        return line

    def repl(match):
        return remap_semantic(match.group(0))

    return HEX_RE.sub(repl, line)


def main():
    with open("theme.toml", "r", encoding="utf-8") as f:
        lines = f.readlines()

    out = []
    in_icon = False
    for line in lines:
        if line.strip().startswith("[icon]"):
            in_icon = True
        elif line.strip().startswith("[") and line.strip() != "[icon]":
            in_icon = False
        out.append(remap_line(line, in_icon))

    with open("theme.toml", "w", encoding="utf-8") as f:
        f.writelines(out)

    print("Remap complete: theme.toml updated.")


if __name__ == "__main__":
    main()
