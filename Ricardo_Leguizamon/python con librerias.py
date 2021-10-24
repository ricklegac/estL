import pandas as pd
import numpy as np
#import datetime as dt
datos=pd.read_csv('total_cases.csv', header=0, delimiter=',')
pdias=pd.read_csv('total_cases.csv', header=0, delimiter=',')
datos2=pd.read_csv('locations.csv',header=0,delimiter=',')
maxvalue=datos['Paraguay'].max()
print ("total cases in paraguay: ",maxvalue)
#datos['Paraguay'].plot.line(color= 'blue')
del(datos['date'])
del(datos['World'])
del(datos['Europe'])
del(datos['Asia'])
del(datos['North America'])
del(datos['European Union'])
del(datos['South America'])
del(datos2['population_year'])
del(datos2['continent'])
del(datos2['Country/Region'])


#paises con menos contagios 
nuevo=pd.DataFrame(datos)
nuevo=nuevo.replace(np.nan,"0")#los null por 0
nuevo= nuevo.T
nuevo.insert(467,"Total",True)
nuevo["Total"]=nuevo[466] 
nuevo.dtypes
nuevoa=(nuevo.sort_values(by=['Total'],ascending=[True])) 
print("4 paises con menos contagios\n")
print(nuevoa .head(4))


#paises con mas contagios
print("\n4 Paises con mas contagio\n")
nuevod=(nuevo.sort_values(by=['Total'],ascending=[False]))
print(nuevod.head(4))

#merge de los datos 
total_cases=nuevo['Total']
total_cases
total_cases.index.names=['location']
datos2.set_index("location",inplace=True)
merge = pd.merge(total_cases, datos2, on='location' , how='inner') 

merge.insert(2,"Caso por Millon",0)
merge["Caso por Millon"]=(merge['Total']*1000000)/merge['population']
tot_casos= (merge['Total'])     

#mayores casos por millon de habitantes
print("\nPaises con mas casos por millon: \n")
casos_p_millon=merge.sort_values(by=["Caso por Millon"],ascending=False)
print(casos_p_millon.head(4))

#menores casos por millon de habitantes
print("\nPaises con menos casos por millon: \n")
casos_p_millon=merge.sort_values(by=["Caso por Millon"],ascending=True)
print(casos_p_millon.head(4))
          
print("\nEn Paraguay: \n")
merge1=merge.T
print(merge1['Paraguay'])


#PROMEDIO DE CASOS EN 10 ULTIMOS DIAS POR PAIS

ultimos10= pdias.iloc[-10:]
ultimos10= ultimos10.drop(["World","Africa","North America","Europe","South America","European Union","Asia"],axis=1)
ultimos10=  ultimos10.mean().to_frame(name="Promedio en 10 dias")
ultimos10=ultimos10.sort_values(by=['Promedio en 10 dias'],ascending=False)
print("\nDataFrame de promedio de casos en ultimos 10 dias por pais\n",ultimos10.head(10))

#CORRELACION PORCENTUAL DE CASOS DE PAISES CON PARAGUAY
casos= datos.tail(16).diff().tail(15)
cor= casos.corrwith(casos['Paraguay'])
cor=pd.DataFrame(cor)
cor=cor.drop(['Paraguay'],axis=0)
cor.rename(columns={0:'Correlacion'}, inplace=True)
cor=cor.sort_values(by=['Correlacion'],ascending=[False])
print("\nPaises con mas correlacion a Paraguay\n")
print(cor.head(10))

#“axis 0” represents rows and “axis 1” represents columns.
#graficar

picos=pd.read_csv('total_cases.csv',delimiter=',',header=0)
picos['date']= pd.to_datetime(picos['date'])
difference = picos.diff(axis=0)
paiseselegidos=["Paraguay","Uruguay","Bolivia","Argentina","Brazil"]
difference[paiseselegidos].plot()





