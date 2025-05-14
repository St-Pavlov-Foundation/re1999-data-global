module("modules.logic.guide.view.GuideMaskItem", package.seeall)

local var_0_0 = class("GuideMaskItem", LuaCompBase)
local var_0_1 = Vector2.zero
local var_0_2 = 16
local var_0_3 = 16

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._maskView = arg_1_1
	arg_1_0._viewTrs = nil
	arg_1_0._targetGO = nil
	arg_1_0._targetTrs = nil
	arg_1_0._targetIs2D = false
	arg_1_0._globalTouch = nil
	arg_1_0._root2DTrs = nil
	arg_1_0._uiCamera = nil
	arg_1_0._maskOpenTime = 0
	arg_1_0._exceptionClickCount = 0
end

function var_0_0.onDestroy(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._updateMaskPosAndSize, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._showArrow, arg_2_0)
	arg_2_0:removeEventCb(GuideController.instance, GuideEvent.SetMaskOffset, arg_2_0._setMaskOffset, arg_2_0)
	arg_2_0:removeEventCb(GuideController.instance, GuideEvent.SetMaskPosition, arg_2_0._setMaskCustomPos, arg_2_0)
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._cacheEffects = arg_3_0:getUserDataTb_()

	arg_3_0:onInitView()
	arg_3_0:addEventCb(GuideController.instance, GuideEvent.SetMaskOffset, arg_3_0._setMaskOffset, arg_3_0)
	arg_3_0:addEventCb(GuideController.instance, GuideEvent.SetMaskPosition, arg_3_0._setMaskCustomPos, arg_3_0)
end

function var_0_0.onInitView(arg_4_0)
	arg_4_0._uiCamera = CameraMgr.instance:getUICamera()
	arg_4_0._unitCamera = CameraMgr.instance:getUnitCamera()
	arg_4_0._mainCamera = CameraMgr.instance:getMainCamera()
	arg_4_0._root2DTrs = ViewMgr.instance:getTopUICanvas().transform
end

function var_0_0.addEventListeners(arg_5_0)
	if arg_5_0._csGuideMaskHole then
		arg_5_0._csGuideMaskHole:InitPointerLuaFunction(arg_5_0._onPointerClick, arg_5_0)
	end
end

function var_0_0.removeEventListeners(arg_6_0)
	if arg_6_0._csGuideMaskHole then
		arg_6_0._csGuideMaskHole:InitPointerLuaFunction(nil, nil)
	end
end

function var_0_0.initTargetGo(arg_7_0)
	arg_7_0._targetGO = gohelper.find(arg_7_0._goPath)

	if arg_7_0._targetGO then
		arg_7_0._targetTrs = arg_7_0._targetGO.transform
		arg_7_0._targetIs2D = arg_7_0._targetGO:GetComponent("RectTransform") ~= nil

		local var_7_0 = arg_7_0._targetGO.transform.parent

		while arg_7_0._targetIs2D and not gohelper.isNil(var_7_0) do
			if var_7_0:GetComponent("RectTransform") == nil then
				arg_7_0._targetIs2D = false

				break
			end

			var_7_0 = var_7_0.parent
		end
	end
end

function var_0_0.setPrevUIInfo(arg_8_0, arg_8_1)
	arg_8_0._prevUIInfo = arg_8_1
end

function var_0_0.updateUI(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0._maskOpenTime = ServerTime.now()

	local var_9_0 = arg_9_2.uiInfo

	arg_9_0._uiType = var_9_0.uiType
	arg_9_0._rotation = var_9_0.rotation
	arg_9_0._width = var_9_0.width
	arg_9_0._height = var_9_0.height
	arg_9_0._arrowOffsetX = var_9_0.arrowOffsetX
	arg_9_0._arrowOffsetY = var_9_0.arrowOffsetY
	arg_9_0._maskAlpha = var_9_0.maskAlpha
	arg_9_0._imgAlpha = var_9_0.imgAlpha
	arg_9_0._goPath = arg_9_2.goPath
	arg_9_0._posX = arg_9_2.uiOffset[1] or 0
	arg_9_0._posY = arg_9_2.uiOffset[2] or 0
	arg_9_0._touchGoPath = arg_9_2.touchGOPath
	arg_9_0._enableClick = arg_9_2.enableClick
	arg_9_0._enableDrag = arg_9_2.enableDrag
	arg_9_0._enablePress = arg_9_2.enablePress
	arg_9_0._enableHoleClick = arg_9_2.enableHoleClick
	arg_9_0._showMask = arg_9_2.showMask
	arg_9_0._isStepEditor = arg_9_2._isStepEditor

	arg_9_0:removeEventListeners()

	arg_9_0._csGuideMaskHole = arg_9_3

	arg_9_0:addEventListeners()

	arg_9_0._holeImg = arg_9_4
	arg_9_0._typeGo = arg_9_5
	arg_9_0._viewTrs = arg_9_1.transform

	arg_9_0:initTargetGo()

	arg_9_0._globalTouch = not string.nilorempty(arg_9_0._touchGoPath) and gohelper.find(arg_9_0._touchGoPath) or nil

	TaskDispatcher.cancelTask(arg_9_0._updateMaskPosAndSize, arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0._updateMaskPosAndSize, arg_9_0, 0.01)
	arg_9_0:_updateMaskPosAndSize()
	arg_9_0:_updateMaskAlpha()
	arg_9_0:_updateEnableClick()
	arg_9_0:_updateEnableDrag()
	arg_9_0:_updateEnablePress()
	arg_9_0:_updateEnableTargetClick()
end

function var_0_0._getHoleEffect(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._maskView.viewContainer:getSetting().otherRes[arg_10_1 and 1 or 2]
	local var_10_1 = arg_10_0._cacheEffects[var_10_0]

	if not var_10_1 then
		local var_10_2 = arg_10_0._maskView:getResInst(var_10_0)

		var_10_1 = MonoHelper.addLuaComOnceToGo(var_10_2, GuideHoleEffect)
		arg_10_0._cacheEffects[var_10_0] = var_10_1
	end

	var_10_1:setVisible(false)

	return var_10_1
end

function var_0_0._updateHoleAlpha(arg_11_0, arg_11_1)
	if arg_11_0._holeEffect then
		arg_11_0._holeEffect:setVisible(false)

		arg_11_0._holeEffect = nil
	end

	local var_11_0 = arg_11_0._holeImg

	if var_11_0 then
		arg_11_1 = arg_11_1 or var_11_0.color
		arg_11_1.a = 0
		var_11_0.color = arg_11_1

		arg_11_0:_setArrow(var_11_0)

		if arg_11_0._imgAlpha > 0 then
			arg_11_0._holeEffect = arg_11_0:_getHoleEffect(arg_11_0._showMask)
			arg_11_0._holeEffect.showMask = arg_11_0._showMask

			arg_11_0._holeEffect:addToParent(arg_11_0._holeImg.gameObject)
		end
	end
end

function var_0_0._updateHoleTrans(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_0._holeImg

	if var_12_0 then
		local var_12_1 = var_12_0.transform
		local var_12_2 = arg_12_0:_isRectangle()
		local var_12_3 = var_12_2 and arg_12_1 - var_0_2
		local var_12_4 = var_12_2 and arg_12_2 - var_0_3

		recthelper.setSize(var_12_1, var_12_3, var_12_4)
		transformhelper.setLocalPosXY(var_12_1, arg_12_3, arg_12_4)
	end

	if arg_12_0._holeEffect then
		arg_12_0._holeEffect:setSize(arg_12_1, arg_12_2, arg_12_0._isStepEditor)
	end
end

function var_0_0._updateMaskAlpha(arg_13_0)
	local var_13_0 = arg_13_0._csGuideMaskHole
	local var_13_1

	if var_13_0 then
		if arg_13_0._prevUIInfo and arg_13_0._prevUIInfo.maskAlpha ~= arg_13_0._maskAlpha then
			arg_13_0._fadeId = ZProj.TweenHelper.DoFade(var_13_0, arg_13_0._prevUIInfo.maskAlpha, arg_13_0._maskAlpha, 0.3)
			arg_13_0._prevUIInfo = nil
		else
			var_13_1 = var_13_0.color
			var_13_1.a = arg_13_0._maskAlpha
			var_13_0.color = var_13_1
		end
	end

	arg_13_0:_updateHoleAlpha(var_13_1)
end

function var_0_0._updateEnableClick(arg_14_0)
	local var_14_0 = arg_14_0._csGuideMaskHole

	if var_14_0 then
		var_14_0.enableClick = arg_14_0._enableClick
	end
end

function var_0_0._updateEnableTargetClick(arg_15_0)
	local var_15_0 = arg_15_0._csGuideMaskHole

	if var_15_0 then
		var_15_0.enableTargetClick = arg_15_0:_hasArrow()
	end
end

function var_0_0._updateEnableDrag(arg_16_0)
	local var_16_0 = arg_16_0._csGuideMaskHole

	if var_16_0 then
		var_16_0.enableDrag = arg_16_0._enableDrag
	end
end

function var_0_0._updateEnablePress(arg_17_0)
	local var_17_0 = arg_17_0._csGuideMaskHole

	if var_17_0 then
		var_17_0.enablePress = arg_17_0._enablePress
	end
end

function var_0_0._setArrow(arg_18_0, arg_18_1)
	if not arg_18_0:_hasArrow() then
		return
	end

	arg_18_0._arrow = gohelper.findChild(arg_18_1.gameObject, "arrow")

	if arg_18_0._arrow then
		transformhelper.setLocalPosXY(arg_18_0._arrow.transform, arg_18_0._arrowOffsetX, arg_18_0._arrowOffsetY)
		transformhelper.setLocalRotation(arg_18_0._arrow.transform, 0, 0, arg_18_0._rotation)
		TaskDispatcher.cancelTask(arg_18_0._showArrow, arg_18_0)
		gohelper.setActive(arg_18_0._arrow, false)
		TaskDispatcher.runDelay(arg_18_0._showArrow, arg_18_0, 0.5)
	end
end

function var_0_0._showArrow(arg_19_0)
	gohelper.setActive(arg_19_0._arrow, true)
end

function var_0_0._hasArrow(arg_20_0)
	return arg_20_0._uiType == GuideEnum.uiTypeArrow or arg_20_0._uiType == GuideEnum.uiTypePressArrow
end

function var_0_0._isRectangle(arg_21_0)
	return arg_21_0._uiType == GuideEnum.uiTypeRectangle or arg_21_0._uiType == GuideEnum.uiTypeArrow or arg_21_0._uiType == GuideEnum.uiTypePressArrow
end

function var_0_0._updateMaskPosAndSize(arg_22_0)
	local var_22_0 = arg_22_0._width
	local var_22_1 = arg_22_0._height
	local var_22_2 = arg_22_0._posX
	local var_22_3 = arg_22_0._posY
	local var_22_4 = arg_22_0._csGuideMaskHole

	if var_22_4 and var_22_4.customAdjustSize then
		local var_22_5 = var_22_4.sizeOffset

		var_22_2 = var_22_5.x
		var_22_3 = var_22_5.y

		local var_22_6 = var_22_4.size

		var_22_0 = var_22_6.x
		var_22_1 = var_22_6.y
	end

	local var_22_7 = arg_22_0:_isRectangle()

	if not gohelper.isNil(arg_22_0._targetGO) then
		if var_22_0 == -1 then
			var_22_0 = recthelper.getWidth(arg_22_0._targetGO.transform)

			if var_22_7 then
				var_22_0 = var_22_0 + var_0_2
			end
		end

		if var_22_1 == -1 then
			var_22_1 = recthelper.getHeight(arg_22_0._targetGO.transform)

			if var_22_7 then
				var_22_1 = var_22_1 + var_0_3
			end
		end
	else
		var_22_0 = math.max(var_22_0, 0)
		var_22_1 = math.max(var_22_1, 0)
	end

	if not gohelper.isNil(arg_22_0._targetGO) then
		if arg_22_0._targetIs2D then
			if not gohelper.isNil(arg_22_0._root2DTrs) and not gohelper.isNil(arg_22_0._targetTrs) then
				local var_22_8 = ZProj.GuideMaskHole.CalculateRelativeRectTransformBounds(arg_22_0._root2DTrs, arg_22_0._targetTrs)

				var_22_2 = var_22_2 + var_22_8.center.x
				var_22_3 = var_22_3 + var_22_8.center.y
			end
		else
			arg_22_0._pos = arg_22_0._pos or Vector3.New()
			arg_22_0._pos.x, arg_22_0._pos.y, arg_22_0._pos.z = transformhelper.getPos(arg_22_0._targetTrs)

			local var_22_9 = arg_22_0._unitCamera

			if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MaskUseMainCamera) then
				var_22_9 = arg_22_0._mainCamera
			end

			local var_22_10 = recthelper.worldPosToAnchorPos(arg_22_0._pos, arg_22_0._viewTrs, arg_22_0._uiCamera, var_22_9)

			var_22_2 = var_22_2 + var_22_10.x + (arg_22_0._externalOffset and arg_22_0._externalOffset.x or 0)
			var_22_3 = var_22_3 + var_22_10.y + (arg_22_0._externalOffset and arg_22_0._externalOffset.y or 0)
		end

		if arg_22_0._customPos then
			var_22_2 = arg_22_0._customPos.x
			var_22_3 = arg_22_0._customPos.y
		end

		arg_22_0:_updateHoleTrans(var_22_0, var_22_1, var_22_2, var_22_3)
	else
		arg_22_0:initTargetGo()
	end

	if var_22_4 then
		var_22_4:SetTarget(arg_22_0._targetTrs, arg_22_0:getTempVector2(var_22_2, var_22_3), var_0_1, arg_22_0._globalTouch)

		if arg_22_0._enableHoleClick then
			if var_22_7 then
				var_22_0 = math.max(0, var_22_0 - var_0_2)
				var_22_1 = math.max(0, var_22_1 - var_0_3)
			end

			var_22_4.size = arg_22_0:getTempVector2(var_22_0, var_22_1)

			if arg_22_0._lastPosX ~= var_22_2 or arg_22_0._lastPosY ~= var_22_3 then
				arg_22_0._lastPosX = var_22_2
				arg_22_0._lastPosY = var_22_3

				arg_22_0._csGuideMaskHole:RefreshMesh()
			end
		else
			var_22_4.size = var_0_1
		end
	else
		local var_22_11 = arg_22_0._typeGo

		if not gohelper.isNil(var_22_11) then
			recthelper.setAnchor(var_22_11.transform, var_22_2, var_22_3)
		end
	end
end

function var_0_0.getTempVector2(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._tempVec2 = arg_23_0._tempVec2 or Vector2.New()
	arg_23_0._tempVec2.x = arg_23_1
	arg_23_0._tempVec2.y = arg_23_2

	return arg_23_0._tempVec2
end

function var_0_0._onClickOutside(arg_24_0)
	if arg_24_0._uiType ~= GuideEnum.uiTypeArrow or arg_24_0._maskAlpha ~= 0 or not arg_24_0._arrow then
		return
	end

	if not arg_24_0._animator then
		arg_24_0._animator = arg_24_0._arrow:GetComponentInChildren(typeof(UnityEngine.Animator))
	end

	if arg_24_0._animator then
		arg_24_0._animator:Play("guide_shark")
	end
end

function var_0_0._onPointerClick(arg_25_0, arg_25_1)
	if GuideController.EnableLog then
		logNormal("guidelog: GuideMaskItem._onPointerClick " .. (arg_25_1 and "true" or "false") .. debug.traceback("", 2))
	end

	if not gohelper.isNil(arg_25_0._targetGO) and not GuideUtil.isGOShowInScreen(arg_25_0._targetGO) then
		arg_25_0._exceptionClickCount = arg_25_0._exceptionClickCount + 1

		local var_25_0 = arg_25_0._maskView:getUiInfo()
		local var_25_1 = var_25_0 and var_25_0.guideId
		local var_25_2 = var_25_0 and var_25_0.stepId

		if arg_25_0._exceptionClickCount >= 5 and ServerTime.now() - arg_25_0._maskOpenTime > 5 then
			arg_25_0._exceptionClickCount = 0

			logError(string.format("目标GameObject不在视野，跳过指引 %s_%s", tostring(var_25_1), tostring(var_25_2)))
			GuideController.instance:disableGuides()
			GameFacade.showMessageBox(MessageBoxIdDefine.GuideSureToSkip, MsgBoxEnum.BoxType.Yes_No, function()
				arg_25_0:_onClickYes()
			end, function()
				arg_25_0:_onClickNo()
			end)
		end

		logError(string.format("目标GameObject不在视野，直接响应点击 %s_%s", tostring(var_25_1), tostring(var_25_2)))
		GuideViewMgr.instance:onClickCallback(true)
		GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, true)

		return
	end

	if arg_25_1 then
		GuideViewMgr.instance:disableHoleClick()
	end

	GuideViewMgr.instance:onClickCallback(arg_25_1)
	GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, arg_25_1)
end

function var_0_0._onClickNo(arg_28_0)
	GuideController.instance:enableGuides()
end

function var_0_0._onClickYes(arg_29_0)
	local var_29_0 = GuideModel.instance:getDoingGuideId()

	if var_29_0 then
		GuideController.instance:oneKeyFinishGuide(var_29_0, true)
		GuideStepController.instance:clearStep()
	end

	GuideController.instance:enableGuides()
end

function var_0_0._setMaskOffset(arg_30_0, arg_30_1)
	arg_30_0._externalOffset = arg_30_1

	arg_30_0:_updateMaskPosAndSize()
end

function var_0_0._setMaskCustomPos(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_2 then
		local var_31_0 = CameraMgr.instance:getUICamera()
		local var_31_1 = CameraMgr.instance:getMainCamera()

		arg_31_1 = recthelper.worldPosToAnchorPos(arg_31_1, arg_31_0._viewTrs, var_31_0, var_31_1)
	end

	arg_31_0._customPos = arg_31_1

	arg_31_0:_updateMaskPosAndSize()
end

return var_0_0
