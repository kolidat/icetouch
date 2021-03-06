# **********************************************************************
#
# Copyright (c) 2003-2014 ZeroC, Inc. All rights reserved.
#
# This copy of Ice is licensed to you under the terms described in the
# ICE_LICENSE file included in this distribution.
#
# **********************************************************************

top_srcdir	= ../../..

CLIENT		= $(call mktestname,client)
SERVER		= $(call mktestname,server)
SERVERAMD	= $(call mktestname,serveramd)
COLLOCATED	= $(call mktestname,collocated)

TARGETS		= $(CLIENT) $(SERVER) $(SERVERAMD) $(COLLOCATED)

COBJS		= Test.o \
		  Client.o \
		  AllTests.o

SOBJS		= Test.o \
		  TestI.o \
		  Server.o

SAMDOBJS	= TestAMD.o \
		  TestAMDI.o \
		  ServerAMD.o

COLOBJS		= Test.o \
		  TestI.o \
		  Collocated.o \
		  AllTests.o

SRCS		= $(COBJS:.o=.cpp) \
		  $(SOBJS:.o=.cpp) \
		  $(SAMDOBJS:.o=.cpp) \
		  $(COLOBJS:.o=.cpp)

SLICE_SRCS	= Test.ice TestAMD.ice


#
# the long allTests function crashes when built with Sun CC 5.9 on x86 with -O,
# inlining and -KPIC; work-around: we disable PIC
#
GENPIC          = no


include $(top_srcdir)/config/Make.rules

CPPFLAGS	:= -I. -I../../include $(CPPFLAGS)

$(CLIENT): $(COBJS)
	rm -f $@
	$(call mktest,$@,$(COBJS),$(LIBS))

$(SERVER): $(SOBJS)
	rm -f $@
	$(call mktest,$@,$(SOBJS),$(LIBS))

$(SERVERAMD): $(SAMDOBJS)
	rm -f $@
	$(call mktest,$@,$(SAMDOBJS),$(LIBS))

$(COLLOCATED): $(COLOBJS)
	rm -f $@
	$(call mktest,$@,$(COLOBJS),$(LIBS))

include .depend
