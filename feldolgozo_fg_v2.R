library(XML)
library(data.table)
library(rio)
library(jsonlite)



feldolgozo<- function(nev){
print(nev)

doc = htmlParse(nev, encoding = "UTF-8")
node.set = getNodeSet(doc, "//table", sessionEncoding = "UTF-8")

col1 = getNodeSet(node.set[[2]], "./tbody/tr/td[1]", sessionEncoding = "UTF-8")
col2 = getNodeSet(node.set[[2]], "./tbody/tr/td[2]", sessionEncoding = "UTF-8")
col3 = getNodeSet(node.set[[2]], "./tbody/tr/td[3]", sessionEncoding = "UTF-8")

col1 <- col1[-1]
col2 <- col2[-1]
col3 <- col3[-1]

df = lapply(col1, function(node) {
  res = getChildrenStrings(node, encoding = "UTF-8")
  forras = res[1]
  varos = res[3]
  res = getChildrenStrings(getNodeSet(node, "./a", sessionEncoding = "UTF-8")[[1]], encoding = "UTF-8")
  nyertes = res[1]
  leiras = res[3]
  data.frame(forras, varos, nyertes, leiras, stringsAsFactors = F)
}


)	
df = do.call("rbind", df)


df2 = lapply(col2, function(node) {
  res = getChildrenStrings(node, encoding = "UTF-8")
  datum = res[1]
  data.frame(datum, stringsAsFactors = F)
}
)	
df_2 = do.call("rbind", df2)

df3 = lapply(col3, function(node) {
  res = getChildrenStrings(node, encoding = "UTF-8")
  osszeg = res[1]
  data.frame(osszeg, stringsAsFactors = F)
}
)	
df_3 = do.call("rbind", df3)
my_df <- cbind(df, df_2, df_3)
my_df$forras <- gsub('\n', '', my_df$forras)
my_df$varos <- gsub('\n', '', my_df$varos)
my_df$leiras <- gsub('\n', '', my_df$leiras)
my_df$nyertes <- gsub('\n', '', my_df$nyertes)
my_df$datum<- as.Date(my_df$datum, format = '%Y.%m.%d')
my_df$osszeg <- as.numeric(gsub(' ', '', my_df$osszeg))/1000000
my_df$program <- sapply(strsplit(my_df$forras, ' - '), "[", 2)
my_df$operativ_program <- sapply(strsplit(sapply(strsplit(my_df$forras,' '), "[", 1), '-'),"[", 1)
my_df$forras <- sapply(strsplit(my_df$forras, ' - '), "[", 1)

my_df <- my_df[,c(1,8,7,2:6)] 
my_df<- data.table(my_df)
return(my_df)

}

full_adat<- data.frame()

my_list <-paste('adat', paste(1:202, '.html', sep=''), sep = '/')


for (i in my_list) {
  adat<- feldolgozo(nev = i)
  full_adat<- rbind(full_adat,adat )
}



#nevek
#http://emir.nfu.hu/nyertes/index.php?node=get_select&name=op_nev&forras=1420

#település
telep_url <- 'http://emir.nfu.hu/nyertes/index.php?node=get_select&name=place&sqltype=place&tkod=&ttype=all'

telepulesek <- fromJSON(telep_url)
telepulesek <- telepulesek[,c(4,8,12,16)]

final <- merge(full_adat, telepulesek, by.x = "varos", by.y = "HELYSEG", all.x = T)
final <-final[(duplicated(final)==F),]


write.csv(final, 'data_eredmeny/szechenyi2020_adatok.csv', row.names = F)

