

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(REQUIRE_TOOLS)/driver.makefile

APP:=
APPDB:=$(APP)/Db
APPSRC:=$(APP)/src


USR_INCLUDES += -I$(where_am_I)$(APPSRC)

USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CFLAGS   += -Wno-unused-but-set-variable
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-but-set-variable

# TEMPLATES += $(wildcard $(APPDB)/*.db)

# DBDINC_SRCS += $(APPSRC)/swaitRecord.c
# DBDINC_SRCS += $(APPSRC)/sseqRecord.c
# DBDINC_SRCS += $(APPSRC)/aCalcoutRecord.c
# DBDINC_SRCS += $(APPSRC)/sCalcoutRecord.c
# DBDINC_SRCS += $(APPSRC)/transformRecord.c

# DBDINC_DBDS = $(subst .c,.dbd,   $(DBDINC_SRCS:$(APPSRC)/%=%))
# DBDINC_HDRS = $(subst .c,.h,     $(DBDINC_SRCS:$(APPSRC)/%=%))
# DBDINC_DEPS = $(subst .c,$(DEP), $(DBDINC_SRCS:$(APPSRC)/%=%))


# HEADERS += $(APPSRC)/fms14PortDriver.h

# HEADERS += $(APPSRC)/aCalcPostfix.h
# HEADERS += $(DBDINC_HDRS)


SOURCES += $(APPSRC)/fms14PortDriver.cpp

# SOURCES += $(APPSRC)/sCalcPerform.c
# SOURCES += $(APPSRC)/aCalcPostfix.c
# SOURCES += $(APPSRC)/aCalcPerform.c

# SOURCES += $(APPSRC)/calcUtil.c
# SOURCES += $(APPSRC)/myFreeListLib.c
# SOURCES += $(APPSRC)/devsCalcoutSoft.c
# SOURCES += $(APPSRC)/devaCalcoutSoft.c
# SOURCES += $(APPSRC)/subAve.c
# SOURCES += $(APPSRC)/swaitRecord.c
# SOURCES += $(APPSRC)/editSseq.st
# SOURCES += $(APPSRC)/interp.c
# SOURCES += $(APPSRC)/arrayTest.c
# SOURCES += $(APPSRC)/aCalcMonitorMem.c
# # DBDINC_SRCS should be last of the series of SOURCES
# SOURCES += $(DBDINC_SRCS)

DBDS += $(APPSRC)/fms14PortDriver.dbd
# DBDS += $(APPSRC)/calcSupport_withSNCSEQ.dbd
# DBDS += $(APPSRC)/calcSupport_withSSCAN.dbd


# $(DBDINC_DEPS): $(DBDINC_HDRS)

# .dbd.h:
# 	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o fms14 $<


# The following lines could be useful if one uses the external lib
#
# Examples...
# 
# USR_CFLAGS += -fPIC
# USR_CFLAGS   += -DDEBUG_PRINT
# USR_CPPFLAGS += -DDEBUG_PRINT
# USR_CPPFLAGS += -DUSE_TYPED_RSET
# USR_INCLUDES += -I/usr/include/libusb-1.0
# USR_LDFLAGS += -lusb-1.0
# USR_LDFLAGS += -L /opt/etherlab/lib
# USR_LDFLAGS += -lethercat
# USR_LDFLAGS += -Wl,-rpath=/opt/etherlab/lib
#





EPICS_BASE_HOST_BIN = $(EPICS_BASE)/bin/$(EPICS_HOST_ARCH)
MSI =  $(EPICS_BASE_HOST_BIN)/msi


USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(APPD)


FMS_TMPS=$(wildcard $(APPDB)/*.template)
FMS_SUBS=$(wildcard $(APPDB)/*.substitutions)


db:  $(FMS_SUBS) $(FMS_TMPS)

$(FMS_SUBS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

$(FMS_TMPS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@


.PHONY: db $(FMS_SUBS) $(FMS_TMPS)

