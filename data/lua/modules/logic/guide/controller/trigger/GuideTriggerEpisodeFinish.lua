module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinish", package.seeall)

slot0 = class("GuideTriggerEpisodeFinish", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, slot0._checkStartGuide, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	slot3 = tonumber(slot2)
	slot4 = DungeonModel.instance:getEpisodeInfo(slot3)

	if DungeonConfig.instance:getEpisodeCO(slot3) and slot4 and DungeonEnum.StarType.None < slot4.star then
		return slot5.afterStory <= 0 or slot5.afterStory > 0 and StoryModel.instance:isStoryFinished(slot5.afterStory)
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
