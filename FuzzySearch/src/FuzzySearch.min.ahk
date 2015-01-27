FuzzySearch(a,b){
if(!IsObject(a)||b=="")
return 0
c:=[]
for d,e in StrSplit(b)
f.=(f?".*?":"")"(" e ")"
for d,g in a{
if(RegExMatch(g,"Oi)"f,h)){
i:={"string":g,"tokens":[],"weight":Round((h.Count()/StrLen(g))*100)}
loop % h.Count(){
j:=h.Pos(A_Index),k:=(A_Index==1?f:SubStr(k,7)),l:={"m":"","n":0,"o":0}
while(RegExMatch(g,"Oi)"k,p,j)){
q:=p.Pos(1)==1?50:RegExMatch(SubStr(g,p.Pos(1)-1,2),"i)(\b|(?<=_))"p[1])?25:RegExMatch(SubStr(g,p.Pos(1),1),"\p{Lu}")?10:01
if(q>l.o)
l.m:=p[1],l.o:=q,l.n:=p.Pos(1)
j:=p.Pos(1)+1
}i.tokens.Insert(l.n,l.m),i.weight+=l.o
}c.Insert(i)
}}return c
}