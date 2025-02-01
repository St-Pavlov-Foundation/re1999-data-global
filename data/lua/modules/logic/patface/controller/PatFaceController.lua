module("modules.logic.patface.controller.PatFaceController", package.seeall)

slot0 = class("PatFaceController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0.reInit(slot0)
	slot0:_destroyPopupFlow()
end

function slot0._onFinishAllPatFace(slot0)
	if slot0._skipBlurViewName then
		PostProcessingMgr.instance:setCloseSkipRefreshBlur(slot0._skipBlurViewName, nil)

		slot0._skipBlurViewName = nil

		PostProcessingMgr.instance:forceRefreshCloseBlur()
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if not PatFaceModel.instance:getIsPatting() or not slot0._patFaceViewNameMap or not slot0._patFaceFlow then
		return
	end

	if slot0._patFaceViewNameMap[slot1] then
		slot0._skipBlurViewName = slot1

		PostProcessingMgr.instance:setCloseSkipRefreshBlur(slot0._skipBlurViewName, true)
	end
end

function slot0._initPatFaceFlow(slot0)
	slot0:_destroyPopupFlow()

	slot0._patFaceFlow = PatFaceFlowSequence.New()
	slot0._patFaceViewNameMap = {}

	for slot5, slot6 in ipairs(PatFaceConfig.instance:getPatFaceConfigList()) do
		slot0._patFaceViewNameMap[slot6.config.patFaceViewName] = true

		slot0._patFaceFlow:addWork((PatFaceEnum.patFaceCustomWork[slot6.id] or PatFaceWorkBase).New(slot7))
	end

	slot0._patFaceFlow:registerDoneListener(slot0._finishAllPatFace, slot0)
end

function slot0.startPatFace(slot0, slot1)
	if PatFaceModel.instance:getIsSkipPatFace() then
		return false
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return false
	end

	if PatFaceModel.instance:getIsPatting() then
		return false
	end

	if not slot0._patFaceFlow then
		slot0:_initPatFaceFlow()
	end

	PatFaceModel.instance:setIsPatting(true)
	slot0._patFaceFlow:start({
		patFaceType = slot1
	})

	return true
end

function slot0._finishAllPatFace(slot0)
	PatFaceModel.instance:setIsPatting(false)

	if slot0._patFaceFlow then
		slot0._patFaceFlow:reset()
	end

	slot0:_onFinishAllPatFace()
	slot0:dispatchEvent(PatFaceEvent.FinishAllPatFace)
end

function slot0._destroyPopupFlow(slot0)
	PatFaceModel.instance:setIsPatting(false)

	if not slot0._patFaceFlow then
		return
	end

	slot0._patFaceFlow:destroy()

	slot0._patFaceFlow = nil
end

slot0.instance = slot0.New()

return slot0
