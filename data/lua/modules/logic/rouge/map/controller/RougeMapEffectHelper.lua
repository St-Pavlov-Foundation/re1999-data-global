module("modules.logic.rouge.map.controller.RougeMapEffectHelper", package.seeall)

local var_0_0 = class("RougeMapEffectHelper")

function var_0_0.checkHadEffect(arg_1_0, arg_1_1)
	local var_1_0 = RougeModel.instance:getEffectDict()

	if not var_1_0 then
		return false
	end

	var_0_0._initEffectHandle()

	local var_1_1 = var_0_0.effectHandleDict[arg_1_0]

	if not var_1_1 then
		return false
	end

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_1.type == arg_1_0 and var_1_1(iter_1_1, arg_1_1) then
			return true
		end
	end

	return false
end

function var_0_0._initEffectHandle()
	if not var_0_0.effectHandleDict then
		var_0_0.effectHandleDict = {
			[RougeMapEnum.EffectType.UnlockRestRefresh] = var_0_0.defaultCheck,
			[RougeMapEnum.EffectType.UnlockFightDropRefresh] = var_0_0._checkUnlockFightDropRefresh,
			[RougeMapEnum.EffectType.UnlockShowPassFightMask] = var_0_0._checkUnlockShowPassFightMask
		}
	end
end

function var_0_0.defaultCheck(arg_3_0)
	return true
end

function var_0_0._checkUnlockFightDropRefresh(arg_4_0, arg_4_1)
	return string.splitToNumber(arg_4_0.typeParam, "#")[1] == arg_4_1
end

function var_0_0._checkUnlockShowPassFightMask(arg_5_0, arg_5_1)
	return tonumber(arg_5_0.typeParam) == arg_5_1
end

return var_0_0
