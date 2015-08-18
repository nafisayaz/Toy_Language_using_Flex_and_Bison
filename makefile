
PARSER_SRCS = $(wildcard g/*.c)

PARSER_OBJS = $(PARSER_SRCS:g/%.c=obj/%.o)

.PHONY: clean create generate make

all: clean create generate make

clean:
	@echo Cleaning up 
	@rm -rf  g/
	@rm -rf  obj/
	@rm -f run

create:
	@echo Making directories
	@mkdir -p g/
	@mkdir -p obj/

generate:
	@echo Generating parser 
	@bison parser.y --defines=parser.h
	@mv parser.h g/parser.h
	@mv parser.tab.c g/parser.c
	@echo Generating lexer
	@flex lexer.l
	@mv lex.yy.c g/lexer.c

start_compilation: generate 
	@echo Start compiling..

$(PARSER_OBJS): start_compilation
	@echo "\033[1;32m> Compiling $(@:obj/%.o=g/%.c)\033[0m"
	@gcc -c  $(@:obj/%.o=g/%.c) -o $@ 

make: $(PARSER_OBJS)
	@echo "\033[1;32m> Linking {$(PARSER_OBJS)}\033[0m"
	@gcc $(PARSER_OBJS) -lfl -o run
	@echo Done

