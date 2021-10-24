require 'daru'
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

#calcula la diferencia 
idx = Daru::Index.new (0..9).to_a 
izq = tcdf.tail(10)
der = tcdf.tal(11).head(10)
izq.index = idx
der.index = idx
tcdiff10= izq-der

idx = Daru::Index.new(0..14).to_a 
izq = tcdf.tail(15)
der = tcdf.tal(16).head(15)
izq.index = idx
der.index = idx
tcdiff15= izq-der

#ejercicio A
menosinfectados10 = tcdf.row[466].sort 
menores = menosinfectados10.head(4)
#agregamos paraguay
menores.concat(menosinfectados10[:paraguay],"Paraguay")

#ejercicio B lo mismo que el A pero descendentemente

masinfectados10=tcdf.row[466].sort ascending: false 
mayores.concat(masinfectados10[:paraguay],"Paraguay")


idx = Daru::Index.new(0..14).to_a 
izq = tcdf.tail(15)
der = tcdf.tal(16).head(15)
izq.index = idx
der.index = idx
tcdiff15= izq-der
