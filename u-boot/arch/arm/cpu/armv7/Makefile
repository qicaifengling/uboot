#
# (C) Copyright 2000-2003
# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
#
# SPDX-License-Identifier:	GPL-2.0+
#

extra-y	:= start.o

obj-y	+= cache_v7.o cache_v7_asm.o

obj-y	+= cpu.o cp15.o
obj-y	+= syslib.o

ifneq ($(CONFIG_TEGRA)$(CONFIG_ARCH_SUNXI),)
ifneq ($(CONFIG_SKIP_LOWLEVEL_INIT),y)
obj-y	+= lowlevel_init.o
endif
endif

obj-$(CONFIG_ARMV7_NONSEC)	+= nonsec_virt.o virt-v7.o virt-dt.o
obj-$(CONFIG_ARMV7_PSCI)	+= psci.o psci-common.o

obj-$(CONFIG_IPROC) += iproc-common/
obj-$(CONFIG_KONA) += kona-common/
obj-$(CONFIG_SYS_ARCH_TIMER) += arch_timer.o
obj-$(CONFIG_ARCH_SUNXI) += sunxi/
