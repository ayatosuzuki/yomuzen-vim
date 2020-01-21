" NモードとVモードにて全角を入力しても、可能な限り半角として解析します。
" Last Change: 2020-1-22
" Maintainer: Ayato Suzuki <info.ayatosuzuki at googlemail dot com>
" License: MIT
"
"
scriptencoding utf-8
if exists("g:loaded_yomuzen")
  finish
endif
let g:loaded_yomuzen = 1

if exists("g:unable_yomuzen")
    finish
endif


let s:save_cpo = &cpo
set cpo&vim
"ノーマルモード時に全角入力しても認識する 独立文字と促音（っ）に対応
let s:dokuritu = {'　': ' ', '１': '1','２': '2','３': '3','４': '4','５': '5','６': '6','７': '7','８': '8','９': '9','０': '0','−': '-','＾': '^','￥': '\','＠': '@','「': '[','；': ';','：': ':','」': ']','、': ',','。': '.','・': '/','＿': '_','！': '!','”': '"','＃': '#','＄': '$','％': '%','＆': '&','’': '''','（': '(','）': ')','＝': '=','〜': '~','｜': '|','｀': '`','｛': '{','＋': '+','＊': '*','｝': '}','＜': '<','＞': '>','？': '?','ｂ': 'b','ｃ': 'c','ｄ': 'd','ｆ': 'f','ｇ': 'g','ｈ': 'h','ｊ': 'j','ｋ': 'k','ｌ': 'l','ｍ': 'm','ｎ': 'n','ｐ': 'p','ｑ': 'q','ｒ': 'r','ｓ': 's','ｔ': 't','ｗ': 'w','ｘ': 'x','ｙ': 'y','ｚ': 'z','あ': 'a','え': 'e','お': 'o','ぱ': 'pa','ぷ': 'pu','ぺ': 'pe','ぽ': 'po','だ': 'da','づ': 'du','な': 'na','ぬ': 'nu','ね': 'ne','の': 'no','ら': 'ra','る': 'ru','れ': 're','ろ': 'ro','さ': 'sa','そ': 'so','た': 'ta','ざ': 'za','ぜ': 'ze','ぞ': 'zo','を': 'wo','ゐ': 'wyi','ゑ': 'wye', 'ア':'a', 'エ':'e','オ':'o','パ':'pa','プ':'pu','ペ':'pe','ポ':'po','ダ':'da','ヅ':'du','ナ':'na','ヌ':'nu','ネ':'ne','ノ':'no','ラ':'ra','ル':'ru','レ':'re','ロ':'ro','サ':'sa','ソ':'so','タ':'ta','ザ':'za','ゼ':'ze','ゾ':'zo','ヲ':'wo','ヱ':'wye','ヰ':'wyi'}
let s:tt_count = 0


function! Zenkaku_Recog(key)
    " 全角文字を受け取り、対応する半角文字が確定すれば返す
    if a:key == "っ"
        let s:tt_count += 1
        return ""
    endif
    let l:res = ""
    for i in range(s:tt_count)
        let l:res .= s:dokuritu[a:key][0]
    endfor
    let s:tt_count = 0
    let l:res .= s:dokuritu[a:key]
    return l:res
endfunction
"以下初期設定
for [key, val] in items(s:dokuritu)
    let mapleader = key
    nmap <expr> <Leader> Zenkaku_Recog("<Leader>")
    vmap <expr> <Leader> Zenkaku_Recog("<Leader>")
endfo
nmap <expr> っ Zenkaku_Recog("っ")
vmap <expr> っ Zenkaku_Recog("っ")


let &cpo = s:save_cpo
unlet s:save_cpo

