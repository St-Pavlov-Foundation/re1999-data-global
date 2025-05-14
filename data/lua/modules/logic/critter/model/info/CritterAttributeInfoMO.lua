module("modules.logic.critter.model.info.CritterAttributeInfoMO", package.seeall)

local var_0_0 = pureTable("CritterAttributeInfoMO")
local var_0_1 = {}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or var_0_1
	arg_1_0.attributeId = arg_1_1.attributeId or 0
	arg_1_0.value = arg_1_1.value and math.floor(arg_1_1.value / 10000) or 0
	arg_1_0.rate = arg_1_1.rate or 0
	arg_1_0._addRate = arg_1_1.addRate or 0
end

function var_0_0.setAttr(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.attributeId = arg_2_1
	arg_2_0.value = arg_2_2
end

function var_0_0.getConfig(arg_3_0)
	return CritterConfig.instance:getCritterAttributeCfg(arg_3_0.attributeId)
end

function var_0_0.getName(arg_4_0)
	return arg_4_0:getConfig().name
end

function var_0_0.getIcon(arg_5_0)
	return arg_5_0:getConfig().icon
end

function var_0_0.getValueNum(arg_6_0)
	return arg_6_0.value
end

function var_0_0.getAdditionRate(arg_7_0)
	return arg_7_0._addRate
end

function var_0_0.getIsAddition(arg_8_0)
	return arg_8_0._addRate and arg_8_0._addRate ~= 0
end

function var_0_0.getRate(arg_9_0)
	if arg_9_0.rate then
		return math.floor(arg_9_0.rate * 0.01) * 0.01
	end
end

function var_0_0.getRateStr(arg_10_0)
	local var_10_0 = arg_10_0:getRate()

	if var_10_0 then
		local var_10_1 = luaLang("critter_attr_rate")

		return GameUtil.getSubPlaceholderLuaLangOneParam(var_10_1, var_10_0)
	end

	return ""
end

function var_0_0.getaddRateStr(arg_11_0)
	if arg_11_0:getIsAddition() then
		local var_11_0 = luaLang("room_critter_Attribute_Addition")

		return GameUtil.getSubPlaceholderLuaLangOneParam(var_11_0, math.floor(arg_11_0._addRate * 0.01))
	end

	return ""
end

return var_0_0
