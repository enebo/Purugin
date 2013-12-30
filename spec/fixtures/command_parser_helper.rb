EOF = Purugin::CommandParser::Lexer::EOF

def lex(str)
  Purugin::CommandParser::Lexer.new(str).to_a
end

def parse(str)
  Purugin::CommandParser::Parser.parse(str)
end

def command(*words)
  Purugin::CommandParser::Syntax::Command.new(*words)
end

def variable(name, type=nil)
  Purugin::CommandParser::Syntax::Variable.new(name).tap do |var|
    var.type = Purugin::CommandParser::Syntax::Type.new(type) if type
  end
end
