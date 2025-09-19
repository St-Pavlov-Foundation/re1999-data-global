module("modules.logic.survival.view.SurvivalMapDragBaseView", package.seeall)

local var_0_0 = class("SurvivalMapDragBaseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofull = gohelper.findChild(arg_1_0.viewGO, "#go_full")
	arg_1_0._clickFull = gohelper.findChildClick(arg_1_0.viewGO, "#go_full")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_2_0._gofull)

	arg_2_0._touchEventMgr:SetIgnoreUI(true)
	arg_2_0._touchEventMgr:SetScrollWheelCb(arg_2_0.onMouseScrollWheelChange, arg_2_0)

	if BootNativeUtil.isMobilePlayer() then
		arg_2_0._touchEventMgr:SetOnMultiDragCb(arg_2_0.onMultDrag, arg_2_0)
	end

	arg_2_0._clickFull:AddClickListener(arg_2_0._onClickFull, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._gofull, arg_2_0._beginDrag, arg_2_0._onDrag, arg_2_0._endDrag, nil, arg_2_0, nil, true)
	SurvivalController.instance:registerCallback(SurvivalEvent.TweenCameraFocus, arg_2_0._onTweenToPos, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.GuideClickPos, arg_2_0._onGuideClickPos, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.GuideTweenCameraPos, arg_2_0._onGuideTweenCameraPos, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.ChangeCameraScale, arg_2_0._onChangeCameraScale, arg_2_0)
	UpdateBeat:Add(arg_2_0._onUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._clickFull:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._gofull)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.TweenCameraFocus, arg_3_0._onTweenToPos, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.GuideClickPos, arg_3_0._onGuideClickPos, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.GuideTweenCameraPos, arg_3_0._onGuideTweenCameraPos, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.ChangeCameraScale, arg_3_0._onChangeCameraScale, arg_3_0)
	UpdateBeat:Remove(arg_3_0._onUpdate, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._scale = 1

	arg_4_0:calcSceneBoard()
end

function var_0_0._onDrag(arg_5_0, arg_5_1, arg_5_2)
	if UnityEngine.Input.touchCount > 1 then
		return
	end

	local var_5_0 = SurvivalHelper.instance:getScene3DPos(arg_5_2.position - arg_5_2.delta)
	local var_5_1 = SurvivalHelper.instance:getScene3DPos() - var_5_0

	var_5_1.y = 0

	arg_5_0:setScenePosSafety(arg_5_0._targetPos:Sub(var_5_1))
end

function var_0_0._onClickFull(arg_6_0)
	if arg_6_0._isDrag then
		return
	end

	local var_6_0 = SurvivalHelper.instance:getScene3DPos()
	local var_6_1, var_6_2, var_6_3 = SurvivalHelper.instance:worldPointToHex(var_6_0.x, var_6_0.y, var_6_0.z)
	local var_6_4 = SurvivalHexNode.New(var_6_1, var_6_2, var_6_3)

	arg_6_0:onClickScene(var_6_0, var_6_4)
end

function var_0_0.onClickScene(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0._beginDrag(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._isDrag = true
end

function var_0_0._endDrag(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._isDrag = false
end

function var_0_0.onMouseScrollWheelChange(arg_10_0, arg_10_1)
	arg_10_0:_setScale(arg_10_0._scale + arg_10_1)
end

function var_0_0.onMultDrag(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:_setScale(arg_11_0._scale + arg_11_2 * 0.01)
end

function var_0_0._setScale(arg_12_0, arg_12_1, arg_12_2)
	if not ViewHelper.instance:checkViewOnTheTop(arg_12_0.viewName, {
		ViewName.SurvivalToastView
	}) and not arg_12_2 then
		return
	end

	arg_12_1 = Mathf.Clamp(arg_12_1, 0, 1)

	if arg_12_1 == arg_12_0._scale and not arg_12_2 then
		return
	end

	arg_12_0._lastScale = arg_12_0._scale
	arg_12_0._scale = arg_12_1

	SurvivalMapHelper.instance:setDistance(arg_12_0._maxDis - (arg_12_0._maxDis - arg_12_0._minDis) * arg_12_0._scale)
	arg_12_0:onSceneScaleChange()
end

function var_0_0.onSceneScaleChange(arg_13_0)
	return
end

function var_0_0.calcSceneBoard(arg_14_0)
	arg_14_0._mapMinX = -10
	arg_14_0._mapMaxX = 10
	arg_14_0._mapMinY = -10
	arg_14_0._mapMaxY = 10
	arg_14_0._maxDis = 10
	arg_14_0._minDis = 5
end

function var_0_0._onTweenToPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0._tweenFinishCallback = arg_15_3
	arg_15_0._tweenFinishCallbackObj = arg_15_4
	arg_15_0._fromPos = arg_15_0._targetPos
	arg_15_0._toPos = arg_15_1

	arg_15_0:cancelCameraTween()

	arg_15_2 = arg_15_2 or 0.5

	if arg_15_2 <= 0 then
		arg_15_0:setScenePosSafety(arg_15_0._toPos)
		arg_15_0:doTweenFinishCallback()
	else
		arg_15_0._cameraTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_15_2, arg_15_0._onTweenCamera, arg_15_0._onTweenCameraFinish, arg_15_0)
	end
end

function var_0_0.doTweenFinishCallback(arg_16_0)
	if arg_16_0._tweenFinishCallback then
		arg_16_0._tweenFinishCallback(arg_16_0._tweenFinishCallbackObj)

		arg_16_0._tweenFinishCallback = nil
		arg_16_0._tweenFinishCallbackObj = nil
	end
end

function var_0_0._onGuideClickPos(arg_17_0, arg_17_1)
	if string.nilorempty(arg_17_1) then
		return
	end

	local var_17_0, var_17_1 = string.match(arg_17_1, "([-%d.]+)_([-%d.]+)")

	if var_17_0 and var_17_1 then
		local var_17_2 = tonumber(var_17_0)
		local var_17_3 = tonumber(var_17_1)
		local var_17_4 = SurvivalHexNode.New(var_17_2, var_17_3)
		local var_17_5, var_17_6, var_17_7 = SurvivalHelper.instance:hexPointToWorldPoint(var_17_2, var_17_3)
		local var_17_8 = Vector3(var_17_5, var_17_6, var_17_7)

		arg_17_0:onClickScene(var_17_8, var_17_4)
	end
end

function var_0_0._onGuideTweenCameraPos(arg_18_0, arg_18_1)
	if string.nilorempty(arg_18_1) then
		return
	end

	local var_18_0, var_18_1, var_18_2 = string.match(arg_18_1, "([-%d.]+)_([-%d.]+)_([-%d.]+)")

	if var_18_0 and var_18_1 then
		local var_18_3 = tonumber(var_18_0)
		local var_18_4 = tonumber(var_18_1)
		local var_18_5 = tonumber(var_18_2)
		local var_18_6, var_18_7, var_18_8 = SurvivalHelper.instance:hexPointToWorldPoint(var_18_3, var_18_4)
		local var_18_9 = Vector3(var_18_6, var_18_7, var_18_8)

		arg_18_0:_onTweenToPos(var_18_9, var_18_5)
	end
end

function var_0_0._onTweenCameraFinish(arg_19_0)
	arg_19_0._cameraTweenId = nil

	arg_19_0:doTweenFinishCallback()
end

function var_0_0._onTweenCamera(arg_20_0, arg_20_1)
	arg_20_0:setScenePosSafety(Vector3.Lerp(arg_20_0._fromPos, arg_20_0._toPos, arg_20_1))
end

function var_0_0.cancelCameraTween(arg_21_0)
	if arg_21_0._cameraTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._cameraTweenId)

		arg_21_0._cameraTweenId = nil
	end
end

function var_0_0.setScenePosSafety(arg_22_0, arg_22_1)
	if arg_22_1.x < arg_22_0._mapMinX then
		arg_22_1.x = arg_22_0._mapMinX
	elseif arg_22_1.x > arg_22_0._mapMaxX then
		arg_22_1.x = arg_22_0._mapMaxX
	end

	if arg_22_1.z < arg_22_0._mapMinY then
		arg_22_1.z = arg_22_0._mapMinY
	elseif arg_22_1.z > arg_22_0._mapMaxY then
		arg_22_1.z = arg_22_0._mapMaxY
	end

	arg_22_0._targetPos = arg_22_1

	SurvivalMapHelper.instance:setFocusPos(arg_22_1.x, arg_22_1.y, arg_22_1.z)
end

function var_0_0.setFollower(arg_23_0, arg_23_1)
	arg_23_0._followerTrs = nil

	if not gohelper.isNil(arg_23_1) then
		arg_23_0._followerTrs = arg_23_1.transform
	end
end

function var_0_0._onUpdate(arg_24_0)
	arg_24_0:_followerTarget(arg_24_0._followerTrs)
end

function var_0_0._followerTarget(arg_25_0, arg_25_1)
	if gohelper.isNil(arg_25_1) then
		return
	end

	if arg_25_0._followerPos == nil then
		arg_25_0._followerPos = Vector3.zero
	end

	local var_25_0, var_25_1, var_25_2 = transformhelper.getPos(arg_25_1)

	if arg_25_0:_equalsZero(var_25_0 - arg_25_0._followerPos.x) and arg_25_0:_equalsZero(var_25_1 - arg_25_0._followerPos.y) and arg_25_0:_equalsZero(var_25_2 - arg_25_0._followerPos.z) then
		return
	end

	arg_25_0._followerPos:Set(var_25_0, var_25_1, var_25_2)
	arg_25_0:setScenePosSafety(arg_25_0._followerPos)
end

function var_0_0._equalsZero(arg_26_0, arg_26_1)
	local var_26_0 = 1e-06

	return arg_26_1 >= -var_26_0 and arg_26_1 <= var_26_0
end

function var_0_0._onChangeCameraScale(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == nil then
		arg_27_1 = arg_27_0._lastScale
	end

	if not arg_27_1 then
		return
	end

	arg_27_0:_setScale(arg_27_1, true)

	if not arg_27_2 then
		SurvivalMapHelper.instance:applyDirectly()
	end
end

return var_0_0
