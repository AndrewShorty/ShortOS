local a,b,c,d,e,f,g,h,i,j,k,l,m,n="MineOS EFI","Internet boot","Change label","key_down","/init.lua","filesystem",component.proxy,component.list,computer.pullSignal,computer.uptime,table.insert,math.max,math.min,math.huge;local o,p,q,r,s,t,u,v=1,0,1,1,0,g(h("eeprom")()),g(h("gpu")()),h("internet")()u.bind(h("screen")(),true)local w,x,y,z,A,B,C,D,E,F,G=computer.shutdown,u.set,u.fill,t.setData,t.getData,u.getDepth(),u.getResolution()computer.getBootAddress,computer.setBootAddress=A,z;if B==4 then o,p,q,r,s=0x333333,0xFFFFFF,0x333333,0x333333,0xFFFFFF elseif B==8 then o,p,q,r,s=0x2D2D2D,0xE1E1E1,0x878787,0x878787,0xE1E1E1 end;local H,I,J,K=function(L)if L~=E then u.setBackground(L)E=L end end,function(L)if L~=F then u.setForeground(L)F=L end end,function(M)return math.floor(M+0.5)end,function(N,O,P)if#N<O then N=N..string.rep(" ",O-#N)else N=N:sub(1,O)end;return N..(P and""or"  ")end;local Q,R,S=function(T,U,V,W,L)H(L)y(T,U,V,W," ")end,function(U,X,N)local T=J(C/2-#N/2)I(X)x(T,U,N)end,function(N,Y,Z)return{s=N,c=Y,b=Z}end;local function _(U,a0,a1,a2)U=U or J(D/2-1)Q(1,1,C,D,p)R(U,o,a0)R(U+2,q,a1 or"")if a2 then repeat local a3=i()until a3==d or a3=="touch"end;return U end;local a4,a5,a6,a7,a8=function(a9)_(G,a,"Booting from "..a9.address)local aa,ab,ac,ad,ae="","",a9.open(e,"r")while ab do aa,ab=aa..ab,a9.read(ac,n)end;a9.close(ac)ad,ae=load(aa)if ad then ad,ae=pcall(ad)if ad then return end end;_(G,a,"Failed to run init file: "..ae,1)end,function()return S("Back",G,1)end,function(a0,af)local ag,ah,ai=2,1,0;for aj=1,#af do ai=math.max(ai,#af[aj].s)end;while 1 do local U,T,ak=_(J(D/2-(#af+2)/2),a0)+2;for aj=1,#af do T=J(C/2-#af[aj].s/2)if aj==ah then Q(J(C/2-ai/2)-2,U,ai+4,1,r)I(s)x(T,U,af[aj].s)else H(p)I(q)x(T,U,af[aj].s)end;U=U+1 end;ak={i()}if ak[1]==d then if ak[4]==200 and ah>1 then ah=ah-1 elseif ak[4]==208 and ah<#af then ah=ah+1 elseif ak[4]==28 then if af[ah].c then af[ah].c()end;if af[ah].b then return end end end end end,function(U,al)local N,am,an,ak,ao="",true;while 1 do an=al..N;y(1,U,C,1," ")x(J(C/2-#an/2),U,an..(am and"█"or""))ak={i(0.5)}if ak[1]==d then if ak[4]==28 then return N elseif ak[4]==14 then N=N:sub(1,-2)else ao=unicode.char(ak[3])if ao:match("^[%w%d%p%s]+")then N=N..ao end end;am=true elseif ak[1]=="clipboard"then N=N..ak[3]elseif not ak[1]then am=not am end end end,function(ap)local aq,aa,ac,ar,ae=function(N)_(G,b,"Internet boot failed: "..N,1)end,"",g(v).request(ap)if ac then _(G,b,"Downloading script...")while 1 do ar,ae=ac.read(n)if ar then aa=aa..ar else ac:close()if ae then aq(ae)else ar,ae=load(aa)if ar then z("#"..ap)ar,ae=pcall(ar)if ar then return else aq(ae)end else aq(ae)end end;break end end else aq("invalid URL-address")end end;_(G,a,"Hold Alt to show boot options menu")local as,ak=j()+1;while j()<as do ak={i(as-j())}if ak[1]==d and ak[4]==56 then local at={S("Disk management",function()local au,av={a5()},A()for aw in h(f)do local a9=g(aw)local ax,ay=a9.getLabel()or"Unnamed",a9.isReadOnly()k(au,1,S((aw==av and"> "or"  ")..K(ax,10)..K(a9.spaceTotal()>1048576 and"HDD"or a9.spaceTotal()>65536 and"FDD"or"SYS",3)..K(ay and"R"or"R/W",3)..aw:sub(1,8).."  "..K(string.format("%.2f",a9.spaceUsed()/a9.spaceTotal()*100).."%",6,1),function()local az={a5()}if not ay then k(az,1,S(c,function()a9.setLabel(a7(_(G,c)+2,"Enter new name: "))end,1))k(az,2,S("Format",function()_(G,a,"Formatting filesystem "..aw)for aA,aB in ipairs(a9.list("/"))do a9.remove(aB)end;_(G,a,"Formatting finished",1)end,1))end;if a9.exists(e)then k(az,1,S("Set as startup",function()z(aw)end,1))end;a6(ax.." ("..aw..")",az)end,1))end;a6("Select filesystem to show options",au)end),S("Shutdown",function()w()end),a5()}if v then k(at,2,S(b,function()a8(a7(_(G,b)+2,"Enter URL: "))end))end;a6(a,at)end end;local aa,a9=A()if aa:sub(1,1)=="#"then a8(aa:sub(2,-1))else a9=g(aa)if a9 and a9.exists(e)then a4(a9)else for aw in h(f)do a9=g(aw)if a9.exists(e)then z(aw)a4(a9)break else a9=nil end end;if not a9 then _(G,a,"No bootable mediums found",1)end end end;w()