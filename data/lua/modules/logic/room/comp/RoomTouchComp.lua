module("modules.logic.room.comp.RoomTouchComp", package.seeall)

local var_0_0 = class("RoomTouchComp", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._stationaryRadius = 5
	arg_2_0._characterPressThreshold = 0
	arg_2_0._characterPressThresholdNormal = 0.3
	arg_2_0._uiRootGO = gohelper.find("UIRoot")
	arg_2_0._hudGO = gohelper.find("UIRoot/HUD")
	arg_2_0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
	arg_2_0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()

	if GamepadController.instance:isOpen() then
		GamepadController.instance:registerCallback(GamepadEvent.AxisChange, arg_2_0._onAxisChange, arg_2_0)
		GamepadController.instance:registerCallback(GamepadEvent.KeyUp, arg_2_0._onKeyUp, arg_2_0)
		GamepadController.instance:registerCallback(GamepadEvent.KeyDown, arg_2_0._onKeyDown, arg_2_0)
	end

	arg_2_0:_resetState()
end

function var_0_0.onUpdate(arg_3_0)
	if not UnityEngine.EventSystems.EventSystem.current then
		arg_3_0:_resetState(true)

		return
	end

	if UIBlockMgr.instance:isBlock() and not RoomCharacterController.instance:isPressCharacter() then
		arg_3_0:_resetState(true)

		return
	end

	if ZProj.TouchEventMgr.Fobidden then
		arg_3_0:_resetState(true)

		return
	end

	if not arg_3_0:_canTouch() then
		arg_3_0:_resetState(true)

		return
	end

	arg_3_0._screenScaleX = 1920 / UnityEngine.Screen.width
	arg_3_0._screenScaleY = 1080 / UnityEngine.Screen.height
	arg_3_0._scale = math.sqrt(arg_3_0._screenScaleX^2 + arg_3_0._screenScaleY^2)

	if GamepadController.instance:isOpen() then
		arg_3_0:_handleGamepadToucInput()
	elseif BootNativeUtil.isStandalonePlayer() or arg_3_0:getIsEmulator() then
		if PCInputController.instance:getIsUse() then
			arg_3_0:_handleNewKeyInput()
		else
			arg_3_0:_handleKeyInput()
		end

		arg_3_0:_handleMouseInput()
	elseif BootNativeUtil.isMobilePlayer() then
		arg_3_0:_handleTouchInput()
	end

	if arg_3_0._isUIDragScreenScroll then
		arg_3_0:_screenScroll(GamepadController.instance:getMousePosition())
	end
end

function var_0_0.getIsEmulator(arg_4_0)
	local var_4_0 = Time.realtimeSinceStartup

	if arg_4_0._lastGetEmulatorTime == nil or var_4_0 - arg_4_0._lastGetEmulatorTime > 10 then
		arg_4_0._isEmulator = SDKMgr.instance:isEmulator()
		arg_4_0._lastGetEmulatorTime = var_4_0
	end

	return arg_4_0._isEmulator
end

function var_0_0._onAxisChange(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == GamepadEnum.KeyCode.RightStickHorizontal then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, arg_5_2 * 0.1)
	elseif arg_5_1 == GamepadEnum.KeyCode.RightStickVertical then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, arg_5_2 * 0.1)
	end
end

function var_0_0._onKeyUp(arg_6_0, arg_6_1)
	if arg_6_1 == GamepadEnum.KeyCode.A then
		arg_6_0:_handleGamepadToucInput(false, true)
	end
end

function var_0_0._onKeyDown(arg_7_0, arg_7_1)
	if arg_7_1 == GamepadEnum.KeyCode.A then
		arg_7_0:_handleGamepadToucInput(true, false)
	end
end

function var_0_0.onDestroy(arg_8_0)
	if GamepadController.instance:isOpen() then
		GamepadController.instance:unregisterCallback(GamepadEvent.AxisChange, arg_8_0._onAxisChange, arg_8_0)
		GamepadController.instance:unregisterCallback(GamepadEvent.KeyUp, arg_8_0._onKeyUp, arg_8_0)
		GamepadController.instance:unregisterCallback(GamepadEvent.KeyDown, arg_8_0._onKeyDown, arg_8_0)
	end
end

function var_0_0._resetState(arg_9_0, arg_9_1)
	arg_9_0._coverUI = arg_9_1
	arg_9_0._hasMoved = false
	arg_9_0._touch1DownPosition = nil
	arg_9_0._coverUI3DGO = nil
	arg_9_0._moveRotate = nil
	arg_9_0._moveScale = nil
	arg_9_0._addRotate = 0
	arg_9_0._addScale = 0
	arg_9_0._press = false
	arg_9_0._pressTime = 0
	arg_9_0._startOnBuildingUid = nil
	arg_9_0._startOnHeroId = nil
	arg_9_0._needDispatchUp = false
	arg_9_0._mouseDownPosition = nil
	arg_9_0._lastMousePosition = nil
	arg_9_0._isUIDragScreenScroll = false

	RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding)
end

function var_0_0._canTouch(arg_10_0)
	if ViewMgr.instance:isOpen(ViewName.RoomMiniMapView) or ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomCharacterPlaceInfoView) or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView) or ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		return false
	end

	if arg_10_0._scene.camera:isTweening() and not RoomCharacterController.instance:isPressCharacter() then
		return false
	end

	if RoomCharacterHelper.isInDialogInteraction() then
		return false
	end

	return true
end

function var_0_0._handleKeyInput(arg_11_0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.HelpView) then
		return
	end

	local var_11_0 = 0
	local var_11_1 = -1 * Time.deltaTime * RoomController.instance.rotateSpeed

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
		var_11_0 = var_11_0 - var_11_1
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.E) then
		var_11_0 = var_11_0 + var_11_1
	end

	if var_11_0 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, var_11_0)
	end

	local var_11_2 = 0
	local var_11_3 = 0
	local var_11_4 = -800 * Time.deltaTime * RoomController.instance.moveSpeed

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		var_11_2 = var_11_2 - var_11_4
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		var_11_2 = var_11_2 + var_11_4
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		var_11_3 = var_11_3 + var_11_4
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
		var_11_3 = var_11_3 - var_11_4
	end

	if var_11_2 ~= 0 or var_11_3 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(var_11_2, var_11_3))
	end

	local var_11_5 = 0
	local var_11_6 = 1 * Time.deltaTime * RoomController.instance.scaleSpeed

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.R) then
		var_11_5 = var_11_5 + var_11_6
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.F) then
		var_11_5 = var_11_5 - var_11_6
	end

	if var_11_5 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, var_11_5)
	end
end

function var_0_0._handleNewKeyInput(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = -1 * Time.deltaTime

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 17) then
		var_12_0 = var_12_0 - var_12_1
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 18) then
		var_12_0 = var_12_0 + var_12_1
	end

	if var_12_0 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, var_12_0)
	end

	local var_12_2 = 0
	local var_12_3 = 0
	local var_12_4 = -800 * Time.deltaTime * RoomController.instance.moveSpeed

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 14) then
		var_12_2 = var_12_2 - var_12_4
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 16) then
		var_12_2 = var_12_2 + var_12_4
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 13) then
		var_12_3 = var_12_3 + var_12_4
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 15) then
		var_12_3 = var_12_3 - var_12_4
	end

	if var_12_2 ~= 0 or var_12_3 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(var_12_2, var_12_3))
	end
end

function var_0_0._handleMouseInput(arg_13_0)
	local var_13_0 = UnityEngine.Input.mouseScrollDelta
	local var_13_1 = gohelper.findChild(arg_13_0._hudGO, "RoomView/go_normalroot/go_confirm/roomviewconfirm(Clone)/go_confirm/go_container")
	local var_13_2 = var_13_1 and var_13_1.activeSelf

	if var_13_0 and var_13_0.y ~= 0 and not var_13_2 then
		local var_13_3 = -3 * var_13_0.y * Time.deltaTime

		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, var_13_3)
	end

	if not UnityEngine.Input.GetMouseButtonDown(0) and not UnityEngine.Input.GetMouseButton(0) and not UnityEngine.Input.GetMouseButtonUp(0) and not UnityEngine.Input.GetMouseButtonDown(1) and not UnityEngine.Input.GetMouseButton(1) and not UnityEngine.Input.GetMouseButtonUp(1) then
		if arg_13_0._needDispatchUp then
			arg_13_0:_dispatchMouseUp()
		end

		arg_13_0:_resetState(false)

		return
	end

	if arg_13_0._coverUI then
		return
	end

	arg_13_0._needDispatchUp = true

	local var_13_4 = UnityEngine.Input.mousePosition

	if not arg_13_0._lastMousePosition then
		arg_13_0._lastMousePosition = var_13_4
	end

	local var_13_5, var_13_6 = arg_13_0:_getCoverUIList(var_13_4)

	if (UnityEngine.Input.GetMouseButtonDown(0) or UnityEngine.Input.GetMouseButtonDown(1)) and #var_13_5 > 0 then
		arg_13_0._coverUI = true

		return
	end

	if UnityEngine.Input.GetMouseButtonDown(0) then
		if #var_13_6 > 0 then
			arg_13_0._coverUI3DGO = var_13_6[1]
		else
			arg_13_0._coverUI3DGO = nil
		end
	end

	if UnityEngine.Input.GetMouseButtonDown(0) or UnityEngine.Input.GetMouseButtonDown(1) then
		arg_13_0._mouseDownPosition = var_13_4

		local var_13_7, var_13_8 = arg_13_0:_getPressEntity(arg_13_0._mouseDownPosition)

		if var_13_7 == RoomEnum.TouchTab.RoomBuilding then
			arg_13_0._startOnBuildingUid = var_13_8
		elseif var_13_7 == RoomEnum.TouchTab.RoomCharacter then
			arg_13_0._startOnHeroId = var_13_8
		end
	elseif UnityEngine.Input.GetMouseButton(0) or UnityEngine.Input.GetMouseButton(1) then
		if not arg_13_0._mouseDownPosition then
			arg_13_0._mouseDownPosition = var_13_4
		end

		if arg_13_0._hasMoved then
			local var_13_9 = var_13_4 - arg_13_0._lastMousePosition

			if UnityEngine.Input.GetMouseButton(0) then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(var_13_9.x * arg_13_0._screenScaleX, var_13_9.y * arg_13_0._screenScaleY))
			else
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, var_13_9.x * arg_13_0._screenScaleX / 800)
			end
		elseif arg_13_0._press then
			if arg_13_0._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, var_13_4)
			elseif arg_13_0._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, var_13_4)
			end

			arg_13_0:_screenScroll(var_13_4)
		else
			if Vector2.Distance(arg_13_0._mouseDownPosition, var_13_4) > arg_13_0._stationaryRadius then
				if arg_13_0._startOnBuildingUid then
					arg_13_0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, var_13_4, arg_13_0._startOnBuildingUid)
				else
					arg_13_0._hasMoved = true
				end
			end

			if not arg_13_0._hasMoved then
				arg_13_0._pressTime = arg_13_0._pressTime + Time.deltaTime

				if (RoomCharacterController.instance:isCharacterListShow() and arg_13_0._characterPressThreshold or arg_13_0._characterPressThresholdNormal) < arg_13_0._pressTime and arg_13_0._startOnHeroId then
					arg_13_0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, var_13_4, arg_13_0._startOnHeroId)
				end
			end
		end
	elseif UnityEngine.Input.GetMouseButtonUp(0) then
		if not arg_13_0._hasMoved and not arg_13_0._press then
			if not arg_13_0._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, var_13_4)
			elseif arg_13_0._coverUI3DGO == var_13_6[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, arg_13_0._coverUI3DGO)
			end
		end

		arg_13_0:_dispatchMouseUp()
		arg_13_0:_resetState(false)
	end

	arg_13_0._lastMousePosition = var_13_4
end

function var_0_0._dispatchMouseUp(arg_14_0)
	local var_14_0 = UnityEngine.Input.mousePosition

	if arg_14_0._press then
		if arg_14_0._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, var_14_0)
		elseif arg_14_0._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, var_14_0)
		end
	end
end

function var_0_0._handleTouchInput(arg_15_0)
	local var_15_0 = UnityEngine.Input.touchCount

	if var_15_0 <= 0 then
		if arg_15_0._needDispatchUp then
			arg_15_0:_dispatchTouchUp()
		end

		arg_15_0:_resetState(false)

		return
	end

	if arg_15_0._coverUI then
		return
	end

	arg_15_0._needDispatchUp = true

	if var_15_0 == 1 then
		arg_15_0:_handleSingleTouchInput()
	elseif var_15_0 >= 2 then
		arg_15_0:_handleMultiTouchInput()
	end
end

function var_0_0._handleSingleTouchInput(arg_16_0)
	local var_16_0 = UnityEngine.Input.GetTouch(0)
	local var_16_1 = var_16_0.position
	local var_16_2 = var_16_0.deltaPosition
	local var_16_3, var_16_4 = arg_16_0:_getCoverUIList(var_16_1)

	if var_16_0.phase == TouchPhase.Began and #var_16_3 > 0 then
		arg_16_0._coverUI = true

		return
	end

	if var_16_0.phase == TouchPhase.Began then
		if #var_16_4 > 0 then
			arg_16_0._coverUI3DGO = var_16_4[1]
		else
			arg_16_0._coverUI3DGO = nil
		end
	end

	if var_16_0.phase == TouchPhase.Began then
		arg_16_0._touch1DownPosition = var_16_1

		local var_16_5, var_16_6 = arg_16_0:_getPressEntity(arg_16_0._touch1DownPosition)

		if var_16_5 == RoomEnum.TouchTab.RoomBuilding then
			arg_16_0._startOnBuildingUid = var_16_6
		elseif var_16_5 == RoomEnum.TouchTab.RoomCharacter then
			arg_16_0._startOnHeroId = var_16_6
		end
	elseif var_16_0.phase == TouchPhase.Moved or var_16_0.phase == TouchPhase.Stationary then
		if arg_16_0._hasMoved then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(var_16_2.x * arg_16_0._screenScaleX, var_16_2.y * arg_16_0._screenScaleY))
		elseif arg_16_0._press then
			if arg_16_0._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, var_16_1)
			elseif arg_16_0._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, var_16_1)
			end

			arg_16_0:_screenScroll(var_16_1)
		else
			if not arg_16_0._touch1DownPosition then
				arg_16_0._touch1DownPosition = var_16_1
			end

			if Vector2.Distance(var_16_1, arg_16_0._touch1DownPosition) > arg_16_0._stationaryRadius then
				if arg_16_0._startOnBuildingUid then
					arg_16_0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, var_16_1, arg_16_0._startOnBuildingUid)
				else
					arg_16_0._hasMoved = true
				end
			end

			if not arg_16_0._hasMoved then
				arg_16_0._pressTime = arg_16_0._pressTime + Time.deltaTime

				if (RoomCharacterController.instance:isCharacterListShow() and arg_16_0._characterPressThreshold or arg_16_0._characterPressThresholdNormal) < arg_16_0._pressTime and arg_16_0._startOnHeroId then
					arg_16_0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, var_16_1, arg_16_0._startOnHeroId)
				end
			end
		end
	elseif var_16_0.phase == TouchPhase.Ended or var_16_0.phase == TouchPhase.Canceled then
		if not arg_16_0._hasMoved and not arg_16_0._press then
			if not arg_16_0._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, var_16_1)
			elseif #var_16_4 > 0 and arg_16_0._coverUI3DGO == var_16_4[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, arg_16_0._coverUI3DGO)
			end
		end

		arg_16_0:_dispatchTouchUp()
		arg_16_0:_resetState(false)
	end
end

function var_0_0._handleGamepadToucInput(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = GamepadController.instance:isDownA()

	if not var_17_0 and not arg_17_2 then
		if arg_17_0._needDispatchUp then
			arg_17_0:_dispatchGamepadKeyUp()
		end

		arg_17_0:_resetState(false)

		return
	end

	if arg_17_0._coverUI then
		return
	end

	arg_17_0._needDispatchUp = true

	local var_17_1 = GamepadController.instance:getScreenPos()

	if not arg_17_0._lastMousePosition then
		arg_17_0._lastMousePosition = var_17_1
	end

	local var_17_2, var_17_3 = arg_17_0:_getCoverUIList(var_17_1)

	if arg_17_1 and #var_17_2 > 0 then
		arg_17_0._coverUI = true

		return
	end

	if UnityEngine.Input.GetMouseButtonDown(0) then
		if #var_17_3 > 0 then
			arg_17_0._coverUI3DGO = var_17_3[1]
		else
			arg_17_0._coverUI3DGO = nil
		end
	end

	if arg_17_1 then
		arg_17_0._mouseDownPosition = var_17_1

		local var_17_4, var_17_5 = arg_17_0:_getPressEntity(arg_17_0._mouseDownPosition)

		if var_17_4 == RoomEnum.TouchTab.RoomBuilding then
			arg_17_0._startOnBuildingUid = var_17_5
		elseif var_17_4 == RoomEnum.TouchTab.RoomCharacter then
			arg_17_0._startOnHeroId = var_17_5
		end
	elseif var_17_0 then
		if not arg_17_0._mouseDownPosition then
			arg_17_0._mouseDownPosition = var_17_1
		end

		if arg_17_0._hasMoved then
			local var_17_6 = var_17_1 - arg_17_0._lastMousePosition

			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(var_17_6.x * arg_17_0._screenScaleX, var_17_6.y * arg_17_0._screenScaleY))
		elseif arg_17_0._press then
			if arg_17_0._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, var_17_1)
			elseif arg_17_0._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, var_17_1)
			end

			arg_17_0:_screenScroll(var_17_1)
		else
			if Vector2.Distance(arg_17_0._mouseDownPosition, var_17_1) > arg_17_0._stationaryRadius then
				if arg_17_0._startOnBuildingUid then
					arg_17_0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, var_17_1, arg_17_0._startOnBuildingUid)
				else
					arg_17_0._hasMoved = true
				end
			end

			if not arg_17_0._hasMoved then
				arg_17_0._pressTime = arg_17_0._pressTime + Time.deltaTime

				if (RoomCharacterController.instance:isCharacterListShow() and arg_17_0._characterPressThreshold or arg_17_0._characterPressThresholdNormal) < arg_17_0._pressTime and arg_17_0._startOnHeroId then
					arg_17_0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, var_17_1, arg_17_0._startOnHeroId)
				end
			end
		end
	elseif arg_17_2 then
		if not arg_17_0._hasMoved and not arg_17_0._press then
			if not arg_17_0._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, var_17_1)
			elseif arg_17_0._coverUI3DGO == var_17_3[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, arg_17_0._coverUI3DGO)
			end
		end

		arg_17_0:_dispatchGamepadKeyUp()
		arg_17_0:_resetState(false)
	end

	arg_17_0._lastMousePosition = var_17_1
end

function var_0_0._dispatchGamepadKeyUp(arg_18_0)
	local var_18_0 = GamepadController.instance:getScreenPos()

	if arg_18_0._press then
		if arg_18_0._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, var_18_0)
		elseif arg_18_0._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, var_18_0)
		end
	end
end

function var_0_0._dispatchTouchUp(arg_19_0)
	local var_19_0 = UnityEngine.Input.touchCount > 0 and UnityEngine.Input.GetTouch(0)
	local var_19_1 = var_19_0 and var_19_0.position or Vector2(0, 0)

	if arg_19_0._press then
		if arg_19_0._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, var_19_1)
		elseif arg_19_0._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, var_19_1)
		end
	end
end

function var_0_0._handleMultiTouchInput(arg_20_0)
	local var_20_0 = UnityEngine.Input.GetTouch(0)
	local var_20_1 = var_20_0.position
	local var_20_2 = var_20_0.deltaPosition
	local var_20_3, var_20_4 = arg_20_0:_getCoverUIList(var_20_1)
	local var_20_5 = UnityEngine.Input.GetTouch(1)
	local var_20_6 = var_20_5.position
	local var_20_7 = var_20_5.deltaPosition
	local var_20_8, var_20_9 = arg_20_0:_getCoverUIList(var_20_6)

	if var_20_0.phase == TouchPhase.Began and #var_20_3 > 0 or var_20_5.phase == TouchPhase.Began and #var_20_8 > 0 then
		arg_20_0._coverUI = true

		return
	end

	arg_20_0._hasMoved = true

	if (var_20_0.phase == TouchPhase.Moved or var_20_0.phase == TouchPhase.Stationary) and (var_20_5.phase == TouchPhase.Moved or var_20_5.phase == TouchPhase.Stationary) then
		local var_20_10 = var_20_1 - var_20_2
		local var_20_11 = var_20_6 - var_20_7

		if Vector2.Distance(var_20_1, var_20_6) < arg_20_0._stationaryRadius or Vector2.Distance(var_20_10, var_20_11) < arg_20_0._stationaryRadius then
			return
		end

		local var_20_12 = Vector2.Distance(var_20_10, var_20_11)
		local var_20_13 = -0.0005 * (Vector2.Distance(var_20_1, var_20_6) - var_20_12) * arg_20_0._scale
		local var_20_14 = arg_20_0:_getDeltaAngle(var_20_10, var_20_11, var_20_1, var_20_6)

		if arg_20_0._moveRotate then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, var_20_14)
		elseif arg_20_0._moveScale then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, var_20_13)
		else
			arg_20_0._addRotate = arg_20_0._addRotate + var_20_14
			arg_20_0._addScale = arg_20_0._addScale + var_20_13

			if math.abs(arg_20_0._addRotate) > 0.08 then
				arg_20_0._moveRotate = true
			elseif math.abs(arg_20_0._addScale) > 0.02 then
				arg_20_0._moveScale = true
			end
		end
	end
end

function var_0_0._getCoverUIList(arg_21_0, arg_21_1)
	arg_21_0._pointerEventData.position = arg_21_1

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(arg_21_0._pointerEventData, arg_21_0._raycastResults)

	local var_21_0 = {}
	local var_21_1 = {}
	local var_21_2 = arg_21_0._raycastResults:GetEnumerator()

	while var_21_2:MoveNext() do
		local var_21_3 = var_21_2.Current
		local var_21_4 = var_21_3.module

		if arg_21_0:_isRaycaster2d(var_21_4, var_21_3.gameObject) then
			table.insert(var_21_0, var_21_3.gameObject)
		else
			table.insert(var_21_1, var_21_3.gameObject)
		end
	end

	return var_21_0, var_21_1
end

function var_0_0._isRaycaster2d(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.gameObject.transform:IsChildOf(arg_22_0._uiRootGO.transform)
	local var_22_1 = gohelper.findChild(arg_22_0._uiRootGO, "HUD/RoomView/go_normalroot/go_ui")

	if var_22_1 and arg_22_2 then
		var_22_0 = var_22_0 and not arg_22_2.transform:IsChildOf(var_22_1.transform)
	end

	return var_22_0
end

function var_0_0._getDeltaAngle(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = (arg_23_3 + arg_23_4) / 2
	local var_23_1 = arg_23_1 + (var_23_0 - (arg_23_1 + arg_23_2) / 2)
	local var_23_2 = Vector2.Normalize(var_23_1 - var_23_0)
	local var_23_3 = Vector2.Normalize(arg_23_3 - var_23_0)
	local var_23_4 = Vector2.Angle(var_23_2, var_23_3)
	local var_23_5 = Vector2.Angle(Vector2.right, var_23_2)
	local var_23_6 = Vector2.Angle(Vector2.right, var_23_3)

	if var_23_2.y < 0 then
		var_23_5 = 360 - var_23_5
	end

	if var_23_3.y < 0 then
		var_23_6 = 360 - var_23_6
	end

	local var_23_7 = var_23_6 - var_23_5

	if var_23_7 >= 180 then
		var_23_7 = var_23_7 - 180
	elseif var_23_7 <= -180 then
		var_23_7 = var_23_7 + 180
	end

	if var_23_7 > 90 then
		var_23_7 = var_23_7 - 180
	elseif var_23_7 < -90 then
		var_23_7 = var_23_7 + 180
	end

	local var_23_8 = 2

	return var_23_7 * Mathf.Deg2Rad * var_23_8
end

function var_0_0._getPressEntity(arg_24_0, arg_24_1)
	local var_24_0, var_24_1 = RoomBendingHelper.getRaycastEntity(arg_24_1, true)

	if var_24_0 == RoomEnum.TouchTab.RoomBuilding and var_24_1 then
		if RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
			local var_24_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_24_1)
			local var_24_3 = RoomMapBuildingModel.instance:getTempBuildingMO()

			if not var_24_2 or not var_24_3 or var_24_3.id ~= var_24_2.id then
				return nil
			end

			if RoomBuildingController.instance:isBuildingListShow() then
				return var_24_0, var_24_2.id
			end
		end
	elseif var_24_0 == RoomEnum.TouchTab.RoomCharacter and var_24_1 and (RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm)) then
		local var_24_4 = RoomCharacterModel.instance:getCharacterMOById(var_24_1)

		if RoomCharacterController.instance:isCharacterListShow() then
			local var_24_5 = RoomCharacterModel.instance:getTempCharacterMO()

			if not var_24_4 or not var_24_5 or var_24_5.id ~= var_24_4.id then
				return nil
			end
		end

		return var_24_0, var_24_4.id
	end

	return nil
end

function var_0_0.setUIDragScreenScroll(arg_25_0, arg_25_1)
	arg_25_0._isUIDragScreenScroll = arg_25_1
end

function var_0_0._screenScroll(arg_26_0, arg_26_1)
	local var_26_0 = 0
	local var_26_1 = 0
	local var_26_2 = recthelper.screenPosToAnchorPos(arg_26_1, arg_26_0._hudGO.transform)
	local var_26_3 = recthelper.getWidth(arg_26_0._hudGO.transform)
	local var_26_4 = recthelper.getHeight(arg_26_0._hudGO.transform)

	if var_26_2.x > var_26_3 * 0.4 then
		var_26_0 = 1
	elseif var_26_2.x < -var_26_3 * 0.4 then
		var_26_0 = -1
	end

	if var_26_2.y > var_26_4 * 0.4 then
		var_26_1 = 1
	elseif var_26_2.y < -var_26_4 * 0.4 then
		var_26_1 = -1
	end

	local var_26_5 = Vector2(var_26_0, var_26_1)

	if var_26_5 == Vector2(0, 0) then
		return
	end

	if arg_26_0._scene.camera:isTweening() then
		return
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, var_26_5 * -4)
end

return var_0_0
