# v 模板引擎语法

> from: https://github.com/vlang/v/blob/master/vlib/v/TEMPLATES.md


V 允许轻松使用文本模板，在编译时扩展到 V 函数，从而有效地生成文本输出。这对于模板化的 HTML 视图特别有用，但该机制足够通用，也可以用于其他类型的文本输出。


## 渲染输出

V 有一个用于文本和 html 模板的简单模板语言，并且可以通过 `$tmpl('path/to/template.txt')` 轻松嵌入它们

```go
fn build() string {
	name := 'Peter'
	age := 25
	numbers := [1, 2, 3]
	return $tmpl('1.txt')
}

fn main() {
	println(build())
}
```

模板文件 `my.tpl`:

```tpl
name: @name

age: @age

numbers: @numbers

@for number in numbers
  @number
@end
```

**输出：**

```txt
name: Peter

age: 25

numbers: [1, 2, 3]

1
2
3
```

## 模板指令

每个模板指令都以 `@` 符号开头。有些指令包含 `{}` 块，有些指令只有 `''`（字符串）参数。

开头和结尾的换行符在 `{}` 块中被忽略，否则（有关此语法，请参阅 [if](#if)）：

```html
@if bool_val {
    <span>This is shown if bool_val is true</span>
}
```

... would output:

```html
    <span>This is shown if bool_val is true</span>
```

### if

if 指令由三部分组成，'@if' 标签、条件（与 V 中的语法相同）和 '{}' 块，您可以在其中编写 html，如果条件为 true，它将被呈现：

```
@if <condition> {}
```

#### if 使用示例

```html
@if bool_val {
    <span>This is shown if bool_val is true</span>
}
```

**一行写法**:

```html
@if bool_val { <span>This is shown if bool_val is true</span> }
```

第一种写法输出:

```html
    <span>This is shown if bool_val is true</span>
```

... 使用一行写法输出:

```html
<span>This is shown if bool_val is true</span>
```

### for 

for 指令由三部分组成，'@for' 标签、条件（与 V 中的语法相同）和 '{}' 块，您可以在其中编写文本，为循环的每次迭代呈现：

```
@for <condition> {}
```

#### for 使用示例

```html
@for i, val in my_vals {
    <span>$i - $val</span>
}
```

示例将输出：

```html
    <span>0 - "First"</span>
    <span>1 - "Second"</span>
    <span>2 - "Third"</span>
    ...
```

一行写法:

```html
@for i, val in my_vals { <span>$i - $val</span> }
```

示例将输出：

```html
<span>0 - "First"</span>
<span>1 - "Second"</span>
<span>2 - "Third"</span>
...
```

您还可以编写（以及 V 中允许的所有其他条件语法）：

```html
@for i = 0; i < 5; i++ {
    <span>$i</span>
}
```

### include

include 指令用于包含其他 html 文件（也将被处理），由两部分组成，'@include' 标签和后面的 ''


#### 使用模板的项目文件夹结构示例：

```
Project root
/templates
    - index.html
    /headers
        - base.html
```

`index.html`

```html

<div>@include 'header/base'</div>
```


> 请注意，不应该有文件后缀，它会自动附加并且只允许 `html` 文件。


### js

js 指令由两部分组成，`@js` 标签和 `'<path>'` 

```
@js '<url>'
```

#### js 指令示例：

```html
@js 'myscripts.js'
```

## 变量


在 `$tmpl` 之前声明的所有变量都可以通过 `@{my_var}` 语法使用。也可以在这里使用结构的属性，如 `@{my_struct.prop}`。


