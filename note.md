指定返回值类型

```python
def f(x) -> int :
    return x * 2
```



lambda表达式

```python
lambda <parameters> : <expression>
```



高阶函数的应用：伪全局变量

```python
def print_max(rec = 0):
    def f(x):
        if x > rec:
            print(x)
            return print_max(x)
        else:
            return print_max(rec)
    return f

f = print_max
f = f(4) # 4
f = f(2)
f = f(5) # 5
```



@装饰器

```python
def trace(f):
    def traced(x):
        print("tracing...")
        return f(x)
    return traced
```

则

```python
@trace
def f(x):
    return x * 2
```

等价于

```python
def f(x):
    return x * 2
f = trace(f)
```

`trace`也可以是表达式



列表类似指针，直接赋值等价于引用，若要复制：

```python
a = [1, 4]
b = a[:] # 不切割
c = list(a)
```



`max(a, key = func)`：对`a`中元素`x`，求使得`func(x)`最大的`x`



**不可变**对象：`int(1), float(0.1), str('abc'), tuple((1, 2, 3))`

因此字符串对象不能直接更改单个字符

**可变**对象：`list([1, 2, 3]), dict({'a':1, 'b':3})`



函数的**可变**默认参数的行为类似当前作用域内的全局变量

```python
def f(s = []):
    s.append(3)
    return len(s)

f() # 1
f() # 2
f() # 3
```



迭代器（`list, tuple, dict, str, range`）

```python
it = iter([1, 2])
next(it) # 1
next(it) # 2
next(it) # StopIteration
```

可以用`for i in it`来枚举

`sort(it)`返回排序后的一个新`list`

`sorted(list)`返回反向迭代器

同时迭代：`for a, b in zip(list_a, list_b)`

`map(func, a)`等价于`iter([func(x) for x in a])`

`filter(func, a)`等价于`iter([x for x in a if func(x)])`



生成器（生成函数）

```python
def func():
    yield 1
    yield 2

it = func()
next(it) # 1
next(it) # 2
next(it) # StopIteration
```

每次调用`next`，从上一次结束运行的地方开始，继续运行到下一个`yield`

可用于节省内存

`yield from a`可以依次返回`a`中的值，`a`可以是`list`或生成器

```python
def f():
    yield 1
    return 2
    yield 3

list(f()) # [1]

def g():
    y = yield from f()
    yield y

list(g()) # [1, 2]
```



类`class`定义中的赋值语句创建一个所有实例共享的对象，是类自身的属性

但成员函数中的赋值语句创建实例自己的对象

`fun()`：共有属性

`_fun()`：半私有，**不应**从外部调用

`__fun()`：私有，**无法**从外部调用，本质是防止其被派生类覆盖

`__fun__()`：应当只被python调用，可用于运算符重载：例如`+`对应`__add__()`

[参考](http://thepythonbook.blogspot.com/2014/10/privatesuperprivate-and-semiprivate-and.html)



`class a(b)`：`a`继承`b`，并重载类变量或方法

此时`a`中的`super().fun(...)`等价于`b.fun(self, ...)`



类的各种`__fun__(self, ...)`：

`__type__`：类型转换，`type`可以是`bool, int, float, str`

`__repr__`：转换为python可计算的表达式，计算结果等于该实例

[其他](https://docs.python.org/3/reference/datamodel.html#special-method-names)



模块：用`import a`引入文件`a.py`，也可以`from a import b`

别名：`import numpy as np`，`from numpy import array as arr`

被直接运行的模块（`python a.py`），python会将全局变量`__name__`设置为`'__main__'`，可以此判断自己被直接运行还是被import



尾递归：递归的值被直接返回，而不用经过其他运算

```python
def frac(n):
    return 1 if n == 0 else n * frac(n-1)
```

不是尾递归，而

```python
def frac(n, prod = 1):
    return prod if n == 0 else frac(n - 1, prod * n)
```

是尾递归

优点：可将其优化至只需要常数的堆栈空间

```python
def frac(n, prod = 1):
    return prod if n == 0 else lambda: frac(n - 1, prod * n)
f = frac(9)
while callable(f):
    f = f()
```

