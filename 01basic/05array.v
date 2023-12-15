module main
// from: https://lydiandylin.gitbook.io/vlang/mu-lu/array

/*
数组
除了内置的基本类型外,数组和字典也是内置类型。

数组定义

根据首个元素的类型来决定数组的类型，
[1, 2, 3]的数组类型是[ ]int，
['a', 'b']的数组类型是[ ]string，
数组元素的类型必须是一样的，不允许异构数组，[1, 'a'] 编译不会通过。
*/

fn simple_case01() {
	arr := [1,2,3,4,5]  //字面量定义数组
	println(arr.data) //返回数组地址:0x7ff0d2c01270
	println(arr.len)  //返回5
	println(arr.cap)  //返回5
	println(arr.element_size) //返回4
}

/*
固定长度数组
对于固定长度数组来说，长度也是类型的一部分，[5]int和[6]int是两个不同的类型。
固定长度数组无法使用 << 追加元素。
*/
fn fixed_len_array() {
	println('固定长度数组')

	mut arr := [8]int{} //声明长度固定的数组,所有数组元素默认都是0值初始化
	println(arr[1]) //返回0
	arr = [0, 1, 2, 3, 4, 5, 6, 7]! //初始化,注意数组后面有个!,否则会报错
	
	for a in arr { //使用for in遍历固定长度数组
		println(a)
	}

	// arr = [0, 1, 2, 3, 4, 5, 6]! //报错,因为长度不匹配
	println(arr[1]) // 返回1
	println(arr[2]) // 返回2
	arr[2] = 222
	println(arr)
	println(arr.len) //固定长度数组,返回长度8

	// arr << 9 //报错,固定长度数组无法使用<<动态追加元素
	x := 2.32
	mut v := [8]f64{}
	println(v[1]) //返回0.000000
	v = [1.0, x, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]!
	println(v[1]) //赋值成功后,返回2.320000
}

/*
数组初始化
可以在定义数组时明确指定len，cap，init进行初始化。
也可以使用数组的索引值it，it是iterator迭代器的缩写，来动态地初始化数组元素值。
*/
fn init_array_case01() {
	println('数组初始化')
	//定义初始len为5,cap为20,初始值为10的数组
	mut arr := []int{len: 5, cap: 20, init: 10}
	println(arr) // 输出[10, 10, 10, 10, 10]
	println('info: len=$arr.len, cap=$arr.cap') //输出5,20
	arr << 3
	println(arr) // 输出[10, 10, 10, 10, 10, 3]

	// 使用index(老版本是it)来动态地初始化数组的元素值
	mut square := []int{len: 6, init: index * index}
	println(square) // 输出[0, 1, 4, 9, 16, 25]
}

/*
数组的追加运算符：<<可以把一个元素追加到数组中，也可以把一个数组追加到数组中。
实际使用中需要注意的是 << 运算符是采用值复制的方式追加到数组中。
*/
fn append_elem_to_arr() {
	println('数组的追加运算符：')

	mut nums := [1, 2, 3]
	println(nums) // "[1, 2, 3]"
	nums << 4 //把一个元素追加到数组中
	println(nums) // "[1, 2, 3, 4]"

	nums << [5, 6, 7] //把一个数组追加到数组中
	println(nums) // "[1, 2, 3, 4, 5, 6, 7]"
}

/*
in操作符 - 判断元素是否在数组里
!in操作符 - in的反操作符,判断元素是否不在数组里
*/
fn check_elem_exists() {
	println('判断元素是否在数组里')
	mut names := ['John']
	names << 'Peter'
	names << 'Sam'
	println('Alex' in names) //false
	println('Sam' in names) //true
	println('aa' !in names) //true

	println('遍历数组：')
	numbers := [1, 2, 3, 4, 5]
	for num in numbers {
		println('num:$num')
	}
	for i, num in numbers {
		println('i:$i,num:$num')
	}
}

/*
数组切片/区间
左闭右开原则
*/
fn split_elems_in_arr() {
	println('数组切片/区间')
	n := [1,2,3,4,5]
	println(n)
	println(n[..2])  //返回[1, 2]
	println(n[2..])  //返回[3, 4, 5]
	println(n[2..4]) //返回[3, 4]
	//区间支持负数的索引值，不过要在数组名后特别加一个#,否则会报错
	println(n#[-1..]) //返回[5]
	println(n#[-3..-1]) //返回[3,4]
}

/*
访问数组的错误处理
当访问数组成员的索引越界或者别的错误，可以使用or代码块来进行错误处理。
*/
fn error_handle_in_arr() {
	println('访问数组的错误处理')

	arr := [1, 2, 3]
	large_index := 999
	// var1:=arr[large_index] //直接报数组越界错误

	y := arr[large_index] or { 100 } //如果数组元素不存在,执行or代码块,可以返回默认值
	println(y)

	// 增加or代码块后,进行错误的处理
	x := arr[large_index] or { panic('out of bounds') }
	println(x)

	myfn() or { panic('myfn error') } //处理myfn向上抛的错误
}

fn myfn() ! {
	arr := [1, 2, 3]
	large_index := 999
	x := arr[large_index]! //也可以本层级不处理,向上抛错误
	println(x)
}

/*if语句判断数组成员是否存在*/
fn if_check_index() {
	println('if语句判断数组成员是否存在')
	mut a := [12.5, 6.5, -17.25]
	mut res := []f64{cap:2}

	for i in [1, 4] {
		// 检查数组a[i]是否存在,如果存在,则赋值,if条件返回true,如果不存在,则返回false
		if x := a[i] { 
			res << x
		} else {
			res << -23.0
		}
	}

	println(res)  //返回 [6.5, -23.0]
}

/*数组解构赋值
目前数组的解构赋值只能用在传递给不确定参数函数，不像js中那样灵活。*/

fn expand_to_variadic() {
	println('数组解构赋值')
	a := ['a', 'b', 'c']
	println(variadic_fn_b(...a)) //数组解构赋值后,传递给不确定参数数组
}
fn variadic_fn_b(a ...string) string {
	a0 := a[0]
	a1 := a[1]
	a2 := a[2]
	return '$a0,$a1,$a2'
}

/*
数组排序
V语言提供了一个内置的数组排序语法，不仅可以对基本类型数组进行排序，也可以对结构体类型数组进行排序。

数组内置函数
filter( )，map( )，any( )，all( )这四个内置函数都是在编译器内部实现的，比较特殊，
具体用法参考。
*/
struct User {
	age  int
	name string
}

fn array_sort_case() {
	println('数组排序')
	//基本类型数组
	mut numbers := [1, 3, 2]
	numbers.sort() // 1, 2, 3,默认升序,即 a < b,小于号表示从小到大
	println(numbers)
	numbers.sort(a > b) // 3, 2, 1,降序排序,即 a > b,大于号表示从大到小
	// numbers.sort(aa > bb) // 只能用a和b这两个变量名,其他变量名会编译不通过
	println(numbers)
	
	println('- 结构体类型数组')
	// 结构体类型数组
	mut users := [
		User{21, 'Bob'},
	 	User{20, 'Zarkon'},
		User{25, 'Alice'},
	]

	users.sort(a.age < b.age) //用结构体的某个字段进行排序
	println(users)
	users.sort(a.name < b.name) //字符串类型也可以排序
	println(users)
}

fn main() {
	simple_case01()

	fixed_len_array()

	init_array_case01()

	append_elem_to_arr()

	check_elem_exists()

	split_elems_in_arr()
	if_check_index()
	expand_to_variadic()
	array_sort_case()


	error_handle_in_arr()
}
