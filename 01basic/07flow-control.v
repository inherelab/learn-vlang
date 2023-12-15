module main
// doc: https://lydiandylin.gitbook.io/vlang/mu-lu/flowcontrol

/*
if条件语句
*/
fn simple_if_case() {
	println('if条件语句')
	a := 10
	b := 20
	if a < b {
		println('$a < $b')
	} else if a > b {
		println('$a > $b')
	} else {
		println('$a == $b')
	}
}

fn use_if_assgin_val() {
	println('条件赋值(if表达式)')
	num := 777
	// 简单的条件赋值
	s := if num % 2 == 0 { 'even' } else { 'odd' }
	println(s)
	// "odd"
	// 多条件赋值
	a, b, c := if true { 1, 'awesome', 13 } else { 0, 'bad', 0 }
	println(a)
	println(b)
	println(c)
}

/*
match分支语句
match要求穷尽所有可能，所以基本都要带上else语句，else语句只能有一个。
*/
fn use_match_stat() {
	println('match分支语句')
	os := 'macos'
	match os {
		'windows' { println('windows') }
		'linux' { println('linux') }
		'macos' { println('macos') }
		else { println('unknow') }
	}

	println('match赋值(match表达式)')
	price := match os {
		'windows' { 100 }
		'linux' { 120 }
		'macos' { 150 }
		else { 0 }
	}
	println(price) //输出150

	//多变量match赋值
	val := 3
	a, b, c := match val {
		1 { 1, 2, 3 }
		2 { 4, 5, 6 }
		else { 7, 8, 9 }
	}
	println(a)
	println(b)
	println(c)

}

// match的同时，加上mut ，可以修改匹配变量，通常是配合for in 语句结合使用
/*
//参考代码
for stmt in file.stmts {
	match mut stmt {
		ast.ConstDecl {
			c.stmt(*it)
		}
		else {}
	}
}
*/


// 使用match判断联合类型的具体类型
struct User {
	name string
	age  int
}

pub fn (m &User) str() string {
	return 'name:$m.name,age:$m.age'
}

type MySum = User | int | string //联合类型声明

pub fn (ms MySum) str() string {
	match ms { //如果函数的参数或者接收者是联合类型，可以使用match进一步判断类型
		int {
			return ms.str()
		}
		string {
			return ms // ms的类型是string
		}
		User {
			return ms.str() // ms的类型是User
		}
		// else { //如果之前的分支已经穷尽了所有可能，else语句不需要，如果没有穷尽所有可能，则else语句是必须的
		// 	return 'unknown'
		// }
	}
}

fn match_check_union_type() {
	println('使用match判断联合类型的具体类型')
	v := MySum(45)
	println(v.str())

	b := MySum('abc')
	println(b.str())

	c := MySum(User{age: 23, name: 'tom'})
	println(c.str())
}

/*
for 循环语句
for的四种形式：
1. 传统的：for i=0;i<100;i++ {}

*/
fn for_case01() {
	println('传统的for 循环')

	// NOTE: 为了简洁的目的，for里面的i默认就是mut可变的，不需要特别声明为mut，如果声明了编译器会报错
	for i := 0; i < 6; i++ {
		// 跳过4
		if i == 4 {
			continue
		}
		println(i)
	}

	mut a := 0
	for i := 0; i < 5; i++, a++ { // 递增可以包含多个变量
		println(a)
	}
}

fn main() {
	simple_if_case()

	use_if_assgin_val()

	use_match_stat()

	match_check_union_type()

	for_case01()
}