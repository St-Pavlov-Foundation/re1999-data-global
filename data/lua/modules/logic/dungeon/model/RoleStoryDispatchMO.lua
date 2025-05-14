module("modules.logic.dungeon.model.RoleStoryDispatchMO", package.seeall)

local var_0_0 = pureTable("RoleStoryDispatchMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.storyId = arg_1_2
	arg_1_0.config = RoleStoryConfig.instance:getDispatchConfig(arg_1_1)
	arg_1_0.heroIds = {}
	arg_1_0.gainReward = false
	arg_1_0.endTime = 0
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.endTime = tonumber(arg_2_1.endTime)
	arg_2_0.gainReward = arg_2_1.gainReward
	arg_2_0.heroIds = {}

	for iter_2_0 = 1, #arg_2_1.heroIds do
		arg_2_0.heroIds[iter_2_0] = arg_2_1.heroIds[iter_2_0]
	end

	arg_2_0:clearFinishAnimFlag()
	arg_2_0:clearRefreshAnimFlag()
end

function var_0_0.updateTime(arg_3_0, arg_3_1)
	arg_3_0.endTime = tonumber(arg_3_1.endTime)
end

function var_0_0.completeDispatch(arg_4_0)
	arg_4_0.gainReward = true

	arg_4_0:clearRefreshAnimFlag()
end

function var_0_0.resetDispatch(arg_5_0)
	arg_5_0.endTime = 0
	arg_5_0.heroIds = {}
end

function var_0_0.getDispatchState(arg_6_0)
	if arg_6_0.gainReward then
		return RoleStoryEnum.DispatchState.Finish
	end

	if arg_6_0.endTime > 0 then
		if ServerTime.now() >= arg_6_0.endTime * 0.001 then
			return RoleStoryEnum.DispatchState.Canget
		else
			return RoleStoryEnum.DispatchState.Dispatching
		end
	end

	local var_6_0 = arg_6_0.config.unlockEpisodeId

	if var_6_0 == 0 or DungeonModel.instance:hasPassLevelAndStory(var_6_0) then
		return RoleStoryEnum.DispatchState.Normal
	end

	return RoleStoryEnum.DispatchState.Locked
end

function var_0_0.getEffectHeros(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0.config.effectCondition

	if string.nilorempty(var_7_1) then
		return var_7_0
	end

	local var_7_2 = GameUtil.splitString2(var_7_1, true)
	local var_7_3 = var_7_2[1][1]
	local var_7_4 = var_7_2[3]

	if var_7_3 == RoleStoryEnum.EffectConditionType.Heros then
		for iter_7_0, iter_7_1 in ipairs(var_7_4) do
			var_7_0[iter_7_1] = true
		end
	elseif var_7_3 == RoleStoryEnum.EffectConditionType.Career then
		local var_7_5 = HeroConfig.instance:getHeroesList()
		local var_7_6 = {}

		for iter_7_2, iter_7_3 in ipairs(var_7_4) do
			var_7_6[iter_7_3] = 1
		end

		for iter_7_4, iter_7_5 in ipairs(var_7_5) do
			if var_7_6[iter_7_5.career] then
				var_7_0[iter_7_5.id] = true
			end
		end
	end

	return var_7_0
end

function var_0_0.isMeetEffectCondition(arg_8_0)
	return arg_8_0:checkHerosMeetEffectCondition(arg_8_0.heroIds)
end

function var_0_0.checkHerosMeetEffectCondition(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.config.effectCondition

	if string.nilorempty(var_9_0) then
		return false
	end

	local var_9_1 = GameUtil.splitString2(var_9_0, true)
	local var_9_2 = var_9_1[1][1]
	local var_9_3 = var_9_1[2][1] or 0
	local var_9_4 = var_9_1[3]

	if var_9_2 == RoleStoryEnum.EffectConditionType.Heros then
		local var_9_5 = 0

		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			for iter_9_2, iter_9_3 in ipairs(var_9_4) do
				if iter_9_1 == iter_9_3 then
					var_9_5 = var_9_5 + 1

					break
				end
			end
		end

		return var_9_3 <= var_9_5
	elseif var_9_2 == RoleStoryEnum.EffectConditionType.Career then
		local var_9_6 = 0
		local var_9_7 = {}

		for iter_9_4, iter_9_5 in ipairs(var_9_4) do
			var_9_7[iter_9_5] = 1
		end

		for iter_9_6, iter_9_7 in ipairs(arg_9_1) do
			if var_9_7[HeroConfig.instance:getHeroCO(iter_9_7).career] then
				var_9_6 = var_9_6 + 1
			end
		end

		return var_9_3 <= var_9_6
	end

	return false
end

function var_0_0.getEffectAddRewardCount(arg_10_0)
	local var_10_0 = arg_10_0.config.effect

	return ((string.splitToNumber(var_10_0, "_")[2] or 1) - 1) * arg_10_0.config.scoreReward
end

function var_0_0.getEffectDelTimeCount(arg_11_0)
	local var_11_0 = arg_11_0.config.effect

	return string.splitToNumber(var_11_0, "_")[1] or 0
end

function var_0_0.isNewFinish(arg_12_0)
	local var_12_0 = arg_12_0:getDispatchState()
	local var_12_1 = arg_12_0.lastState

	arg_12_0.lastState = var_12_0

	if var_12_0 == RoleStoryEnum.DispatchState.Canget and var_12_1 == RoleStoryEnum.DispatchState.Dispatching then
		return true
	end
end

function var_0_0.checkFinishAnimIsPlayed(arg_13_0)
	local var_13_0 = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, arg_13_0.storyId, arg_13_0.id)

	return PlayerPrefsHelper.getNumber(var_13_0, 0) == 1
end

function var_0_0.clearFinishAnimFlag(arg_14_0)
	if arg_14_0:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
		return
	end

	local var_14_0 = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, arg_14_0.storyId, arg_14_0.id)
	local var_14_1 = 0

	PlayerPrefsHelper.setNumber(var_14_0, var_14_1)
end

function var_0_0.setFinishAnimFlag(arg_15_0)
	if arg_15_0:getDispatchState() ~= RoleStoryEnum.DispatchState.Finish then
		return
	end

	local var_15_0 = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, arg_15_0.storyId, arg_15_0.id)
	local var_15_1 = 1

	PlayerPrefsHelper.setNumber(var_15_0, var_15_1)
end

function var_0_0.canPlayRefreshAnim(arg_16_0)
	if arg_16_0:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	local var_16_0 = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, arg_16_0.storyId, arg_16_0.id)

	return PlayerPrefsHelper.getNumber(var_16_0, 0) == 0
end

function var_0_0.clearRefreshAnimFlag(arg_17_0)
	local var_17_0 = arg_17_0:getDispatchState()

	if var_17_0 == RoleStoryEnum.DispatchState.Finish or var_17_0 == RoleStoryEnum.DispatchState.Locked then
		local var_17_1 = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, arg_17_0.storyId, arg_17_0.id)
		local var_17_2 = 0

		PlayerPrefsHelper.setNumber(var_17_1, var_17_2)
	end
end

function var_0_0.setRefreshAnimFlag(arg_18_0)
	if arg_18_0:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	local var_18_0 = string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, arg_18_0.storyId, arg_18_0.id)
	local var_18_1 = 1

	PlayerPrefsHelper.setNumber(var_18_0, var_18_1)
end

return var_0_0
