object universitario {
	method esClaseMedia() = true
}

class NivelDeEducacion {
	method esClaseMedia() = false

}
object terciario inherits NivelDeEducacion {

}

object secundario inherits NivelDeEducacion {

}

object primario inherits NivelDeEducacion {

}

object chapa {

	method esBueno() = false

}

object material {

	method esBueno() = true

}

class Pais {

	var localidades = []

	method poblacionTotal() = localidades.sum({ localidad => localidad.habitantes() })

	method localidadesChicas() = localidades.filter({ localidad => localidad.esChica() })

	method porcentajeClaseMedia() = self.poblacionDeClaseMedia() / self.poblacionTotal()

	method poblacionDeClaseMedia() = localidades.sum({ localidad => localidad.poblacionDeClaseMedia() })
	method indiceHacinamiento() = localidades.sum({ localidad => localidad.viviendasHacinadas() }) /  localidades.sum({ localidad => localidad.viviendasTotales() })

}

class Localidad {

	var property viviendas = []

	method habitantes() = viviendas.sum({ vivienda => vivienda.habitantes() })

	method esChica() = self.habitantes() < 500

	method poblacionDeClaseMedia() = viviendas.sum({ vivienda => vivienda.poblacionDeClaseMedia() })
	method viviendasHacinadas() = viviendas.count({ vivienda => vivienda.esHacinada() })
	method viviendasTotales() = viviendas.size()
		

}

class FormularioReducido {


	var property edad = 18
	var property nivelDeEstudios

	method claseMedia() = nivelDeEstudios.esClaseMedia()
}

class Extendido inherits FormularioReducido {
	var property tieneTrabajo = true
	var property descendienteDePueblosOriginarios = true
	
	override method claseMedia(){
		return super() && tieneTrabajo
	}
}

class Vivienda {

	const property estiloDeConstruccion = material

	method esClaseMedia() = estiloDeConstruccion.esBueno()

	method habitantes()

	method poblacionDeClaseMedia() {
		if (self.esClaseMedia()) return self.habitantes()
			return 0
	}
}

object computadora {

}

class ViviendaComun inherits Vivienda {

	var property ambientes = 1
	var property artefactos = []
	var property formularios = []

	override method habitantes() = formularios.size()

	override method esClaseMedia() = super() && artefactos.contains(computadora) && self.alguienEsClaseMedia()
	method alguienEsClaseMedia() = formularios.any({formulario => formulario.claseMedia()})

	method esHacinada() = self.habitantes() > ambientes * 2
}

class ViviendaColectiva inherits Vivienda {

	var property superficie = 1
	var property habitantes = 1

	override method poblacionDeClaseMedia() {
		if (self.esClaseMedia()) return self.habitantes()
			return 0
	}

	override method esClaseMedia() = super() && superficie > 100
	method esHacinada() = (superficie/self.habitantes()) < 10

}

