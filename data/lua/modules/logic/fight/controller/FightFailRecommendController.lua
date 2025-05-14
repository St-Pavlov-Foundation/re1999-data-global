module("modules.logic.fight.controller.FightFailRecommendController", package.seeall)

local var_0_0 = class("FightFailRecommendController", BaseController)
local var_0_1 = 2

function var_0_0.addConstEvents(arg_1_0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, arg_1_0._respBeginFight, arg_1_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_1_0._pushEndFight, arg_1_0)
end

function var_0_0.onClickRecommend(arg_2_0)
	local var_2_0 = arg_2_0:_getKey()

	PlayerPrefsHelper.deleteKey(var_2_0)
end

function var_0_0.needShowRecommend(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:_getKey()
	local var_3_1 = PlayerPrefsHelper.getString(var_3_0, "")
	local var_3_2 = string.splitToNumber(var_3_1, "#")
	local var_3_3 = var_3_2 and var_3_2[1]

	if not var_3_3 or var_3_3 ~= arg_3_1 then
		return false
	end

	local var_3_4 = var_3_2 and var_3_2[2]

	return var_3_4 and var_3_4 >= var_0_1
end

function var_0_0._respBeginFight(arg_4_0)
	local var_4_0 = FightModel.instance:getFightParam()

	arg_4_0._isReplay = var_4_0 and var_4_0.isReplay

	if arg_4_0._isReplay then
		return
	end

	local var_4_1 = var_4_0 and var_4_0.episodeId
	local var_4_2 = arg_4_0:_getKey()
	local var_4_3 = PlayerPrefsHelper.getString(var_4_2, "")
	local var_4_4 = string.splitToNumber(var_4_3, "#")
	local var_4_5 = var_4_4 and var_4_4[1]

	if var_4_5 and var_4_1 ~= var_4_5 then
		PlayerPrefsHelper.deleteKey(var_4_2)
	end
end

function var_0_0._pushEndFight(arg_5_0)
	local var_5_0 = FightModel.instance:getFightParam()

	arg_5_0._isReplay = var_5_0 and var_5_0.isReplay

	if arg_5_0._isReplay then
		arg_5_0._isReplay = nil

		return
	end

	local var_5_1 = FightModel.instance:getRecordMO()
	local var_5_2 = var_5_1 and var_5_1.fightResult ~= FightEnum.FightResult.Succ
	local var_5_3 = arg_5_0:_getKey()

	if var_5_2 then
		local var_5_4
		local var_5_5 = FightModel.instance:getFightParam()
		local var_5_6 = var_5_5 and var_5_5.episodeId

		if not var_5_6 then
			local var_5_7 = FightModel.instance:getFightReason()

			var_5_6 = var_5_7 and var_5_7.episodeId

			if not var_5_6 then
				return
			end
		end

		local var_5_8 = PlayerPrefsHelper.getString(var_5_3, "")
		local var_5_9 = string.splitToNumber(var_5_8, "#")
		local var_5_10 = var_5_9 and var_5_9[1]
		local var_5_11 = var_5_9 and var_5_9[2]

		if var_5_10 and var_5_10 == var_5_6 then
			var_5_11 = var_5_11 and var_5_11 + 1 or 1
		else
			var_5_10 = var_5_6
			var_5_11 = 1
		end

		if var_5_10 then
			PlayerPrefsHelper.setString(var_5_3, var_5_10 .. "#" .. var_5_11)
		end
	else
		PlayerPrefsHelper.deleteKey(var_5_3)
	end
end

function var_0_0._getKey(arg_6_0)
	return PlayerModel.instance:getMyUserId() .. "_" .. PlayerPrefsKey.FightFailEpisode
end

var_0_0.instance = var_0_0.New()

return var_0_0
