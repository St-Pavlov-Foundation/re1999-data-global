module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinishAndInMainScene", package.seeall)

slot0 = class("GuideTriggerEpisodeFinishAndInMainScene", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, slot0._checkStartGuide, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._checkStartGuide, slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._checkStartGuide, slot0)
	PatFaceController.instance:registerCallback(PatFaceEvent.FinishAllPatFace, slot0._checkStartGuide, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	slot5 = OpenConfig.instance:getOpenCo(tonumber(slot2)) and slot4.episodeId or slot3
	slot6 = DungeonModel.instance:getEpisodeInfo(slot5)

	if DungeonConfig.instance:getEpisodeCO(slot5) and slot6 and DungeonEnum.StarType.None < slot6.star then
		if not (slot7.afterStory <= 0 or slot7.afterStory > 0 and StoryModel.instance:isStoryFinished(slot7.afterStory)) then
			return false
		end
	else
		return false
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main and not GameSceneMgr.instance:isLoading() and not GameSceneMgr.instance:isClosing() and not PatFaceModel.instance:getIsPatting() then
		slot12 = false

		for slot17, slot18 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
			if ViewMgr.instance:isModal(slot18) or ViewMgr.instance:isFull(slot18) then
				slot12 = true

				break
			end
		end

		if not slot12 then
			return true
		end
	end

	return false
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.MainView then
		slot0:checkStartGuide()
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	slot0:checkStartGuide()
end

function slot0._checkStartGuide(slot0)
	slot0:checkStartGuide()
end

return slot0
