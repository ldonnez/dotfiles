set mouse=a

" Set Editor Font
if exists(':GuiFont')
  if has('win32') || has('win64')
    GuiFont! Hack Nerd Font:h14:w1
  else
    GuiFont! Hack Nerd Font:h16:w1
  endif
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif
