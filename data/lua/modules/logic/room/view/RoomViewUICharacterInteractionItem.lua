module("modules.logic.room.view.RoomViewUICharacterInteractionItem", package.seeall)

local var_0_0 = class("RoomViewUICharacterInteractionItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._heroId = arg_1_1
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._gochaticon = gohelper.findChild(arg_2_0._gocontainer, "go_chaticon")
	arg_2_0._btnchat = gohelper.findChildButton(arg_2_0._gocontainer, "go_chaticon/btn_chat")
	arg_2_0._godialog = gohelper.findChild(arg_2_0._gocontainer, "go_dialog")
	arg_2_0._txtdialog = gohelper.findChildText(arg_2_0._gocontainer, "go_dialog/bg/txt_dialog")
	arg_2_0._animator = arg_2_0._godialog:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._gogetfaith = gohelper.findChild(arg_2_0._gocontainer, "go_getfaith")
	arg_2_0._btngetfaith = gohelper.findChildButton(arg_2_0._gocontainer, "go_getfaith/btn_getfaith")
	arg_2_0._imageprocess = gohelper.findChildImage(arg_2_0._gocontainer, "go_getfaith/process")
	arg_2_0._gofullfaith = gohelper.findChild(arg_2_0._gocontainer, "go_fullfaith")
	arg_2_0._btnfull = gohelper.findChildButton(arg_2_0._gocontainer, "go_fullfaith/btn_full")
	arg_2_0._gomaxfaith = gohelper.findChild(arg_2_0._gocontainer, "go_maxfaith")
	arg_2_0._btnmax = gohelper.findChildButton(arg_2_0._gocontainer, "go_maxfaith/btn_max")
end

function var_0_0._customAddEventListeners(arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, arg_3_0._characterPositionChanged, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, arg_3_0._refreshBtnShow, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, arg_3_0._refreshBtnShow, arg_3_0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, arg_3_0._refreshBtnShow, arg_3_0)
	arg_3_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, arg_4_0._characterPositionChanged, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, arg_4_0._refreshBtnShow, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, arg_4_0._refreshBtnShow, arg_4_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, arg_4_0._refreshBtnShow, arg_4_0)
end

function var_0_0.refreshUI(arg_5_0, arg_5_1)
	arg_5_0:_refreshBtnShow()
	arg_5_0:_refreshShow(arg_5_1)
	arg_5_0:_refreshPosition()
end

function var_0_0._characterPositionChanged(arg_6_0, arg_6_1)
	if arg_6_0._heroId ~= arg_6_1 then
		return
	end

	arg_6_0:_refreshPosition()
end

function var_0_0._refreshBtnShow(arg_7_0)
	gohelper.setActive(arg_7_0._godialog, false)

	local var_7_0 = RoomCharacterModel.instance:getCharacterMOById(arg_7_0._heroId)

	if not var_7_0 then
		return
	end

	if not var_7_0:getCurrentInteractionId() then
		gohelper.setActive(arg_7_0._gochaticon, false)

		local var_7_1 = RoomCharacterController.instance:isCharacterFaithFull(var_7_0.heroId)

		gohelper.setActive(arg_7_0._gofullfaith, var_7_1 and RoomController.instance:isObMode() and RoomCharacterModel.instance:isShowFaithFull(var_7_0.heroId))

		if var_7_1 then
			gohelper.setActive(arg_7_0._gogetfaith, false)
			gohelper.setActive(arg_7_0._gomaxfaith, false)

			return
		end

		local var_7_2 = RoomCharacterHelper.getCharacterFaithFill(var_7_0)

		gohelper.setActive(arg_7_0._gogetfaith, var_7_2 > 0 and var_7_2 < 1)
		gohelper.setActive(arg_7_0._gomaxfaith, var_7_2 >= 1)

		if var_7_2 > 0 and var_7_2 < 1 then
			arg_7_0._imageprocess.fillAmount = var_7_2 * 0.55 + 0.2
		end

		return
	end

	gohelper.setActive(arg_7_0._gofullfaith, false)
	gohelper.setActive(arg_7_0._gogetfaith, false)
	gohelper.setActive(arg_7_0._gomaxfaith, false)

	local var_7_3 = RoomCharacterController.instance:getPlayingInteractionParam()

	gohelper.setActive(arg_7_0._gochaticon, not var_7_3)
end

function var_0_0._refreshShow(arg_8_0, arg_8_1)
	if not RoomCharacterModel.instance:getCharacterMOById(arg_8_0._heroId) then
		arg_8_0:_setShow(false, true)

		return
	end

	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_8_0:_setShow(false, arg_8_1)

		return
	end

	if arg_8_0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Normal then
		arg_8_0:_setShow(false, arg_8_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_8_0:_setShow(false, arg_8_1)

		return
	end

	arg_8_0:_setShow(true, arg_8_1)
end

function var_0_0.getUI3DPos(arg_9_0)
	local var_9_0 = RoomCharacterModel.instance:getCharacterMOById(arg_9_0._heroId)

	if not var_9_0 then
		return Vector3.zero
	end

	local var_9_1 = var_9_0.currentPosition
	local var_9_2 = var_9_1.y + 0.18
	local var_9_3 = arg_9_0._scene.charactermgr:getCharacterEntity(var_9_0.id, SceneTag.RoomCharacter)

	if var_9_3 then
		local var_9_4 = var_9_3.characterspine:getMountheadGOTrs()

		if var_9_4 then
			local var_9_5, var_9_6, var_9_7 = transformhelper.getPos(var_9_4)

			var_9_2 = var_9_6 - 0.02
		end
	end

	return (Vector3(var_9_1.x, var_9_2, var_9_1.z))
end

function var_0_0._refreshPosition(arg_10_0)
	local var_10_0 = arg_10_0:getUI3DPos()
	local var_10_1 = RoomBendingHelper.worldToBendingSimple(var_10_0)
	local var_10_2 = RoomBendingHelper.worldPosToAnchorPos(var_10_1, arg_10_0.go.transform.parent)

	if var_10_2 then
		var_10_2.x = var_10_2.x * 0.98

		recthelper.setAnchor(arg_10_0.go.transform, var_10_2.x, var_10_2.y)
	end

	local var_10_3 = 0

	if var_10_2 then
		local var_10_4 = CameraMgr.instance:getMainCameraGO()
		local var_10_5 = var_10_4.transform.position
		local var_10_6 = var_10_4.transform.forward
		local var_10_7 = var_10_1 - var_10_5
		local var_10_8 = Vector3.Dot(var_10_6, var_10_7)

		var_10_3 = var_10_8 == 0 and 0 or 1 / var_10_8
	end

	transformhelper.setLocalScale(arg_10_0._gocontainer.transform, var_10_3, var_10_3, var_10_3)
	arg_10_0:_refreshCanvasGroup()
end

function var_0_0._onClick(arg_11_0, arg_11_1, arg_11_2)
	if not RoomController.instance:isObMode() then
		return
	end

	local var_11_0 = RoomCharacterModel.instance:getCharacterMOById(arg_11_0._heroId)

	if not var_11_0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)

	if arg_11_1.transform:IsChildOf(arg_11_0._btngetfaith.transform) or arg_11_1.transform:IsChildOf(arg_11_0._btnmax.transform) then
		RoomCharacterController.instance:gainCharacterFaith({
			var_11_0.heroId
		})
		AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
	elseif arg_11_1.transform:IsChildOf(arg_11_0._btnfull.transform) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(var_11_0.heroId)
		GameFacade.showToast(RoomEnum.Toast.GainFaithFull)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif arg_11_1.transform:IsChildOf(arg_11_0._btnchat.transform) then
		RoomCharacterController.instance:startInteraction(var_11_0:getCurrentInteractionId(), true)
	end
end

function var_0_0._customOnDestory(arg_12_0)
	return
end

return var_0_0
