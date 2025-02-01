module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeAndGuideFinish", package.seeall)

slot0 = class("GuideTriggerEpisodeAndGuideFinish", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, slot0._checkStartGuide, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._checkStartGuide, slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	slot3 = string.splitToNumber(slot2, "_")
	slot4 = slot3[1]
	slot5 = slot3[2]
	slot6 = DungeonModel.instance:getEpisodeInfo(slot4)
	slot8 = false

	if DungeonConfig.instance:getEpisodeCO(slot4) and slot6 and DungeonEnum.StarType.None < slot6.star then
		slot8 = slot7.afterStory <= 0 or slot7.afterStory > 0 and StoryModel.instance:isStoryFinished(slot7.afterStory)
	end

	return slot8 and GuideModel.instance:isGuideFinish(slot5)
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
