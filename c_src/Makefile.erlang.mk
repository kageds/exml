ERL_CFLAGS ?= -finline-functions -Wall -fPIC -I "/usr/local/otp-24/erts-12.3.2.17/include" -I "/usr/local/otp-24/lib/erl_interface-5.2.2.1/include"
ERL_LDFLAGS ?= -L "/usr/local/otp-24/lib/erl_interface-5.2.2.1/lib" -lei


all:: priv/exml_event.so

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.C
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.cc
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

priv/exml_event.so: CFLAGS +=  -g -Wall
priv/exml_event.so: LDFLAGS +=  -fPIC -lexpat
priv/exml_event.so: $(foreach ext,.c .C .cc .cpp,$(patsubst %$(ext),%.o,$(filter %$(ext),$(wildcard c_src/exml_utils.c c_src/exml_event.c))))
	$(CC) -o $@ $? $(LDFLAGS) $(ERL_LDFLAGS) $(DRV_LDFLAGS) $(EXE_LDFLAGS) -shared


all:: priv/exml_escape.so

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.C
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.cc
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

priv/exml_escape.so: CFLAGS +=  -g -Wall
priv/exml_escape.so: LDFLAGS +=  -fPIC
priv/exml_escape.so: $(foreach ext,.c .C .cc .cpp,$(patsubst %$(ext),%.o,$(filter %$(ext),$(wildcard c_src/exml_utils.c c_src/exml_escape.c))))
	$(CC) -o $@ $? $(LDFLAGS) $(ERL_LDFLAGS) $(DRV_LDFLAGS) $(EXE_LDFLAGS) -shared
