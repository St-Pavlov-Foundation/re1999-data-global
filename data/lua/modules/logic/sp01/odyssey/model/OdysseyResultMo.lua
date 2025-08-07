module("modules.logic.sp01.odyssey.model.OdysseyResultMo", package.seeall)

local var_0_0 = pureTable("OdysseyResultMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._iswin = arg_1_1.result == OdysseyEnum.Result.Win
	arg_1_0._rewardList = arg_1_1.reward and arg_1_1.reward.rewards
	arg_1_0._element = arg_1_1.element
	arg_1_0._elementId = arg_1_1.element.id
	arg_1_0._resultconfig = OdysseyConfig.instance:getElementFightConfig(arg_1_0._elementId)
	arg_1_0._fighttype = arg_1_0._resultconfig.type
	arg_1_0._isMyth = arg_1_0._resultconfig.type == OdysseyEnum.FightType.Myth
	arg_1_0._isConquer = arg_1_0._resultconfig.type == OdysseyEnum.FightType.Conquer

	if arg_1_0._isMyth and arg_1_0._element and arg_1_0._element.mythicEle then
		local var_1_0 = arg_1_0._element.mythicEle

		arg_1_0._fightRecord = var_1_0.evaluation
		arg_1_0._fightFinishedTaskIds = var_1_0.finishedTaskIds
	end

	if arg_1_0._isConquer and arg_1_0._element and arg_1_0._element.conquestEle then
		arg_1_0._conquestEle = arg_1_0._element.conquestEle
	end
end

function var_0_0.getConquestEle(arg_2_0)
	return arg_2_0._conquestEle
end

function var_0_0.getElementId(arg_3_0)
	return arg_3_0._elementId
end

function var_0_0.checkFightTypeIsMyth(arg_4_0)
	return arg_4_0._isMyth
end

function var_0_0.checkFightTypeIsConquer(arg_5_0)
	return arg_5_0._isConquer
end

function var_0_0.getFightRecord(arg_6_0)
	return arg_6_0._fightRecord
end

function var_0_0.getFightFinishedTaskIdList(arg_7_0)
	return arg_7_0._fightFinishedTaskIds
end

function var_0_0.canShowMythSuccess(arg_8_0)
	return arg_8_0._fightFinishedTaskIds and #arg_8_0._fightFinishedTaskIds > 0
end

function var_0_0.getRewardList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._rewardList) do
		local var_9_1 = iter_9_1.itemReward
		local var_9_2 = iter_9_1.expReward
		local var_9_3 = iter_9_1.talentReward

		if var_9_1 and var_9_1.count > 0 then
			local var_9_4 = {
				rewardType = OdysseyEnum.ResultRewardType.Item
			}
			local var_9_5 = OdysseyConfig.instance:getItemConfig(var_9_1.itemId)

			var_9_4.itemType = var_9_5.type
			var_9_4.itemId = var_9_5.id
			var_9_4.count = var_9_1.count

			table.insert(var_9_0, var_9_4)
		end

		if var_9_2 and var_9_2.exp > 0 then
			local var_9_6 = {
				rewardType = OdysseyEnum.ResultRewardType.Exp,
				count = var_9_2.exp
			}

			table.insert(var_9_0, var_9_6)
		end

		if var_9_3 and var_9_3.point > 0 then
			local var_9_7 = {
				rewardType = OdysseyEnum.ResultRewardType.Talent,
				count = var_9_3.point
			}

			table.insert(var_9_0, var_9_7)
		end
	end

	return var_9_0
end

return var_0_0
