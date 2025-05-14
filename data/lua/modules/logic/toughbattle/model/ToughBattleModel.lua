module("modules.logic.toughbattle.model.ToughBattleModel", package.seeall)

local var_0_0 = class("ToughBattleModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._isActOnline = false
	arg_1_0._actInfo = nil
	arg_1_0._storyInfo = nil
	arg_1_0._isJumpToActElement = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getIsJumpActElement(arg_3_0)
	return arg_3_0._isJumpToActElement
end

function var_0_0.setIsJumpActElement(arg_4_0, arg_4_1)
	arg_4_0._isJumpToActElement = arg_4_1
end

function var_0_0.getActIsOnline(arg_5_0)
	return arg_5_0._isActOnline
end

function var_0_0.setActOffLine(arg_6_0)
	arg_6_0._isActOnline = false
	arg_6_0._actInfo = nil
end

function var_0_0.onGetActInfo(arg_7_0, arg_7_1)
	arg_7_0._isActOnline = true
	arg_7_0._actInfo = arg_7_1

	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.ToughBattleActChange)
end

function var_0_0.getActInfo(arg_8_0)
	return arg_8_0._actInfo
end

function var_0_0.isDropActItem(arg_9_0)
	if not arg_9_0:getActIsOnline() then
		return true
	end

	return #arg_9_0._actInfo.enterDifficulty < 3
end

function var_0_0.onGetStoryInfo(arg_10_0, arg_10_1)
	arg_10_0._storyInfo = arg_10_1
end

function var_0_0.getStoryInfo(arg_11_0)
	return arg_11_0._storyInfo
end

function var_0_0.isStoryFinish(arg_12_0)
	if not arg_12_0._storyInfo then
		return false
	end

	return arg_12_0._storyInfo.openChallenge and #arg_12_0._storyInfo.passChallengeIds >= 4
end

function var_0_0.getEpisodeId(arg_13_0)
	local var_13_0 = FightModel.instance:getFightParam()

	if not var_13_0 then
		return false
	end

	local var_13_1 = var_13_0.episodeId

	if not var_13_1 then
		return false
	end

	if not ToughBattleConfig.instance:getCoByEpisodeId(var_13_1) then
		return false
	end

	return var_13_1
end

function var_0_0.getAddTrialHeros(arg_14_0)
	local var_14_0 = arg_14_0:getEpisodeId()

	if not var_14_0 then
		return false
	end

	if not ToughBattleConfig.instance:getCoByEpisodeId(var_14_0) then
		return false
	end

	local var_14_1 = ToughBattleConfig.instance:isActEpisodeId(var_14_0)
	local var_14_2 = {}

	if var_14_1 then
		local var_14_3 = arg_14_0:getActInfo()

		if not var_14_3 then
			return false
		end

		for iter_14_0, iter_14_1 in ipairs(var_14_3.passChallengeIds) do
			local var_14_4 = lua_activity158_challenge.configDict[iter_14_1]

			if var_14_4 and var_14_4.heroId > 0 then
				local var_14_5 = lua_siege_battle_hero.configDict[var_14_4.heroId]

				if var_14_5 and var_14_5.type == ToughBattleEnum.HeroType.Hero then
					table.insert(var_14_2, tonumber(var_14_5.param))
				end
			end
		end
	else
		local var_14_6 = arg_14_0:getStoryInfo()

		if not var_14_6 then
			return false
		end

		for iter_14_2, iter_14_3 in ipairs(var_14_6.passChallengeIds) do
			local var_14_7 = lua_siege_battle.configDict[iter_14_3]

			if var_14_7 and var_14_7.heroId > 0 then
				local var_14_8 = lua_siege_battle_hero.configDict[var_14_7.heroId]

				if var_14_8 and var_14_8.type == ToughBattleEnum.HeroType.Hero then
					table.insert(var_14_2, tonumber(var_14_8.param))
				end
			end
		end
	end

	if not var_14_2[1] then
		return false
	end

	return var_14_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
