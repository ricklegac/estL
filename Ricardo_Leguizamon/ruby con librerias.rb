require 'daru'
require 'matplotlib/iruby'
options ={
    :col_sep => ',',
    :converters => :numeric,
    :headers => true
}
tcdf= Daru::DataFrame.from_csv('total_cases.csv',opts = options)
ldf= Daru::DataFrame.from_csv('locations.csv',opts=options)
tcdf.delete_vectors(:date, :asia , :world, :europe, :north_america, :south_america, :european_union )
ldf = ldf.recode(:row) do |row|
    row[:location] = simbolizar(row[:location])
    row
end

#ejercicio A
menosinfectados10 = tcdf.row[466].sort 
menores = menosinfectados10.head(4)

#agregamos paraguay
menores.concat(menosinfectados10[:paraguay],"Paraguay")

#ejercicio B lo mismo que el A pero descendentemente

masinfectados10=tcdf.row[466].sort ascending: false 
mayores.concat(masinfectados10[:paraguay],"Paraguay")


#ejercicio c 

row466 = tcdf.row[466]
datosrow466 = Daru::DataFrame.new([row466.to_a], order [:casos], index: row466.index)
datosrow466[:location] = datosrow466.index.to_a
datosrow466 = datosrow466.join(ldf, how:inner, on: [:location])
datosrow466["CasosPorMillon"]=datosrow466[:casos] * 1000000 / datosrow466[:population]
datosrow466.sort(["CasosPorMillon"], ascending: false).head(4)

#ejercicio d

datosrow466.sort(["CasosPorMillon"]).head(4)

#ejercicio e
idx = Daru::Index.new (0..9).to_a 
izq = tcdf.tail(10)
der = tcdf.tal(11).head(10)
izq.index = idx
der.index = idx
tcdiff10= izq-der

tcdiff10.mean 

#ejercicio f

idx = Daru::Index.new(0..14).to_a 
izq = tcdf.tail(15)
der = tcdf.tal(16).head(15)
izq.index = idx
der.index = idx
tcdiff15= izq-der
correlacion=tcdiff15.corr
pycorr= correlacion[:paraguay].replace_nils(0)
pycorr.sort(ascending: false)[1..20]

#la grafica cambiare 