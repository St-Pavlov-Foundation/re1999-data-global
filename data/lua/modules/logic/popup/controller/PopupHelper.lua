-- chunkname: @modules/logic/popup/controller/PopupHelper.lua

module("modules.logic.popup.controller.PopupHelper", package.seeall)

local PopupHelper = class("PopupHelper")

function PopupHelper.checkInFight()
	local result = GameSceneMgr.instance:isFightScene()

	return result
end

function PopupHelper.checkInGuide()
	local result = false
	local isGuiding = GuideController.instance:isGuiding()
	local isOpenGuideView = ViewMgr.instance:isOpen(ViewName.GuideView)
	local forceGuideId = GuideModel.instance:lastForceGuideId()
	local isFinishForceGuide = GuideModel.instance:isGuideFinish(forceGuideId)

	if isGuiding or isOpenGuideView or not isFinishForceGuide then
		result = true
	end

	return result
end

function PopupHelper.checkInSummonDrawing()
	local result = SummonModel.instance:getIsDrawing()

	return result
end

return PopupHelper
