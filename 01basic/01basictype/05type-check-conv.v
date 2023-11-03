module main


fn main() {

println('## 类型推断及类型转换')
    type_deduce_conv()

    println('## 获取变量和类型占用内存大小')
    get_var_mem_size()


    println('## 获取变量和类型的类型信息')
    get_var_type_info()
    println('### 获取类型的类型的idx和name')
    get_type_type_info()


     println('## 判断变量和类型是否为引用类型')
   check_var_or_type_isref()
}

/*
类型推断及类型转换
*/
fn type_deduce_conv() {
    i := 8 // 默认类型推断为int
    b := u8(8) // 明确指定类型为u8
    ii := int(b) // 强制转换为int
    f := 3.2 // 默认推断类型为f64
    ff := f32(3.2) // 明确指定类型为f32
    f3 := f64(f) // 强制转换为f64
    s := 'abc' // 默认推断为string
    c := `c` // 默认推断为rune

    // 布尔类型可以转换为u8/int或其他整数类型
    yes := true
    no := false
    yes_u8 := u8(yes) // 输出1
    no_u8 := u8(no) // 输出0
    yes_int := int(yes)  // 输出1
    no_int := int(no) // 输出0

    // 将字节数组转成字符串
    mut u8_arr := []u8{} // 字节数组
    u8_arr << `a`
    u8_arr << `b`
    println(u8_arr) // 输出[97,98]
    str := u8_arr.bytestr() // 将字节数组转成字符串
    println(str) // 输出ab
}

/*
获取变量和类型占用内存大小
使用内置函数sizeof来获取变量和类型占用内存大小：

- 普通函数，获取变量的占用内存大小 sizeof(var)
- 泛型函数，获取类型的占用内存大小 sizeof[T]()
*/
fn get_var_mem_size() {
    x := 1
    u := u8(1)
    b := true
    //普通函数
    println(sizeof(x)) // 4
    println(sizeof(u)) // 1
    println(sizeof(b)) // 1

    //泛型函数
    println(get_size[int]()) // 4
    println(get_size[u8]()) // 1
    println(get_size[bool]()) // 1
}

fn get_size[T]() u32 {
    return sizeof(T) //泛型函数
}

/*
使用内置函数typeof来返回变量的类型和类型的idx和name

普通函数，获取变量的类型的idx和name
    typeof(var).name
    typeof(var).idx
    var.type_name()
泛型函数，获取类型的类型的idx和name
    typeof[T]().name
    typeof[T]().idx
*/
struct Point {
    x int
}

type MyFn = fn (int) int

type MyFn2 = fn ()

fn myfn(i int) int {
    return i
}

fn myfn2() {
}

fn get_var_type_info() {
    a := 123
    s := 'abc'
    aint := []int{}
    astring := []string{}
    astruct_static := [2]Point{}
    astruct_dynamic := [Point{}, Point{}]

    //使用typeof().idx获取变量类型的id
    //使用typeof().name获取变量的类型
    println(typeof(a).idx) // 7
    println(typeof(a).name) // int
    println(typeof(s).name) // string
    println(typeof(aint).name) // array_int
    println(typeof(astring).name) // array_string
    println(typeof(astruct_static).name) // [2]Point
    println(typeof(astruct_dynamic).name) // array_Point

    //函数类型
    println(typeof(myfn).name) // fn (int) int
    println(typeof(myfn2).name) // fn ()
}

struct MyStruct {}

struct MyGenericStruct2[T, U] {}

type Abc = int | string
type AnAlias = int

enum EFoo {
    a
    b
    c
}

fn get_type_type_info() {
    println(typeof[int]().idx) //返回类型的id,int类型在编译器内部的id是7
    println(typeof[int]().name) //返回类型的名字: int
    println(typeof[?string]().name) //返回类型的名字: ?string
    println(typeof[!string]().name) //返回类型的名字: !string
    println(typeof[[]string]().name) //返回数组类型的名字: []string
    println(typeof[map[string]int]().name) //返回字典类型的名字: map[string]int
    println(typeof[fn (s string, x u32) (int, f32)]().name) //返回函数类型的名字: fn (string, u32) (int, f32)
    println(typeof[MyGenericStruct]().name) //返回结构体类型的名字: MyStruct
    println(typeof[MyGenericStruct2[string, int]]().name) //返回泛型结构体类型的名字: MyGenericStruct2[string, int]
    println(typeof[Abc]().name) //返回联合体类型的名字: Abc
    println(typeof[EFoo]().name) //返回枚举类型的名字: EFoo
    println(typeof[AnAlias]().name) //返回类型别名名字: AnAlias
}


/*
判断变量和类型是否为引用类型
- 普通函数，判断变量是否为引用类型 isreftype(var)
- 泛型函数，判断类型是否为引用类型 isreftype[T]()
*/


struct PointXY {
    x int
    y int
}

fn check_var_or_type_isref() {
    i := 8
    println(isreftype(i)) //基本类型除了string，都不是引用类型

    s := 'abc'
    println((isreftype(s))) // string是引用类型,因为字符串是使用结构体来实现的

    mut m := map[string]string{} // map是引用类型,因为字典是使用结构体来实现的
    m['name'] = 'tom'
    println(isreftype(m))

    a := [1, 2, 3]
    println(isreftype(a)) // array是引用类型,因为数组是使用结构体来实现的

    p := PointXY{
        x: 1
        y: 2
    }
    pp := &PointXY{
        x: 1
        y: 2
    }
    println(isreftype(p)) // p不是引用类型
    println(isreftype(pp)) // pp是引用类型

    println('### 判断类型是否为引用类型：')
    println(isreftype(int))
    println(isreftype[string]())
    println(get_is_ref_type[[]int]())
}

fn get_is_ref_type[T]() bool {
    return isreftype[T]()
}