module("modules.logic.versionactivity2_4.pinball.view.PinballCitySceneView", package.seeall)

local var_0_0 = class("PinballCitySceneView", PinballBaseSceneView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobuildingui = gohelper.findChild(arg_1_0.viewGO, "#go_buildingui")
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
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_2_0.calcSceneBoard, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._tweenToMainCity, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.TweenToHole, arg_2_0._tweenToHole, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._clickFull:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._gofull)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_3_0.calcSceneBoard, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._tweenToMainCity, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.TweenToHole, arg_3_0._tweenToHole, arg_3_0)
end

function var_0_0.beforeLoadScene(arg_4_0)
	arg_4_0._sceneTrans = arg_4_0._sceneRoot.transform
	arg_4_0._buildingRoot = gohelper.create3d(arg_4_0._sceneRoot, "Building")
end

function var_0_0.onSceneLoaded(arg_5_0, arg_5_1)
	arg_5_0._scale = PinballConst.Const105

	transformhelper.setLocalScale(arg_5_0._sceneTrans, arg_5_0._scale, arg_5_0._scale, 1)

	arg_5_0._sceneGo = arg_5_1

	arg_5_0:calcSceneBoard()
	arg_5_0:placeBuildings()
	arg_5_0:setScenePosSafety(arg_5_0:getMainPos())
end

function var_0_0.placeBuildings(arg_6_0)
	local var_6_0 = PinballConfig.instance:getAllHoleCo(VersionActivity2_4Enum.ActivityId.Pinball)

	arg_6_0._buildings = {}

	local var_6_1 = arg_6_0.viewContainer._viewSetting.otherRes.menu

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_2 = gohelper.create3d(arg_6_0._buildingRoot, tostring(iter_6_0))
		local var_6_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, PinballBuildingEntity)

		var_6_3:initCo(iter_6_1)
		var_6_3:setUI(arg_6_0:getResInst(var_6_1, arg_6_0._gobuildingui, "UI_" .. iter_6_0))
		var_6_3:setUIScale(arg_6_0._scale)
		table.insert(arg_6_0._buildings, var_6_3)
	end
end

function var_0_0.calcSceneBoard(arg_7_0)
	arg_7_0._mapMinX = -10
	arg_7_0._mapMaxX = 10
	arg_7_0._mapMinY = -10
	arg_7_0._mapMaxY = 10

	if not arg_7_0._sceneGo then
		return
	end

	local var_7_0 = gohelper.findChild(arg_7_0._sceneGo, "BackGround/size")

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if not var_7_1 then
		return
	end

	local var_7_2 = var_7_0.transform.lossyScale

	arg_7_0._mapSize = var_7_1.size
	arg_7_0._mapSize.x = arg_7_0._mapSize.x * var_7_2.x
	arg_7_0._mapSize.y = arg_7_0._mapSize.y * var_7_2.y

	local var_7_3
	local var_7_4 = GameUtil.getAdapterScale()

	if var_7_4 ~= 1 then
		var_7_3 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_7_3 = ViewMgr.instance:getUIRoot()
	end

	local var_7_5 = var_7_4 * 7 / 5
	local var_7_6 = var_7_3.transform:GetWorldCorners()
	local var_7_7 = var_7_6[1] * var_7_5
	local var_7_8 = var_7_6[3] * var_7_5

	arg_7_0._viewWidth = math.abs(var_7_8.x - var_7_7.x)
	arg_7_0._viewHeight = math.abs(var_7_8.y - var_7_7.y)

	local var_7_9 = 5.8
	local var_7_10 = var_7_1.center

	arg_7_0._mapMinX = var_7_7.x - (arg_7_0._mapSize.x / 2 - arg_7_0._viewWidth) - var_7_10.x * var_7_2.x
	arg_7_0._mapMaxX = var_7_7.x + arg_7_0._mapSize.x / 2 - var_7_10.x * var_7_2.x
	arg_7_0._mapMinY = var_7_7.y - arg_7_0._mapSize.y / 2 + var_7_9 - var_7_10.y * var_7_2.y
	arg_7_0._mapMaxY = var_7_7.y + (arg_7_0._mapSize.y / 2 - arg_7_0._viewHeight) + var_7_9 - var_7_10.y * var_7_2.y
end

function var_0_0.onMouseScrollWheelChange(arg_8_0, arg_8_1)
	arg_8_0:_setScale(arg_8_0._scale + arg_8_1 * PinballConst.Const103)
end

function var_0_0.onMultDrag(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:_setScale(arg_9_0._scale + arg_9_2 * 0.01 * PinballConst.Const104)
end

function var_0_0._setScale(arg_10_0, arg_10_1)
	if not arg_10_0._sceneGo then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.PinballCityView) then
		return
	end

	arg_10_1 = Mathf.Clamp(arg_10_1, PinballConst.Const101, PinballConst.Const102)

	if arg_10_1 == arg_10_0._scale then
		return
	end

	arg_10_0._targetPos.x = arg_10_0._targetPos.x / arg_10_0._scale * arg_10_1
	arg_10_0._targetPos.y = arg_10_0._targetPos.y / arg_10_0._scale * arg_10_1
	arg_10_0._scale = arg_10_1

	transformhelper.setLocalScale(arg_10_0._sceneTrans, arg_10_0._scale, arg_10_0._scale, 1)
	arg_10_0:calcSceneBoard()
	arg_10_0:setScenePosSafety(arg_10_0._targetPos)

	for iter_10_0, iter_10_1 in pairs(arg_10_0._buildings) do
		iter_10_1:setUIScale(arg_10_0._scale)
	end
end

function var_0_0._tweenToMainCity(arg_11_0, arg_11_1)
	if arg_11_1 ~= ViewName.PinballDayEndView then
		return
	end

	local var_11_0 = arg_11_0:getMainPos()

	if not var_11_0 then
		return
	end

	arg_11_0._fromPos = arg_11_0._targetPos
	arg_11_0._toPos = var_11_0
	arg_11_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_11_0._onTween, arg_11_0._onTweenFinish, arg_11_0)
end

function var_0_0._tweenToHole(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getHolePos(tonumber(arg_12_1) or PinballModel.instance.guideHole or 1)

	if not var_12_0 then
		return
	end

	arg_12_0._fromPos = arg_12_0._targetPos
	arg_12_0._toPos = var_12_0
	arg_12_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_12_0._onTween, arg_12_0._onTweenFinish, arg_12_0)
end

function var_0_0.getMainPos(arg_13_0)
	if not arg_13_0._buildings then
		return
	end

	local var_13_0

	for iter_13_0, iter_13_1 in pairs(arg_13_0._buildings) do
		if iter_13_1:isMainCity() then
			var_13_0 = -iter_13_1.trans.localPosition
			var_13_0.y = var_13_0.y + 5.8
		end
	end

	return var_13_0
end

function var_0_0.getHolePos(arg_14_0, arg_14_1)
	if not arg_14_0._buildings then
		return
	end

	local var_14_0

	for iter_14_0, iter_14_1 in pairs(arg_14_0._buildings) do
		if iter_14_1.co.index == arg_14_1 then
			var_14_0 = -iter_14_1.trans.localPosition
			var_14_0.y = var_14_0.y + 5.8
		end
	end

	return var_14_0
end

function var_0_0._onTween(arg_15_0, arg_15_1)
	arg_15_0:setScenePosSafety(Vector3.Lerp(arg_15_0._fromPos, arg_15_0._toPos, arg_15_1))
end

function var_0_0._onTweenFinish(arg_16_0)
	arg_16_0._tweenId = nil
end

local var_0_1 = Vector3()

function var_0_0._onClickFull(arg_17_0)
	if arg_17_0._isDrag then
		return
	end

	if not arg_17_0._buildings then
		return
	end

	arg_17_0.viewContainer:dispatchEvent(PinballEvent.ClickScene)

	local var_17_0 = CameraMgr.instance:getMainCamera()
	local var_17_1 = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), var_17_0, var_0_1)
	local var_17_2

	for iter_17_0, iter_17_1 in pairs(arg_17_0._buildings) do
		var_17_2 = iter_17_1:tryClick(var_17_1, arg_17_0._scale) or var_17_2
	end

	PinballController.instance:dispatchEvent(PinballEvent.OnClickBuilding, var_17_2 or 0)
end

function var_0_0._beginDrag(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._isDrag = true
end

function var_0_0._endDrag(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._isDrag = false
end

function var_0_0._onDrag(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0._targetPos then
		return
	end

	if UnityEngine.Input.touchCount > 1 then
		return
	end

	local var_20_0 = CameraMgr.instance:getMainCamera()
	local var_20_1 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_20_2.position - arg_20_2.delta, var_20_0, var_0_1)
	local var_20_2 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_20_2.position, var_20_0, var_0_1) - var_20_1

	var_20_2.z = 0

	arg_20_0:setScenePosSafety(arg_20_0._targetPos:Add(var_20_2))
end

function var_0_0.setScenePosSafety(arg_21_0, arg_21_1)
	if not arg_21_0._mapMinX then
		return
	end

	if arg_21_1.x < arg_21_0._mapMinX then
		arg_21_1.x = arg_21_0._mapMinX
	elseif arg_21_1.x > arg_21_0._mapMaxX then
		arg_21_1.x = arg_21_0._mapMaxX
	end

	if arg_21_1.y < arg_21_0._mapMinY then
		arg_21_1.y = arg_21_0._mapMinY
	elseif arg_21_1.y > arg_21_0._mapMaxY then
		arg_21_1.y = arg_21_0._mapMaxY
	end

	arg_21_0._targetPos = arg_21_1
	arg_21_0._sceneTrans.localPosition = arg_21_1
end

function var_0_0.getScenePath(arg_22_0)
	return "scenes/v2a4_m_s12_ttsz_jshd/scenes_prefab/v2a4_m_s12_ttsz_jshd_p.prefab"
end

function var_0_0.onClose(arg_23_0)
	var_0_0.super.onClose(arg_23_0)

	if arg_23_0._tweenId then
		ZProj.TweenHelper.KillById(arg_23_0._tweenId)

		arg_23_0._tweenId = nil
	end
end

return var_0_0
