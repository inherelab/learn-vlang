module main
// doc: https://lydiandylin.gitbook.io/vlang/mu-lu/map

fn map_define_case() {
	mut m := map[string]int{} //字面量创建字典
	m['one'] = 1 //如果key不存在，则是新增
	m['one'] = 11 //如果key存在，则是修改
	m['two'] = 2
	println(m['one']) //返回对应的value
	println(m['bad_key']) // 如果指定key不存在,返回该类型的默认值，0

	println(m.len) // 返回2
}

enum Token {
	aa = 2
	bb
	cc
}

/*
map的key除了string类型，也可以是其他任何类型。
*/
fn other_type_key() {
	println('非字符串key')
	// int key 整数
	mut m1 := map[int]int{}
	m1[3] = 9
	m1[4] = 16
	println(m1)
	// voidptr key 通用指针
	mut m2 := map[voidptr]string{}
	v := 5
	m2[&v] = 'var'
	m2[&m2] = 'map'
	println(m2)
	// rune key unicode码
	mut m3 := {
		`!`: 2 //是反引号`,不是单引号'
		`%`: 3
	}
	println(typeof(m3).name) // map[rune]int
	println(m3)
	// u8 key 字节
	mut m4 := map[u8]string{}
	m4[u8(1)] = 'a'
	m4[u8(2)] = 'b'
	println(m4)
	// float key 小数
	mut m5 := map[f64]string{}
	m5[1.2] = 'a'
	m5[2.0] = 'b'
	println(m5)
	// enum key 枚举值
	mut m6 := map[Token]string{}
	m6[Token.aa] = 'abc'
	m6[Token.bb] = 'def'
	println(m6)
}

/*
map字面量初始化，编译器会进行类型推断：
*/
fn map_define_case2() {
	println('map字面量初始化')
	m := {
		'one':   1
		'two':   2
		'three': 3
	}
	m2 := {
		1: 'a'
		2: 'b'
		3: 'c'
	}
	println(m)
	println(m2)
}

/*
in操作符
判断某一个元素是否包含在map的key中
*/
fn check_key_in_map() {
 	println('检查key是否在map的keys里')
    mut m := map[string]int{}
    m['one'] = 1
    m['two'] = 2
    println('one' in m) //返回true
    println('three' in m) //返回false
}

fn for_in_map() {
 	println('遍历map')
	mut m := map[string]int{}
	m['one'] = 1
	m['two'] = 2
	m['three'] = 3
	for key, value in m {
		println('key:$key,value:$value')
	}
	for key, _ in m {
		println('key:$key')
	}
	for _, value in m {
		println('value:$value')
	}
}


fn delete_elem_on_map() {
	println('删除字典成员')
	mut m := map[string]int{} //字面量创建字典
	m['one'] = 1 //如果key不存在，则是新增
	m['one'] = 11 //如果key存在，则是修改
	m['two'] = 2
	println(m['two'])
	m.delete('two') //删除字典成员
	println(m['two']) //不存在返回默认值0
}

fn err_on_access_map() {
	println('访问字典成员错误处理')
	sm := {
		'abc': 'xyz'
	}
	val := sm['bad_key']
	println(val) // 如果字典元素不存在,会返回该类型的默认值: 空字符串

	intm := {
		1: 1234
		2: 5678
	}
	s := intm[3]
	println(s) // 如果字典元素不存在,会返回该类型的默认值:0
	
	//也可以加上or代码块来进行错误处理
	mut mm := map[string]int{}
	mm['abc'] = 1
	val2 := mm['bad_key'] or { panic('key not found') } //如果元素不存在,在or代码块中进行错误处理
	println(val2)
	val3 := mm['bad_key'] or { 100 } //如果元素不存在,也可以在or代码块中返回默认值,类型必须和字典的value类型一致
	println(val3)
	if val4 := mm['abc'] { //如果元素存在,赋值成功,才执行
		println(val4)
	}
	myfn() or { panic(err) }
}

fn myfn() ! {
	mm := map[string]int{}
	x := mm['bad_key']! //也可以本层级不处理,向上抛转错误
	println(x)
}

fn main() {
    map_define_case()

    map_define_case2()

    other_type_key()

    check_key_in_map()

    for_in_map()
delete_elem_on_map()
    err_on_access_map()
}

