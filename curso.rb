class Curso 
    attr_accessor :cod_curso, :cr, :alunos

	def initialize(cod_curso)
  	@cod_curso = cod_curso
    @cr = 0.0
    @alunos = []			
  end

  def adicionar_aluno(aluno)
    alunos.push(aluno)
  end

  def possui_aluno(aluno)
  	return @alunos.include?(aluno)
  end

	def calcular_cr
  	alunos.each do |aluno|
    	@cr += aluno.cr
    end
    @cr /= alunos.length
  end
end