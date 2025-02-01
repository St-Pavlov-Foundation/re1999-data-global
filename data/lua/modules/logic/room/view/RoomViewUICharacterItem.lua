module("modules.logic.room.view.RoomViewUICharacterItem", package.seeall)

slot0 = class("RoomViewUICharacterItem", RoomViewUIBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._heroId = slot1
end

function slot0._customOnInit(slot0)
	slot0._simageheroicon = gohelper.findChildImage(slot0._gocontainer, "mask/simage_heroicon")
	slot0._gochat = gohelper.findChild(slot0._gocontainer, "go_chat")
	slot0._btnchat = gohelper.findChildButton(slot0._gocontainer, "go_chat/btn_chat")
	slot0._gofullfaith = gohelper.findChild(slot0._gocontainer, "go_fullfaith")
	slot0._gogetfaith = gohelper.findChild(slot0._gocontainer, "go_getfaith")
	slot0._btngetfaith = gohelper.findChildButton(slot0._gocontainer, "go_getfaith/btn_getfaith")
	slot0._btnfull = gohelper.findChildButton(slot0._gocontainer, "go_fullfaith/btn_full")
	slot0._gomaxfaith = gohelper.findChild(slot0._gocontainer, "go_maxfaith")
	slot0._btnmax = gohelper.findChildButton(slot0._gocontainer, "go_maxfaith/btn_max")
	slot0._imageprocess = gohelper.findChildImage(slot0._gocontainer, "go_getfaith/process")
	slot0._goonbirthdayicon = gohelper.findChild(slot0._gocontainer, "#image_onbirthday")
end

function slot0._customAddEventListeners(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, slot0._refreshBtnShow, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, slot0._refreshBtnShow, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, slot0._refreshBtnShow, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:refreshUI(true)
end

function slot0._customRemoveEventListeners(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, slot0._refreshBtnShow, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, slot0._refreshBtnShow, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, slot0._refreshBtnShow, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.refreshUI(slot0, slot1)
	slot0:_refreshCharacter()
	slot0:_refreshBtnShow()
	slot0:_refreshShow(slot1)
	slot0:_refreshPosition()
	slot0:_refreshBirthday()
end

function slot0._characterPositionChanged(slot0, slot1)
	if slot0._heroId ~= slot1 then
		return
	end

	slot0:_refreshPosition()
end

function slot0._refreshCharacter(slot0)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return
	end

	gohelper.getSingleImage(slot0._simageheroicon.gameObject):LoadImage(ResUrl.roomHeadIcon(SkinConfig.instance:getSkinCo(slot1.skinId).headIcon))
end

function slot0._refreshBtnShow(slot0)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) or slot1:isTrainSourceState() then
		return
	end

	if slot0._isPlayingGainAnim then
		return
	end

	TaskDispatcher.cancelTask(slot0._gainCharacterFaithAnimEnd, slot0)

	if slot1:getCurrentInteractionId() and RoomController.instance:isObMode() then
		gohelper.setActive(slot0._gochat, true)
		gohelper.setActive(slot0._gofullfaith, false)
		gohelper.setActive(slot0._gogetfaith, false)
		gohelper.setActive(slot0._gomaxfaith, false)

		return
	end

	gohelper.setActive(slot0._gochat, false)
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
end

function slot0._onDailyRefresh(slot0)
	slot0:_refreshBirthday()
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

	if RoomEnum.CameraShowSpineMap[slot0._scene.camera:getCameraState()] then
		slot0:_setShow(false, slot1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		slot0:_setShow(false, slot1)

		return
	end

	slot0:_setShow(true, slot1)
end

function slot0._refreshBirthday(slot0)
	gohelper.setActive(slot0._goonbirthdayicon, RoomCharacterModel.instance:isOnBirthday(slot0._heroId))
end

function slot0.getUI3DPos(slot0)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return Vector3.zero
	end

	slot2 = slot1.currentPosition

	return Vector3(slot2.x, slot2.y, slot2.z)
end

function slot0._gainCharacterFaith(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		slot0._isPlayingGainAnim = false

		return
	end

	slot0._baseAnimator:Play("room_task_lingqu", 0, 0)
	TaskDispatcher.runDelay(slot0._gainCharacterFaithAnimEnd, slot0, 1.5)
end

function slot0._gainCharacterFaithAnimEnd(slot0)
	slot0._isPlayingGainAnim = false

	slot0:_refreshBtnShow()
end

function slot0._onClick(slot0, slot1, slot2)
	if not RoomController.instance:isObMode() then
		return
	end

	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)

	if slot1.transform:IsChildOf(slot0._btngetfaith.gameObject.transform) or slot1.transform:IsChildOf(slot0._btnmax.gameObject.transform) then
		slot0:_switchCamera(slot0.gainCharacterFaith, slot0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif slot1.transform:IsChildOf(slot0._btnfull.gameObject.transform) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(slot3.heroId)
		slot0:_switchCamera()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif slot1.transform:IsChildOf(slot0._btnchat.gameObject.transform) then
		slot0:_switchCamera(slot0.startInteraction, slot0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	else
		slot0:_switchCamera()

		if RoomCharacterModel.instance:isNeedShowBirthdayToastTip(slot0._heroId) then
			GameFacade.showToast(ToastEnum.CharacterOnBirthday)
			RoomCharacterModel.instance:setHasShowBirthdayToastTip(slot0._heroId)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	end
end

function slot0._switchCamera(slot0, slot1, slot2)
	slot4 = RoomCharacterModel.instance:getCharacterMOById(slot0._heroId).currentPosition

	slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {
		focusX = slot4.x,
		focusY = slot4.z
	}, nil, slot1, slot2)
end

function slot0.startInteraction(slot0)
	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return
	end

	RoomCharacterController.instance:startInteraction(slot1:getCurrentInteractionId(), true)
end

function slot0.gainCharacterFaith(slot0)
	if not RoomController.instance:isObMode() then
		return
	end

	if not RoomCharacterModel.instance:getCharacterMOById(slot0._heroId) then
		return
	end

	RoomCharacterController.instance:gainCharacterFaith({
		slot1.heroId
	})
	AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
end

function slot0._customOnDestory(slot0)
	TaskDispatcher.cancelTask(slot0._gainCharacterFaithAnimEnd, slot0)
end

return slot0
