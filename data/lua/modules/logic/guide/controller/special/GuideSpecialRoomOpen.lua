module("modules.logic.guide.controller.special.GuideSpecialRoomOpen", package.seeall)

slot0 = class("GuideSpecialRoomOpen", BaseGuideAction)
slot1 = 401
slot2 = 17

function slot0.ctor(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onGetInfoFinish, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	GuideController.instance:registerCallback(GuideEvent.StartGuide, slot0._onStartGuide, slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

function slot0.reInit(slot0)
	slot0._hasGetInfo = nil
end

function slot0._onGetInfoFinish(slot0)
	slot0._hasGetInfo = true
end

function slot0._onUpdateDungeonInfo(slot0, slot1)
	if slot0._hasGetInfo then
		slot0:_checkStart()
	end
end

function slot0._checkStart(slot0)
	if not slot0._hasGetInfo then
		return
	end

	if GuideController.instance:isForbidGuides() then
		return
	end

	if GuideModel.instance:getDoingGuideId() and slot1 ~= uv0 then
		return
	end

	if GuideModel.instance:isStepFinish(uv0, uv1) then
		return
	end

	if GuideConfig.instance:getTriggerType(uv0) == "EpisodeFinishAndInMainScene" then
		slot6 = OpenConfig.instance:getOpenCo(tonumber(GuideConfig.instance:getTriggerParam(uv0))) and slot5.episodeId or slot4
		slot7 = DungeonModel.instance:getEpisodeInfo(slot6)

		if DungeonConfig.instance:getEpisodeCO(slot6) and slot7 and DungeonEnum.StarType.None < slot7.star and (slot8.afterStory <= 0 or slot8.afterStory > 0 and StoryModel.instance:isStoryFinished(slot8.afterStory)) then
			GuideModel.instance:setFlag(GuideModel.GuideFlag.DontOpenMain, true, uv0)
		end
	else
		logError("小屋401触发条件有修改")
	end
end

function slot0._onStartGuide(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1 == uv0 then
		slot0:_checkStart()
	elseif GuideConfig.instance:getGuideCO(slot1) and slot2.parallel ~= 1 then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.DontOpenMain, nil)
	end
end

function slot0._onFinishGuide(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1 == uv0 then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.MainView) then
			return
		end

		if ViewMgr.instance:hasOpenFullView() then
			return
		end

		ViewMgr.instance:openView(ViewName.MainView)
	else
		slot0:_checkStart()
	end
end

function slot0._removeEvents(slot0)
	LoginController.instance:unregisterCallback(LoginEvent.OnGetInfoFinish, slot0._onGetInfoFinish, slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, slot0._onStartGuide, slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

function slot0.clearWork(slot0)
	slot0:_removeEvents()
end

return slot0
