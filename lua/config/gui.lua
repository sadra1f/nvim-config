vim.cmd([[
    aunmenu   PopUp

    anoremenu PopUp.Hover                   <Cmd>lua vim.lsp.buf.hover()<CR>
    amenu     PopUp.Open\ in\ web\ browser  gx
    anoremenu PopUp.Go\ to\ definition      <Cmd>lua vim.lsp.buf.definition()<CR>
    anoremenu PopUp.Show\ Diagnostics       <Cmd>lua vim.diagnostic.open_float()<CR>
    anoremenu PopUp.Show\ All\ Diagnostics  <Cmd>lua vim.diagnostic.setqflist()<CR>
    anoremenu PopUp.Configure\ Diagnostics  <Cmd>help vim.diagnostic.config()<CR>

    anoremenu PopUp.-1-                     <Nop>

    amenu     PopUp.Debug                   <leader>dr
    anoremenu PopUp.Toggle\ breakpoint      <Cmd>lua require("dap").toggle_breakpoint()<CR>
    amenu     PopUp.View\ all\ breakpoints  <leader>dr

    anoremenu PopUp.-2-                     <Nop>

    vnoremenu PopUp.Cut                     "+x
    vnoremenu PopUp.Copy                    "+y
    anoremenu PopUp.Paste                   "+gP
    vnoremenu PopUp.Paste                   "+P
    vnoremenu PopUp.Delete                  "_x
    nnoremenu PopUp.Select\ All             ggVG
    vnoremenu PopUp.Select\ All             gg0oG$
    inoremenu PopUp.Select\ All             <C-Home><C-O>VG

    anoremenu PopUp.-3-                     <Nop>

    anoremenu PopUp.Inspect                 <Cmd>Inspect<CR>
]])

vim.opt.mousemodel = "popup_setpos"
