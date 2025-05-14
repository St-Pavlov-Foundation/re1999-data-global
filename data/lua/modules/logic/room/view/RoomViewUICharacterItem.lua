module("modules.logic.room.view.RoomViewUICharacterItem", package.seeall)

local var_0_0 = class("RoomViewUICharacterItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._heroId = arg_1_1
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._simageheroicon = gohelper.findChildImage(arg_2_0._gocontainer, "mask/simage_heroicon")
	arg_2_0._gochat = gohelper.findChild(arg_2_0._gocontainer, "go_chat")
	arg_2_0._btnchat = gohelper.findChildButton(arg_2_0._gocontainer, "go_chat/btn_chat")
	arg_2_0._gofullfaith = gohelper.findChild(arg_2_0._gocontainer, "go_fullfaith")
	arg_2_0._gogetfaith = gohelper.findChild(arg_2_0._gocontainer, "go_getfaith")
	arg_2_0._btngetfaith = gohelper.findChildButton(arg_2_0._gocontainer, "go_getfaith/btn_getfaith")
	arg_2_0._btnfull = gohelper.findChildButton(arg_2_0._gocontainer, "go_fullfaith/btn_full")
	arg_2_0._gomaxfaith = gohelper.findChild(arg_2_0._gocontainer, "go_maxfaith")
	arg_2_0._btnmax = gohelper.findChildButton(arg_2_0._gocontainer, "go_maxfaith/btn_max")
	arg_2_0._imageprocess = gohelper.findChildImage(arg_2_0._gocontainer, "go_getfaith/process")
	arg_2_0._goonbirthdayicon = gohelper.findChild(arg_2_0._gocontainer, "#image_onbirthday")
end

function var_0_0._customAddEventListeners(arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, arg_3_0._characterPositionChanged, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, arg_3_0._refreshBtnShow, arg_3_0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, arg_3_0._refreshBtnShow, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, arg_3_0._refreshBtnShow, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, arg_4_0._characterPositionChanged, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, arg_4_0._refreshBtnShow, arg_4_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, arg_4_0._refreshBtnShow, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, arg_4_0._refreshBtnShow, arg_4_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_4_0._onDailyRefresh, arg_4_0)
end

function var_0_0.refreshUI(arg_5_0, arg_5_1)
	arg_5_0:_refreshCharacter()
	arg_5_0:_refreshBtnShow()
	arg_5_0:_refreshShow(arg_5_1)
	arg_5_0:_refreshPosition()
	arg_5_0:_refreshBirthday()
end

function var_0_0._characterPositionChanged(arg_6_0, arg_6_1)
	if arg_6_0._heroId ~= arg_6_1 then
		return
	end

	arg_6_0:_refreshPosition()
end

function var_0_0._refreshCharacter(arg_7_0)
	local var_7_0 = RoomCharacterModel.instance:getCharacterMOById(arg_7_0._heroId)

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.skinId
	local var_7_2 = SkinConfig.instance:getSkinCo(var_7_1)

	gohelper.getSingleImage(arg_7_0._simageheroicon.gameObject):LoadImage(ResUrl.roomHeadIcon(var_7_2.headIcon))
end

function var_0_0._refreshBtnShow(arg_8_0)
	local var_8_0 = RoomCharacterModel.instance:getCharacterMOById(arg_8_0._heroId)

	if not var_8_0 or var_8_0:isTrainSourceState() then
		return
	end

	if arg_8_0._isPlayingGainAnim then
		return
	end

	TaskDispatcher.cancelTask(arg_8_0._gainCharacterFaithAnimEnd, arg_8_0)

	if var_8_0:getCurrentInteractionId() and RoomController.instance:isObMode() then
		gohelper.setActive(arg_8_0._gochat, true)
		gohelper.setActive(arg_8_0._gofullfaith, false)
		gohelper.setActive(arg_8_0._gogetfaith, false)
		gohelper.setActive(arg_8_0._gomaxfaith, false)

		return
	end

	gohelper.setActive(arg_8_0._gochat, false)

	local var_8_1 = RoomCharacterController.instance:isCharacterFaithFull(var_8_0.heroId)

	gohelper.setActive(arg_8_0._gofullfaith, var_8_1 and RoomController.instance:isObMode() and RoomCharacterModel.instance:isShowFaithFull(var_8_0.heroId))

	if var_8_1 then
		gohelper.setActive(arg_8_0._gogetfaith, false)
		gohelper.setActive(arg_8_0._gomaxfaith, false)

		return
	end

	local var_8_2 = RoomCharacterHelper.getCharacterFaithFill(var_8_0)

	gohelper.setActive(arg_8_0._gogetfaith, var_8_2 > 0 and var_8_2 < 1)
	gohelper.setActive(arg_8_0._gomaxfaith, var_8_2 >= 1)

	if var_8_2 > 0 and var_8_2 < 1 then
		arg_8_0._imageprocess.fillAmount = var_8_2 * 0.55 + 0.2
	end
end

function var_0_0._onDailyRefresh(arg_9_0)
	arg_9_0:_refreshBirthday()
end

function var_0_0._refreshShow(arg_10_0, arg_10_1)
	if not RoomCharacterModel.instance:getCharacterMOById(arg_10_0._heroId) then
		arg_10_0:_setShow(false, true)

		return
	end

	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_10_0:_setShow(false, arg_10_1)

		return
	end

	local var_10_0 = arg_10_0._scene.camera:getCameraState()

	if RoomEnum.CameraShowSpineMap[var_10_0] then
		arg_10_0:_setShow(false, arg_10_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_10_0:_setShow(false, arg_10_1)

		return
	end

	arg_10_0:_setShow(true, arg_10_1)
end

function var_0_0._refreshBirthday(arg_11_0)
	local var_11_0 = RoomCharacterModel.instance:isOnBirthday(arg_11_0._heroId)

	gohelper.setActive(arg_11_0._goonbirthdayicon, var_11_0)
end

function var_0_0.getUI3DPos(arg_12_0)
	local var_12_0 = RoomCharacterModel.instance:getCharacterMOById(arg_12_0._heroId)

	if not var_12_0 then
		return Vector3.zero
	end

	local var_12_1 = var_12_0.currentPosition

	return (Vector3(var_12_1.x, var_12_1.y, var_12_1.z))
end

function var_0_0._gainCharacterFaith(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 ~= 0 then
		arg_13_0._isPlayingGainAnim = false

		return
	end

	arg_13_0._baseAnimator:Play("room_task_lingqu", 0, 0)
	TaskDispatcher.runDelay(arg_13_0._gainCharacterFaithAnimEnd, arg_13_0, 1.5)
end

function var_0_0._gainCharacterFaithAnimEnd(arg_14_0)
	arg_14_0._isPlayingGainAnim = false

	arg_14_0:_refreshBtnShow()
end

function var_0_0._onClick(arg_15_0, arg_15_1, arg_15_2)
	if not RoomController.instance:isObMode() then
		return
	end

	local var_15_0 = RoomCharacterModel.instance:getCharacterMOById(arg_15_0._heroId)

	if not var_15_0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)

	if arg_15_1.transform:IsChildOf(arg_15_0._btngetfaith.gameObject.transform) or arg_15_1.transform:IsChildOf(arg_15_0._btnmax.gameObject.transform) then
		arg_15_0:_switchCamera(arg_15_0.gainCharacterFaith, arg_15_0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif arg_15_1.transform:IsChildOf(arg_15_0._btnfull.gameObject.transform) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(var_15_0.heroId)
		arg_15_0:_switchCamera()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif arg_15_1.transform:IsChildOf(arg_15_0._btnchat.gameObject.transform) then
		arg_15_0:_switchCamera(arg_15_0.startInteraction, arg_15_0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	else
		arg_15_0:_switchCamera()

		if RoomCharacterModel.instance:isNeedShowBirthdayToastTip(arg_15_0._heroId) then
			GameFacade.showToast(ToastEnum.CharacterOnBirthday)
			RoomCharacterModel.instance:setHasShowBirthdayToastTip(arg_15_0._heroId)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	end
end

function var_0_0._switchCamera(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = RoomCharacterModel.instance:getCharacterMOById(arg_16_0._heroId).currentPosition

	arg_16_0._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {
		focusX = var_16_0.x,
		focusY = var_16_0.z
	}, nil, arg_16_1, arg_16_2)
end

function var_0_0.startInteraction(arg_17_0)
	local var_17_0 = RoomCharacterModel.instance:getCharacterMOById(arg_17_0._heroId)

	if not var_17_0 then
		return
	end

	RoomCharacterController.instance:startInteraction(var_17_0:getCurrentInteractionId(), true)
end

function var_0_0.gainCharacterFaith(arg_18_0)
	if not RoomController.instance:isObMode() then
		return
	end

	local var_18_0 = RoomCharacterModel.instance:getCharacterMOById(arg_18_0._heroId)

	if not var_18_0 then
		return
	end

	RoomCharacterController.instance:gainCharacterFaith({
		var_18_0.heroId
	})
	AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
end

function var_0_0._customOnDestory(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._gainCharacterFaithAnimEnd, arg_19_0)
end

return var_0_0
