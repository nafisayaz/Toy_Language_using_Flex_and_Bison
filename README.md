# Toy_Language_using_Flex_and_Bison

- This is very basic use of Flex and Bison created for my language specifications. Some basic Syntaces like:
```
    println("Nafis Ayaz");
    student_name = scan(string);
    print(student_name);
```
The lex analyses the syntax and makes tokenize as mentioned in lexical file and then tokens are passed to set grammar rules
in parser file, that changes my syntax in C++ as folllows:

```
    std::cout<<"Nafis Ayaz"<<std::endl;
    std::string student_name;
    std::cin>>student_name;
    std::cout<<"student_name";
```





