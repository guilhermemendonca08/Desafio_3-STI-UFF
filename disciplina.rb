class Disciplina
  attr_accessor :cod_disciplina, :carga_horaria, :nota

  def initialize(cod_disciplina, carga_horaria, nota)
    @cod_disciplina = cod_disciplina
    @carga_horaria = carga_horaria
    @nota = nota
  end
end