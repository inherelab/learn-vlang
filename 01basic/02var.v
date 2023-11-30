module main

// https://lydiandylin.gitbook.io/vlang/mu-lu/var
fn main() {
	x := 3
	s := 'abc'
	println(typeof(x).name) // int
	println(typeof(s).name) // string

	println('默认不可变:')
	not_change()

	println('多变量赋值:')
	f1()
	f2()
	f4()

	println('条件赋值:')
	var_by_if()
	println('匹配赋值:')
	var_by_match()
	println('强制类型转换:')
	force_conv_type()
}

/*
默认不可变
跟rust一样，变量默认不可变，要声明为可变，使用mut关键字：*/

fn not_change() {
	mut age := 20
	println(age)
	age = 21
	println(age)
}

fn f1() {
	a, b, c := 1, 3, 5 // 多变量声明并赋值
	println(a)
	println(b)
	println(c)
}

fn f2() {
	mut a := 1
	mut b := 2
	a, b = b, a // 交换
}

fn f4() {
	mut x, y := 1, 3 //注意，只有x是可以变的，y不可变
	println(x)
	println(y)
	mut a, mut b, mut c := 1, 2, 3 // a,b,c都是可变的
	println(a)
	println(b)
	println(c)
}

fn var_by_if() {
	d, e, f := if true {
		1, 'awesome', [13]
	} else {
		0, 'bad', [0]
	}

	println(d)
	println(e)
	println(f)
}

fn var_by_match() {
	a, b, c := match 2 {
		2 { 1, 2, 3 }
		1 { 4, 5, 6 }
		else { 7, 8, 9 }
	}

	println(a)
	println(b)
	println(c)
}

/*
强制类型转换
可以通过T() 对类型进行显示声明，或者强制类型转换
*/
fn force_conv_type() {
	x := int(3)
	y := u8(x)
	println('x is $x')
	println('y is $y, type: '+ typeof(y).name)

	z := f32(x)
	println('z is $z, type: '+ typeof(z).name)
	f := 1.2
	i := int(f)
	println(i) // 输出1，强制转换丧失精度
}