module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinishWithOpen", package.seeall)

slot0 = class("GuideTriggerEpisodeFinishWithOpen", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, slot0._checkStartGuide, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	if not OpenConfig.instance:getOpenCo(tonumber(slot2)) then
		return false
	end

	slot5 = slot4.episodeId
	slot6 = DungeonModel.instance:getEpisodeInfo(slot5)

	if DungeonConfig.instance:getEpisodeCO(slot5) and slot6 and DungeonEnum.StarType.None < slot6.star then
		return slot7.afterStory <= 0 or slot7.afterStory > 0 and StoryModel.instance:isStoryFinished(slot7.afterStory)
	else
		return false
	end
end

function slot0._onMainScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:checkStartGuide()
	end
end

function slot0._checkStartGuide(slot0)
	slot0:checkStartGuide()
end

return slot0
