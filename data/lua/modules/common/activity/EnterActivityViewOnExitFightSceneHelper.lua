module("modules.common.activity.EnterActivityViewOnExitFightSceneHelper", package.seeall)

local var_0_0 = class("EnterActivityViewOnExitFightSceneHelper")

function var_0_0.checkCurrentIsActivityFight()
	var_0_0.recordMO = FightModel.instance:getRecordMO()

	local var_1_0 = DungeonModel.instance.curSendChapterId

	return var_0_0.checkIsActivityFight(var_1_0)
end

function var_0_0.checkIsActivityFight(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getChapterCO(arg_2_0)
	local var_2_1 = var_2_0 and var_2_0.actId or 0

	return var_2_1 ~= 0 and var_0_0["enterActivity" .. var_2_1]
end

function var_0_0.enterCurrentActivity(arg_3_0, arg_3_1)
	local var_3_0 = DungeonModel.instance.curSendChapterId
	local var_3_1 = DungeonConfig.instance:getChapterCO(var_3_0)
	local var_3_2 = var_3_1 and var_3_1.actId or 0

	var_0_0.enterActivity(var_3_2, arg_3_0, arg_3_1)
end

function var_0_0.enterActivity(arg_4_0, arg_4_1, arg_4_2)
	if ActivityHelper.getActivityStatus(arg_4_0) ~= ActivityEnum.ActivityStatus.Normal then
		DungeonModel.instance.curSendEpisodeId = nil

		MainController.instance:enterMainScene(arg_4_1)

		return
	end

	if arg_4_0 == 0 then
		return
	end

	local var_4_0 = var_0_0["enterActivity" .. arg_4_0]

	if not arg_4_2 then
		local var_4_1 = var_0_0["checkFightAfterStory" .. arg_4_0]

		if var_4_1 and var_4_1(var_4_0, arg_4_1, arg_4_2) then
			return
		end
	end

	if var_4_0 then
		var_4_0(arg_4_1, arg_4_2)
	end
end

function var_0_0.enterVersionActivityDungeonCommon(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = DungeonModel.instance.curSendChapterId
	local var_5_1 = DungeonModel.instance.curSendEpisodeId
	local var_5_2 = FightController.instance:isReplayMode(var_5_1)
	local var_5_3 = DungeonConfig.instance:getEpisodeCO(var_5_1)
	local var_5_4 = DungeonConfig.instance:getChapterCO(var_5_0).actId
	local var_5_5 = ActivityHelper.getActivityStatus(var_5_4)

	if ActivityEnum.ActivityStatus.Normal ~= var_5_5 then
		MainController.instance:enterMainScene(arg_5_1)

		return
	end

	if not arg_5_2 and var_5_2 then
		if var_0_0["enterFightAgain" .. var_5_4] then
			if var_0_0["enterFightAgain" .. var_5_4]() then
				return
			end
		else
			var_0_0.enterFightAgain()

			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_5_1)

	local var_5_6 = {
		episodeId = var_5_1,
		episodeCo = var_5_3,
		exitFightGroup = arg_5_2
	}

	SceneHelper.instance:waitSceneDone(SceneType.Main, arg_5_0, var_0_0, var_5_6)
end

function var_0_0.enterFightAgain()
	GameSceneMgr.instance:closeScene(nil, nil, nil, true)

	local var_6_0 = DungeonModel.instance.curSendChapterId
	local var_6_1 = DungeonModel.instance.curSendEpisodeId

	DungeonFightController.instance:enterFight(var_6_0, var_6_1, DungeonModel.instance.curSelectTicketId)
end

function var_0_0.activeExtend()
	ActivityHelper.activateClass("EnterActivityViewOnExitFightSceneHelper%d_%d", 1, 1)
end

return var_0_0
