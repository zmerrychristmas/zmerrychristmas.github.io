---
title: Loop with decrement order in Python, Ruby, PHP.
categories:
- Fullstack
- Python
tags:
- python
- ruby
- php
- loop
- for-loop
---

# Loop in decrease mode
## Python
In Python, decrement is not clearly supported by syntax.
By default, the loop is used to iterate over the sequence: a list, a tuple, a dictionary, a set, or a string.
```python
For <variable> in range(start index, stop index, step) 
```
1. Variable: A variable is a value that starts from the start index and ends at the stop index in for loop.
1. Start index: It is an optional value. If not passed, it starts from 0. It is the integer value from which the for loop value gets starts iterating.
1. Stop index: It is the integer value from which the for loop value gets stops iterating.
Step: It is the optional value. If not passed it increment the value by 1. It is an integer value that defines the increment and decrement of the loop.
	
### 1. Using Start, Stop Index, and step to Decrement for loop in Python 
```python
#Start index and stop index value
startindex = 10
stopindex = 0
step = -1
 
#applying for loop
for i in range(startindex, stopindex, step):
    print(i)
```
### 2. Using reversed() Function to Decrement for loop in Python
Reversed() function is used to loop over a sequence in reverse order
```python
#applying reversed() function 
for i in reversed(range(5)):
    print('Output : ',i)
```
### 3. Using while
This way look isn't an elegant way, but while was introduction is an infinite loop. So everything is hard to approach you can start to think about using while
```py
#applying while and -= operation
s = 10
while s>0:
    print("Output : ",s)
    s -= 1
```
## Ruby
First way:
```ruby
for i in (10).downto(0)
  puts i
end
```
Second way:
```ruby
(10).downto(0) do |i|
  puts i
end
```
Third way:
```ruby
i=10;
until i<0
  puts i
  i-=1
end
```
Four way:
```ruby
i = 10
while i > 0
  i -= 1
end
```
## PHP
Elegant way:
```php
for($i=10,$j=1;$i>=1;$i--)
{
    echo $i.'<br>';
    echo $j.'<br>';
    $j++;
}
```
