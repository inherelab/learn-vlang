module main
// doc: https://lydiandylin.gitbook.io/vlang/mu-lu/enum

/*
定义枚举
枚举默认是模块内访问，通过pub关键字来定义公共枚举。

枚举的命名跟结构体命名一样，必须以大写字母开头，枚举项的名称跟函数命名一样，必须是小写加下划线。
*/

enum Color {
	blue // 如果没有指定初始值，默认从0开始，然后往下递增1
	green
	white
	black
}

// 枚举也可以像结构体那样添加方法：
fn (c Color) is_blue() bool { // 枚举方法
	return c == .blue
}

// 也可以指定枚举值的值，枚举值也可以是负数：
enum Color2 {
	blue = 2 //可以指定初始值
	green
	white
	black
}

enum Color3 {
	blue = -4 //初始值也可以是负数
	green
	white
	black
}

/*枚举值类型
枚举值默认是int类型，也可以使用as来明确指定枚举值的类型，枚举值的类型只能是内置的整数类型。*/
enum ColorI8 as i8 {
	red
	green = 126
	blue
}

enum ColorI16 as i16 {
	red
	green = 32766
	blue
}


fn main() {
	println('定义枚举:')
	mut c := Color.green // 第一次定义要使用：枚举名称.枚举值
	println(c) // 输出green
	c = Color.blue
	c = .blue // 第二次修改赋值，也可以忽略枚举名称，直接使用.枚举值就可以了
	println(c) // 输出blue
	println(c.is_blue())

	init_value_enum()

	conv_enum_type()

	enum_array()

	for_in_enum()
}

fn init_value_enum() {

	println('可以指定初始值')
	mut c := Color2.green
	println(c) //输出green
	// c = .blue
	println(Color3.blue) //输出blue
}

/*
枚举值/整型相互转换
枚举类型和整数类型可以相互转换，不过有一点需要特别注意，
将整数转换为枚举类型，属于跨类型的强制转换，必须在不安全代码块中执行，不然编译器会报错。
*/

fn conv_enum_type() {
	println('枚举值/整型相互转换')
	i := 2 // 推断为int
	// println(i==.blue) 	//报错,类型不匹配
	e := unsafe { Color2(i) } // 将整数转换为枚举类型，属于跨类型的强制转换，必须在不安全代码块中

	println(e == .blue) // 输出true
	ii := int(e) // 枚举类型转换为int
	println(ii) // 输出2

	iii := e // iii是枚举类型
	println(typeof(iii).name)
	println(iii)
}

/*
枚举类型数组
可以定义枚举类型的数组，数组的值是某个枚举项：
*/

struct Abc {
mut:
	flags []Flag
}

enum Flag {
	flag_one
	flag_two
	flag_three
}

fn enum_array() {
	println('枚举类型数组')
	mut a := Abc{}
	a.flags << Flag.flag_one
	a.flags << .flag_two
	a.flags << .flag_three
	println(a.flags)
}

/*
遍历枚举值
可以使用$for in语句来遍历所有的枚举值：

*/
fn for_in_enum() {
	println('遍历枚举值')
	$for e in Color2.values {
		print('$e.name => ')
		println(int(e.value))
	}
}

