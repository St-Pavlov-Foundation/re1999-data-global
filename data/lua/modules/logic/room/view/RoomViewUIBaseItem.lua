module("modules.logic.room.view.RoomViewUIBaseItem", package.seeall)

local var_0_0 = class("RoomViewUIBaseItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goTrs = arg_1_1.transform
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.go, "go_container")
	arg_1_0._gocontainerTrs = arg_1_0._gocontainer.transform
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
	arg_1_0._canvasGroup = arg_1_0.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._baseAnimator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._containerCanvasGroup = arg_1_0._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._isShow = true

	if arg_1_0._customOnInit then
		arg_1_0:_customOnInit()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	RoomMapController.instance:registerCallback(RoomEvent.RefreshUIShow, arg_2_0._refreshShow, arg_2_0)
	RoomBuildingController.instance:registerCallback(RoomEvent.BuildingListShowChanged, arg_2_0._refreshShow, arg_2_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, arg_2_0._refreshShow, arg_2_0)
	RoomMapController.instance:registerCallback(RoomEvent.BendingAmountUpdate, arg_2_0._refreshPosition, arg_2_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_2_0._refreshPosition, arg_2_0)
	RoomMapController.instance:registerCallback(RoomEvent.TouchClickUI3D, arg_2_0._onTouchClick, arg_2_0)

	if arg_2_0._customAddEventListeners then
		arg_2_0:_customAddEventListeners()
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.RefreshUIShow, arg_3_0._refreshShow, arg_3_0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.BuildingListShowChanged, arg_3_0._refreshShow, arg_3_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, arg_3_0._refreshShow, arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BendingAmountUpdate, arg_3_0._refreshPosition, arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_3_0._refreshPosition, arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchClickUI3D, arg_3_0._onTouchClick, arg_3_0)

	if arg_3_0._customRemoveEventListeners then
		arg_3_0:_customRemoveEventListeners()
	end
end

function var_0_0._refreshPosition(arg_4_0)
	local var_4_0 = arg_4_0:getUI3DPos()
	local var_4_1 = RoomBendingHelper.worldToBendingSimple(var_4_0)
	local var_4_2 = RoomBendingHelper.worldPosToAnchorPos(var_4_1, arg_4_0.goTrs.parent)
	local var_4_3 = 0

	if var_4_2 then
		recthelper.setAnchor(arg_4_0.goTrs, var_4_2.x, var_4_2.y)

		local var_4_4 = arg_4_0._scene.camera:getCameraPosition()
		local var_4_5 = Vector3.Distance(var_4_1, var_4_4)

		var_4_3 = var_4_5 <= 3.5 and 1 or var_4_5 >= 7 and 0.5 or 1 - (var_4_5 - 3.5) / 3.5 / 2
	end

	transformhelper.setLocalScale(arg_4_0._gocontainerTrs, var_4_3, var_4_3, var_4_3)
	arg_4_0:_refreshCanvasGroup()
end

function var_0_0._refreshCanvasGroup(arg_5_0)
	local var_5_0 = arg_5_0:getUI3DPos()
	local var_5_1 = arg_5_0._scene.camera:getCameraPosition()
	local var_5_2 = Vector2(var_5_0.x, var_5_0.z)
	local var_5_3 = Vector2(var_5_1.x, var_5_1.z)
	local var_5_4 = Vector2.Distance(var_5_2, var_5_3)
	local var_5_5 = 1

	if var_5_4 >= RoomBaseUIComp.fadeMax then
		var_5_5 = 0
	elseif var_5_4 <= RoomBaseUIComp.fadeMin then
		var_5_5 = 1
	else
		var_5_5 = 1 - (var_5_4 - RoomBaseUIComp.fadeMin) / (RoomBaseUIComp.fadeMax - RoomBaseUIComp.fadeMin)

		if arg_5_0._lastAlpha and math.abs(arg_5_0._lastAlpha - var_5_5) < RoomBaseUIComp.alphaChangeMinimum then
			var_5_5 = arg_5_0._lastAlpha
		end
	end

	local var_5_6 = var_5_5 > 0.25

	if arg_5_0._lastAlpha ~= var_5_5 then
		arg_5_0._lastAlpha = var_5_5
		arg_5_0._canvasGroup.alpha = var_5_5
	end

	if arg_5_0._lastBlocksRaycasts ~= var_5_6 then
		arg_5_0._lastBlocksRaycasts = var_5_6
		arg_5_0._canvasGroup.blocksRaycasts = var_5_6
	end
end

function var_0_0.getUI3DPos(arg_6_0)
	return
end

function var_0_0._setShow(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		if not arg_7_0._isShow then
			arg_7_0._baseAnimator:Play("room_task_in", 0, arg_7_2 and 1 or 0)
		end

		arg_7_0._containerCanvasGroup.blocksRaycasts = true
	else
		if arg_7_0._isShow then
			arg_7_0._baseAnimator:Play("room_task_out", 0, arg_7_2 and 1 or 0)
		end

		arg_7_0._containerCanvasGroup.blocksRaycasts = false
	end

	arg_7_0._isShow = arg_7_1
end

function var_0_0._onTouchClick(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._isShow and not arg_8_0._isReturning and arg_8_0.goTrs and arg_8_1 and arg_8_1.transform:IsChildOf(arg_8_0.goTrs) then
		arg_8_0:_onClick(arg_8_1, arg_8_2)
	end
end

function var_0_0._onClick(arg_9_0, arg_9_1, arg_9_2)
	return
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0._customOnDestory then
		arg_10_0:_customOnDestory()
	end
end

return var_0_0
