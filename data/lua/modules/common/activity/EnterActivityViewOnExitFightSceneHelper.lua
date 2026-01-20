-- chunkname: @modules/common/activity/EnterActivityViewOnExitFightSceneHelper.lua

module("modules.common.activity.EnterActivityViewOnExitFightSceneHelper", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = class("EnterActivityViewOnExitFightSceneHelper")

function EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight()
	EnterActivityViewOnExitFightSceneHelper.recordMO = FightModel.instance:getRecordMO()

	local chapterId = DungeonModel.instance.curSendChapterId

	return EnterActivityViewOnExitFightSceneHelper.checkIsActivityFight(chapterId)
end

function EnterActivityViewOnExitFightSceneHelper.checkIsActivityFight(chapterId)
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo and chapterCo.actId or 0

	return actId ~= 0 and EnterActivityViewOnExitFightSceneHelper["enterActivity" .. actId]
end

function EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo and chapterCo.actId or 0

	EnterActivityViewOnExitFightSceneHelper.enterActivity(actId, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity(actId, forceStarting, exitFightGroup)
	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		DungeonModel.instance.curSendEpisodeId = nil

		MainController.instance:enterMainScene(forceStarting)

		return
	end

	if actId == 0 then
		return
	end

	local enterFunc = EnterActivityViewOnExitFightSceneHelper["enterActivity" .. actId]

	if not exitFightGroup then
		local checkFunc = EnterActivityViewOnExitFightSceneHelper["checkFightAfterStory" .. actId]

		if checkFunc and checkFunc(enterFunc, forceStarting, exitFightGroup) then
			return
		end
	end

	if enterFunc then
		enterFunc(forceStarting, exitFightGroup)
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(callBack, forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local isReplay = FightController.instance:isReplayMode(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterConfig.actId
	local activityState = ActivityHelper.getActivityStatus(actId)

	if ActivityEnum.ActivityStatus.Normal ~= activityState then
		MainController.instance:enterMainScene(forceStarting)

		return
	end

	if not exitFightGroup and isReplay then
		if EnterActivityViewOnExitFightSceneHelper["enterFightAgain" .. actId] then
			if EnterActivityViewOnExitFightSceneHelper["enterFightAgain" .. actId]() then
				return
			end
		else
			EnterActivityViewOnExitFightSceneHelper.enterFightAgain()

			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)

	local param = {
		episodeId = episodeId,
		episodeCo = episodeCo,
		exitFightGroup = exitFightGroup
	}

	SceneHelper.instance:waitSceneDone(SceneType.Main, callBack, EnterActivityViewOnExitFightSceneHelper, param)
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain()
	GameSceneMgr.instance:closeScene(nil, nil, nil, true)

	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId

	DungeonFightController.instance:enterFight(chapterId, episodeId, DungeonModel.instance.curSelectTicketId)
end

function EnterActivityViewOnExitFightSceneHelper.activeExtend()
	ActivityHelper.activateClass("EnterActivityViewOnExitFightSceneHelper%d_%d", 1, 1)

	local _ = _G.EnterActivityViewOnExitFightSceneHelper2_9
end

return EnterActivityViewOnExitFightSceneHelper
