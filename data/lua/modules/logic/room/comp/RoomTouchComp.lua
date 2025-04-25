module("modules.logic.room.comp.RoomTouchComp", package.seeall)

slot0 = class("RoomTouchComp", LuaCompBase)

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1)
	slot0._stationaryRadius = 5
	slot0._characterPressThreshold = 0
	slot0._characterPressThresholdNormal = 0.3
	slot0._uiRootGO = gohelper.find("UIRoot")
	slot0._hudGO = gohelper.find("UIRoot/HUD")
	slot0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
	slot0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	slot0._scene = GameSceneMgr.instance:getCurScene()

	if GamepadController.instance:isOpen() then
		GamepadController.instance:registerCallback(GamepadEvent.AxisChange, slot0._onAxisChange, slot0)
		GamepadController.instance:registerCallback(GamepadEvent.KeyUp, slot0._onKeyUp, slot0)
		GamepadController.instance:registerCallback(GamepadEvent.KeyDown, slot0._onKeyDown, slot0)
	end

	slot0:_resetState()
end

function slot0.onUpdate(slot0)
	if not UnityEngine.EventSystems.EventSystem.current then
		slot0:_resetState(true)

		return
	end

	if UIBlockMgr.instance:isBlock() and not RoomCharacterController.instance:isPressCharacter() then
		slot0:_resetState(true)

		return
	end

	if ZProj.TouchEventMgr.Fobidden then
		slot0:_resetState(true)

		return
	end

	if not slot0:_canTouch() then
		slot0:_resetState(true)

		return
	end

	slot0._screenScaleX = 1920 / UnityEngine.Screen.width
	slot0._screenScaleY = 1080 / UnityEngine.Screen.height
	slot0._scale = math.sqrt(slot0._screenScaleX^2 + slot0._screenScaleY^2)

	if GamepadController.instance:isOpen() then
		slot0:_handleGamepadToucInput()
	elseif BootNativeUtil.isStandalonePlayer() or slot0:getIsEmulator() then
		if PCInputController.instance:getIsUse() then
			slot0:_handleNewKeyInput()
		else
			slot0:_handleKeyInput()
		end

		slot0:_handleMouseInput()
	elseif BootNativeUtil.isMobilePlayer() then
		slot0:_handleTouchInput()
	end

	if slot0._isUIDragScreenScroll then
		slot0:_screenScroll(GamepadController.instance:getMousePosition())
	end
end

function slot0.getIsEmulator(slot0)
	slot1 = Time.realtimeSinceStartup

	if slot0._lastGetEmulatorTime == nil or slot1 - slot0._lastGetEmulatorTime > 10 then
		slot0._isEmulator = SDKMgr.instance:isEmulator()
		slot0._lastGetEmulatorTime = slot1
	end

	return slot0._isEmulator
end

function slot0._onAxisChange(slot0, slot1, slot2)
	if slot1 == GamepadEnum.KeyCode.RightStickHorizontal then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, slot2 * 0.1)
	elseif slot1 == GamepadEnum.KeyCode.RightStickVertical then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, slot2 * 0.1)
	end
end

function slot0._onKeyUp(slot0, slot1)
	if slot1 == GamepadEnum.KeyCode.A then
		slot0:_handleGamepadToucInput(false, true)
	end
end

function slot0._onKeyDown(slot0, slot1)
	if slot1 == GamepadEnum.KeyCode.A then
		slot0:_handleGamepadToucInput(true, false)
	end
end

function slot0.onDestroy(slot0)
	if GamepadController.instance:isOpen() then
		GamepadController.instance:unregisterCallback(GamepadEvent.AxisChange, slot0._onAxisChange, slot0)
		GamepadController.instance:unregisterCallback(GamepadEvent.KeyUp, slot0._onKeyUp, slot0)
		GamepadController.instance:unregisterCallback(GamepadEvent.KeyDown, slot0._onKeyDown, slot0)
	end
end

function slot0._resetState(slot0, slot1)
	slot0._coverUI = slot1
	slot0._hasMoved = false
	slot0._touch1DownPosition = nil
	slot0._coverUI3DGO = nil
	slot0._moveRotate = nil
	slot0._moveScale = nil
	slot0._addRotate = 0
	slot0._addScale = 0
	slot0._press = false
	slot0._pressTime = 0
	slot0._startOnBuildingUid = nil
	slot0._startOnHeroId = nil
	slot0._needDispatchUp = false
	slot0._mouseDownPosition = nil
	slot0._lastMousePosition = nil
	slot0._isUIDragScreenScroll = false

	RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding)
end

function slot0._canTouch(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomMiniMapView) or ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomCharacterPlaceInfoView) or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView) or ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		return false
	end

	if slot0._scene.camera:isTweening() and not RoomCharacterController.instance:isPressCharacter() then
		return false
	end

	if RoomCharacterHelper.isInDialogInteraction() then
		return false
	end

	return true
end

function slot0._handleKeyInput(slot0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.HelpView) then
		return
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
		slot1 = 0 - -1 * Time.deltaTime * RoomController.instance.rotateSpeed
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.E) then
		slot1 = slot1 + slot2
	end

	if slot1 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, slot1)
	end

	slot4 = 0

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		slot3 = 0 - -800 * Time.deltaTime * RoomController.instance.moveSpeed
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		slot3 = slot3 + slot5
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		slot4 = slot4 + slot5
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
		slot4 = slot4 - slot5
	end

	if slot3 ~= 0 or slot4 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(slot3, slot4))
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.R) then
		slot6 = 0 + 1 * Time.deltaTime * RoomController.instance.scaleSpeed
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.F) then
		slot6 = slot6 - slot7
	end

	if slot6 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, slot6)
	end
end

function slot0._handleNewKeyInput(slot0)
	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 17) then
		slot1 = 0 - -1 * Time.deltaTime
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 18) then
		slot1 = slot1 + slot2
	end

	if slot1 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, slot1)
	end

	slot4 = 0

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 14) then
		slot3 = 0 - -800 * Time.deltaTime * RoomController.instance.moveSpeed
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 16) then
		slot3 = slot3 + slot5
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 13) then
		slot4 = slot4 + slot5
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 15) then
		slot4 = slot4 - slot5
	end

	if slot3 ~= 0 or slot4 ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(slot3, slot4))
	end
end

function slot0._handleMouseInput(slot0)
	if UnityEngine.Input.mouseScrollDelta and slot1.y ~= 0 and not (gohelper.findChild(slot0._hudGO, "RoomView/go_normalroot/go_confirm/roomviewconfirm(Clone)/go_confirm/go_container") and slot2.activeSelf) then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, -3 * slot1.y * Time.deltaTime)
	end

	if not UnityEngine.Input.GetMouseButtonDown(0) and not UnityEngine.Input.GetMouseButton(0) and not UnityEngine.Input.GetMouseButtonUp(0) and not UnityEngine.Input.GetMouseButtonDown(1) and not UnityEngine.Input.GetMouseButton(1) and not UnityEngine.Input.GetMouseButtonUp(1) then
		if slot0._needDispatchUp then
			slot0:_dispatchMouseUp()
		end

		slot0:_resetState(false)

		return
	end

	if slot0._coverUI then
		return
	end

	slot0._needDispatchUp = true
	slot4 = UnityEngine.Input.mousePosition

	if not slot0._lastMousePosition then
		slot0._lastMousePosition = slot4
	end

	slot5, slot6 = slot0:_getCoverUIList(slot4)

	if (UnityEngine.Input.GetMouseButtonDown(0) or UnityEngine.Input.GetMouseButtonDown(1)) and #slot5 > 0 then
		slot0._coverUI = true

		return
	end

	if UnityEngine.Input.GetMouseButtonDown(0) then
		if #slot6 > 0 then
			slot0._coverUI3DGO = slot6[1]
		else
			slot0._coverUI3DGO = nil
		end
	end

	if UnityEngine.Input.GetMouseButtonDown(0) or UnityEngine.Input.GetMouseButtonDown(1) then
		slot0._mouseDownPosition = slot4
		slot7, slot0._startOnBuildingUid = slot0:_getPressEntity(slot0._mouseDownPosition)

		if slot7 == RoomEnum.TouchTab.RoomBuilding then
			-- Nothing
		elseif slot7 == RoomEnum.TouchTab.RoomCharacter then
			slot0._startOnHeroId = slot8
		end
	elseif UnityEngine.Input.GetMouseButton(0) or UnityEngine.Input.GetMouseButton(1) then
		if not slot0._mouseDownPosition then
			slot0._mouseDownPosition = slot4
		end

		if slot0._hasMoved then
			slot7 = slot4 - slot0._lastMousePosition

			if UnityEngine.Input.GetMouseButton(0) then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(slot7.x * slot0._screenScaleX, slot7.y * slot0._screenScaleY))
			else
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, slot7.x * slot0._screenScaleX / 800)
			end
		elseif slot0._press then
			if slot0._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, slot4)
			elseif slot0._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot4)
			end

			slot0:_screenScroll(slot4)
		else
			if slot0._stationaryRadius < Vector2.Distance(slot0._mouseDownPosition, slot4) then
				if slot0._startOnBuildingUid then
					slot0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, slot4, slot0._startOnBuildingUid)
				else
					slot0._hasMoved = true
				end
			end

			if not slot0._hasMoved then
				slot0._pressTime = slot0._pressTime + Time.deltaTime

				if (RoomCharacterController.instance:isCharacterListShow() and slot0._characterPressThreshold or slot0._characterPressThresholdNormal) < slot0._pressTime and slot0._startOnHeroId then
					slot0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot4, slot0._startOnHeroId)
				end
			end
		end
	elseif UnityEngine.Input.GetMouseButtonUp(0) then
		if not slot0._hasMoved and not slot0._press then
			if not slot0._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, slot4)
			elseif slot0._coverUI3DGO == slot6[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, slot0._coverUI3DGO)
			end
		end

		slot0:_dispatchMouseUp()
		slot0:_resetState(false)
	end

	slot0._lastMousePosition = slot4
end

function slot0._dispatchMouseUp(slot0)
	if slot0._press then
		if slot0._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, UnityEngine.Input.mousePosition)
		elseif slot0._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, slot1)
		end
	end
end

function slot0._handleTouchInput(slot0)
	if UnityEngine.Input.touchCount <= 0 then
		if slot0._needDispatchUp then
			slot0:_dispatchTouchUp()
		end

		slot0:_resetState(false)

		return
	end

	if slot0._coverUI then
		return
	end

	slot0._needDispatchUp = true

	if slot1 == 1 then
		slot0:_handleSingleTouchInput()
	elseif slot1 >= 2 then
		slot0:_handleMultiTouchInput()
	end
end

function slot0._handleSingleTouchInput(slot0)
	slot1 = UnityEngine.Input.GetTouch(0)
	slot3 = slot1.deltaPosition
	slot4, slot5 = slot0:_getCoverUIList(slot1.position)

	if slot1.phase == TouchPhase.Began and #slot4 > 0 then
		slot0._coverUI = true

		return
	end

	if slot1.phase == TouchPhase.Began then
		if #slot5 > 0 then
			slot0._coverUI3DGO = slot5[1]
		else
			slot0._coverUI3DGO = nil
		end
	end

	if slot1.phase == TouchPhase.Began then
		slot0._touch1DownPosition = slot2
		slot6, slot0._startOnBuildingUid = slot0:_getPressEntity(slot0._touch1DownPosition)

		if slot6 == RoomEnum.TouchTab.RoomBuilding then
			-- Nothing
		elseif slot6 == RoomEnum.TouchTab.RoomCharacter then
			slot0._startOnHeroId = slot7
		end
	elseif slot1.phase == TouchPhase.Moved or slot1.phase == TouchPhase.Stationary then
		if slot0._hasMoved then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(slot3.x * slot0._screenScaleX, slot3.y * slot0._screenScaleY))
		elseif slot0._press then
			if slot0._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, slot2)
			elseif slot0._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot2)
			end

			slot0:_screenScroll(slot2)
		else
			if not slot0._touch1DownPosition then
				slot0._touch1DownPosition = slot2
			end

			if slot0._stationaryRadius < Vector2.Distance(slot2, slot0._touch1DownPosition) then
				if slot0._startOnBuildingUid then
					slot0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, slot2, slot0._startOnBuildingUid)
				else
					slot0._hasMoved = true
				end
			end

			if not slot0._hasMoved then
				slot0._pressTime = slot0._pressTime + Time.deltaTime

				if (RoomCharacterController.instance:isCharacterListShow() and slot0._characterPressThreshold or slot0._characterPressThresholdNormal) < slot0._pressTime and slot0._startOnHeroId then
					slot0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot2, slot0._startOnHeroId)
				end
			end
		end
	elseif slot1.phase == TouchPhase.Ended or slot1.phase == TouchPhase.Canceled then
		if not slot0._hasMoved and not slot0._press then
			if not slot0._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, slot2)
			elseif #slot5 > 0 and slot0._coverUI3DGO == slot5[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, slot0._coverUI3DGO)
			end
		end

		slot0:_dispatchTouchUp()
		slot0:_resetState(false)
	end
end

function slot0._handleGamepadToucInput(slot0, slot1, slot2)
	if not GamepadController.instance:isDownA() and not slot2 then
		if slot0._needDispatchUp then
			slot0:_dispatchGamepadKeyUp()
		end

		slot0:_resetState(false)

		return
	end

	if slot0._coverUI then
		return
	end

	slot0._needDispatchUp = true
	slot4 = GamepadController.instance:getScreenPos()

	if not slot0._lastMousePosition then
		slot0._lastMousePosition = slot4
	end

	slot5, slot6 = slot0:_getCoverUIList(slot4)

	if slot1 and #slot5 > 0 then
		slot0._coverUI = true

		return
	end

	if UnityEngine.Input.GetMouseButtonDown(0) then
		if #slot6 > 0 then
			slot0._coverUI3DGO = slot6[1]
		else
			slot0._coverUI3DGO = nil
		end
	end

	if slot1 then
		slot0._mouseDownPosition = slot4
		slot7, slot0._startOnBuildingUid = slot0:_getPressEntity(slot0._mouseDownPosition)

		if slot7 == RoomEnum.TouchTab.RoomBuilding then
			-- Nothing
		elseif slot7 == RoomEnum.TouchTab.RoomCharacter then
			slot0._startOnHeroId = slot8
		end
	elseif slot3 then
		if not slot0._mouseDownPosition then
			slot0._mouseDownPosition = slot4
		end

		if slot0._hasMoved then
			slot7 = slot4 - slot0._lastMousePosition

			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(slot7.x * slot0._screenScaleX, slot7.y * slot0._screenScaleY))
		elseif slot0._press then
			if slot0._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, slot4)
			elseif slot0._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot4)
			end

			slot0:_screenScroll(slot4)
		else
			if slot0._stationaryRadius < Vector2.Distance(slot0._mouseDownPosition, slot4) then
				if slot0._startOnBuildingUid then
					slot0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, slot4, slot0._startOnBuildingUid)
				else
					slot0._hasMoved = true
				end
			end

			if not slot0._hasMoved then
				slot0._pressTime = slot0._pressTime + Time.deltaTime

				if (RoomCharacterController.instance:isCharacterListShow() and slot0._characterPressThreshold or slot0._characterPressThresholdNormal) < slot0._pressTime and slot0._startOnHeroId then
					slot0._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot4, slot0._startOnHeroId)
				end
			end
		end
	elseif slot2 then
		if not slot0._hasMoved and not slot0._press then
			if not slot0._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, slot4)
			elseif slot0._coverUI3DGO == slot6[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, slot0._coverUI3DGO)
			end
		end

		slot0:_dispatchGamepadKeyUp()
		slot0:_resetState(false)
	end

	slot0._lastMousePosition = slot4
end

function slot0._dispatchGamepadKeyUp(slot0)
	if slot0._press then
		if slot0._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, GamepadController.instance:getScreenPos())
		elseif slot0._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, slot1)
		end
	end
end

function slot0._dispatchTouchUp(slot0)
	slot2 = UnityEngine.Input.touchCount > 0 and UnityEngine.Input.GetTouch(0)

	if slot0._press then
		if slot0._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, slot2 and slot2.position or Vector2(0, 0))
		elseif slot0._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, slot3)
		end
	end
end

function slot0._handleMultiTouchInput(slot0)
	slot1 = UnityEngine.Input.GetTouch(0)
	slot3 = slot1.deltaPosition
	slot4, slot5 = slot0:_getCoverUIList(slot1.position)
	slot6 = UnityEngine.Input.GetTouch(1)
	slot8 = slot6.deltaPosition
	slot9, slot10 = slot0:_getCoverUIList(slot6.position)

	if slot1.phase == TouchPhase.Began and #slot4 > 0 or slot6.phase == TouchPhase.Began and #slot9 > 0 then
		slot0._coverUI = true

		return
	end

	slot0._hasMoved = true

	if (slot1.phase == TouchPhase.Moved or slot1.phase == TouchPhase.Stationary) and (slot6.phase == TouchPhase.Moved or slot6.phase == TouchPhase.Stationary) then
		slot11 = slot2 - slot3
		slot12 = slot7 - slot8

		if Vector2.Distance(slot2, slot7) < slot0._stationaryRadius or Vector2.Distance(slot11, slot12) < slot0._stationaryRadius then
			return
		end

		slot15 = -0.0005 * (Vector2.Distance(slot2, slot7) - Vector2.Distance(slot11, slot12)) * slot0._scale

		if slot0._moveRotate then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, slot0:_getDeltaAngle(slot11, slot12, slot2, slot7))
		elseif slot0._moveScale then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, slot15)
		else
			slot0._addRotate = slot0._addRotate + slot16
			slot0._addScale = slot0._addScale + slot15

			if math.abs(slot0._addRotate) > 0.08 then
				slot0._moveRotate = true
			elseif math.abs(slot0._addScale) > 0.02 then
				slot0._moveScale = true
			end
		end
	end
end

function slot0._getCoverUIList(slot0, slot1)
	slot0._pointerEventData.position = slot1

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(slot0._pointerEventData, slot0._raycastResults)

	slot2 = {}
	slot3 = {}
	slot4 = slot0._raycastResults:GetEnumerator()

	while slot4:MoveNext() do
		slot5 = slot4.Current

		if slot0:_isRaycaster2d(slot5.module, slot5.gameObject) then
			table.insert(slot2, slot5.gameObject)
		else
			table.insert(slot3, slot5.gameObject)
		end
	end

	return slot2, slot3
end

function slot0._isRaycaster2d(slot0, slot1, slot2)
	if gohelper.findChild(slot0._uiRootGO, "HUD/RoomView/go_normalroot/go_ui") and slot2 then
		slot4 = slot1.gameObject.transform:IsChildOf(slot0._uiRootGO.transform) and not slot2.transform:IsChildOf(slot5.transform)
	end

	return slot4
end

function slot0._getDeltaAngle(slot0, slot1, slot2, slot3, slot4)
	slot5 = (slot3 + slot4) / 2
	slot9 = Vector2.Normalize(slot1 + slot5 - (slot1 + slot2) / 2 - slot5)
	slot10 = Vector2.Normalize(slot3 - slot5)
	slot11 = Vector2.Angle(slot9, slot10)
	slot13 = Vector2.Angle(Vector2.right, slot10)

	if slot9.y < 0 then
		slot12 = 360 - Vector2.Angle(Vector2.right, slot9)
	end

	if slot10.y < 0 then
		slot13 = 360 - slot13
	end

	if slot13 - slot12 >= 180 then
		slot14 = slot14 - 180
	elseif slot14 <= -180 then
		slot14 = slot14 + 180
	end

	if slot14 > 90 then
		slot14 = slot14 - 180
	elseif slot14 < -90 then
		slot14 = slot14 + 180
	end

	return slot14 * Mathf.Deg2Rad * 2
end

function slot0._getPressEntity(slot0, slot1)
	slot2, slot3 = RoomBendingHelper.getRaycastEntity(slot1, true)

	if slot2 == RoomEnum.TouchTab.RoomBuilding and slot3 then
		if RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
			slot5 = RoomMapBuildingModel.instance:getTempBuildingMO()

			if not RoomMapBuildingModel.instance:getBuildingMOById(slot3) or not slot5 or slot5.id ~= slot4.id then
				return nil
			end

			if RoomBuildingController.instance:isBuildingListShow() then
				return slot2, slot4.id
			end
		end
	elseif slot2 == RoomEnum.TouchTab.RoomCharacter and slot3 and (RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm)) then
		slot4 = RoomCharacterModel.instance:getCharacterMOById(slot3)

		if RoomCharacterController.instance:isCharacterListShow() then
			slot5 = RoomCharacterModel.instance:getTempCharacterMO()

			if not slot4 or not slot5 or slot5.id ~= slot4.id then
				return nil
			end
		end

		return slot2, slot4.id
	end

	return nil
end

function slot0.setUIDragScreenScroll(slot0, slot1)
	slot0._isUIDragScreenScroll = slot1
end

function slot0._screenScroll(slot0, slot1)
	slot2 = 0
	slot3 = 0
	slot6 = recthelper.getHeight(slot0._hudGO.transform)

	if recthelper.screenPosToAnchorPos(slot1, slot0._hudGO.transform).x > recthelper.getWidth(slot0._hudGO.transform) * 0.4 then
		slot2 = 1
	elseif slot4.x < -slot5 * 0.4 then
		slot2 = -1
	end

	if slot4.y > slot6 * 0.4 then
		slot3 = 1
	elseif slot4.y < -slot6 * 0.4 then
		slot3 = -1
	end

	if Vector2(slot2, slot3) == Vector2(0, 0) then
		return
	end

	if slot0._scene.camera:isTweening() then
		return
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, slot7 * -4)
end

return slot0
