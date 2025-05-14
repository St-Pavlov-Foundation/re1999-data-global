module("modules.logic.versionactivity1_4.act129.model.Activity129Model", package.seeall)

local var_0_0 = class("Activity129Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.selectPoolId = nil
end

function var_0_0.setInfo(arg_3_0, arg_3_1)
	arg_3_0:getActivityMo(arg_3_1.activityId):init(arg_3_1)
end

function var_0_0.onLotterySuccess(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.rewards
	local var_4_1 = {}
	local var_4_2 = {}
	local var_4_3 = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_4 = var_4_0[iter_4_0]
		local var_4_5 = Activity129Config.instance:getRewardConfig(arg_4_1.poolId, var_4_4.rare, var_4_4.rewardType, var_4_4.rewardId)
		local var_4_6 = Activity129Config.instance:getPoolConfig(arg_4_1.activityId, arg_4_1.poolId)

		for iter_4_1 = 1, var_4_4.num do
			if var_4_4.rare == 5 then
				if var_4_6.type ~= Activity129Enum.PoolType.Unlimite then
					table.insert(var_4_2, var_4_5)
				end

				table.insert(var_4_1, var_4_5)
			else
				table.insert(var_4_3, var_4_5)
			end
		end
	end

	tabletool.addValues(var_4_1, var_4_3)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnShowSpecialReward, var_4_2, var_4_1)
	arg_4_0:getActivityMo(arg_4_1.activityId):onLotterySuccess(arg_4_1)
end

function var_0_0.getActivityMo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getById(arg_5_1)

	if not var_5_0 then
		var_5_0 = Activity129Mo.New(arg_5_1)

		arg_5_0:addAtLast(var_5_0)
	end

	return var_5_0
end

function var_0_0.getShopVoiceConfig(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:getHeroShopVoice(arg_6_1, arg_6_4)

	if not var_6_1 or not next(var_6_1) then
		return var_6_0
	end

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		if iter_6_1.type == arg_6_2 and (not arg_6_3 or arg_6_3(iter_6_1)) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_0.getHeroShopVoice(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}
	local var_7_1 = CharacterDataConfig.instance:getCharacterShopVoicesCo(arg_7_1)

	if not var_7_1 then
		return var_7_0
	end

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		if arg_7_0:_checkSkin(iter_7_1, arg_7_2) then
			var_7_0[iter_7_1.audio] = iter_7_1
		end
	end

	return var_7_0
end

function var_0_0._checkSkin(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		return false
	end

	if string.nilorempty(arg_8_1.skins) or not arg_8_2 then
		return true
	end

	return string.find(arg_8_1.skins, arg_8_2)
end

function var_0_0.setSelectPoolId(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.selectPoolId = arg_9_1

	if not arg_9_2 then
		Activity129Controller.instance:dispatchEvent(Activity129Event.OnEnterPool)
	end
end

function var_0_0.getSelectPoolId(arg_10_0)
	return arg_10_0.selectPoolId
end

function var_0_0.checkPoolIsEmpty(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0:getActivityMo(arg_11_1):checkPoolIsEmpty(arg_11_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
