class Aluno
	attr_accessor :matricula, :cr, :notas, :disciplinas_cursadas
    
	def initialize(matricula)
  	@matricula = matricula
  	@cr = 0.0
  	@disciplinas_cursadas = []
  end

  def calcular_cr
    total_carga_horaria = 0
      @disciplinas_cursadas.each do |disciplina|
      @cr += (disciplina.nota * disciplina.carga_horaria)
      total_carga_horaria += disciplina.carga_horaria
    end
    @cr /= total_carga_horaria
  end

  def adicionar_disciplina_cursada(disciplina)
    @disciplinas_cursadas.push(disciplina)
  end
end