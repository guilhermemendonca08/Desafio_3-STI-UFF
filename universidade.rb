require 'csv'
require_relative 'aluno'
require_relative 'curso'
require_relative 'disciplina_cursada'

class Universidade
  attr_accessor :alunos, :cursos, :arquivo, :cursos

  def initialize(arquivo)
    @alunos = {}
    @cursos = {}
    @arquivo = arquivo
  end

  def criar_dados
    criar_alunos
    criar_cursos
  end

  def calcular_cr_alunos
    @alunos.each do |matricula, aluno|
      aluno.calcular_cr
    end
  end

  def mostrar_cr_alunos
    puts "-"*10 + "CR dos Alunos" + "-" *10
    @alunos.each do |matricula, aluno|
      print "#{aluno.matricula} - "
      cr_formatado = format('%.2f', aluno.cr)
      puts cr_formatado

      puts "-"*33
    end
  end

  def mostrar_cr_cursos
    codigos_cursos = @cursos.keys.sort
    puts "-"*7 + "CR Médio dos Cursos" + "-" *7
    codigos_cursos.each do |cod_curso|
      curso = @cursos[cod_curso]
      print "#{cod_curso} - "

      cr_formatado = format('%.2f', curso.cr)
      puts cr_formatado

      puts "-"*33
    end
  end

  def calcular_cr_cursos
    @cursos.each do |cod_curso, curso|
      curso.calcular_cr
    end
  end

  private 

  def criar_alunos
    ultima_matricula_criada = -1
    CSV.foreach(@arquivo, headers: true) do |registro|
      matricula_aluno = registro["MATRICULA"].to_i
      if(matricula_aluno != ultima_matricula_criada) 
        aluno = Aluno.new(matricula_aluno)
        disciplina = criar_disciplina(aluno, registro)
        aluno.adicionar_disciplina_cursada(disciplina)
                
        @alunos[matricula_aluno] = aluno
        ultima_matricula_criada = matricula_aluno

      else
        aluno = @alunos[ultima_matricula_criada]
        disciplina = criar_disciplina(aluno, registro)
        aluno.adicionar_disciplina_cursada(disciplina)
      end
    end
  end

  def criar_disciplina(aluno, registro)
    disciplina = DisciplinaCursada.new(registro["COD_DISCIPLINA"].to_i, registro["CARGA_HORARIA"].to_i, registro["NOTA"].to_i)
  end

  def criar_cursos
    CSV.foreach(@arquivo, headers: true) do |registro|
      codigo_curso = registro["COD_CURSO"].to_i
      matricula_aluno = registro["MATRICULA"].to_i
      aluno = @alunos[matricula_aluno]
    
      unless @cursos.key?(codigo_curso)
        curso = Curso.new(codigo_curso)
        curso.adicionar_aluno(aluno)
        @cursos[codigo_curso] = curso
        next
      end
    
      curso = @cursos[codigo_curso]
      curso.adicionar_aluno(aluno) unless curso.possui_aluno(aluno)
    end
  end
end