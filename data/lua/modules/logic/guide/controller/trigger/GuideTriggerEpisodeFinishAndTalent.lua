module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinishAndTalent", package.seeall)

slot0 = class("GuideTriggerEpisodeFinishAndTalent", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, slot0._checkStartGuide, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroRankUp, slot0._checkStartGuide, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	slot5 = OpenConfig.instance:getOpenCo(tonumber(slot2)) and slot4.episodeId or slot3
	slot6 = DungeonModel.instance:getEpisodeInfo(slot5)

	if DungeonConfig.instance:getEpisodeCO(slot5) and slot6 and DungeonEnum.StarType.None < slot6.star then
		if not (slot7.afterStory <= 0 or slot7.afterStory > 0 and StoryModel.instance:isStoryFinished(slot7.afterStory)) then
			return false
		end

		for slot13, slot14 in ipairs(HeroModel.instance:getList()) do
			if slot14.rank > 1 then
				return true
			end
		end

		return false
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
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		slot0:checkStartGuide()
	end
end

return slot0
