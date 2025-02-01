module("modules.logic.room.view.RoomViewUICharacterInteractionItem", package.seeall)

slot0 = class("RoomViewUICharacterInteractionItem", RoomViewUIBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._heroId = slot1
end

function slot0._customOnInit(slot0)
	slot0._gochaticon = gohelper.findChild(slot0._gocontainer, "go_chaticon")
	slot0._btnchat = gohelper.findChildButton(slot0._gocontainer, "go_chaticon/btn_chat")
	slot0._godialog = gohelper.findChild(slot0._gocontainer, "go_dialog")
	slot0._txtdialog = gohelper.findChildText(slot0._gocontainer, "go_dialog/bg/txt_dialog")
	slot0._animator = slot0._godialog:GetComponent(typeof(UnityEngine.Animator))
	slot0._gogetfaith = gohelper.findChild(slot0._gocontainer, "go_getfaith")
	slot0._btngetfaith = gohelper.findChildButton(slot0._gocontainer, "go_getfaith/btn_getfaith")
	slot0._imageprocess = gohelper.findChildImage(slot0._gocontainer, "go_getfaith/process")
	slot0._gofullfaith = gohelper.findChild(slot0._gocontainer, "go_fullfaith")
	slot0._btnfull = gohelper.findChildButton(slot0._gocontainer, "go_fullfaith/btn_full")
	slot0._gomaxfaith = gohelper.findChild(slot0._gocontainer, "go_maxfaith")
	slot0._btnmax = gohelper.findChildButton(slot0._gocontainer, "go_maxfaith/btn_max")
end

function slot0._customAddEventListeners(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, slot0._refreshBtnShow, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, slot0._refreshBtnShow, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, slot0._refreshBtnShow, slot0)
	slot0:refreshUI(true)
end

function slot0._customRemoveEventListeners(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, slot0._refreshBtnShow, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, slot0._refreshBtnShow, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, slot0._refreshBtnShow, slot0)
end

function slot0.refreshUI(slot0, slot1)
	slot0:_refreshBtnShow()
	slot0:_refreshShow(slot1)
	slot0:_refreshPosition()
end

function slot0._characterPositionChanged(slot0, slot1)
	if slot0._heroId ~= slot1 then
		return
	end

	slot0:_refreshPosition()
end

function slot0._refreshBtnShow(slot0)
	gohelper.setActive(slot0._godialog, false)

	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return
	end

	if not slot1:getCurrentInteractionId() then
		gohelper.setActive(slot0._gochaticon, false)
		gohelper.setActive(slot0._gofullfaith, RoomCharacterController.instance:isCharacterFaithFull(slot1.heroId) and RoomController.instance:isObMode() and RoomCharacterModel.instance:isShowFaithFull(slot1.heroId))

		if slot3 then
			gohelper.setActive(slot0._gogetfaith, false)
			gohelper.setActive(slot0._gomaxfaith, false)

			return
		end

		gohelper.setActive(slot0._gogetfaith, RoomCharacterHelper.getCharacterFaithFill(slot1) > 0 and slot4 < 1)
		gohelper.setActive(slot0._gomaxfaith, slot4 >= 1)

		if slot4 > 0 and slot4 < 1 then
			slot0._imageprocess.fillAmount = slot4 * 0.55 + 0.2
		end

		return
	end

	gohelper.setActive(slot0._gofullfaith, false)
	gohelper.setActive(slot0._gogetfaith, false)
	gohelper.setActive(slot0._gomaxfaith, false)
	gohelper.setActive(slot0._gochaticon, not RoomCharacterController.instance:getPlayingInteractionParam())
end

function slot0._refreshShow(slot0, slot1)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		slot0:_setShow(false, true)

		return
	end

	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		slot0:_setShow(false, slot1)

		return
	end

	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Normal then
		slot0:_setShow(false, slot1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		slot0:_setShow(false, slot1)

		return
	end

	slot0:_setShow(true, slot1)
end

function slot0.getUI3DPos(slot0)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return Vector3.zero
	end

	slot3 = slot1.currentPosition.y + 0.18

	if slot0._scene.charactermgr:getCharacterEntity(slot1.id, SceneTag.RoomCharacter) and slot4.characterspine:getMountheadGOTrs() then
		slot6, slot7, slot8 = transformhelper.getPos(slot5)
		slot3 = slot7 - 0.02
	end

	return Vector3(slot2.x, slot3, slot2.z)
end

function slot0._refreshPosition(slot0)
	if RoomBendingHelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(slot0:getUI3DPos()), slot0.go.transform.parent) then
		slot3.x = slot3.x * 0.98

		recthelper.setAnchor(slot0.go.transform, slot3.x, slot3.y)
	end

	slot4 = 0

	if slot3 then
		slot5 = CameraMgr.instance:getMainCameraGO()
		slot4 = Vector3.Dot(slot5.transform.forward, slot2 - slot5.transform.position) == 0 and 0 or 1 / slot9
	end

	transformhelper.setLocalScale(slot0._gocontainer.transform, slot4, slot4, slot4)
	slot0:_refreshCanvasGroup()
end

function slot0._onClick(slot0, slot1, slot2)
	if not RoomController.instance:isObMode() then
		return
	end

	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)

	if slot1.transform:IsChildOf(slot0._btngetfaith.transform) or slot1.transform:IsChildOf(slot0._btnmax.transform) then
		RoomCharacterController.instance:gainCharacterFaith({
			slot3.heroId
		})
		AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
	elseif slot1.transform:IsChildOf(slot0._btnfull.transform) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(slot3.heroId)
		GameFacade.showToast(RoomEnum.Toast.GainFaithFull)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif slot1.transform:IsChildOf(slot0._btnchat.transform) then
		RoomCharacterController.instance:startInteraction(slot3:getCurrentInteractionId(), true)
	end
end

function slot0._customOnDestory(slot0)
end

return slot0
