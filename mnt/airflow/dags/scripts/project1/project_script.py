#import pandas
from mpmath import mp
import argh

print("import test okay")
pii = str(mp.pi)

with open('pi.txt', 'w') as f:
    f.write(pii[:100])