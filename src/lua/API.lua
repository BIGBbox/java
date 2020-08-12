--- API.lua（服务端）
--- Powered By xx
--- DateTime: 2020/8/12 15:29

---如果`index`是一个数字，则返回第---`index`对应的实体参数。负数从末尾开始索引（-1是最后一个参数）。
---否则，`index`必须为字符串“＃”，而`select`返回---它收到的参数的总数。

local str = "1,2,3,4,5"
print(select(-1, 1, 2, 3, 4, 5) .. "")