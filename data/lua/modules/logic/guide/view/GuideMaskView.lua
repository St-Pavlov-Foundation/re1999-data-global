module("modules.logic.guide.view.GuideMaskView", package.seeall)

local var_0_0 = class("GuideMaskView", BaseView)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._typeGOs = nil
	arg_1_0._csGuideMaskHoles = nil
	arg_1_0._holeImgs = nil
	arg_1_0._cacheHoleImgs = nil
	arg_1_0._exceptionClickCount = 0
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._typeGOs = arg_2_0:getUserDataTb_()
	arg_2_0._csGuideMaskHoles = arg_2_0:getUserDataTb_()
	arg_2_0._holeImgs = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, GuideEnum.uiTypeMaxCount do
		arg_2_0._typeGOs[iter_2_0] = gohelper.findChild(arg_2_0.viewGO, "type" .. iter_2_0)

		if arg_2_0._typeGOs[iter_2_0] then
			local var_2_0 = arg_2_0._typeGOs[iter_2_0]:GetComponent("GuideMaskHole")

			arg_2_0._csGuideMaskHoles[iter_2_0] = var_2_0

			if var_2_0 then
				var_2_0.mainCamera = CameraMgr.instance:getMainCamera()
				var_2_0.uiCamera = CameraMgr.instance:getUICamera()
				var_2_0.mainCanvas = ViewMgr.instance:getUICanvas()
				arg_2_0._holeImgs[iter_2_0] = gohelper.findChildImage(arg_2_0._typeGOs[iter_2_0], "Image")
			end
		end
	end

	arg_2_0._maskComponent = MonoHelper.addLuaComOnceToGo(arg_2_0.viewGO, GuideMaskItem, arg_2_0)
	arg_2_0._cacheHoleImgs = arg_2_0:getUserDataTb_()
	arg_2_0._otherMasksTypeGo = gohelper.findChild(arg_2_0.viewGO, "otherMasks/type_go")
	arg_2_0._mainMaskMat = gohelper.findChildImage(arg_2_0.viewGO, "otherMasks/main_mask").material
	arg_2_0._otherMaskMat = gohelper.findChildImage(arg_2_0.viewGO, "otherMasks/other_mask").material
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:_onOpenUpdateUI()

	arg_3_0._exceptionClickCount = 0

	arg_3_0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_3_0._updateUI, arg_3_0)
	NavigateMgr.instance:addSpace(ViewName.GuideView, arg_3_0._onSpaceBtnClick, arg_3_0)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0._exceptionClickCount = 0

	arg_4_0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_4_0._updateUI, arg_4_0)
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:_onOpenUpdateUI()
end

function var_0_0._onSpaceBtnClick(arg_6_0)
	if not arg_6_0.viewParam then
		return
	end

	if arg_6_0.viewParam.enableSpaceBtn then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:onClickCallback(true)
		GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, true)
	end

	GuideController.instance:dispatchEvent(GuideEvent.OnClickSpace)
end

function var_0_0.getUiInfo(arg_7_0)
	if not arg_7_0.viewParam then
		return
	end

	return arg_7_0.viewParam.uiInfo
end

function var_0_0._onOpenUpdateUI(arg_8_0)
	if not arg_8_0.viewParam or not arg_8_0.viewParam.uiInfo then
		return
	end

	local var_8_0 = arg_8_0.viewParam.uiInfo

	if arg_8_0._prevUIInfo and arg_8_0._prevUIInfo.stepId and (var_8_0.guideId ~= arg_8_0._prevUIInfo.guideId or GuideConfig.instance:getNextStepId(arg_8_0._prevUIInfo.guideId, arg_8_0._prevUIInfo.stepId) ~= var_8_0.stepId) then
		arg_8_0._prevUIInfo = nil
	end

	arg_8_0.viewParam.maskChangeAlpha = arg_8_0._prevUIInfo and arg_8_0._prevUIInfo.maskAlpha ~= var_8_0.maskAlpha

	arg_8_0._maskComponent:setPrevUIInfo(arg_8_0._prevUIInfo)
	arg_8_0:_updateUI()

	arg_8_0._prevUIInfo = var_8_0
end

function var_0_0._updateUI(arg_9_0)
	arg_9_0:_updateMainMask()
	arg_9_0:_updateOtherMasks()
end

function var_0_0._updateMainMask(arg_10_0)
	if not arg_10_0.viewParam or not arg_10_0.viewParam.uiInfo then
		return
	end

	arg_10_0._uiType = arg_10_0.viewParam.uiInfo.uiType

	local var_10_0 = arg_10_0._typeGOs[arg_10_0._uiType]

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._typeGOs) do
		gohelper.setActive(iter_10_1, iter_10_0 == arg_10_0._uiType)
	end

	local var_10_1 = arg_10_0.viewParam
	local var_10_2 = arg_10_0._csGuideMaskHoles[arg_10_0._uiType]

	if var_10_2 then
		var_10_2.raycastTarget = not arg_10_0.viewParam.hasAnyTouchAction
		var_10_2.material = arg_10_0._mainMaskMat
	end

	arg_10_0._maskComponent:updateUI(arg_10_0.viewGO, var_10_1, var_10_2, arg_10_0._holeImgs[arg_10_0._uiType], var_10_0)
end

function var_0_0._updateOtherMasks(arg_11_0)
	if not arg_11_0.viewParam then
		return
	end

	local var_11_0 = {}

	if arg_11_0.viewParam.otherMasks then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.viewParam.otherMasks) do
			iter_11_1.showMask = arg_11_0.viewParam.showMask

			local var_11_1 = iter_11_1.uiInfo.uiType
			local var_11_2 = arg_11_0:_getHoleImg(var_11_1, iter_11_1)

			if var_11_2 then
				var_11_2.material = arg_11_0._otherMaskMat

				MonoHelper.addLuaComOnceToGo(var_11_2.gameObject, GuideMaskItem, arg_11_0):updateUI(arg_11_0.viewGO, iter_11_1, nil, var_11_2)

				var_11_0[iter_11_1] = true
			end
		end
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0._cacheHoleImgs) do
		if not var_11_0[iter_11_2] then
			gohelper.destroy(iter_11_3.transform.parent.gameObject)

			arg_11_0._cacheHoleImgs[iter_11_2] = nil
		end
	end
end

function var_0_0._getHoleImg(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._cacheHoleImgs[arg_12_2]

	if not var_12_0 then
		local var_12_1 = arg_12_0._holeImgs[arg_12_1]

		if not var_12_1 then
			return
		end

		local var_12_2 = gohelper.cloneInPlace(arg_12_0._otherMasksTypeGo, tostring(arg_12_1))

		var_12_0 = gohelper.clone(var_12_1.gameObject, var_12_2, "Image"):GetComponent(gohelper.Type_Image)
		arg_12_0._cacheHoleImgs[arg_12_2] = var_12_0
	end

	return var_12_0
end

return var_0_0
