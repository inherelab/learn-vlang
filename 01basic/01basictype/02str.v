module main

// https://lydiandylin.gitbook.io/vlang/mu-lu/basictype#zi-fu-chuan-lei-xing
fn main() {

    /* 
    string字符串类型，默认不可变，UTF-8编码。
    单引号和双引号都可以，习惯上都还是使用单引号，V编译器中的代码都是统一使用的单引号。
    */

    println("# 字符串类型")

    str_basic()

    println('## 遍历字符串：')
    each_str()

    println('## 字符串切片/区间')
    str_slice()

    println('## 原始字符串')
    raw_str()
}


fn str_basic() {

    s1:='abc'
    s2:="def"
    println(s1)

    // 字符串长度：
    println(s2.len) // 3

    // 字符串连接：
    s3 := s1+s2
    println(s3)

    // 字符串追加：
    mut s4 := 'a-' // 必须是可变才可以追加
    s4 += s1
    println(s4)

    // 字符串插值：
    name:='Bob'
    println('hello ${name}')
    println("hello ${name}2")

    // 多行字符串
    println('1 first line
2 second line')

    // 是否包含子字符串
    println(s1.contains('bc')) //true
    println(s1.contains('bb')) //false

}


fn each_str() {
    str := 'abc123'
    //遍历value
    for s in str {
        println(s.str())
    }
    //遍历index和value
    for i, s in str {
        println('index:$i，value:$s.str()')
    }
}

// TIP: 采用的是左闭右开。
fn str_slice() {
    s := 'hello_world'
    println(s[..3]) //输出hel
    println(s[2..]) //输出llo_world
    println(s[2..5]) //输出llo

    // NOTE: 区间支持负数的索引值，不过要在字符串名后特别加一个#,否则会报错
    println(s#[-5..-2]) //输出wor

    // NOTE: 字符串区间越界的or代码块处理
    println(s[..s.len])
    println(s[..s.len + 1] or { 'oh,no' })
    println(range_check(s) or { 'out of range' })
}

fn range_check(s string) !string {
    return s[..20] !
}

// 原始字符串
// 在单引号或双引号前加上小写r，就表示是raw字符串，在原始字符串中不支持插值和转译。
fn raw_str() {
    name := 'tom'
    str := 'name is: ${name} \n' //字符串插值和转译
    raw_str := r'name is: {name} \n' //原始字符串,在单引号或双引号之前加上r前缀
    raw_str2 := r"name is: {name} \n" //原始字符串,在单引号或双引号之前加上r前缀
    println(str)
    println(raw_str)
    println(raw_str2)
}
