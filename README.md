# This is only a temporary and extra ugly hack!

## This repository is totally temporary!

You should clone this repository at the same directory level as mega65-core is.
Compare with this:

    commit e6efb397cb9d77810887c66ca27d0efd9178f897 (HEAD -> px100mhz, origin/px100mhz)
    Author: Paul Gardner-Stephen <paul@servalproject.org>
    Date:   Sat Jan 27 23:29:10 2018 +1030

Say: `make`

Result is `kick.bin`, and also `kick-src.diff` for diff against the mentioned mega65-core
source files.

To test on the board: `make board`

You may need to modify settings though in Makefile.

version.a65 is 'hacked' only for having a *strong* signal, that it's not the "normal"
kickstart for now!

### TODO:

LOT. It's totally a some hour try&error thing ... Without even trying to do things the
right way. Also many warnings, ZP<->absolute addressing problems on import/export, etc
etc. TOTALLY MESS!!!!
