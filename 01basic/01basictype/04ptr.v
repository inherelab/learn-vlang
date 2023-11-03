module main

// https://lydiandylin.gitbook.io/vlang/mu-lu/basictype#zhi-zhen-lei-xing

/*
voidptr 通用类型指针，用来存储变量的内存地址，可以保存任何类型的地址。
指针本身占用的内存大小就是C语言里面的size_t类型，通常在32位系统上的长度是32位，64位系统上是64位。
*/
fn main() {
    // 测试机器是64位操作系统
    println(sizeof(voidptr)) //输出8个字节

    /*
    变量前加&表示取内存地址，返回指针类型。
    指针类型前加*表示取内存地址对应变量的值。
    */
    a := 'abc'
    println(&a) // 取变量地址，返回地址
    b := &a
    println(*b) // 取指针对应的值，返回abc

    /*
    nil，表示空值或者空指针，等价于voidptr(0)。

正常情况下，由V创建的变量，因为声明和初始化一定是同时进行的，所以变量一定会有初始值。V指针一定不会有空值nil，即voidptr(0)值。
NOTE: 但是通过调用C代码返回的指针，有可能是空指针，所以在使用前可以用isnil(ptr)内置函数判断一下，判断由C代码生成的指针是否是空指针。
*/
    println('## check nil:')
   check_nil()

/*
在V语言中，指针只是表示引用，不能进行指针运算。

只有在unsafe代码块中，V编译器不进行任何检查，允许指针像C那样可以进行指针运算，指针偏移，多级指针。
详细内容可以参考：不安全代码。
除了voidptr通用类型指针，V还有2种指针类型，一般情况比较少用：字节类型指针byteptr，字符类型指针charptr。
*/
println('## other ptr:')
    other_ptr()
}

fn check_nil() {
    a := 1
    println(isnil(&a)) // false 变量只能通过:=来初始化，一定会有初始值
}

fn other_ptr() {
    u := u8(10)
    b := &u //&u类型
    c := `a`
    b_ptr := byteptr(b) // byteptr类型,等价于&u
    c_ptr := charptr(&c) // charptr类型,一般用于跟C集成使用,等价于*char

    println(typeof(b).name) 
    println(typeof(b_ptr).name) 
    println(typeof(c_ptr).name) 
}

