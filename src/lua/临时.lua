--[[将多位数字的每一位存入到一个数组内
	数组中索引1的数字是最高位数字

]]
function getWeightNum(num)
	local t = {}
	if tonumber(num) == nil then
		return t
	end

	local length = #tostring(num)
	for i = length, 1, -1 do
		local s = math.floor(num / (10 ^ (i - 1)) % 10)
		table.insert(t, s)
	end

	return t
end


--local num = 98764
--local t = getWeightNum(num)
--print(t)
--t = {9,8,7,6,4}

