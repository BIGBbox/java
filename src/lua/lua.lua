-----利用repeat ... until 语句实现continue功能
for i = 10, 1, -1 do
	repeat

		if i == 5 then
			print("continue code here")
			break
		end
		print(i, "loop code here")

	until true
end

print("=======")

----函数作为参数传给另外一个函数
function addFunc(num1, num2, print)
	local result = num1 + num2

	return print(result)
end

function myPrint(param)
	return "####\t" .. param .. "\t###"
end

print(addFunc(1, 2, myPrint))


