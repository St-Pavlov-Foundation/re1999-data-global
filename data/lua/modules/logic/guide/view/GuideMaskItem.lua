module("modules.logic.guide.view.GuideMaskItem", package.seeall)

slot0 = class("GuideMaskItem", LuaCompBase)
slot1 = Vector2.zero
slot2 = 16
slot3 = 16

function slot0.ctor(slot0, slot1)
	slot0._maskView = slot1
	slot0._viewTrs = nil
	slot0._targetGO = nil
	slot0._targetTrs = nil
	slot0._targetIs2D = false
	slot0._globalTouch = nil
	slot0._root2DTrs = nil
	slot0._uiCamera = nil
	slot0._maskOpenTime = 0
	slot0._exceptionClickCount = 0
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._updateMaskPosAndSize, slot0)
	TaskDispatcher.cancelTask(slot0._showArrow, slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.SetMaskOffset, slot0._setMaskOffset, slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.SetMaskPosition, slot0._setMaskCustomPos, slot0)
end

function slot0.init(slot0, slot1)
	slot0._cacheEffects = slot0:getUserDataTb_()

	slot0:onInitView()
	slot0:addEventCb(GuideController.instance, GuideEvent.SetMaskOffset, slot0._setMaskOffset, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.SetMaskPosition, slot0._setMaskCustomPos, slot0)
end

function slot0.onInitView(slot0)
	slot0._uiCamera = CameraMgr.instance:getUICamera()
	slot0._unitCamera = CameraMgr.instance:getUnitCamera()
	slot0._mainCamera = CameraMgr.instance:getMainCamera()
	slot0._root2DTrs = ViewMgr.instance:getTopUICanvas().transform
end

function slot0.addEventListeners(slot0)
	if slot0._csGuideMaskHole then
		slot0._csGuideMaskHole:InitPointerLuaFunction(slot0._onPointerClick, slot0)
	end
end

function slot0.removeEventListeners(slot0)
	if slot0._csGuideMaskHole then
		slot0._csGuideMaskHole:InitPointerLuaFunction(nil, )
	end
end

function slot0.initTargetGo(slot0)
	slot0._targetGO = gohelper.find(slot0._goPath)

	if slot0._targetGO then
		slot0._targetTrs = slot0._targetGO.transform
		slot0._targetIs2D = slot0._targetGO:GetComponent("RectTransform") ~= nil
		slot1 = slot0._targetGO.transform.parent

		while slot0._targetIs2D and not gohelper.isNil(slot1) do
			if slot1:GetComponent("RectTransform") == nil then
				slot0._targetIs2D = false

				break
			end

			slot1 = slot1.parent
		end
	end
end

function slot0.setPrevUIInfo(slot0, slot1)
	slot0._prevUIInfo = slot1
end

function slot0.updateUI(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._maskOpenTime = ServerTime.now()
	slot6 = slot2.uiInfo
	slot0._uiType = slot6.uiType
	slot0._rotation = slot6.rotation
	slot0._width = slot6.width
	slot0._height = slot6.height
	slot0._arrowOffsetX = slot6.arrowOffsetX
	slot0._arrowOffsetY = slot6.arrowOffsetY
	slot0._maskAlpha = slot6.maskAlpha
	slot0._imgAlpha = slot6.imgAlpha
	slot0._goPath = slot2.goPath
	slot0._posX = slot2.uiOffset[1] or 0
	slot0._posY = slot2.uiOffset[2] or 0
	slot0._touchGoPath = slot2.touchGOPath
	slot0._enableClick = slot2.enableClick
	slot0._enableDrag = slot2.enableDrag
	slot0._enablePress = slot2.enablePress
	slot0._enableHoleClick = slot2.enableHoleClick
	slot0._showMask = slot2.showMask
	slot0._isStepEditor = slot2._isStepEditor

	slot0:removeEventListeners()

	slot0._csGuideMaskHole = slot3

	slot0:addEventListeners()

	slot0._holeImg = slot4
	slot0._typeGo = slot5
	slot0._viewTrs = slot1.transform

	slot0:initTargetGo()

	slot0._globalTouch = not string.nilorempty(slot0._touchGoPath) and gohelper.find(slot0._touchGoPath) or nil

	TaskDispatcher.cancelTask(slot0._updateMaskPosAndSize, slot0)
	TaskDispatcher.runRepeat(slot0._updateMaskPosAndSize, slot0, 0.01)
	slot0:_updateMaskPosAndSize()
	slot0:_updateMaskAlpha()
	slot0:_updateEnableClick()
	slot0:_updateEnableDrag()
	slot0:_updateEnablePress()
	slot0:_updateEnableTargetClick()
end

function slot0._getHoleEffect(slot0, slot1)
	if not slot0._cacheEffects[slot0._maskView.viewContainer:getSetting().otherRes[slot1 and 1 or 2]] then
		slot0._cacheEffects[slot2] = MonoHelper.addLuaComOnceToGo(slot0._maskView:getResInst(slot2), GuideHoleEffect)
	end

	slot3:setVisible(false)

	return slot3
end

function slot0._updateHoleAlpha(slot0, slot1)
	if slot0._holeEffect then
		slot0._holeEffect:setVisible(false)

		slot0._holeEffect = nil
	end

	if slot0._holeImg then
		slot1 = slot1 or slot2.color
		slot1.a = 0
		slot2.color = slot1

		slot0:_setArrow(slot2)

		if slot0._imgAlpha > 0 then
			slot0._holeEffect = slot0:_getHoleEffect(slot0._showMask)
			slot0._holeEffect.showMask = slot0._showMask

			slot0._holeEffect:addToParent(slot0._holeImg.gameObject)
		end
	end
end

function slot0._updateHoleTrans(slot0, slot1, slot2, slot3, slot4)
	if slot0._holeImg then
		slot6 = slot5.transform

		recthelper.setSize(slot6, slot0:_isRectangle() and slot1 - uv0, slot7 and slot2 - uv1)
		transformhelper.setLocalPosXY(slot6, slot3, slot4)
	end

	if slot0._holeEffect then
		slot0._holeEffect:setSize(slot1, slot2, slot0._isStepEditor)
	end
end

function slot0._updateMaskAlpha(slot0)
	slot2 = nil

	if slot0._csGuideMaskHole then
		if slot0._prevUIInfo and slot0._prevUIInfo.maskAlpha ~= slot0._maskAlpha then
			slot0._fadeId = ZProj.TweenHelper.DoFade(slot1, slot0._prevUIInfo.maskAlpha, slot0._maskAlpha, 0.3)
			slot0._prevUIInfo = nil
		else
			slot2 = slot1.color
			slot2.a = slot0._maskAlpha
			slot1.color = slot2
		end
	end

	slot0:_updateHoleAlpha(slot2)
end

function slot0._updateEnableClick(slot0)
	if slot0._csGuideMaskHole then
		slot1.enableClick = slot0._enableClick
	end
end

function slot0._updateEnableTargetClick(slot0)
	if slot0._csGuideMaskHole then
		slot1.enableTargetClick = slot0:_hasArrow()
	end
end

function slot0._updateEnableDrag(slot0)
	if slot0._csGuideMaskHole then
		slot1.enableDrag = slot0._enableDrag
	end
end

function slot0._updateEnablePress(slot0)
	if slot0._csGuideMaskHole then
		slot1.enablePress = slot0._enablePress
	end
end

function slot0._setArrow(slot0, slot1)
	if not slot0:_hasArrow() then
		return
	end

	slot0._arrow = gohelper.findChild(slot1.gameObject, "arrow")

	if slot0._arrow then
		transformhelper.setLocalPosXY(slot0._arrow.transform, slot0._arrowOffsetX, slot0._arrowOffsetY)
		transformhelper.setLocalRotation(slot0._arrow.transform, 0, 0, slot0._rotation)
		TaskDispatcher.cancelTask(slot0._showArrow, slot0)
		gohelper.setActive(slot0._arrow, false)
		TaskDispatcher.runDelay(slot0._showArrow, slot0, 0.5)
	end
end

function slot0._showArrow(slot0)
	gohelper.setActive(slot0._arrow, true)
end

function slot0._hasArrow(slot0)
	return slot0._uiType == GuideEnum.uiTypeArrow or slot0._uiType == GuideEnum.uiTypePressArrow
end

function slot0._isRectangle(slot0)
	return slot0._uiType == GuideEnum.uiTypeRectangle or slot0._uiType == GuideEnum.uiTypeArrow or slot0._uiType == GuideEnum.uiTypePressArrow
end

function slot0._updateMaskPosAndSize(slot0)
	slot1 = slot0._width
	slot2 = slot0._height
	slot3 = slot0._posX
	slot4 = slot0._posY

	if slot0._csGuideMaskHole and slot5.customAdjustSize then
		slot6 = slot5.sizeOffset
		slot3 = slot6.x
		slot4 = slot6.y
		slot7 = slot5.size
		slot1 = slot7.x
		slot2 = slot7.y
	end

	if not gohelper.isNil(slot0._targetGO) then
		if slot1 == -1 then
			if slot0:_isRectangle() then
				slot1 = recthelper.getWidth(slot0._targetGO.transform) + uv0
			end
		end

		if slot2 == -1 then
			if slot6 then
				slot2 = recthelper.getHeight(slot0._targetGO.transform) + uv1
			end
		end
	else
		slot1 = math.max(slot1, 0)
		slot2 = math.max(slot2, 0)
	end

	if not gohelper.isNil(slot0._targetGO) then
		if slot0._targetIs2D then
			if not gohelper.isNil(slot0._root2DTrs) and not gohelper.isNil(slot0._targetTrs) then
				slot7 = ZProj.GuideMaskHole.CalculateRelativeRectTransformBounds(slot0._root2DTrs, slot0._targetTrs)
				slot3 = slot3 + slot7.center.x
				slot4 = slot4 + slot7.center.y
			end
		else
			slot0._pos = slot0._pos or Vector3.New()
			slot0._pos.x, slot0._pos.y, slot0._pos.z = transformhelper.getPos(slot0._targetTrs)
			slot7 = slot0._unitCamera

			if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MaskUseMainCamera) then
				slot7 = slot0._mainCamera
			end

			slot3 = slot3 + recthelper.worldPosToAnchorPos(slot0._pos, slot0._viewTrs, slot0._uiCamera, slot7).x + (slot0._externalOffset and slot0._externalOffset.x or 0)
			slot4 = slot4 + slot8.y + (slot0._externalOffset and slot0._externalOffset.y or 0)
		end

		if slot0._customPos then
			slot3 = slot0._customPos.x
			slot4 = slot0._customPos.y
		end

		slot0:_updateHoleTrans(slot1, slot2, slot3, slot4)
	else
		slot0:initTargetGo()
	end

	if slot5 then
		slot5:SetTarget(slot0._targetTrs, slot0:getTempVector2(slot3, slot4), uv2, slot0._globalTouch)

		if slot0._enableHoleClick then
			if slot6 then
				slot1 = math.max(0, slot1 - uv0)
				slot2 = math.max(0, slot2 - uv1)
			end

			slot5.size = slot0:getTempVector2(slot1, slot2)

			if slot0._lastPosX ~= slot3 or slot0._lastPosY ~= slot4 then
				slot0._lastPosX = slot3
				slot0._lastPosY = slot4

				slot0._csGuideMaskHole:RefreshMesh()
			end
		else
			slot5.size = uv2
		end
	elseif not gohelper.isNil(slot0._typeGo) then
		recthelper.setAnchor(slot7.transform, slot3, slot4)
	end
end

function slot0.getTempVector2(slot0, slot1, slot2)
	slot0._tempVec2 = slot0._tempVec2 or Vector2.New()
	slot0._tempVec2.x = slot1
	slot0._tempVec2.y = slot2

	return slot0._tempVec2
end

function slot0._onClickOutside(slot0)
	if slot0._uiType ~= GuideEnum.uiTypeArrow or slot0._maskAlpha ~= 0 or not slot0._arrow then
		return
	end

	if not slot0._animator then
		slot0._animator = slot0._arrow:GetComponentInChildren(typeof(UnityEngine.Animator))
	end

	if slot0._animator then
		slot0._animator:Play("guide_shark")
	end
end

function slot0._onPointerClick(slot0, slot1)
	if GuideController.EnableLog then
		logNormal("guidelog: GuideMaskItem._onPointerClick " .. (slot1 and "true" or "false") .. debug.traceback("", 2))
	end

	if not gohelper.isNil(slot0._targetGO) and not GuideUtil.isGOShowInScreen(slot0._targetGO) then
		slot0._exceptionClickCount = slot0._exceptionClickCount + 1
		slot3 = slot0._maskView:getUiInfo() and slot2.guideId
		slot4 = slot2 and slot2.stepId

		if slot0._exceptionClickCount >= 5 and ServerTime.now() - slot0._maskOpenTime > 5 then
			slot0._exceptionClickCount = 0

			logError(string.format("目标GameObject不在视野，跳过指引 %s_%s", tostring(slot3), tostring(slot4)))
			GuideController.instance:disableGuides()
			GameFacade.showMessageBox(MessageBoxIdDefine.GuideSureToSkip, MsgBoxEnum.BoxType.Yes_No, function ()
				uv0:_onClickYes()
			end, function ()
				uv0:_onClickNo()
			end)
		end

		logError(string.format("目标GameObject不在视野，直接响应点击 %s_%s", tostring(slot3), tostring(slot4)))
		GuideViewMgr.instance:onClickCallback(true)
		GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, true)

		return
	end

	if slot1 then
		GuideViewMgr.instance:disableHoleClick()
	end

	GuideViewMgr.instance:onClickCallback(slot1)
	GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, slot1)
end

function slot0._onClickNo(slot0)
	GuideController.instance:enableGuides()
end

function slot0._onClickYes(slot0)
	if GuideModel.instance:getDoingGuideId() then
		GuideController.instance:oneKeyFinishGuide(slot1, true)
		GuideStepController.instance:clearStep()
	end

	GuideController.instance:enableGuides()
end

function slot0._setMaskOffset(slot0, slot1)
	slot0._externalOffset = slot1

	slot0:_updateMaskPosAndSize()
end

function slot0._setMaskCustomPos(slot0, slot1, slot2)
	if slot2 then
		slot1 = recthelper.worldPosToAnchorPos(slot1, slot0._viewTrs, CameraMgr.instance:getUICamera(), CameraMgr.instance:getMainCamera())
	end

	slot0._customPos = slot1

	slot0:_updateMaskPosAndSize()
end

return slot0
