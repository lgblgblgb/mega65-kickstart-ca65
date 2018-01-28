CA65		= ca65
LD65		= ld65
TARGET		= kick.bin
LABELFILE	= kick.label
MAPFILE		= kick.map
SOURCES		= kickstart_debug.a65 kickstart_freeze.a65 kickstart_process_descriptor.a65 kickstart_syspart.a65 kickstart_ultimax.a65 kickstart.a65 kickstart_dos.a65 kickstart_keyboard.a65 kickstart_mem.a65 kickstart_sdfat.a65 kickstart_task.a65 kickstart_virtual_f011.a65
LISTFILES	= $(SOURCES:.a65=.list)
INCLUDES	= kickstart.i65 kickstart_machine.a65
OBJECTS		= $(SOURCES:.a65=.o)
LD65CFG		= kickstart-ld.cfg
TARBALL		= kickstart.tar.bz2
DIFF		= kick-src.diff
CA65FLAGS	= -g
LD65FLAGS	= -Ln $(LABELFILE) -m $(MAPFILE) -vm -C $(LD65CFG) -v
BITSTREAM	= ../mega65-core/bin/nexys4ddr-on-vega.bit
MONITOR_TOOL	= ../mega65-core/src/tools/monitor_load

all:	$(TARGET) $(DIFF)

$(TARBALL): $(TARGET) $(DIFF)
	tar cfvj $@ $(SOURCES) $(LD65CFG) Makefile $(TARGET) $(MAPFILE) $(LABELFILE) version.a65 $(INCLUDES) $(DIFF)

$(DIFF): *.a65 ../mega65-core/src/*.a65
	rm -f $(DIFF)
	for a in *.a65 ; do if [ -f $$a -a -f ../mega65-core/src/$$a ]; then diff -u ../mega65-core/src/$$a $$a >> $(DIFF) || true ; fi ; done
	ls -l $(DIFF)

kickstart.o: version.a65

$(TARGET): $(OBJECTS) $(LD65CFG) Makefile
	$(LD65) $(LD65FLAGS) -o $@ $(OBJECTS)
	$(MAKE) $(DIFF)
	ls -l $(TARGET) $(DIFF)

%.o: %.a65 $(INCLUDES) Makefile
	$(CA65) $(CA65FLAGS) -l $(@:.o=.list) -o $@ $<

board:	$(TARGET)
	$(MONITOR_TOOL) -b $(BITSTREAM) -k $(TARGET)

clean:
	rm -f $(TARGET) $(OBJECTS) $(LISTFILES) $(MAPFILE) $(LABELFILE) $(TARBALL) $(DIFF)

.PHONY: clean board
