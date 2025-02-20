module("modules.logic.room.view.RoomViewTouch", package.seeall)

slot0 = class("RoomViewTouch", BaseView)

function slot0.onInitView(slot0)
	slot0._commonEmptyBlockMO = RoomBlockMO.New()

	slot0._commonEmptyBlockMO:init(RoomInfoHelper.generateEmptyMapBlockInfo(-1, 0, 0))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._characterTouchStateMap = {
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.Normal] = true
	}
	slot0._isNotCanClickEeventMap = {
		[RoomEnum.CameraState.InteractBuilding] = true
	}
end

function slot0._isInitBlockById(slot0, slot1)
	return RoomConfig.instance:getInitBlock(slot1) ~= nil
end

function slot0._onClick(slot0, slot1)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)

		return
	end

	if slot0._isNotCanClickEeventMap[slot0._scene.camera:getCameraState()] then
		return
	end

	if slot0:_click3DGameObject(slot1) then
		return
	end

	slot3, slot4 = RoomBendingHelper.screenPosToHex(slot1)

	if not slot3 then
		return
	end

	if not RoomMapBlockModel.instance:getBlockMO(slot3.x, slot3.y) and not RoomEnum.IsBlockNeedConnInit and RoomBlockHelper.isCanPlaceBlock() then
		slot0._commonEmptyBlockMO.hexPiont = slot3
		slot5 = slot0._commonEmptyBlockMO
	end

	if not slot5 then
		slot0:_checkCancelBackBlock()

		return
	end

	slot6 = RoomBendingHelper.screenToWorld(slot1)

	if RoomController.instance:isDebugMode() then
		slot0:_debugBlockInfo(slot5)
		slot0:_clickInDebugMode(slot5, slot3, slot4)
	elseif RoomController.instance:isEditMode() then
		slot0:_debugBlockInfo(slot5)
		slot0:_clickInEditMode(slot5, slot3, slot4)
	elseif RoomController.instance:isObMode() then
		slot0:_debugBlockInfo(slot5)
		slot0:_clickInObMode(slot5, slot3, slot4, slot6)
	end
end

function slot0._clickInDebugMode(slot0, slot1, slot2, slot3)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
		return
	end

	if slot1:canPlace() then
		RoomDebugController.instance:debugPlaceBlock(slot2)
	elseif slot1.blockState == RoomBlockEnum.BlockState.Map then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.X) then
			if RoomDebugController.instance:isDebugBuildingListShow() then
				RoomDebugController.instance:debugRotateBuilding(slot2)
			elseif RoomDebugController.instance:isDebugPlaceListShow() then
				RoomDebugController.instance:debugRotateBlock(slot2)
			end
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) then
			if RoomDebugController.instance:isDebugBuildingListShow() then
				RoomDebugController.instance:debugRootOutBuilding(slot2)
			elseif RoomDebugController.instance:isDebugPackageListShow() then
				RoomDebugController.instance:debugSetPackageId(slot1.id, 0)
			elseif RoomDebugController.instance:isDebugPlaceListShow() then
				RoomDebugController.instance:debugRootOutBlock(slot2)
			end
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.V) then
			RoomDebugController.instance:debugPlaceBuilding(slot2)
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.B) then
			RoomDebugController.instance:debugRotateBuilding(slot2)
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.N) then
			RoomDebugController.instance:debugRootOutBuilding(slot2)
		elseif RoomDebugController.instance:isDebugBuildingListShow() then
			RoomDebugController.instance:debugPlaceBuilding(slot2)
		elseif RoomDebugController.instance:isDebugPlaceListShow() then
			RoomDebugController.instance:debugReplaceBlock(slot2)
		elseif RoomDebugController.instance:isDebugPackageListShow() then
			if RoomDebugController.instance:isEditPackageOrder() then
				RoomDebugController.instance:debugSetPackageLastOrder(slot1.id)
			else
				RoomDebugController.instance:debugSetPackage(slot1.id)
			end
		end
	end
end

function slot0._chickSelectInventontoryBlockId(slot0, slot1, slot2, slot3)
	if not RoomHelper.isOutCameraFocusCenter(HexMath.hexToPosition(slot1.hexPoint, RoomBlockEnum.BlockSize)) then
		-- Nothing
	elseif not slot0._scene.camera:isTweening() then
		slot0._scene.camera:tweenCamera({
			focusX = slot4.x,
			focusY = slot4.y
		})
	end
end

function slot0._chickBackBlock(slot0, slot1, slot2, slot3)
	slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryBackBlock, {
		hexPoint = slot2
	})
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._checkBuilding(slot0, slot1, slot2, slot3)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		return
	end

	if slot0:_isInitBlockById(slot1.id) then
		GameFacade.showToast(RoomEnum.Toast.BuildingCannotInitBlock)

		return
	end

	slot5 = {
		hexPoint = slot2
	}

	if slot2 ~= slot4.hexPoint then
		AudioMgr.instance:trigger(slot4:getPlaceAudioId())
	end

	for slot9 = 0, 5 do
		if RoomBuildingHelper.canTryPlace(slot4.buildingId, slot2, RoomRotateHelper.rotateRotate(slot4.rotate, slot9)) then
			slot5.rotate = slot10

			slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, slot5)

			break
		end
	end
end

function slot0._checkCancelBackBlock(slot0)
	if RoomController.instance:isEditMode() and not RoomMapBlockModel.instance:isBackMore() and not RoomWaterReformModel.instance:isWaterReform() and RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		slot0._scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	end
end

function slot0._clickInEditMode(slot0, slot1, slot2, slot3)
	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) or RoomBuildingController.instance:isBuildingListShow() then
		slot0:_checkBuilding(slot1, slot2, slot3)

		return
	end

	slot4 = RoomMapBlockModel.instance:isBackMore()
	slot5 = RoomWaterReformModel.instance:isWaterReform()

	if not slot1:canPlace() then
		if slot1.id == RoomInventoryBlockModel.instance:getSelectInventoryBlockId() then
			slot0:_chickSelectInventontoryBlockId(slot1, slot2, slot3)
		elseif slot1.blockState == RoomBlockEnum.BlockState.Map then
			if slot5 then
				RoomWaterReformController.instance:selectWater(slot1, slot2)
			elseif slot4 and slot0:_isInitBlockById(slot1.id) then
				GameFacade.showToast(RoomEnum.Toast.InventoryCannotBackInitBlock)
			else
				slot0:_chickBackBlock(slot1, slot2, slot3)
			end
		end

		return
	end

	slot0:_checkCancelBackBlock()

	if slot4 or slot5 then
		return
	end

	if not RoomInventoryBlockModel.instance:getSelectInventoryBlockMO() then
		GameFacade.showToast(RoomEnum.Toast.NoSelectInventoryBlock)

		return
	end

	if RoomInventoryBlockModel.instance:isMaxNum() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMax)

		return
	end

	if not RoomBlockHelper.isInBoundary(slot2) then
		GameFacade.showToast(RoomEnum.Toast.InventBlockMapPositionMax)

		return
	end

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, {
			hexPoint = slot2
		})
	end
end

function slot0._clickInObMode(slot0, slot1, slot2, slot3, slot4)
	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
		slot0:_checkBuilding(slot1, slot2, slot3)
	elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) and slot1.blockState == RoomBlockEnum.BlockState.Map and RoomCharacterModel.instance:getTempCharacterMO() and RoomCharacterHelper.reCalculateHeight(Vector3(slot4.x, 0, slot4.y)) ~= slot5.currentPosition then
		if RoomCharacterHelper.getRecommendHexPoint(slot5.heroId, slot5.skinId, slot4) then
			slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				position = slot8.position
			})

			return
		end

		GameFacade.showToast(ToastEnum.RoomViewTouch)
	end
end

function slot0._click3DGameObject(slot0, slot1)
	if not slot0._click3DFuncDict then
		slot0._click3DFuncDict = {
			[RoomEnum.TouchTab.RoomBuilding] = slot0._click3DBuilding,
			[RoomEnum.TouchTab.RoomInitBuilding] = slot0._click3DInitBuilding,
			[RoomEnum.TouchTab.RoomPartBuilding] = slot0._click3DPartBuilding,
			[RoomEnum.TouchTab.RoomCharacter] = slot0._click3DCharacter,
			[RoomEnum.TouchTab.RoomCritter] = slot0._click3DCritter,
			[RoomEnum.TouchTab.RoomTransportSite] = slot0._click3DTransportSite
		}
	end

	slot2, slot3 = RoomBendingHelper.getRaycastEntity(slot1)

	if slot0._click3DFuncDict[slot2] then
		return slot4(slot0, slot3)
	end

	return false
end

function slot0._isCanClickBuilding(slot0)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		return false
	end

	return RoomController.instance:isObMode()
end

function slot0._click3DBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		return false
	end

	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			if RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
				slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
					buildingUid = slot2.id,
					hexPoint = slot2.hexPoint,
					rotate = slot2.rotate
				})
				RoomShowBuildingListModel.instance:setSelect(slot2.id)
			end

			return slot3
		end
	elseif slot0:_isCanClickBuilding() and slot2.config and RoomBuildingEnum.CanClickTouchBuildingType[slot2.config.buildingType] == true then
		RoomMap3DClickController.instance:onBuildingEntityClick(slot2)

		return true
	end

	return false
end

function slot0._click3DInitBuilding(slot0, slot1)
	if slot0:_isCanClickBuilding() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
		RoomMapController.instance:openRoomInitBuildingView(0.2)

		return true
	end

	return false
end

function slot0._click3DPartBuilding(slot0, slot1)
	if slot0:_isCanClickBuilding() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
		RoomMapController.instance:openRoomInitBuildingView(0.2, {
			partId = slot1
		})

		return true
	end

	return false
end

function slot0._click3DCharacter(slot0, slot1)
	if not RoomCharacterModel.instance:getCharacterMOById(slot1) then
		return false
	end

	if RoomController.instance:isObMode() then
		if RoomCharacterController.instance:isCharacterListShow() then
			if RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
				slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					heroId = slot2.heroId,
					position = slot2.currentPosition
				})
				RoomCharacterPlaceListModel.instance:setSelect(slot2.id)
			end

			return slot3
		elseif slot0._characterTouchStateMap[slot0._scene.camera:getCameraState()] then
			RoomCharacterController.instance:dispatchEvent(RoomEvent.ClickCharacterInNormalCamera, slot2.heroId)

			return true
		end
	elseif RoomController.instance:isVisitMode() and slot0._characterTouchStateMap[slot0._scene.camera:getCameraState()] then
		RoomCharacterController.instance:dispatchEvent(RoomEvent.ClickCharacterInNormalCamera, slot2.heroId)

		return true
	end

	return false
end

function slot0._click3DCritter(slot0, slot1)
	if not RoomCritterModel.instance:getCritterMOById(slot1) then
		return false
	end

	if (RoomController.instance:isObMode() or RoomController.instance:isVisitMode()) and slot0._characterTouchStateMap[slot0._scene.camera:getCameraState()] then
		RoomMap3DClickController.instance:onCritterEntityClick(slot2)

		return true
	end

	return false
end

function slot0._click3DTransportSite(slot0, slot1)
	if slot0:_isCanClickBuilding() then
		RoomMap3DClickController.instance:onTransportSiteClick(slot1)

		return true
	end

	return false
end

function slot0._debugBlockInfo(slot0, slot1)
	if isDebugBuild then
		if (slot1.blockState == RoomBlockEnum.BlockState.Map or slot1.blockState == RoomBlockEnum.BlockState.Temp) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
			slot3 = HexMath.hexToPosition(slot1.hexPoint, RoomBlockEnum.BlockSize)
			slot3.z = slot3.y
			slot3.y = 0
			slot4 = CameraMgr.instance:getMainCameraTrs().position
			slot5 = slot1:getResourceList()

			logNormal(string.format("当前选中的地块(%d, %d, %d) %d, 资源: %d | %d # %d # %d # %d # %d # %d, 发声位置 : (%s, %s, %s), 摄像机位置 : (%s, %s, %s), 距离摄像机距离 : %s", slot1.hexPoint.x, slot1.hexPoint.y, slot1.id, slot1.defineId, slot1:getResourceCenter(), slot5[1], slot5[2], slot5[3], slot5[4], slot5[5], slot5[6], slot3.x, slot3.y, slot3.z, slot4.x, slot4.y, slot4.z, Vector3.Distance(slot3, slot4)))
		end
	end
end

function slot0._onDrag(slot0, slot1)
	if slot0._scene.cameraFollow:isFollowing() then
		return
	end

	slot2 = slot0._scene.camera:getCameraRotate()
	slot3 = slot0._scene.camera:getCameraZoom()
	slot4 = slot1.x * (slot3 / 2 + 1)
	slot5 = slot1.y * (slot3 / 2 + 1)

	if not slot0._scene.fsm:isTransitioning() then
		slot8 = -0.0025 * RoomController.instance.touchMoveSpeed

		slot0._scene.camera:move((slot4 * Mathf.Cos(slot2) + slot5 * Mathf.Sin(slot2)) * slot8, (-slot4 * Mathf.Sin(slot2) + slot5 * Mathf.Cos(slot2)) * slot8)
	end
end

function slot0._onPressBuilding(slot0, slot1, slot2)
	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook then
		return
	end

	RoomBuildingController.instance:pressBuildingUp(slot1, slot2)
end

function slot0._onDropBuilding(slot0, slot1)
	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook then
		return
	end

	RoomBuildingController.instance:dropBuildingDown(slot1)
end

function slot0._onPressCharacter(slot0, slot1, slot2)
	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Character and slot3 ~= RoomEnum.CameraState.Normal then
		return
	end

	RoomCharacterController.instance:pressCharacterUp(slot1, slot2)
end

function slot0._onDropCharacter(slot0, slot1)
	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Character then
		return
	end

	RoomCharacterController.instance:dropCharacterDown(slot1)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchClickScene, slot0._onClick, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchDrag, slot0._onDrag, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchScale, slot0._onScale, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchRotate, slot0._onRotate, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchPressBuilding, slot0._onPressBuilding, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchDropBuilding, slot0._onDropBuilding, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchPressCharacter, slot0._onPressCharacter, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TouchDropCharacter, slot0._onDropCharacter, slot0)
end

function slot0.onClose(slot0)
end

function slot0._onScale(slot0, slot1)
	if not RoomEnum.CameraCanScaleMap[slot0._scene.camera:getCameraState()] then
		return
	end

	if slot0._scene.fsm:isTransitioning() then
		return
	end

	if slot1 ~= 0 then
		slot0._scene.camera:zoom(slot1)
	end
end

function slot0._onRotate(slot0, slot1)
	if slot0._scene.fsm:isTransitioning() or slot0._scene.cameraFollow:isLockRotate() then
		return
	end

	if slot1 ~= 0 then
		slot0._scene.camera:rotate(slot1)
	end
end

function slot0._screenPosToHexPoint(slot0, slot1)
	return slot0:_screenPosToGroundPos(slot1) and HexMath.positionToRoundHex(slot2, RoomBlockEnum.BlockSize)
end

function slot0._screenPosToGroundPos(slot0, slot1)
	slot2 = CameraMgr.instance:getMainCamera()
	slot3 = GameSceneMgr.instance:getCurScene()
	slot5 = slot3.go.planeGO.transform.position.y

	if slot3.camera.camera:ScreenPointToRay(slot1).direction.y == 0 then
		return nil
	end

	if (slot5 - slot6.origin.y) / slot6.direction.y > 1000 or slot7 < 0 then
		return nil
	end

	slot8 = Vector2(slot6.origin.x + slot6.direction.x * slot7, slot6.origin.z + slot6.direction.z * slot7)

	if slot3.go.groundGO.transform.localScale.x == 0 or slot9.y == 0 then
		return nil
	end

	return Vector2(slot8.x / slot9.x, slot8.y / slot9.z)
end

function slot0.onDestroyView(slot0)
end

return slot0
