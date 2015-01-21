FuzzySearch(a,b){
StringLower b,b
c:=StrSplit(b),d:=[]
for i,j in a{
e:=f:=1,g:=[],h:=0
if(SubStr(j,1,1)=c[1])
h-=50
for k,l in StrSplit(j,[" ","_","-"]){
if(SubStr(l,1,1)=c[e]){
h-=10,f:=(InStr(j, l)),g.Insert({"index":f,"token":c[e]})
if(RegExMatch(l,"O)\w[a-z0-9]+([A-Z])",m)&&m[1]=c[e+1]){
h-=5,f+=(InStr(l,m[1],true)-1),e+=1,g.Insert({"index":(f-1),"token":c[e]})
}e++
if(e>NumGet(&c+4*A_PtrSize)){
d.Insert(h,{"match":a[i],"matchedTokens":g})
break
}}}StringLower j,j
while((f-1)<StrLen(j)){
n:=StrSplit(j)[f]
if(n==c[e]){
h--,g.Insert({"index":f,"token":n}),e++
if(e>NumGet(&c+4*A_PtrSize)){
d.Insert(h,{"match":a[i],"matchedTokens":g})
break
}}f++
}}return d
}