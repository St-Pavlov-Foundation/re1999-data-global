module("modules.logic.popup.controller.PopupHelper", package.seeall)

slot0 = class("PopupHelper")

function slot0.checkInFight()
	return GameSceneMgr.instance:isFightScene()
end

function slot0.checkInGuide()
	slot0 = false

	if GuideController.instance:isGuiding() or ViewMgr.instance:isOpen(ViewName.GuideView) or not GuideModel.instance:isGuideFinish(GuideModel.instance:lastForceGuideId()) then
		slot0 = true
	end

	return slot0
end

function slot0.checkInSummonDrawing()
	return SummonModel.instance:getIsDrawing()
end

return slot0
