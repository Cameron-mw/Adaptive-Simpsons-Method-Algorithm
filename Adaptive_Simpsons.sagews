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

