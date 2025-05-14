module("modules.logic.rouge.controller.RougeCollectionExpressionHelper", package.seeall)

local var_0_0 = _M
local var_0_1 = {
	__index = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_0.attrMap and arg_1_0.attrMap[arg_1_1]

		if not var_1_0 then
			logError(string.format("尝试解析造物描述失败!!! 失败原因: 无法匹配属性Flag:%s", arg_1_1))
		end

		var_1_0 = var_1_0 or 0

		if var_1_0 > 0 then
			arg_1_0.hasAttrMuchZero = true
		end

		return var_1_0
	end
}
local var_0_2 = {
	hasAttrMuchZero = false,
	min = math.min,
	max = math.max,
	attrMap = {}
}

setmetatable(var_0_2, var_0_1)

function var_0_0.getCollectionAttrMap(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 then
		local var_2_0 = RougeCollectionModel.instance:getCollectionByUid(arg_2_0)

		return var_0_0._buildCollectionAttrMap2(var_2_0)
	else
		return var_0_0._buildCollectionAttrMap(arg_2_1, arg_2_2)
	end
end

function var_0_0._buildCollectionAttrMap(arg_3_0, arg_3_1)
	local var_3_0 = RougeCollectionConfig.instance:getCollectionStaticAttrValueMap(arg_3_0)

	return (var_0_0._computeAttrValue(arg_3_1, var_3_0))
end

function var_0_0._buildCollectionAttrMap2(arg_4_0)
	if not arg_4_0 then
		return
	end

	local var_4_0 = arg_4_0:getAttrValueMap()

	if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(arg_4_0.id) then
		return var_4_0
	end

	local var_4_1 = var_0_0._buildCollectionAttrMap(arg_4_0.cfgId, arg_4_0:getAllEnchantCfgId())

	if var_4_0 then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			var_4_1[iter_4_0] = (var_4_1[iter_4_0] or 0) + iter_4_1
		end
	end

	return var_4_1
end

function var_0_0._computeAttrValue(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_0 and arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			if iter_5_1 > 0 and arg_5_1[iter_5_1] then
				for iter_5_2, iter_5_3 in pairs(arg_5_1[iter_5_1]) do
					local var_5_1 = RougeCollectionConfig.instance:getCollectionAttrByFlag(iter_5_2)
					local var_5_2 = var_5_1 and var_5_1.id or 0

					var_5_0[var_5_2] = var_5_0[var_5_2] or 0
					var_5_0[var_5_2] = var_5_0[var_5_2] + iter_5_3
				end
			end
		end
	end

	return var_5_0
end

local var_0_3 = "#CCFF99"

function var_0_0.getDescExpressionResult(arg_6_0, arg_6_1)
	if string.nilorempty(arg_6_0) or not arg_6_1 then
		return arg_6_0
	end

	return (string.gsub(arg_6_0, "%b{}", function(arg_7_0)
		return var_0_0._loadAndExecuteExpressionFunc(arg_7_0, arg_6_1)
	end))
end

function var_0_0._loadAndExecuteExpressionFunc(arg_8_0, arg_8_1)
	arg_8_0 = string.gsub(arg_8_0, "{", "")
	arg_8_0 = string.gsub(arg_8_0, "}", "")

	local var_8_0 = var_0_0._loadExpressionFunc(arg_8_0)
	local var_8_1 = var_0_0._buildGsubExperisonEnv(arg_8_1)

	setfenv(var_8_0, var_8_1)

	local var_8_2, var_8_3 = var_8_0()

	if var_8_3 then
		var_8_2 = string.format("<%s>%s</color>", var_0_3, var_8_2)
	end

	return var_8_2
end

function var_0_0._loadExpressionFunc(arg_9_0)
	local var_9_0 = string.format("return %s, hasAttrMuchZero", string.lower(arg_9_0))
	local var_9_1 = loadstring(var_9_0)

	if not var_9_1 then
		logError("肉鸽造物描述表达式解析失败: 文本内容:" .. tostring(arg_9_0))

		return arg_9_0
	end

	return var_9_1
end

function var_0_0._buildGsubExperisonEnv(arg_10_0)
	local var_10_0 = var_0_2

	var_10_0.hasAttrMuchZero = false
	var_10_0.attrMap = var_0_0._buildAttrNameAndValueMap(arg_10_0)

	return var_10_0
end

function var_0_0._buildAttrNameAndValueMap(arg_11_0)
	local var_11_0 = RougeCollectionConfig.instance:getAllCollectionAttrMap()
	local var_11_1 = {}

	if var_11_0 then
		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			var_11_1[iter_11_1.flag] = arg_11_0[iter_11_0] or 0
		end
	end

	return var_11_1
end

return var_0_0
