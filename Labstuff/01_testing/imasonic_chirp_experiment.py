import pyvisa as visa
import time

# import misc stuff for picoscope
import ctypes
from picosdk.ps3000a import ps3000a as ps
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import interactive
interactive(True)
from picosdk.functions import adc2mV, assert_pico_ok
import scipy.io
import scipy.signal

#import oct2py   # needed for processing

#oc = oct2py.Oct2Py()
fh=10   # MHz high cut off
fl=1    # MHz low cut off
[b,a]=scipy.signal.butter(4,[2*fl/125,2*fh/125],btype='bandpass') # bandpass filter Fs/2=125MHz

# --------------------------------------------------------------------------------------------------------
# use AGILENT 33220A generator's AWG functionality to generate various excitation pulses
# use pico3204 oscilloscope to measure resulting waveforms
#  
# ---------------------------------------------------------------------------------------------------------

#rm = visa.ResourceManager('C:\\Program Files\\IVI Foundation\\VISA\\WinNT\\agvisa\\agbin\\visa32.dll')
rm = visa.ResourceManager('C:\\Program Files\\IVI Foundation\\VISA\\Win64\\agvisa\\agbin\\visa32.dll')
#USB Connection: USB0::xxxxxx::xxxxxx::xxxxxxxxxx::0::INSTR
myinst = rm.open_resource('USB0::0x0957::0x0407::MY44022245::0::INSTR')
myinst.timeout =  5000
myinst.write("*CLS")     
myinst.write("*IDN?")     #*IDN? - Query Instrumnet ID  
print (myinst.read())
myinst.write("*RST")    # do a generator RESET 

# --------------------------------------------------------------------------------------------
# initialize pico3204
#
# -------------------------------------------------------------------------------------------------------------------
# misc config for picoscope
# Create chandle and status ready for use
status = {}
chandle = ctypes.c_int16()

# Opens the device/s
status["openunit"] = ps.ps3000aOpenUnit(ctypes.byref(chandle), None)

try:
    assert_pico_ok(status["openunit"])
except:

    # powerstate becomes the status number of openunit
    powerstate = status["openunit"]

    # If powerstate is the same as 282 then it will run this if statement
    if powerstate == 282:
        # Changes the power input to "PICO_POWER_SUPPLY_NOT_CONNECTED"
        status["ChangePowerSource"] = ps.ps3000aChangePowerSource(chandle, 282)
        # If the powerstate is the same as 286 then it will run this if statement
    elif powerstate == 286:
        # Changes the power input to "PICO_USB3_0_DEVICE_NON_USB3_0_PORT"
        status["ChangePowerSource"] = ps.ps3000aChangePowerSource(chandle, 286)
    else:
        raise

    assert_pico_ok(status["ChangePowerSource"])

# Set up channel A
# handle = chandle
# channel = PS3000A_CHANNEL_A = 0
# enabled = 1
# coupling type = PS3000A_DC = 1
# range = PS3000A_10V = 8
# analogue offset = 0 V
#chARange = 6    # 6 tilsvarer +-2v range
chARange = 7    # 6 tilsvarer +-5v range (?)
chARange = 8    # 6 tilsvarer +-10v range (?)
chARange = 2    #  tilsvarer +-50mV range
#chARange = 3    # 5 tilsvarer +-100mv range (??)
status["setChA"] = ps.ps3000aSetChannel(chandle, 0, 1, 1, chARange, 0)
assert_pico_ok(status["setChA"])

# Sets up single trigger
# Handle = Chandle
# Source = ps3000A_channel_B = 0
# Enable = 0
# Threshold = 1024 ADC counts
# Direction = ps3000A_Falling = 3
# Delay = 0
# autoTrigger_ms = 1000


# obs, satt opp for å trigge på kanal B (source = 1), autotrigger_ms =0, direction er satt til 2 (rising))
status["trigger"] = ps.ps3000aSetSimpleTrigger(chandle, 1, 1, 1024, 2, 0, 0)
assert_pico_ok(status["trigger"])

# Setting the number of sample to be collected
preTriggerSamples = 250 # 5000
postTriggerSamples = 12000 # 45000
maxsamples = preTriggerSamples + postTriggerSamples

# Gets timebase innfomation
# Handle = chandle
# Timebase = 2 = timebase
# Nosample = maxsamples
# TimeIntervalNanoseconds = ctypes.byref(timeIntervalns)
# MaxSamples = ctypes.byref(returnedMaxSamples)
# Segement index = 0
timebase = 2
timeIntervalns = ctypes.c_float()
returnedMaxSamples = ctypes.c_int16()
status["GetTimebase"] = ps.ps3000aGetTimebase2(chandle, timebase, maxsamples, ctypes.byref(timeIntervalns), 1, ctypes.byref(returnedMaxSamples), 0)
assert_pico_ok(status["GetTimebase"])


# Creates a overlow location for data
overflow = ctypes.c_int16()
# Creates converted types maxsamples
cmaxSamples = ctypes.c_int32(maxsamples)

# Starts the block capture
# Handle = chandle
# Number of prTriggerSamples
# Number of postTriggerSamples
# Timebase = 2 = 4ns (see Programmer's guide for more information on timebases)
# time indisposed ms = None (This is not needed within the example)
# Segment index = 0
# LpRead = None
# pParameter = None
status["runblock"] = ps.ps3000aRunBlock(chandle, preTriggerSamples, postTriggerSamples, timebase, 1, None, 0, None, None)
assert_pico_ok(status["runblock"])

# Create buffers ready for assigning pointers for data collection
bufferAMax = (ctypes.c_int16 * maxsamples)()
bufferAMin = (ctypes.c_int16 * maxsamples)() # used for downsampling which isn't in the scope of this example

# Setting the data buffer location for data collection from channel A
# Handle = Chandle
# source = ps3000A_channel_A = 0
# Buffer max = ctypes.byref(bufferAMax)
# Buffer min = ctypes.byref(bufferAMin)
# Buffer length = maxsamples
# Segment index = 0
# Ratio mode = ps3000A_Ratio_Mode_None = 0
status["SetDataBuffers"] = ps.ps3000aSetDataBuffers(chandle, 0, ctypes.byref(bufferAMax), ctypes.byref(bufferAMin), maxsamples, 0, 0)
assert_pico_ok(status["SetDataBuffers"])

# Creates a overlow location for data
overflow = (ctypes.c_int16 * 10)()
# Creates converted types maxsamples
cmaxSamples = ctypes.c_int32(maxsamples)

# Checks data collection to finish the capture
ready = ctypes.c_int16(0)
check = ctypes.c_int16(0)
while ready.value == check.value:
    status["isReady"] = ps.ps3000aIsReady(chandle, ctypes.byref(ready))

status["GetValues"] = ps.ps3000aGetValues(chandle, 0, ctypes.byref(cmaxSamples), 0, 0, 0, ctypes.byref(overflow))
assert_pico_ok(status["GetValues"])

# Finds the max ADC count
# Handle = chandle
# Value = ctype.byref(maxADC)
maxADC = ctypes.c_int16()
status["maximumValue"] = ps.ps3000aMaximumValue(chandle, ctypes.byref(maxADC))
assert_pico_ok(status["maximumValue"])



def readscope(stack):
    mybuf=np.zeros((1,12250),dtype=float)
    # midle stack ganger
    for cntr in range (0,stack,1):
        # Starts the block capture
        status["runblock"] = ps.ps3000aRunBlock(chandle, preTriggerSamples, postTriggerSamples, timebase, 1, None, 0, None, None)
        assert_pico_ok(status["runblock"])
        # Checks data collection to finish the capture
        ready = ctypes.c_int16(0)
        check = ctypes.c_int16(0)
        while ready.value == check.value:
            status["isReady"] = ps.ps3000aIsReady(chandle, ctypes.byref(ready))
        status["GetValues"] = ps.ps3000aGetValues(chandle, 0, ctypes.byref(cmaxSamples), 0, 0, 0, ctypes.byref(overflow))
        assert_pico_ok(status["GetValues"])
        #print('accumulating from scope %04d of 100' % cntr)
        mybuf += np.array(bufferAMax)
    return mybuf


#time.sleep(5)

def linchirp(volt,cyc_cnt):
    # erfaring fra litt prøving og feiling med generatoren, målt med skop:
    # følgende combo ser ok ut:
    # Sett Frequency til 10000
    # overfør 25000 samples til buffer
    # påtrykt firkantsignal med 10 samples høy, og 10 samples lav gir da en resulterende frekvens på ca 12.46 MHz, eller altså sample intervall ca 4ns.
    # i følge manualen er det 50MHz rate på DA converter, altså 20ns sample intervall. så det må være noe matematikk involvert imellom her. 
    # 2MHz er 0.5us periode altså 500/4=125  4ns counts pr periode
    # 8MHz er 0.125us periode, altså 125/4= 31.25 4ns counts per periode
    # linchirp fra ca 2 til 8 MHz, anta delta_t=4ns, altså sweep med signalperiode fra 125 til 31 x delta T
    my_wfm='DATA VOLATILE'
    half_periode=63
    #cyc_cnt=18
    delta_t= (125.0-30.0)/(4.0*cyc_cnt)
    #print('start freq: %4.2f' %  (1000.0/(4*half_periode*2)))
    count=0
    chirpref=[]
    for cycles in range (0,cyc_cnt,1):
        for cntr in range(0,round(half_periode),1):
            my_wfm += ',1'
            chirpref.append(1) 
            count +=1
        half_periode -=delta_t
        for cntr in range(0,round(half_periode),1):
            my_wfm += ',-1'
            chirpref.append(-1) 
            count +=1
        half_periode -=delta_t    
        #print('periode:%f frekvens:%f' % (half_periode*2,1000/(half_periode*2*4)))
        #print('half periode:%f' % (half_periode))
        #print('cycle %d' % cycles)
    #print('stop freq: %4.2f' %  (1000.0/(4*half_periode*2)))        
    nosamples=25000-count
    for cntr in range(0,nosamples,1):
        my_wfm += ',0'
    #myinst.write("*RST")
    myinst.write(my_wfm)
    myinst.write("Function:User Volatile")          # ‘ Select the active arb waveform 
    myinst.write("Function:Shape User")         # ‘ Output selected arb waveform
    myinst.write("Output:Load 50")              #‘ Output termination is 50 ohms
    #myinst.write("Frequency 10000; Voltage 5")   # ‘ Ouput frequency is 5 kHz @ 5 Vpp
    ape='Frequency 10000; Voltage %4.1f' % volt
    myinst.write(ape)   # ‘ Ouput frequency is 5 kHz @ 5 Vpp
    myinst.write("OUTPut ON")                   # ‘ Enable output
    print ('Chirp created')
    print(ape)
    return chirpref


def burst_n(freq,n,volt):      
    my_wfm='DATA VOLATILE'
    periode= 1000.0/freq/4.    # regn ut periode pr cycles i antall 4ns counts 
    half_periode=periode/2.
    count=0
    for cycles in range (0,n,1):
        for cntr in range(0,round(half_periode),1):
            my_wfm += ',1'
            count +=1
        for cntr in range(0,round(half_periode),1):
            my_wfm += ',-1'
            count +=1    
    #print('periode:%f frekvens:%f' % (half_periode*2,1000/(half_periode*2*4)))    
    nosamples=25000-count
    for cntr in range(0,nosamples,1):
        my_wfm += ',0'
    myinst.write(my_wfm)
    myinst.write("Function:User Volatile")          # ‘ Select the active arb waveform 
    myinst.write("Function:Shape User")         # ‘ Output selected arb waveform
    myinst.write("Output:Load 50")              #‘ Output termination is 50 ohms
    ape='Frequency 10000; Voltage %4.1f' % volt
    myinst.write(ape)
    #myinst.write("Frequency 10000; Voltage 5")   # ‘ Ouput frequency is 5 kHz @ 5 Vpp
    myinst.write("OUTPut ON")                   # ‘ Enable output
    print('Frekvens:%f MHz cycles:%d amplitude:%4.1f' % (freq,n,volt))

bufferm=np.zeros((10,3,12250),dtype=float)
for v in range (1,11,1):
    vv=v/4.
    chirpref18=linchirp(vv,18)
    time.sleep(2)
    print('reading scope chirp 18')
    ape = readscope(100)
    #signl=ape[0,4901:17000] # extract for processing
    signl=ape[0,:] # extract for processing
    bufferm[v-1,0,:]=ape[0,:]
    plt.figure(1)
    plt.plot(signl)
    plt.title('chirp')
    plt.show()
    plt.pause(1)
    plt.clf()

    chirpref9=linchirp(vv,9)
    time.sleep(2)
    print('reading scope chirp 9')
    ape = readscope(100)
    #signl=ape[0,4901:17000] # extract for processing
    signl=ape[0,:] # extract for processing
    bufferm[v-1,1,:]=ape[0,:]
    plt.figure(1)
    plt.plot(signl)
    plt.title('chirp')
    plt.show()
    plt.pause(1)
    plt.clf()

    burst_n(5,1,vv)
    time.sleep(2)
    print('reading scope burst')
    ape = readscope(100)
    #signl=ape[0,4901:17000] # extract for processing
    signlbrst=ape[0,:] # extract for processing
    bufferm[v-1,2,:]=ape[0,:]
    plt.figure(1)
    plt.plot(signlbrst)
    plt.title('burst')
    plt.show()
    plt.pause(1)
    plt.clf()


#dumpfile='imasonic_lin_chirp2-8MHz.mat'
dumpfile='imasonic_ampl_chirp_burst_cladding1.mat'
print('dumping rawdata to mat file')
doc='imasonic_volt_chirp_burst volt (1-10)/4, chirp, and burst'
scipy.io.savemat(dumpfile, mdict={'a': bufferm,'t_sample': np.array(8),'ReadMe': doc,'chirpref9': chirpref9,'chirpref18': chirpref18})


myinst.close()  # close AGILENT generator

