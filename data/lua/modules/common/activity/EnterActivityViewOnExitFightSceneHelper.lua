module("modules.common.activity.EnterActivityViewOnExitFightSceneHelper", package.seeall)

slot0 = class("EnterActivityViewOnExitFightSceneHelper")

function slot0.checkCurrentIsActivityFight()
	uv0.recordMO = FightModel.instance:getRecordMO()

	return uv0.checkIsActivityFight(DungeonModel.instance.curSendChapterId)
end

function slot0.checkIsActivityFight(slot0)
	slot2 = DungeonConfig.instance:getChapterCO(slot0) and slot1.actId or 0

	return slot2 ~= 0 and uv0["enterActivity" .. slot2]
end

function slot0.enterCurrentActivity(slot0, slot1)
	uv0.enterActivity(DungeonConfig.instance:getChapterCO(DungeonModel.instance.curSendChapterId) and slot3.actId or 0, slot0, slot1)
end

function slot0.enterActivity(slot0, slot1, slot2)
	if ActivityHelper.getActivityStatus(slot0) ~= ActivityEnum.ActivityStatus.Normal then
		DungeonModel.instance.curSendEpisodeId = nil

		MainController.instance:enterMainScene(slot1)

		return
	end

	if slot0 == 0 then
		return
	end

	slot4 = uv0["enterActivity" .. slot0]

	if not slot2 and uv0["checkFightAfterStory" .. slot0] and slot5(slot4, slot1, slot2) then
		return
	end

	if slot4 then
		slot4(slot1, slot2)
	end
end

function slot0.enterVersionActivityDungeonCommon(slot0, slot1, slot2)
	slot4 = DungeonModel.instance.curSendEpisodeId
	slot5 = FightController.instance:isReplayMode(slot4)
	slot6 = DungeonConfig.instance:getEpisodeCO(slot4)

	if ActivityEnum.ActivityStatus.Normal ~= ActivityHelper.getActivityStatus(DungeonConfig.instance:getChapterCO(DungeonModel.instance.curSendChapterId).actId) then
		MainController.instance:enterMainScene(slot1)

		return
	end

	if not slot2 and slot5 then
		if uv0["enterFightAgain" .. slot8] then
			if uv0["enterFightAgain" .. slot8]() then
				return
			end
		else
			uv0.enterFightAgain()

			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot1)
	SceneHelper.instance:waitSceneDone(SceneType.Main, slot0, uv0, {
		episodeId = slot4,
		episodeCo = slot6,
		exitFightGroup = slot2
	})
end

function slot0.enterFightAgain()
	GameSceneMgr.instance:closeScene(nil, , , true)
	DungeonFightController.instance:enterFight(DungeonModel.instance.curSendChapterId, DungeonModel.instance.curSendEpisodeId, DungeonModel.instance.curSelectTicketId)
end

function slot0.activeExtend()
	ActivityHelper.activateClass("EnterActivityViewOnExitFightSceneHelper%d_%d", 1, 1)
end

return slot0
