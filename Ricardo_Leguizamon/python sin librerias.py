import pandas as pnd
#import matplotlib.pyplot as plt
#import math
csv = pnd.read_csv('total_cases.csv',error_bad_lines=False)
dates = csv.pop("date")
csv.pop("World")
csv.pop("Europe")
csv.pop("Asia")
csv.pop("Africa")
csv.pop("North America")
csv.pop("European Union")
csv.pop("South America")
csv.pop("Oceania")
csv.pop("International")
localidadesCSV = pnd.read_csv("locations.csv",error_bad_lines=False)
transpuesta = csv.transpose()
csv
datosCovid = {"paises" : transpuesta[466].index.astype(str) , "cantidad_casos" :  transpuesta[466].values}
covidcases = pnd.DataFrame(data = datosCovid, columns = ["paises", "cantidad_casos"])
covidcases.set_index("paises")

#hacemos lo mismo con los datos de localidades. Usamos las columnas Location y Population para la nueva dataframe
datosPobl = {"paises" : localidadesCSV["location "].values.astype(str) , "poblacion" :  localidadesCSV["population"].values}
poblacionXpais = pnd.DataFrame(data = datosPobl, columns = ["paises", "poblacion"])

poblacionXpais.paises = [p.strip() for p in poblacionXpais.paises]

#unimos los dos dataframes en la columna de paises.
dfcompleto = pnd.merge(covidcases,poblacionXpais, left_on = "paises", right_on = "paises", how = "inner")

#buscar paraguay 
for i in range(len(covidcases.index.to_list())):
    if covidcases.paises[i] == "Paraguay":
        paraguayCases = covidcases.iloc[i]
def mini(covidcases,n):
    numPaises = len(covidcases.index.to_list())
    for i in range(numPaises):
        min = i
        for j in range (i+1 , numPaises):
            if covidcases.cantidad_casos[min] > covidcases.cantidad_casos[j] :
                min = j
        if(i!=min):
            aux = covidcases.iloc[i].copy()
            covidcases.iloc[i] = covidcases.iloc[min]
            covidcases.iloc[min] = aux
   
    covidcases.iloc[n] = paraguayCases
    for i in range(0,n+1):
        print(covidcases.loc[i].to_string())

#item a
print("menores caso con covid")
mini(covidcases,4)

def may(df,n):
    numPaises = len(df.index.to_list())
    for i in range(numPaises):
        max = i
        for j in range (i+1 , numPaises):
            if df.cantidad_casos[max] < df.cantidad_casos[j] :
                max = j
        if(i!=max):
            aux = df.iloc[i].copy()
            df.iloc[i] = df.iloc[max]
            df.iloc[max] = aux
   
    df.iloc[n] = paraguayCases
    for i in range(0,n+1):
        print(df.loc[i].to_string())
        
#item b
print("mayores caso con covid")
may(covidcases,4)

#item c
casosXmillon = []
for i in range(len(dfcompleto.index.to_list())):
    casosXmillon.append((dfcompleto["cantidad_casos"][i] / dfcompleto["poblacion"][i]) *1000000)

dfcompleto["casosXmillon"] = casosXmillon
dfcompleto
for i in range(len(dfcompleto.index.to_list())):
    if dfcompleto.paises[i] == "Paraguay":
        paraguayCasesXmillon = dfcompleto.iloc[i]
def maxmillon(df,n):
    numPaises = len(df.index.to_list())
    for i in range(numPaises):
        max = i
        for j in range (i+1 , numPaises):
            if df.casosXmillon[max] < df.casosXmillon[j] :
                max = j
        if(i!=max):
            aux = df.iloc[i].copy()
            df.iloc[i] = df.iloc[max]
            df.iloc[max] = aux
   
    df.iloc[n] = paraguayCasesXmillon
    for i in range(0,n+1):
        print(df.loc[i].to_string())
print("\nmas casos por millon")
maxmillon(dfcompleto,4)

def minmillon(df,n):
    numPaises = len(df.index.to_list())
    for i in range(numPaises):
        min = i
        for j in range (i+1 , numPaises):
            if df["casosXmillon"][min] > df["casosXmillon"][j] :
                min = j
        if(i!=min):
            aux = df.iloc[i].copy()
            df.iloc[i] = df.iloc[min]
            df.iloc[min] = aux
   
    df.iloc[n] = paraguayCasesXmillon
    for i in range(0,n+1):
        print(df.loc[i].to_string())
print("\nmenos casos por millon")
maxmillon(dfcompleto,4)

#promedio de los ultimos 10 dias 
def prom(df,n):
    paises = df.columns.to_list()
    promedios = []
    for pais in paises:
        sum = 0
        for i in range(len(df.index)-1, len(df.index)-n-1, -1) :
            sum += df[pais][i]
        promedios.append(sum / n)
    temp = {"paises" : paises , "promedios" : promedios}
    dfPromedios = pnd.DataFrame(data = temp, columns = ["paises","promedios"])
    return dfPromedios

print("Promedio de los ultimos 10 dias por pais")
print(prom(csv,10).to_string())


#corr fuente stackoverflow
'''
def sortCorr(df):
    numPaises = len(df.paises)
    for i in range(numPaises):
        max = i
        for j in range (i+1 , numPaises):
            if df["correlaciones"][max] < df["correlaciones"][j] :
                max = j
        if(i!=max):
            aux = df.iloc[i].copy()
            df.iloc[i] = df.iloc[max]
            df.iloc[max] = aux
    return df
def corrWith(df,dfpais,key,n):
    promedios = prom(df,n)
    paises = promedios.paises.to_list()
    corr = []
    for pais in paises: 
        numerador = 0
        denominador = 0
        sumxy = 0
        sumx = 0
        sumy = 0
        sumxsqr = 0
        sumysqr = 0
        for i in range(len(df.index)-1, len(df.index)-n-1, -1):
            x=(0 if math.isnan(df[pais][i]) else df[pais][i])
            y=(0 if math.isnan(dfpais[key][i]) else dfpais[key][i])
            sumx += x
            sumy += y
            sumxy += x*y
            sumxsqr += math.pow(x,2)
            sumysqr += math.pow(y,2)
        numerador = n*sumxy - sumx*sumy
        denominador = math.sqrt( (n*sumxsqr - math.pow(sumx,2)) * (n*sumysqr - math.pow(sumy,2)))
        
        corr.append(numerador/denominador)
        #print(promedioPais.promedios[0])
    temp = {"paises" : paises, "correlaciones" : corr}
    dfCorr = pnd.DataFrame(data = temp)
    return dfCorr

dfPy = pnd.DataFrame(data = dfParaguay)
print(sortCorr(corrWith(csv,dfPy,"Paraguay",15)).to_string(float_format=lambda x: '%.4f' % x))'''
