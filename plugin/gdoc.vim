if !has('python3')
    echom "[ERROR] Python3 is required for this to work"
    finish
endif

let path_to_creds = get(g:, 'path_to_creds', "-1")
let token_directory = get(g:, 'token_directory', "-1")
let g:loaded = 0

if path_to_creds == -1
    echom "[ERROR] Please provde a credential file path"
    finish
endif

if token_directory == -1
    let token_directory = './'
endif


" We assume the user has executed `./install.py` and thus has all the packages
let g:buf_content = join(getline(1,'$'), "\n")

" We can choose to disable startup load, which will lead to normal startup
" but a longer writing time.
let disabled = get(g:, 'disable_startup', "-1")

if disabled == -1
    call doc#Gdoc(path_to_creds, token_directory)
    command! -nargs=1 -complete=command Gdoc call doc#WriteDoc(<q-args>)
else
    command! -nargs=1 -complete=command Gdoc call doc#InitAndWrite(path_to_creds, token_directory, <f-args>)
endif
