-----利用repeat ... until 语句实现continue功能
print("")
print("")
print("利用repeat ... until 语句实现continue功能")
for i = 10, 1, -1 do
	repeat

		if i == 5 then
			print("continue code here")
			break
		end
		print(i, "loop code here")

	until true
end

--[[
输出结果:
10	loop code here
9	loop code here
8	loop code here
7	loop code here
6	loop code here
continue code here
4	loop code here
3	loop code here
2	loop code here
1	loop code here]]

print("")
print("")
print("函数作为参数传给另外一个函数")
function addFunc(num1, num2, print)
	local result = num1 + num2

	return print(result)
end

function myPrint(param)
	return "####\t" .. param .. "\t###"
end

print(addFunc(1, 2, myPrint))

--[[

输出结果:
####	3	###

]]

print("")
print("")
print("使用 " .. "\"...\"" .. " 代表可变参数 ")

function add(...)
	local s = 0
	for i, v in ipairs { ... } do
		s = s + v
	end
	return s
end

print("Example<1-1>:add(1,2,3) ")
print(add(1, 2, 3))

--[[

输出结果:
1+2+3 = 6

]]
print("Example<1-2>:add(1,2)")
print(add(1, 2))

--[[

输出结果:
1+2 = 3

]]
print("")
function average(...)

	local result = 0
	local args = { ... }

	for i, v in ipairs(args) do
		result = result + v
	end

	print("总共传入" .. #args .. "个参数")
	print("平均数为:" .. result / #args)

end

print("Example<2-1>")
print(average(1, 2, 3))

--[[

输出结果:
(1+2+3)/3 = 2

]]


