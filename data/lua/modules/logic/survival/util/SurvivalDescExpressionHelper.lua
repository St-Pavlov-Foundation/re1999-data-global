module("modules.logic.survival.util.SurvivalDescExpressionHelper", package.seeall)

local var_0_0 = class("SurvivalDescExpressionHelper")
local var_0_1

local function var_0_2(arg_1_0)
	var_0_1 = arg_1_0

	return ""
end

local var_0_3 = {
	hasAttrVal = false,
	min = math.min,
	max = math.max,
	floor = math.floor,
	ceil = math.ceil,
	abs = math.abs,
	check = var_0_2
}

setmetatable(var_0_3, {
	__index = function(arg_2_0, arg_2_1)
		local var_2_0 = 0
		local var_2_1

		arg_2_1, var_2_1 = string.gsub(arg_2_1, "out_", "")

		local var_2_2 = SurvivalConfig.instance.attrNameToId[arg_2_1]

		if not var_2_2 then
			logError("属性Key不存在" .. tostring(arg_2_1))

			return 0
		end

		local var_2_3 = (var_2_1 > 0 and arg_2_0.attrMapTotal or arg_2_0.attrMap)[var_2_2] or 0

		if var_2_3 then
			var_0_3.hasAttrVal = true
		end

		return var_2_3
	end
})

function var_0_0.parstDesc(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if string.nilorempty(arg_3_1) then
		return arg_3_1
	end

	var_0_1 = true
	var_0_3.attrMap = arg_3_2 or {}
	var_0_3.attrMapTotal = arg_3_3 or {}
	var_0_3.hasAttrVal = false

	local var_3_0 = string.gsub(arg_3_1, "%b{}", var_0_0._passExpressionStr)

	var_0_3.attrMap = nil
	var_0_3.attrMapTotal = nil

	return var_3_0, var_0_1
end

function var_0_0._passExpressionStr(arg_4_0)
	arg_4_0 = string.sub(arg_4_0, 2, #arg_4_0 - 1)

	local var_4_0 = loadstring(string.format("return %s, hasAttrVal", string.lower(arg_4_0)))

	if not var_4_0 then
		logError("解析表达式失败" .. arg_4_0)

		return arg_4_0
	end

	setfenv(var_4_0, var_0_3)

	local var_4_1, var_4_2, var_4_3 = pcall(var_4_0)

	if var_4_1 then
		return var_4_2
	else
		logError("执行表达式错误" .. arg_4_0)

		return arg_4_0
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
