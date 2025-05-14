module("modules.logic.versionactivity1_6.dungeon.model.VersionActivity1_6DungeonBossModel", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonBossModel", Activity149Model)
local var_0_1 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "Score"

function var_0_0.onInit(arg_1_0)
	var_0_0.super.onInit(arg_1_0)

	arg_1_0._receivedMsgInit = false
end

function var_0_0.reInit(arg_2_0)
	var_0_0.super.reInit(arg_2_0)
end

function var_0_0.isInBossFight(arg_3_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return false
	end

	return arg_3_0:checkBattleEpisodeType(DungeonEnum.EpisodeType.Act1_6DungeonBoss)
end

function var_0_0.checkBattleEpisodeType(arg_4_0, arg_4_1)
	local var_4_0 = DungeonModel.instance.curSendEpisodeId

	if not var_4_0 then
		return false
	end

	local var_4_1 = DungeonConfig.instance:getEpisodeCO(var_4_0)

	if not var_4_1 then
		return false
	end

	return var_4_1.type == arg_4_1
end

function var_0_0.onReceiveInfos(arg_5_0, arg_5_1)
	var_0_0.super.onReceiveInfos(arg_5_0, arg_5_1)

	if not arg_5_0._receivedMsgInit then
		arg_5_0:applyPreScoreToCurScore()

		arg_5_0._receivedMsgInit = true
	end
end

function var_0_0.getScorePrefValue(arg_6_0)
	local var_6_0 = PlayerModel.instance:getPlayerPrefsKey(var_0_1)

	return PlayerPrefsHelper.getNumber(var_6_0) or 0
end

function var_0_0.setScorePrefValue(arg_7_0, arg_7_1)
	local var_7_0 = PlayerModel.instance:getPlayerPrefsKey(var_0_1)

	PlayerPrefsHelper.setNumber(var_7_0, arg_7_1)
end

function var_0_0.SetOpenBossViewWithDailyBonus(arg_8_0, arg_8_1)
	arg_8_0._getDailyBonus = arg_8_1
end

function var_0_0.GetOpenBossViewWithDailyBonus(arg_9_0)
	return arg_9_0._getDailyBonus
end

var_0_0.instance = var_0_0.New()

return var_0_0
