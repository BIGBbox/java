--- 计算.lua（服务端）
--- Powered By 徐熊
--- DateTime: 2020/8/13 11:39
--[[

RedPointAB
RedPointM
RedPointCD
RedPointFM
RedpointA
RedpointB

]]


local str = "123456"

str = string.sub(str, #str - 4, #str)
print(tostring(str))

function funcName(player)
    local counts = 0    ---记录几天没登录过游戏
    for i = 1, 10 do
        local days = lualib:GetInt(player, "开服第" .. i .. "天")
        if days == 0 then
            counts = counts + 1
        end
    end

    ----计算疲劳值
    local tired = countsPiLao(counts) * 100

end

---
function countsPiLao(param)

    if param == 0 then
        return param
    end

    local value = countsPiLao(param - 1)
    return value + param

end


