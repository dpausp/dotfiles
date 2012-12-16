imap <C-r><C-r> <ESC>:python fill_rst_heading()<CR>o<CR>
imap <C-r><C-t> <ESC>:python fill_rst_heading(upper_line=True)<CR>o<CR>

python << EOF
import vim

def fill_rst_heading(upper_line=False, newline=True):
    lineno, col = vim.current.window.cursor
    cb = vim.current.buffer
    symbol = cb[lineno-1][col-1]
    count = len(unicode(cb[lineno-2].rstrip(), encoding="utf8"))
    header_line = symbol * count
    cb[lineno-1] = header_line
    if upper_line:
        cb[lineno-2:lineno-2] = [header_line]


# vim: set filetype=python :#
