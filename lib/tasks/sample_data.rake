namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Create base user
    User.create!(name: "Dummy User",
                 email: "example@railstutorial.org",
                 password: "secret",
                 password_confirmation: "secret",
                 citizen_number: "12349999")

    # Create another 99 copies
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "secret"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   citizen_number: "1337000#{n+1}")
    end

    # Create 50 proposals for the first 6 user
    user = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(1)
      problem = Faker::Lorem.sentence(4)
      solution = Faker::Lorem.sentence(8)
      user.each { |user| user.proposals.create!(title: title, problem: problem, solution: solution) }
    end
  end

  # ==========
  # PRODUCTION
  # ==========

  desc "Create admin user"
  task create_admin: :environment do

    # Create admin user
    admin = User.create!(name: ENV["ADMIN_NAME"],
                         email: ENV["ADMIN_EMAIL"],
                         password: ENV["ADMIN_PASS"],
                         password_confirmation: ENV["ADMIN_PASS"],
                         citizen_number: ENV["ADMIN_ID"],
                         admin: true)
  end

  desc "populate with realistic dummy users"
  task populate_realistic_users: :environment do

    User.create!(name: "Ricardo Salgueiro",
                 email: "ricardo.salgueiro@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765400",
                 political_party: "PCP")
    User.create!(name: "Ana Morgado",
                 email: "ana.morgado@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765401",
                 political_party: "PS")
    User.create!(name: "Maria Costa da Silva",
                 email: "maria.silva@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765402",
                 political_party: "PSD")
    User.create!(name: "Rodrigo Maia de Sousa",
                 email: "rodrigo.maia@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765403",
                 political_party: "CDS")
    User.create!(name: "Valter Melo",
                 email: "valter.melo@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765404",
                 political_party: "BE")
    User.create!(name: "Alexandra Moreira",
                 email: "alexandra.moreira@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765405",
                 political_party: "PAN")
    User.create!(name: "Rita Santos",
                 email: "rita.santos@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765406",
                 political_party: "PCP")
    User.create!(name: "José Ribeiro",
                 email: "jose.ribeiro@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765407",
                 political_party: "")
    User.create!(name: "António Parreira",
                 email: "antonio.parreira@example.com",
                 password: "52a5lG*S@DMu1S8c",
                 password_confirmation: "52a5lG*S@DMu1S8c",
                 citizen_number: "98765408",
                 political_party: "")
  end

  desc "populate with realistic dummy proposals"
  task populate_realistic_proposals: :environment do

    user = User.find_by(citizen_number: "98765405")
    title = "Fim dos dinheiros públicos para as touradas"
    problem = "É injusto e imoral que os dinheiros públicos sejam utilizados na perpetuação das touradas em Portugal. A realização de touradas em Portugal depende dos subsídios para a criação de touros e de diversos apoios das autarquias. Estes apoios custam anualmente ao Estado português cerca de 16 milhões € que podiam ser utilizados de forma mais útil e saudável."
    solution = "Não sendo possível acabar com as touradas, acabar com os subsídios e apoios atribuídos pelo Estado a esta indústria."
    user.proposals.create!(title: title, problem: problem, solution: solution)

    user = User.find_by(citizen_number: "98765407")
    title = "Tara Recuperável: chega de garrafas no chão"
    problem = "Há demasiadas garrafas de plástico e latas de alummínio espalhadas pelo chão das ruas, florestas ou praias."
    solution = "Todas as garrafas/latas de bebidas passam a ter tara recuperável. Quem limpa/recicla será recompensado. Esta medida reduzirá a poluição implantando um mecanismo eficaz de poluidor-pagador, melhorará reciclagem, baixará preços dos produtos, reduzirá a importação de derivados de petróleo."
    user.proposals.create!(title: title, problem: problem, solution: solution)

    user = User.find_by(citizen_number: "98765408")
    title = "Candidaturas Independentes ao Parlamento"
    problem = "É impossível um independente candidatar-se ao cargo de deputado na assembleia da república."
    solution = "Pela dignificação do cargo de Deputado, essencial para a regeneração da nossa Democracia, e pelo fim da asfixia partidocrática sobre o nosso regime democrático. Só assim, com Deputados que livremente representem aqueles que os elegeram e que não sejam apenas uma caixa de ressonância dos respectivos Partidos - como hoje, na maior parte dos casos, acontece -, teremos uma verdadeira Democracia Representativa."
    user.proposals.create!(title: title, problem: problem, solution: solution)

    user = User.find_by(citizen_number: "98765400")
    title = "Incentivo à Natalidade"
    problem = "Portugal tem uma das taxas de natalidade mais baixas do mundo. Em poucas décadas passarão a haver mais idosos que jovens e a segurança social assim desaparece."
    solution = "À semelhança das famílias, um país só tem futuro se tiver descendentes. Com os níveis médios de 1,36 crianças por casal, facilmente percebemos que não estão a nascer crianças suficientes para haver renovação de gerações. Portugal está a desaparecer."
    user.proposals.create!(title: title, problem: problem, solution: solution)

    user = User.find_by(citizen_number: "98765401")
    title = "Fim das subvenções vitalícias para políticos"
    problem = "Políticos acumulam subvenções com outros rendimentos."
    solution = "Fim da possibilidade de políticos acumularem as respetivas subvenções vitalícias com rendimentos privados."
    user.proposals.create!(title: title, problem: problem, solution: solution)

    user = User.find_by(citizen_number: "98765404")
    title = "Transição para software livre"
    problem = "O Estado e seus organismos continuam em geral a utilizar software proprietário para operações básicas (Office)."
    solution = "Transição para Open-Source, por exemplo usando LibreOffice. As vantagens são óbvias, poupa-se dinheiro em licenças e torna-se mais fácil a transferência de informação entre organizações e pessoas."
    user.proposals.create!(title: title, problem: problem, solution: solution)

    user = User.find_by(citizen_number: "98765403")
    title = "Impossibilitar a prescrição de crimes financeiros"
    problem = "É uma vergonha que o caso BPN tenha sido arquivado porque prescreveu graças aos recursos atrás de recursos dos arguidos."
    solution = "Das duas uma, ou limitar o número de recursos dos arguidos deste tipo de crimes ou impossibilitar a sua perscrição."
    user.proposals.create!(title: title, problem: problem, solution: solution)
  end
end
