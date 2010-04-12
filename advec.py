

# Advection

import math













# Params
N = 4000
dx = 0.1
courant = 0.5 #dt/dx
dt = courant*dx
Nt = 5000
fout = 50

x0 = 180.
sig= 3.
A = 1.0

outfile=open('pyphi.rl','w')

#define arrays and initialize
x = []
phi = []
phi_p = []
phi_s = [] 
for i in range(N):
    x.append(i*dx)
    phi.append(A*math.exp( - ( (x[i]-x0) /sig)**2))
    phi_p.append(0.)
    phi_s.append(0.)


# write initial data
for i in range(1,N-1):
    outfile.write(str(x[i])+' '+str(phi[i])+'\n')
outfile.write('\n')


# Loop
for i in range(1,Nt+1):
    phi_p=phi
    #inner 
    for j in range(1,N-1):
        phi_s[j] = (phi_p[j+1]-phi_p[j-1])/(2.0)
        phi[j] = phi_p[j] + courant*phi_s[j]

    #boundaries Nothing Static

    # output
    if not i%fout :
        for j in range(1,N-1):
            outfile.write(str(x[j])+' '+str(phi[j])+'\n')
        outfile.write('\n')

outfile.close()
print 'Done'
