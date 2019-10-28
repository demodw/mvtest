library('MCMCglmm')

pedigreemulti<-read.table('pedigreemulti.txt',header=T)
datamulti<-read.table('datamulti.txt',header=T)

prior<- list(R=list(V=diag(2)/2,nu=2), G=list(G1=list(V=diag(2)/2,nu=2)))

modelmulti<-MCMCglmm(cbind(phen1,phen2)~trait-1,
                     random=~us(trait):animal,
                     rcov=~us(trait):units,
                     family=c("gaussian","gaussian"),
                     prior=prior,
                     pedigree=pedigreemulti,data=datamulti,nitt=100000,burnin=10000,thin=10)

corr.gen <- modelmulti$VCV[,'traitphen1:traitphen2.animal'] / sqrt(modelmulti$VCV[,'traitphen1:traitphen1.animal']*modelmulti$VCV[,'traitphen2:traitphen2.animal'])
mean(corr.gen)