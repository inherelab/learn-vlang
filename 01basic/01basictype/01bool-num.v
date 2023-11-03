module main

// link https://lydiandylin.gitbook.io/vlang/mu-lu/basictype
fn main() {
    // bool
    yes := true

    println("# 布尔类型")
    println(yes)
    println(sizeof(yes))

    println("\n# 数值类型(int/float):")
    mut c := 0xa_0 // 十六进制 a0
    println(c) // 160
    c = 0b10_01 // 二进制 1001
    println(c) // 9
    c = 1_000_000 // 十进制
    println(c)

    println("# - float")
    f1 := 1.0
    println(f1)

    // 默认自动推导类型 可以使用 T(value) 设置类型
    println("\n# 默认自动推导类型")
    x := 3
    y := 1.3
    println(typeof(x).name) // int
    println(typeof(y).name) // f64

    xx := i64(3)
    yy := f32(3.0)
    println(typeof(xx).name) // i64
    println(typeof(yy).name) // f32

}
