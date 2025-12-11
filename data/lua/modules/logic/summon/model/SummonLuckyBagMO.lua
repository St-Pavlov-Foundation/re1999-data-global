module("modules.logic.summon.model.SummonLuckyBagMO", package.seeall)

local var_0_0 = pureTable("SummonLuckyBagMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.luckyBagIdUseDic = {}
	arg_1_0.luckyBagIdGotDic = {}
	arg_1_0.summonTimes = 0
	arg_1_0.openedTimes = 0
	arg_1_0.getTimes = 0
	arg_1_0.notSSRCount = 0
end

function var_0_0.update(arg_2_0, arg_2_1)
	local var_2_0 = 0
	local var_2_1 = 0

	if arg_2_1.singleBagInfos and #arg_2_1.singleBagInfos > 0 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.singleBagInfos) do
			if iter_2_1.isOpen then
				var_2_0 = var_2_0 + 1
			end

			var_2_1 = var_2_1 + 1
			arg_2_0.luckyBagIdGotDic[iter_2_1.bagId] = iter_2_1.bagId
			arg_2_0.luckyBagIdUseDic[iter_2_1.bagId] = iter_2_1.isOpen
		end
	end

	arg_2_0.openedTimes = var_2_0
	arg_2_0.getTimes = var_2_1
	arg_2_0.summonTimes = arg_2_1.count or 0
	arg_2_0.notSSRCount = arg_2_1.notSSRCount or 0
end

function var_0_0.isGot(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return arg_3_0.getTimes > 0
	else
		if arg_3_0.luckyBagIdGotDic == nil then
			return false
		end

		return arg_3_0.luckyBagIdGotDic[arg_3_1] ~= nil
	end
end

function var_0_0.isOpened(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return arg_4_0:isGot() and arg_4_0.getTimes <= arg_4_0.openedTimes
	else
		if arg_4_0.luckyBagIdUseDic == nil then
			return false
		end

		return arg_4_0.luckyBagIdUseDic[arg_4_1]
	end
end

function var_0_0.getOpenTimes(arg_5_0)
	return arg_5_0.openedTimes or 0
end

return var_0_0
