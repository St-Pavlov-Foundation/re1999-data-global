module("modules.logic.fight.system.work.FightWorkSeasonPopupAndStory", package.seeall)

slot0 = class("FightWorkSeasonPopupAndStory", BaseWork)

function slot0.onStart(slot0)
	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Season then
		if PopupController.instance:getPopupCount() > 0 then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		else
			slot0:_checkStory()
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0)
	if PopupController.instance:getPopupCount() == 0 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:_checkStory()
	end
end

function slot0._checkStory(slot0)
	if FightModel.instance:getAfterStory() > 0 and not StoryModel.instance:isStoryFinished(slot1) then
		StoryController.instance:playStory(slot1, {
			mark = true,
			episodeId = DungeonModel.instance.curSendEpisodeId
		}, slot0._storyEnd, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._storyEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
