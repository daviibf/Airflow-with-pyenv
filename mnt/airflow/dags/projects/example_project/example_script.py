from mpmath import mp
import sys
import argh

if sys.version_info.minor == 6:
    print("Correrct Python Version: \n"+sys.version)
    print("\n Task succeeded!")
    pii = str(mp.pi)
    print("Pi Value: "+pii)
    
else :
    raise Exception("Wrong Python Version: \n"+sys.version) 