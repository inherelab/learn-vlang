module main

/*
rune类型
rune是u32的类型别名，用4个字节来表示一个unicode字符/码点，跟string不是同一个类型。
rune使用反引号来表示。
*/
fn main() {
	println('rune类型:')

	s1 := 'a' //单引号，string类型
	s2 := "a" //双引号，string类型
	s3 := `a` //反引号，rune类型
	println(typeof(s1).name)
	println(typeof(s2).name)
	println(typeof(s3).name)
	println(int(s3)) // 97

	// c2 := `aa` // ERR: 编译不通过，报错，只能是单字符
	c3 := `中`
	println(typeof(c3).name) // rune类型
	println(sizeof(c3)) // 4个字节，unicode4.0
	println(int(c3)) // 20013
	println(c3)
}
