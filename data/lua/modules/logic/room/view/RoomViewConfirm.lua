module("modules.logic.room.view.RoomViewConfirm", package.seeall)

slot0 = class("RoomViewConfirm", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goconfirm = gohelper.findChild(slot0.viewGO, "go_confirm")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "go_confirm/go_container")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_confirm/go_container/btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_confirm/go_container/btn_cancel")

	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)

	slot0._btncancelcharacter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_confirm/go_container/btn_cancelcharacter")

	slot0._btncancelcharacter:AddClickListener(slot0._btncancelOnClick, slot0)

	slot0._gocancelpos = gohelper.findChild(slot0.viewGO, "go_confirm/go_container/go_cancelpos")
	slot0._goconfirmpos = gohelper.findChild(slot0.viewGO, "go_confirm/go_container/go_confirmpos")
	slot0._gocancelposcharacter = gohelper.findChild(slot0.viewGO, "go_confirm/go_container/go_cancelposcharacter")
	slot0._goconfirmposcharacter = gohelper.findChild(slot0.viewGO, "go_confirm/go_container/go_confirmposcharacter")
	slot1 = {}

	for slot5 = 1, 100 do
		table.insert(slot1, 0.5)
	end

	slot0._gorotate = gohelper.findChild(slot0.viewGO, "go_confirm/go_container/go_rotate")
	slot0._rotateClick = SLFramework.UGUI.UIClickListener.Get(slot0._gorotate)

	slot0._rotateClick:AddClickListener(slot0._btnrotateOnClick, slot0)

	slot0._rotatePress = SLFramework.UGUI.UILongPressListener.Get(slot0._gorotate)

	slot0._rotatePress:SetLongPressTime(slot1)

	slot0._confirmCanvasGroup = slot0._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._isCharacter = false
	slot0._allFocusItem = slot0:getUserDataTb_()
	slot0._allFocusItem[1] = slot0._btncancel.transform
	slot0._allFocusItem[2] = slot0._gorotate.transform
	slot0._allFocusItem[3] = slot0._btnconfirm.transform
	slot0._inputhandle = TaskDispatcher.runRepeat(slot0._handleMouseInput, slot0, 0.01)
end

function slot0._handleMouseInput(slot0)
	if UnityEngine.Input.mouseScrollDelta and slot1.y ~= 0 then
		slot0:_btnrotateOnClick()
	end

	if UnityEngine.Input.GetMouseButtonDown(1) then
		slot0:_btncancelOnClick()
	end

	if UnityEngine.Input.GetKey("space") then
		slot0:_btnconfirmOnClick()
	end
end

function slot0._btnconfirmOnClick(slot0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			slot0:_confirmBuilding()
		else
			slot0:_confirmBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			slot0:_confirmBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			slot0:_confirmCharacter()
		end
	end
end

function slot0._confirmBuilding(slot0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		return
	end

	slot2 = slot1.id
	slot6, slot7 = RoomBuildingHelper.canConfirmPlace(slot1.buildingId, slot1.hexPoint, slot1.rotate, nil, , false, slot1.levels, true)

	if slot6 then
		if tonumber(slot2) < 1 then
			if ManufactureConfig.instance:getManufactureBuildingCfg(slot3) and slot8.placeNoCost == 1 then
				RoomBuildingController.instance:sendBuyManufactureBuildingRpc(slot3)

				return
			end

			ViewMgr.instance:openView(ViewName.RoomManufacturePlaceCostView)

			return
		end

		if RoomBuildingAreaHelper.findTempOutBuildingMOList() and #slot8 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeMainBuilding, MsgBoxEnum.BoxType.Yes_No, slot0._requestUseBuilding, nil, , slot0, nil, , RoomBuildingAreaHelper.formatBuildingMOListNameStr(slot8))

			return
		end

		if RoomBuildingAreaHelper.findTempOutTransportMOList() and #slot9 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeMainBuildingTransportPath, MsgBoxEnum.BoxType.Yes_No, slot0._requestUseBuilding, nil, , slot0, nil, )

			return
		end

		RoomMapController.instance:useBuildingRequest(slot2, slot4, slot5.x, slot5.y)
	elseif slot7 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.Foundation then
		GameFacade.showToast(ToastEnum.RoomErrorFoundation)
	elseif slot7 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId then
		GameFacade.showToast(ToastEnum.RoomErrorResourceId)
	elseif slot7 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceArea then
		GameFacade.showToast(ToastEnum.RoomErrorResourceArea)
	elseif slot7 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding then
		GameFacade.showToast(ToastEnum.NoAreaMainBuilding)
	elseif slot7 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding then
		GameFacade.showToast(ToastEnum.OutSizeAreaBuilding)
	elseif slot7 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.InTransportPath then
		GameFacade.showToast(ToastEnum.RoomBuildingInTranspath)
	end
end

function slot0._requestUnUseBuilding(slot0)
	if RoomMapBuildingModel.instance:getTempBuildingMO() then
		RoomMapController.instance:unUseBuildingRequest(slot1.id)
	end
end

function slot0._requestUseBuilding(slot0)
	if RoomMapBuildingModel.instance:getTempBuildingMO() then
		slot2 = slot1.hexPoint

		RoomMapController.instance:useBuildingRequest(slot1.id, slot1.rotate, slot2.x, slot2.y)
	end
end

function slot0._removeOutBuildingMOList(slot0, slot1)
	if RoomBuildingAreaHelper.findTempOutBuildingMOList(slot1) and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			RoomMapController.instance:unUseBuildingRequest(slot7.id)
		end
	end
end

function slot0._confirmBlock(slot0)
	if not RoomMapBlockModel.instance:getTempBlockMO() or not RoomInventoryBlockModel.instance:getSelectInventoryBlockMO() then
		return
	end

	if RoomInventoryBlockModel.instance:isMaxNum() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMax)

		return
	end

	slot5 = slot1.hexPoint

	RoomMapController.instance:useBlockRequest(slot2.id, slot2.rotate, slot5.x, slot5.y)
end

function slot0._confirmCharacter(slot0)
	if not RoomCharacterModel.instance:getTempCharacterMO() then
		return
	end

	if RoomCharacterHelper.canConfirmPlace(slot1.heroId, slot1.currentPosition, slot1.skinId, true) then
		RoomMapController.instance:useCharacterRequest(slot1.id)
	end
end

function slot0._btnrotateOnClick(slot0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			slot0:_rotateBuilding()
		else
			slot0:_rotateBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			slot0:_rotateBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			slot0:_rotateCharacter()
		end
	end
end

function slot0._rotateBuilding(slot0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		return
	end

	for slot5 = 1, 5 do
		if RoomBuildingHelper.canTryPlace(slot1.buildingId, slot1.hexPoint, RoomRotateHelper.rotateRotate(slot1.rotate, slot5)) then
			slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				rotate = slot6
			})

			return
		end
	end

	GameFacade.showToast(ToastEnum.RoomRotateBuilding)
end

function slot0._rotateBlock(slot0)
	if not RoomMapBlockModel.instance:getTempBlockMO() then
		return
	end

	slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, {
		rotate = RoomRotateHelper.rotateRotate(slot1.rotate, 1)
	})
end

function slot0._rotateCharacter(slot0)
end

function slot0._btncancelOnClick(slot0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			slot0:_cancelBuilding()
		else
			slot0:_cancelBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			slot0:_cancelBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			slot0:_cancelCharacter()
		end
	end
end

function slot0._cancelBuilding(slot0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		return
	end

	if slot1.buildingState == RoomBuildingEnum.BuildingState.Temp then
		slot0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	elseif slot1.buildingState == RoomBuildingEnum.BuildingState.Revert then
		if slot1:isBuildingArea() and RoomBuildingAreaHelper.findTempOutBuildingMOList() and #slot2 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseMainBuilding, MsgBoxEnum.BoxType.Yes_No, slot0._requestUnUseBuilding, nil, , slot0, nil, , RoomBuildingAreaHelper.formatBuildingMOListNameStr(slot2))

			return
		end

		if slot0:_checkBuildingHasCriter(slot1) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseManufactureBuilding, MsgBoxEnum.BoxType.Yes_No, slot0._requestUnUseBuilding, nil, , slot0, nil, )

			return
		end

		if RoomBuildingAreaHelper.findTempOutTransportMOList() and #slot3 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseMainBuildingTransportPath, MsgBoxEnum.BoxType.Yes_No, slot0._requestUnUseBuilding, nil, , slot0, nil, )

			return
		end

		RoomMapController.instance:unUseBuildingRequest(slot1.id)
	end
end

function slot0._checkBuildingHasCriter(slot0, slot1)
	if slot1 and RoomBuildingEnum.BuildingArea[slot1.config and slot1.config.buildingType] then
		return true
	end

	return false
end

function slot0._cancelBlock(slot0)
	slot0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
end

function slot0._cancelCharacter(slot0)
	if not RoomCharacterModel.instance:getTempCharacterMO() then
		return
	end

	if slot1.characterState == RoomCharacterEnum.CharacterState.Temp then
		slot0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceCharacter)
	elseif slot1.characterState == RoomCharacterEnum.CharacterState.Revert then
		RoomMapController.instance:unUseCharacterRequest(slot1.id, nil, , true)
	end
end

function slot0._refreshUI(slot0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			slot0:_refreshBuildingUI()
		else
			slot0:_refreshBlockUI()
		end

		slot0._isCharacter = false
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			slot0:_refreshBuildingUI()

			slot0._isCharacter = false
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			slot0:_refreshCharacterUI()

			slot0._isCharacter = true
		else
			gohelper.setActive(slot0._gocontainer, false)
		end
	else
		gohelper.setActive(slot0._gocontainer, false)
	end
end

function slot0._refreshBuildingUI(slot0)
	gohelper.setActive(slot0._btncancel.gameObject, true)
	gohelper.setActive(slot0._btncancelcharacter.gameObject, false)

	slot1 = (RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm)) and slot0._dropOP ~= true

	gohelper.setActive(slot0._gocontainer, slot1)
	gohelper.setActive(slot0._gorotate, true)

	if slot1 then
		if RoomMapBuildingModel.instance:getTempBuildingMO() and slot0._scene.buildingmgr:getBuildingEntity(slot2.id, SceneTag.RoomBuilding) then
			slot6 = slot2.config and slot2.config.uiScale

			slot0:_setUIPos(Vector3(transformhelper.getPos((slot3:getBodyGO() or slot3.go).transform)), 0, slot6 and slot6 * 0.001)
		end

		slot0:_setRotateAudio(AudioEnum.Room.play_ui_home_board_switch)
		slot0:_setCancelAudio(AudioEnum.Room.play_ui_home_board_recovery)
		slot0:_setConfirmAudio(0)
	end

	recthelper.setAnchor(slot0._btncancel.gameObject.transform, recthelper.getAnchor(slot0._gocancelpos.transform))
	recthelper.setAnchor(slot0._btnconfirm.gameObject.transform, recthelper.getAnchor(slot0._goconfirmpos.transform))
end

function slot0._refreshBlockUI(slot0)
	gohelper.setActive(slot0._btncancel.gameObject, true)
	gohelper.setActive(slot0._btncancelcharacter.gameObject, false)

	slot1 = RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomFSMHelper.isCanJompTo(RoomEnum.FSMEditState.PlaceConfirm)

	gohelper.setActive(slot0._gocontainer, slot1)
	gohelper.setActive(slot0._gorotate, true)

	if slot1 then
		if RoomMapBlockModel.instance:getTempBlockMO() and slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomMapBlock) then
			slot0:_setUIPos(Vector3(transformhelper.getPos(slot3.go.transform)), 0.12)
		end

		slot0:_setRotateAudio(AudioEnum.Room.play_ui_home_board_switch)
		slot0:_setCancelAudio(AudioEnum.Room.play_ui_home_board_remove)
		slot0:_setConfirmAudio(0)
	end

	recthelper.setAnchor(slot0._btncancel.gameObject.transform, recthelper.getAnchor(slot0._gocancelpos.transform))
	recthelper.setAnchor(slot0._btnconfirm.gameObject.transform, recthelper.getAnchor(slot0._goconfirmpos.transform))
end

function slot0._refreshCharacterUI(slot0)
	gohelper.setActive(slot0._gorotate, true)
	gohelper.setActive(slot0._gocontainer, slot0._dropOP ~= true)
	gohelper.setActive(slot0._gorotate, false)
	gohelper.setActive(slot0._btncancel.gameObject, not slot1 or slot1.characterState ~= RoomCharacterEnum.CharacterState.Revert)
	gohelper.setActive(slot0._btncancelcharacter.gameObject, slot1 and slot1.characterState == RoomCharacterEnum.CharacterState.Revert)

	if RoomCharacterModel.instance:getTempCharacterMO() and slot0._scene.charactermgr:getCharacterEntity(slot1.id, SceneTag.RoomCharacter) then
		slot3 = slot1.currentPosition
		slot4 = 0.6 * RoomBlockEnum.BlockSize
		slot5 = slot0._scene.camera:getCameraRotate()

		slot0:_setUIPos(Vector3(slot3.x + slot4 * math.sin(slot5), 0, slot3.z + slot4 * math.cos(slot5)), 0.05, 0.5)
		slot0:_setRotateAudio(AudioEnum.Room.play_ui_home_role_switch)
		slot0:_setCancelAudio(AudioEnum.Room.play_ui_home_role_remove)
		slot0:_setConfirmAudio(AudioEnum.Room.play_ui_home_role_fix)
	end

	recthelper.setAnchor(slot0._btncancel.gameObject.transform, recthelper.getAnchor(slot0._gocancelposcharacter.transform))
	recthelper.setAnchor(slot0._btnconfirm.gameObject.transform, recthelper.getAnchor(slot0._goconfirmposcharacter.transform))
end

function slot0._setRotateAudio(slot0, slot1)
	if slot1 == 0 then
		gohelper.removeUIClickAudio(slot0._gorotate)
	else
		gohelper.addUIClickAudio(slot0._gorotate, slot1 or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function slot0._setCancelAudio(slot0, slot1)
	if slot1 == 0 then
		gohelper.removeUIClickAudio(slot0._btncancel.gameObject)
		gohelper.removeUIClickAudio(slot0._btncancelcharacter.gameObject)
	else
		gohelper.addUIClickAudio(slot0._btncancel.gameObject, slot1 or AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(slot0._btncancelcharacter.gameObject, slot1 or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function slot0._setConfirmAudio(slot0, slot1)
	if slot1 == 0 then
		gohelper.removeUIClickAudio(slot0._btnconfirm.gameObject)
	else
		gohelper.addUIClickAudio(slot0._btnconfirm.gameObject, slot1 or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function slot0._setUIPos(slot0, slot1, slot2, slot3)
	slot4 = RoomBendingHelper.worldToBendingSimple(slot1)
	slot6 = slot0._scene.camera:getCameraFocus()
	slot8 = Mathf.Clamp(2.912 / Vector3.Distance(slot0._scene.camera:getCameraPosition(), slot4), 0.4, 1)
	slot9 = slot0._scene.camera:getCameraRotate()

	recthelper.setAnchor(slot0._gocontainer.transform, recthelper.worldPosToAnchorPos(Vector3(slot4.x - (0.9 - slot8 * 0.5) * Mathf.Sin(slot9), slot4.y + (slot2 or 0), slot4.z - (0.9 - slot8 * 0.5) * Mathf.Cos(slot9)), slot0._goconfirm.transform).x, slot0._isCharacter and slot13.y or slot13.y - 20)
end

function slot0._onFSMEnterState(slot0, slot1)
	slot0:_refreshUI()
end

function slot0._onFSMLeaveState(slot0, slot1)
	slot0:_refreshUI()
end

function slot0._onConfirmRefreshUI(slot0)
	slot0:_refreshUI()
end

function slot0._pressBuildingUp(slot0)
	slot0._dropOP = true

	slot0:_refreshUI()
end

function slot0._dropBuildingDown(slot0)
	slot0._dropOP = false

	slot0:_refreshUI()
end

function slot0._pressCharacterUp(slot0)
	slot0._dropOP = true

	slot0:_refreshUI()
end

function slot0._dropCharacterDown(slot0)
	slot0._dropOP = false

	slot0:_refreshUI()
end

function slot0._isDropOP(slot0)
	if slot0._dropOP then
		return true
	end
end

function slot0._cameraTransformUpdate(slot0)
	slot0:_refreshUI()
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnconfirm.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0._onGamepadKeyUp(slot0, slot1)
	if (slot1 == GamepadEnum.KeyCode.LB or slot1 == GamepadEnum.KeyCode.RB) and slot0._gocontainer.activeInHierarchy then
		slot0._focusIndex = slot0._focusIndex or 2

		if slot0._focusIndex + (slot1 == GamepadEnum.KeyCode.LB and -1 or 1) == 2 and slot0._gorotate.activeInHierarchy == false then
			slot3 = slot3 + slot2
		end

		slot3 = math.min(3, math.max(1, slot3))
		slot0._focusIndex = slot3
		slot5 = recthelper.rectToRelativeAnchorPos(slot0._allFocusItem[slot3].position, ViewMgr.instance:getUIRoot().transform)

		GamepadController.instance:setPointerAnchor(slot5.x, slot5.y)
	end
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:_addBtnAudio()
	slot0:addEventCb(RoomMapController.instance, RoomEvent.FSMEnterState, slot0._onFSMEnterState, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.FSMLeaveState, slot0._onFSMLeaveState, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.PressBuildingUp, slot0._pressBuildingUp, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.DropBuildingDown, slot0._dropBuildingDown, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.PressCharacterUp, slot0._pressCharacterUp, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.DropCharacterDown, slot0._dropCharacterDown, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.RoomVieiwConfirmRefreshUI, slot0._onConfirmRefreshUI, slot0)

	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, slot0._onGamepadKeyUp, slot0)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btncancelcharacter:RemoveClickListener()
	slot0._rotateClick:RemoveClickListener()
	slot0._rotatePress:RemoveLongPressListener()
	TaskDispatcher.cancelTask(slot0._handleMouseInput, slot0)
end

slot0.prefabPath = "ui/viewres/room/roomviewconfirm.prefab"

return slot0
