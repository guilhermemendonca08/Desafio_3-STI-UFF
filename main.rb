require_relative 'universidade'

PATH = 'db/notas.csv'

universidade = Universidade.new(PATH)
universidade.criar_dados

universidade.calcular_cr_alunos
universidade.mostrar_cr_alunos

puts

universidade.calcular_cr_cursos
universidade.mostrar_cr_cursos