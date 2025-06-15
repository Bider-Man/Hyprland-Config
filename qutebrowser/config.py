# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

config.load_autoconfig(False)

####################################
######## Homepage & New Tab ########
####################################
c.url.start_pages = ["https://www.ecosia.org"]
c.url.default_page = "https://www.ecosia.org"

###############################################
######## Search Engines and Completion ########
###############################################
c.url.searchengines = {
    "DEFAULT": "https://www.ecosia.org/search?q={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
}

c.completion.open_categories = ["searchengines", "quickmarks", "bookmarks", "history", "filesystem"]

##########################
######## Keybinds ########
##########################
config.bind("h", "history")
config.bind("!es", "open https://www.ecosia.org")

###########################
######## Dark Mode ########
###########################
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")

#########################
######## Privacy ########
#########################
# Cookie settings that allow logins
c.content.cookies.accept = "no-3rdparty"  # Changed from "never" to allow 1st-party cookies
c.content.cookies.store = True  # Changed to True to maintain sessions

# Tracking protection
c.content.canvas_reading = False
c.content.webrtc_ip_handling_policy = "disable-non-proxied-udp"  # Fixed typo

# Ad blocking
c.content.blocking.enabled = True
c.content.blocking.method = "adblock"
c.content.blocking.adblock.lists = [
        "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"]

# Privacy exceptions for login domains
with config.pattern('*://accounts.google.com/*') as p:
    p.content.javascript.enabled = True
    p.content.cookies.accept = "all"

with config.pattern('*://*.google.com/*') as p:
    p.content.javascript.enabled = True
    p.content.cookies.accept = "all"

#############################
######## Performance ########
#############################
c.content.autoplay = False
c.content.javascript.enabled = True  # Enabled globally but can be toggled
c.content.webgl = False
