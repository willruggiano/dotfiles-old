# load the autoconfig.yml file which is the home of all customization done through the UI (:set, :bind, etc)
config.load_autoconfig()

# additional custom aliases
c.aliases.update({
    'settings': 'open -t qute://settings'
})

# additional custom keybindings
config.bind(';q', 'hint links run :set-cmd-text -s :quickmark-add {hint-url}')
config.unbind('q')  # as it will be the root of our quickmark hierarchy
config.bind('ql', 'set-cmd-text -s :quickmark-load')
config.bind('qL', 'set-cmd-text -s :quickmark-load -t')
config.bind('qa', 'quickmark-save')
config.bind('qd', 'quickmark-del')
config.unbind('b')  # as it will be the root of our bookmark hierarcy
config.bind('bl', 'set-cmd-text -s :bookmark-load')
config.bind('bL', 'set-cmd-text -s :bookmark-load -t')
config.bind('ba', 'bookmark-add')
config.bind('bd', 'bookmark-del')
config.unbind('\'')  # as we will use standard vim mark/jump semantics
config.bind('m', 'enter-mode set_mark')
config.bind('`', 'enter-mode jump_mark')

import platform
if platform.system() == 'Linux':
    # pass bindings (only on ubuntu for now)
    config.bind(',P', 'spawn --userscript qute-pass --password-only')
    config.bind(',p', 'spawn --userscript qute-pass')

c.editor.command = ['alacritty', "-e 'nvim -f {file} -c normal {line}G{column0}l'"]

# default start page/search engine
c.url.default_page = 'https://google.com'
c.url.start_pages = ['https://google.com']
c.url.searchengines.update({
    'google': 'https://google.com/search?q={}',
    'code': 'https://code.amazon.com/search?term={}',
    'package': 'https://code.amazon.com/packages/{}/trees/mainline'
})
c.url.searchengines['DEFAULT'] = c.url.searchengines['google']

# security + privacy
#c.content.canvas_reading = False
#c.content.dns_prefetch = False
#c.content.headers.accept_language = 'en-US,en;q=0.5'
#c.content.headers.custom['accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
# c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64) Gecko/20100101 Firefox/68.0'
#c.content.webgl = False
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'

# enable kerberos in qtwebengine
c.qt.args = [ "auth-server-whitelist=*.amazon.com" ]
