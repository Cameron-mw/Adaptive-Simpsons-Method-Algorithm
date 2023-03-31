︠79f2e419-9dab-4c9c-b732-d3b95f7c365c︠
# def Simp(f,a,b):
#     f(x)=f
#     s=(b-a)/(6)*(f(a)+4*f((a+b)/2)+f(b))
#     return float(s)
#
# def AdaptiveSimp(f,a,b,E):
#     f(x)=f
#     p,q=var('p','q')
#     p=Simp(f,a,(a+b)/2)
#     q=Simp(f,(a+b)/2,b)
#
#     if (0.1)*abs(p+q-Simp(f,a,b)) > E:
#         return AdaptiveSimp(f,a,(a+b)/2,E/2)+AdaptiveSimp(f,(a+b)/2,b,E/2)
#
#     else:
#         return p+q
#
#
# x=var('x')
# AdaptiveSimp(3*x^2,0,6,0.025)
︡22189d75-1037-4946-b6b6-96e98e2c16b8︡{"stdout":"216.0\n"}︡{"done":true}
︠e8bc58d1-2625-4727-9eb3-0a4bf4dbf7f6s︠
def AdaptiveSimp(f,a,b,E): #Outer function where we evaluate the function midpoints and midpoints-of-midpoints
    f(x)=f
    mid=(a+b)/2
    Lmid=(a+mid)/2
    Rmid=(b+mid)/2
    fa=f(a)
    fb=f(b)
    fmid=f(mid)
    fLmid=f(Lmid)
    fRmid=f(Rmid)
    simp=(b-a)/(6)*(fa+fb+4*fmid) #Simpsons on Entire interval
    pts=[a,b,mid,Lmid,Rmid]
    fpts=[fa,fb,fmid,fLmid,fRmid]

    def Inner(f,fa,fb,fmid,fLmid,fRmid,E,a,b,mid,Lmid,Rmid,simp): #Inner function that will be recursively called
        f(x)=f
        p,q=var('p','q')
        p=(mid-a)/6*(fa+4*fLmid+fmid) #Simpsons on left subinterval
        q=(b-mid)/6*(fmid+4*fRmid+fb) #Simpsons on right subinterval

        if (1/10)*abs(p+q-simp) > E: #If the error is too large, recursively call the inner function with accordingly SHIFTED points, summing the left and right subintervals together
            #In the left subinterval
            LLmid=(a+Lmid)/2
            LRmid=(Lmid+mid)/2
            fLLmid=f(LLmid)
            fLRmid=f(LRmid)
            pts.append(LLmid)
            pts.append(LRmid)
            fpts.append(fLLmid)
            fpts.append(fLRmid)

            #In the right subinterval
            RLmid=(mid+Rmid)/2
            RRmid=(Rmid+b)/2
            fRLmid=f(RLmid)
            fRRmid=f(RRmid)
            pts.append(RLmid)
            pts.append(RRmid)
            fpts.append(fRLmid)
            fpts.append(fRRmid)

            return Inner(f,fa,fmid,fLmid,fLLmid,fLRmid,E/2,a,mid,Lmid,LLmid,LRmid,p) + Inner(f,fmid,fb,fRmid,fRLmid,fRRmid,E/2,mid,b,Rmid,RLmid,RRmid,q)

        else:
            return p+q

    approx=Inner(f,fa,fb,fmid,fLmid,fRmid,E,a,b,mid,Lmid,Rmid,simp)
    points=zip(pts,fpts)
    g=list_plot(points, color='blue',pointsize=30)
    g += plot(f(x),x,a,b,color='blue')
    show(g)

    return float(approx)

x=var('x')
AdaptiveSimp(exp(-x)*sin(5*x),0,8,0.001)
AdaptiveSimp(x^3*exp(-5*x)*cos(3*x),0,5,10^-5)
︡5f5bada4-e9e6-4dcf-8009-ac25d1d87280︡{"stderr":"Error in lines 46-46\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/usr/local/sage/src/sage/plot/plot.py\", line 3088, in list_plot\n    RDF(data[0])\nTypeError: 'zip' object is not subscriptable\n\nDuring handling of the above exception, another exception occurred:\n\nTraceback (most recent call last):\n  File \"/usr/local/sage/local/var/lib/sage/venv-python3.10.5/lib/python3.10/site-packages/smc_sagews/sage_server.py\", line 1244, in execute\n    exec(\n  File \"\", line 1, in <module>\n  File \"\", line 41, in AdaptiveSimp\n  File \"/usr/local/sage/src/sage/misc/decorators.py\", line 491, in wrapper\n    return func(*args, **options)\n  File \"/usr/local/sage/src/sage/plot/plot.py\", line 3098, in list_plot\n    if data[0] in sage.symbolic.ring.SR:\nTypeError: 'zip' object is not subscriptable\n"}︡{"done":true}
︠7ea51483-0c66-41cc-9e93-c06c5ba77a91︠









