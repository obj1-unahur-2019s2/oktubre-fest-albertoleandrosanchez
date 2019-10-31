class CervezaBase{
	var property cantidadLupulo //GramoXLitro
	var property pais
	var property graduacion //porcentaje
	

}

class CervezaRubia inherits CervezaBase{
	
}

class CervezaNegra inherits CervezaBase{
	
	
	override method graduacion(){
		return graduacionReglamentaria.graduacion().min(cantidadLupulo*2)
	}
}

class CervezaRoja inherits CervezaNegra{
	
	override method	graduacion(){
		return super() * 1.25
	}
}

class Jarra{
	var property litro
	var property marca
	method contenidoDeAlcohol(){
		return litro * (marca.graduacion()/100)
	}
}

class Personas{
	
	var property peso
	var property jarras= []
	var property aguante //INT
	var property gustaMusicaTradicional //BOOL
	
	method pais()
	method gustoDeCerveza(marca)
	
	method agregarJarra(jar){
		jarras.add(jar)
	}
	
	method estaEbria(){
		return (self.litrosTomados()*peso) > aguante
	}
	
	method litrosTomados(){
		return jarras.sum({jar=>jar.litro()})
	}
	method totalDeAlcohol(){
		return jarras.sum({
			jar=>jar.contenidoDeAlcohol()
		})
	}
	
	method quiereEntrar(carpa){
		return self.gustoDeCerveza(carpa.marca()) and self.gustaMusicaTradicional() == carpa.tieneBanda()
	} 
	
	method esPatriota(){
		return jarras.all({jarra=>jarra.pais()==self.pais()})
	}
	///////

}

class Belgas inherits Personas{
	const property pais = belgica
	 override method gustoDeCerveza(cerveza){
			return cerveza.cantidadLupulo() > 4
		}
}

class Checos inherits Personas{
	const property pais = checolovaquia
	override method gustoDeCerveza(cerveza){
		return cerveza.graduacion()>8
	}
}

class Alemanes inherits Personas{
	const property pais = alemania
	
	override method gustoDeCerveza(cerveza){
		return true
	}
	override method quiereEntrar(carpa){
		return super(carpa) and carpa.personasDentro().even()
	}
}

class Carpas{
	var property limiteDeGente
	var property tieneBanda
	var property marca
	var property personasDentro = []
	
	method dejaIngresar(persona){
		return not persona.estaEbria() and self.personasDentro().size() < limiteDeGente
	}
	method puedeEntrar(persona){
		return self.dejaIngresar(persona) and persona.quiereEntrar(self)
	}
	method entra (persona){
		if(self.puedeEntrar(persona)){
			personasDentro.add(persona)
		}
		else{
			self.error("estas re mamado o esta todo lleno, no tengo idea pero no te voy a dejar entrar campeon")
		}
	}
	method personaEstaDentro(persona){
		return personasDentro.contains(persona)
	}
	
	method servir(persona,cntLitros){
		if(self.personaEstaDentro(persona)){
			persona.jarras().add(new Jarra(litro=cntLitros,marca= self.marca()))
		}
		else self.error("ni entraste capo, ves que estas borrachisimo!")
	}
	method cuantosEbriosEmp(){
		personasDentro.count({
			ebr=>ebr.jarras().all({
				jar=>jar.litro()>=1
			})
		})
	}
	method esHomogeneo(){
		
	}
	
}









//AUX

object graduacionReglamentaria{
	var property graduacion
}
object belgica{}
object checolovaquia{}
object alemania{}
