module("modules.logic.guide.view.GuideMaskView", package.seeall)

slot0 = class("GuideMaskView", BaseView)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._typeGOs = nil
	slot0._csGuideMaskHoles = nil
	slot0._holeImgs = nil
	slot0._cacheHoleImgs = nil
	slot0._exceptionClickCount = 0
end

function slot0.onInitView(slot0)
	slot0._typeGOs = slot0:getUserDataTb_()
	slot0._csGuideMaskHoles = slot0:getUserDataTb_()
	slot0._holeImgs = slot0:getUserDataTb_()

	for slot4 = 1, GuideEnum.uiTypeMaxCount do
		slot0._typeGOs[slot4] = gohelper.findChild(slot0.viewGO, "type" .. slot4)

		if slot0._typeGOs[slot4] then
			slot5 = slot0._typeGOs[slot4]:GetComponent("GuideMaskHole")
			slot0._csGuideMaskHoles[slot4] = slot5

			if slot5 then
				slot5.mainCamera = CameraMgr.instance:getMainCamera()
				slot5.uiCamera = CameraMgr.instance:getUICamera()
				slot5.mainCanvas = ViewMgr.instance:getUICanvas()
				slot0._holeImgs[slot4] = gohelper.findChildImage(slot0._typeGOs[slot4], "Image")
			end
		end
	end

	slot0._maskComponent = MonoHelper.addLuaComOnceToGo(slot0.viewGO, GuideMaskItem, slot0)
	slot0._cacheHoleImgs = slot0:getUserDataTb_()
	slot0._otherMasksTypeGo = gohelper.findChild(slot0.viewGO, "otherMasks/type_go")
	slot0._mainMaskMat = gohelper.findChildImage(slot0.viewGO, "otherMasks/main_mask").material
	slot0._otherMaskMat = gohelper.findChildImage(slot0.viewGO, "otherMasks/other_mask").material
end

function slot0.onOpen(slot0)
	slot0:_onOpenUpdateUI()

	slot0._exceptionClickCount = 0

	slot0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUI, slot0)
	NavigateMgr.instance:addSpace(ViewName.GuideView, slot0._onSpaceBtnClick, slot0)
end

function slot0.onClose(slot0)
	slot0._exceptionClickCount = 0

	slot0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUI, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_onOpenUpdateUI()
end

function slot0._onSpaceBtnClick(slot0)
	if not slot0.viewParam then
		return
	end

	if slot0.viewParam.enableSpaceBtn then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:onClickCallback(true)
		GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, true)
	end

	GuideController.instance:dispatchEvent(GuideEvent.OnClickSpace)
end

function slot0.getUiInfo(slot0)
	if not slot0.viewParam then
		return
	end

	return slot0.viewParam.uiInfo
end

function slot0._onOpenUpdateUI(slot0)
	if not slot0.viewParam or not slot0.viewParam.uiInfo then
		return
	end

	slot1 = slot0.viewParam.uiInfo

	if slot0._prevUIInfo and slot0._prevUIInfo.stepId and (slot1.guideId ~= slot0._prevUIInfo.guideId or GuideConfig.instance:getNextStepId(slot0._prevUIInfo.guideId, slot0._prevUIInfo.stepId) ~= slot1.stepId) then
		slot0._prevUIInfo = nil
	end

	slot0.viewParam.maskChangeAlpha = slot0._prevUIInfo and slot0._prevUIInfo.maskAlpha ~= slot1.maskAlpha

	slot0._maskComponent:setPrevUIInfo(slot0._prevUIInfo)
	slot0:_updateUI()

	slot0._prevUIInfo = slot1
end

function slot0._updateUI(slot0)
	slot0:_updateMainMask()
	slot0:_updateOtherMasks()
end

function slot0._updateMainMask(slot0)
	if not slot0.viewParam or not slot0.viewParam.uiInfo then
		return
	end

	slot0._uiType = slot0.viewParam.uiInfo.uiType
	slot1 = slot0._typeGOs[slot0._uiType]

	for slot5, slot6 in ipairs(slot0._typeGOs) do
		gohelper.setActive(slot6, slot5 == slot0._uiType)
	end

	slot2 = slot0.viewParam

	if slot0._csGuideMaskHoles[slot0._uiType] then
		slot3.raycastTarget = not slot0.viewParam.hasAnyTouchAction
		slot3.material = slot0._mainMaskMat
	end

	slot0._maskComponent:updateUI(slot0.viewGO, slot2, slot3, slot0._holeImgs[slot0._uiType], slot1)
end

function slot0._updateOtherMasks(slot0)
	if not slot0.viewParam then
		return
	end

	slot1 = {}

	if slot0.viewParam.otherMasks then
		for slot5, slot6 in ipairs(slot0.viewParam.otherMasks) do
			slot6.showMask = slot0.viewParam.showMask

			if slot0:_getHoleImg(slot6.uiInfo.uiType, slot6) then
				slot8.material = slot0._otherMaskMat

				MonoHelper.addLuaComOnceToGo(slot8.gameObject, GuideMaskItem, slot0):updateUI(slot0.viewGO, slot6, nil, slot8)

				slot1[slot6] = true
			end
		end
	end

	for slot5, slot6 in pairs(slot0._cacheHoleImgs) do
		if not slot1[slot5] then
			gohelper.destroy(slot6.transform.parent.gameObject)

			slot0._cacheHoleImgs[slot5] = nil
		end
	end
end

function slot0._getHoleImg(slot0, slot1, slot2)
	if not slot0._cacheHoleImgs[slot2] then
		if not slot0._holeImgs[slot1] then
			return
		end

		slot0._cacheHoleImgs[slot2] = gohelper.clone(slot4.gameObject, gohelper.cloneInPlace(slot0._otherMasksTypeGo, tostring(slot1)), "Image"):GetComponent(gohelper.Type_Image)
	end

	return slot3
end

return slot0
