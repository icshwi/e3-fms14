

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(REQUIRE_TOOLS)/driver.makefile

APP:=

APPSRC:=$(APP)/src
APPDB:=$(APP)/Db

USR_INCLUDES += -I$(where_am_I)$(APPSRC)

USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CFLAGS   += -Wno-unused-but-set-variable
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-but-set-variable


SOURCES += $(APPSRC)/fms14PortDriver.cpp


DBDS += $(APPSRC)/fms14PortDriver.dbd

TEMPLATES += $(APPDB)/fms14_fmc.template
TEMPLATES += $(APPDB)/fms14_sfp.template
TEMPLATES += $(APPDB)/fms14_simfmc.template
TEMPLATES += $(APPDB)/fms14_simsfp.template


# EPICS_BASE_HOST_BIN = $(EPICS_BASE)/bin/$(EPICS_HOST_ARCH)
# MSI =  $(EPICS_BASE_HOST_BIN)/msi


# USR_DBFLAGS += -I . -I ..
# USR_DBFLAGS += -I $(EPICS_BASE)/db
# USR_DBFLAGS += -I $(APPD)


#FMS_TMPS=$(wildcard $(APPDB)/*.template)
# FMS_SUBS=$(wildcard $(APPDB)/*.substitutions)



# db:  $(FMS_SUBS) $(FMS_TMPS)

# $(FMS_SUBS):
# 	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
# 	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
# 	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
# 	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

# $(FMS_TMPS):
# 	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
# 	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
# 	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
# 	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@


# .PHONY: db $(FMS_SUBS) $(FMS_TMPS)

