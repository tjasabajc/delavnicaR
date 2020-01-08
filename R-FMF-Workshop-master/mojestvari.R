# komentar
n <- 20
is_same <- n == n
# != ni enako, < > <= >=
datum <- Sys.Date()
datum
some_date <- as.Date("2020-01-01", format = "%Y-%m-%d")
some_date
student_name <- "Nejc"
paste(student_name, "je star", n, "let.")

student_ages <- c(20,23,21) #vektor stevil
student_names <- c("Luke","Jan","Mike")
passed <- c(TRUE, TRUE, FALSE)

student_ages[2] # zacne se z 1
student_ages[c(1,3)] # vrne 1. in 3. element
student_ages[c(3,1)] # vrne 3. in 1. element
#dodas element
c(student_ages,22) # dodas 22 na konec, lahko tudi:
c(student_ages, student_ages)
length(student_ages)

## Racunanje z vektorji

a <- c(1,3,5)
b <- c(2,2,1)
d <- c(6,7)
# operacije so po elementih
a + b
a + d
# tule je R podaljsal d ciklicno tolikokrat, da so se dolzine ujemale,
# torej je a + (6,7,6).
a + 5
# podaljsa 2 do dolzine a-ja
a %*% b
#skalarni produkt

a < b
# vrne vektor truefalse po komponentah

## Dostop do elementov vektorja
a[1]
a[c(1,1,2,1,3)]
a[c(TRUE,TRUE,FALSE)]
a[passed]
# elementi a, vecji od 2
a[a>=2]

a <- c(2,5,4,0,9,11,4,6)
# ce imamo dva kriterija
(a < 3 ) | (a > 8)
(a > 3 ) & (a < 8)
a[(a > 3 ) & (a < 8)]

# FAKTORJI - imajo vnaprej doloceno nekaj
car_brand <- factor(c("Audi","BMW","Mercedes", "Audi"),
                    ordered = FALSE)
car_brand
# Levels so tisti, ki so mozni
car_brand[5] <- "Renault"
# Ne gre
car_brand
car_brand[6] <- "Audi"
car_brand

freq <- factor(x = NA, # na zacetku prazen
               levels = c("never","rarely","sometimes","always"),
               ordered = T)
freq
freq[1:3] <- c("rarely", "never","always")
freq


## MATRIKE

matrika <- matrix(c(1,2,1,
                    5,4,2),
                  nrow = 2,
                  byrow = TRUE) # da se polni po vrsticah
matrika
B <- matrix(c(1,3,
              2,3),
            nrow = 2)
B
matrika[2,]
matrika[2,3]
matrika[c(2,1),2]
matrika
B + 1
B
dim(matrika)
t(matrika)
#transponira
diag(B)
diag(matrika)
# vzame diagonalo iz najvecje kvadratne matrike, ki jo najde

# diagonalna matrika
D <- diag(c(3,10,800))
D
B
t(matrika) %*% B
B %*% B # matricno
B * B # komponentno

## RAZPREDELNICE 
# V matrikah je vse istega tipa, v razpredelnicah pa ne
studenti <- data.frame("Kdo" = student_names, 
                       "Starost" = student_ages, 
                       "Opravil" = passed,
                       stringsAsFactors = F)
                        # To je zato, da lahko recimo dodamo ime,
                        # ki ga se ni v imenih
studenti
#dostop do elementov kot v matrikah
studenti[1,]
studenti[,2]
studenti["Starost"]
manjsa_razpredelnica <- studenti[c("Kdo","Starost")]
manjsa_razpredelnica
#Kdo je opravil
studenti[studenti[,"Opravil"],]
studenti$"Starost" # je isto kot studenti["Starost"]
studenti[studenti$Opravil,]

## SEZNAMI
# elementi so alhko  razliènih tipov
sez <- list("studenti_razpredelnica" = studenti,
            "x" = 2,
            "imena" = student_names)
sez
# za dostop do elementov uporabljamo dvojne [[]]
sez [[3]]
sez[[4]] <- "Tjasa mi je ime"
sez

## BRANJE PODATKOV

# dve funkciji:
#   read.csv ---> locilo je vejica, decimalke imajo piko AMERISKO
#   read.csv2 --> locilo je podpicje, decimalke imajo vejico MI CARJI

?read.csv2
# odpre pomoc
zavarovalnica <- read.csv(file = "./data/insurance01.csv")
head(zavarovalnica)

zav <- read.csv2(file = "./data/insurance02.csv")
head(zav)

# RDS
shrani <- list("podatki" = zav,
               "stud" = studenti)
saveRDS(shrani, "./moji_shranjeni.rds")
nalozi <- readRDS("./moji_shranjeni.rds")
nalozi
nalozi[[2]]


## IF

x <- 5
if (x < 0) {
  print ("majhen x imas")
} else if (x == 0) {
  print("Nic nimas!")
} else {
  print (paste("Uf, kaksen x!!!",x))
}

## ZANKE

# for

vsota <- 0
1:15
-2:8
for (i in 1:10) {
  vsota <- vsota + i
}
stevila <- c(9,0,-3,5)
for (i in stevila) {
  vsota <- vsota + i
}
vsota

## FUNKCIJE

sum(1:10)
prod(stevila[c(1,4)])
dd<- rep(c(1,11), times = 4)
dd
seq(-2,3,by = 0.2)
summary(studenti)

## PISANJE FUNKCIJ
sestej_n <- function (n) { #ime <- function (n,m,k,seznam) { telo funkcije }
  vsota <- 0
  for (i in 1:n) {
    vsota <- vsota + i
  }
  return (vsota)
}
sestej_n(3)

# za nakljucna stevila
# set.seed(1) #potem bodo od tu naprej vedno ista nakljucna stevila,
# da lahko ponavljas eksperimente

#gostota, kumilativna, kvantili, vzorcenje
x <- rnorm(n = 100, mean = 0, sd = 4)
x
plot(density(x))

## OBDELAVA PODATKOV
head(zav)
x <- c(5,3,4,2,1)
order(x)
x[order(x)]
urejeni <- zav[order(zav$age,
                     zav$charges),]
head(urejeni)
# zelimo dodat claim/st.oseb (ce ima otroke...)
novarazpredelnica <- urejeni
novarazpredelnica$na_osebo <- zav$charges / (1+ zav$children)
head(novarazpredelnica)
df1 <- novarazpredelnica[,c("age","sex")]
df2 <- novarazpredelnica[,c("charges","smoker")]
zdruzen <- cbind(df1,df2) # zdruzi po stolpcih
head(zdruzen)

mean(zav$charges)
pokriteriju <- aggregate(zav$charges,
                          by = list(zav$smoker,
                                    zav$region),
                          FUN = mean)
pokriteriju

## VIZUALIZACIJA

# WIDE cloveku prijazno
# datum | 00:00 | 01:00 | 02:00 | ...
# 1.1.20|   30  |   20  |  38   | ...
# 2.1.20|   15  |   25  |  19   | ...
# ...

# LONG
# datum |  ura  | vrednost
# 1.1.20| 00:00 |    30
# 1.1.20| 01:00 |    20
# 1.1.20| 02:00 |    38

library(tidyr)
delnice <- readRDS("./data/stocks.rds")
head(delnice)

long_df <- gather(delnice, key = "stock",
                  value = "value",
                  - time) #vse stolpce razen casa
head(long_df)
wide_df <- spread(long_df, key = "stock",
                  value = "value")
head(wide_df)
# dobili smo to, s cimer smo zaceli

## RISANJE
# 1. data v LONG formatu
# 2. aes(thetics) ... kaj je x, kaj je y, ali naj barva
# 3. geom(etries) ... pike, crte, gostota, histogram
# ***** glavne *****
# 4. facets ... vska stvar na svojem grafu
# 5. statistics ... recimo na razsevni diagram narises premico
# ***** se uporabno *****
# 6. coordinates
# 7. themes ... barve, pisava

library(ggplot2)
df_dax <- long_df[long_df$stock == "X.DAX",]
ggplot(data = df_dax, mapping = aes(x = time, y = value)) +
       geom_line() + geom_point() +
  coord_cartesian(ylim = c(0,6500))
# vse na istem, razlicne barve
#ggplot(long_df, mapping = aes(x=time,
 #                             y= value,
  #                            color = stock)) +
#  geom_line() +
 # coord_cartesian(ylim = c(0,8100)) +
  #theme_bw()

# razl grafi
ggplot(long_df, mapping = aes(x=time,
                             y= value)) +
  geom_line() +
 coord_cartesian(ylim = c(0,8100)) +
theme_bw() + 
  facet_wrap(~ stock, scales = "free")

# scatterplot
filmi <- read.csv2(("./data/movies.csv"))
head(filmi)
ggplot(filmi, aes(x = budget, y = rating)) + # sam izloci NA
  geom_point(alpha = 0.2) + # prosojnost tock, da vidimo, kje je vecja gneca
  coord_cartesian(ylim = c(0,10)) + 
  ggtitle("Ocene filmov glede na proracun filma") +
  geom_smooth(method = "lm") # vrne glajeno krivuljo, dolocimo stopnjo
