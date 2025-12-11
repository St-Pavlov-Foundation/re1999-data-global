module("modules.logic.survival.util.SurvivalDescExpressionHelper", package.seeall)

local var_0_0 = class("SurvivalDescExpressionHelper")
local var_0_1

local function var_0_2(arg_1_0)
	var_0_1 = arg_1_0

	return ""
end

local function var_0_3(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 then
		return arg_2_1 or ""
	else
		return arg_2_2 or ""
	end
end

local var_0_4 = {
	hasAttrVal = false,
	min = math.min,
	max = math.max,
	floor = math.floor,
	ceil = math.ceil,
	abs = math.abs,
	check = var_0_2,
	condition = var_0_3
}

setmetatable(var_0_4, {
	__index = function(arg_3_0, arg_3_1)
		local var_3_0 = 0
		local var_3_1

		arg_3_1, var_3_1 = string.gsub(arg_3_1, "out_", "")

		local var_3_2 = SurvivalConfig.instance.attrNameToId[arg_3_1]

		if not var_3_2 then
			logError("属性Key不存在" .. tostring(arg_3_1))

			return 0
		end

		local var_3_3 = (var_3_1 > 0 and arg_3_0.attrMapTotal or arg_3_0.attrMap)[var_3_2] or 0

		if var_3_3 then
			var_0_4.hasAttrVal = true
		end

		return var_3_3
	end
})

function var_0_0.parstDesc(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if string.nilorempty(arg_4_1) then
		return arg_4_1
	end

	var_0_1 = true
	var_0_4.attrMap = arg_4_2 or {}
	var_0_4.attrMapTotal = arg_4_3 or {}
	var_0_4.hasAttrVal = false

	local var_4_0 = string.gsub(arg_4_1, "%b{}", var_0_0._passExpressionStr)

	var_0_4.attrMap = nil
	var_0_4.attrMapTotal = nil

	return var_4_0, var_0_1
end

function var_0_0._passExpressionStr(arg_5_0)
	arg_5_0 = string.sub(arg_5_0, 2, #arg_5_0 - 1)

	local var_5_0 = loadstring(string.format("return %s, hasAttrVal", string.lower(arg_5_0)))

	if not var_5_0 then
		logError("解析表达式失败" .. arg_5_0)

		return arg_5_0
	end

	setfenv(var_5_0, var_0_4)

	local var_5_1, var_5_2, var_5_3 = pcall(var_5_0)

	if var_5_1 then
		return var_5_2
	else
		logError("执行表达式错误" .. arg_5_0)

		return arg_5_0
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
