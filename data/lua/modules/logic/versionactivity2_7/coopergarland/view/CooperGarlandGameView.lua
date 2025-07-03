module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameView", package.seeall)

local var_0_0 = class("CooperGarlandGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "Left")
	arg_1_0._goTargetStar1 = gohelper.findChild(arg_1_0.viewGO, "Left/Target/TargetStar/#go_TargetStar1")
	arg_1_0._goTargetStar2 = gohelper.findChild(arg_1_0.viewGO, "Left/Target/TargetStar/#go_TargetStar2")
	arg_1_0._btnControl = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Control/#btn_Control")
	arg_1_0._animControl = gohelper.findChildAnim(arg_1_0.viewGO, "Left/Control")
	arg_1_0._goJoystickMode = gohelper.findChild(arg_1_0.viewGO, "Left/Control/#go_Joystick")
	arg_1_0._txtjoystick = gohelper.findChildText(arg_1_0.viewGO, "Left/Control/#go_Joystick/txt_Joystick")
	arg_1_0._imgjoystick = gohelper.findChildImage(arg_1_0.viewGO, "Left/Control/#go_Joystick/image_Joystick")
	arg_1_0._goGyroscopeMode = gohelper.findChild(arg_1_0.viewGO, "Left/Control/#go_Gyroscope")
	arg_1_0._transJoyLeftPoint = gohelper.findChild(arg_1_0.viewGO, "Left/#go_joyLeftPoint").transform
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Reset")
	arg_1_0._goRemove = gohelper.findChild(arg_1_0.viewGO, "Right/Collect")
	arg_1_0._animCollect = gohelper.findChildAnim(arg_1_0.viewGO, "Right/Collect")
	arg_1_0._goIcon1 = gohelper.findChild(arg_1_0.viewGO, "Right/Collect/#go_Icon1")
	arg_1_0._goIcon2 = gohelper.findChild(arg_1_0.viewGO, "Right/Collect/#go_Icon2")
	arg_1_0._goselectRemove = gohelper.findChild(arg_1_0.viewGO, "Right/Collect/#go_select")
	arg_1_0._txtLightNum = gohelper.findChildText(arg_1_0.viewGO, "Right/Collect/#txt_LightNum")
	arg_1_0._btnRemoveMode = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "Right/Collect/#btn_modeClick")
	arg_1_0._transJoyRightPoint = gohelper.findChild(arg_1_0.viewGO, "Right/#go_joyRightPoint").transform
	arg_1_0._gojoystick = gohelper.findChild(arg_1_0.viewGO, "Right/#go_joyRightPoint/#go_joystick")
	arg_1_0._goTopTips = gohelper.findChild(arg_1_0.viewGO, "#go_TopTips")
	arg_1_0._goGameTips = gohelper.findChild(arg_1_0.viewGO, "#go_TopTips2")
	arg_1_0._txtGameTips = gohelper.findChildText(arg_1_0.viewGO, "#go_TopTips2/#txt_Tips")
	arg_1_0._goExtraTips = gohelper.findChild(arg_1_0.viewGO, "#go_ExtraTips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnControl:AddClickListener(arg_2_0._btnControlOnClick, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
	arg_2_0._btnRemoveMode:AddClickListener(arg_2_0._btnRemoveModeClick, arg_2_0)
	NavigateMgr.instance:addEscape(ViewName.CooperGarlandGameView, arg_2_0._onEscapeBtnClick, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnChangeControlMode, arg_2_0._onChangeControlMode, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, arg_2_0._onRemoveModeChange, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveComponent, arg_2_0._onRemoveComponent, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, arg_2_0._onPlayEnterNextRoundAnim, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnEnterNextRound, arg_2_0._onEnterNextRound, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, arg_2_0._onResetGame, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayFinishEpisodeStarVX, arg_2_0._onPlayStarFinishVx, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.ResetJoystick, arg_2_0._resetJoystick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnControl:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
	arg_3_0._btnRemoveMode:RemoveClickListener()
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnChangeControlMode, arg_3_0._onChangeControlMode, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, arg_3_0._onRemoveModeChange, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveComponent, arg_3_0._onRemoveComponent, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, arg_3_0._onPlayEnterNextRoundAnim, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnEnterNextRound, arg_3_0._onEnterNextRound, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, arg_3_0._onResetGame, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayFinishEpisodeStarVX, arg_3_0._onPlayStarFinishVx, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.ResetJoystick, arg_3_0._resetJoystick, arg_3_0)
end

function var_0_0._btnControlOnClick(arg_4_0)
	CooperGarlandController.instance:changeControlMode()

	local var_4_0 = CooperGarlandGameModel.instance:getIsJoystick()
	local var_4_1 = luaLang(var_4_0 and "v2a7_coopergarland_change_control_mode1" or "v2a7_coopergarland_change_control_mode2")

	arg_4_0:_showGameTips(var_4_1)
end

function var_0_0._btnResetOnClick(arg_5_0)
	CooperGarlandController.instance:setStopGame(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.CooperGarlandResetGame, MsgBoxEnum.BoxType.Yes_No, arg_5_0._confirmReset, arg_5_0._closeResetMessBox, nil, arg_5_0, arg_5_0)
end

function var_0_0._confirmReset(arg_6_0)
	CooperGarlandStatHelper.instance:sendMapReset(arg_6_0.viewName)
	CooperGarlandController.instance:resetGame()
end

function var_0_0._closeResetMessBox(arg_7_0)
	CooperGarlandController.instance:setStopGame(false)
end

function var_0_0._btnRemoveModeClick(arg_8_0)
	CooperGarlandController.instance:changeRemoveMode()
end

function var_0_0._onEscapeBtnClick(arg_9_0)
	arg_9_0.viewContainer:overrideClose()
end

function var_0_0._onChangeControlMode(arg_10_0)
	arg_10_0:refreshControlMode(true)
end

function var_0_0._onRemoveModeChange(arg_11_0)
	arg_11_0:refreshControlMode()
	arg_11_0:refreshRemoveMode()

	if CooperGarlandGameModel.instance:getIsRemoveMode() then
		arg_11_0:_showGameTips()
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_choose)
	end
end

function var_0_0._onRemoveComponent(arg_12_0)
	arg_12_0:_btnRemoveModeClick()
	arg_12_0:refreshRemoveCount(true)
	arg_12_0:_showGameTips(luaLang("v2a7_coopergarland_remove_comp"))
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_dispel)
end

function var_0_0._onPlayEnterNextRoundAnim(arg_13_0)
	if not arg_13_0.animator then
		return
	end

	arg_13_0.animator.enabled = true

	arg_13_0.animator:Play("switch", 0, 0)
end

function var_0_0._onEnterNextRound(arg_14_0)
	arg_14_0:refreshRemoveCount()
end

function var_0_0._onResetGame(arg_15_0)
	arg_15_0:refresh()
end

function var_0_0._onPlayStarFinishVx(arg_16_0)
	arg_16_0:setTargetStar(true, true)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_pkls_star_light)
	TaskDispatcher.runDelay(arg_16_0._afterPlayStarFinish, arg_16_0, TimeUtil.OneSecond)
end

function var_0_0._afterPlayStarFinish(arg_17_0)
	local var_17_0 = CooperGarlandGameModel.instance:getEpisodeId()

	CooperGarlandController.instance:finishEpisode(var_17_0, true)
end

function var_0_0._resetJoystick(arg_18_0)
	if not arg_18_0.joystick then
		return
	end

	arg_18_0.joystick:reset()
end

function var_0_0._showGameTips(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goGameTips, false)

	if string.nilorempty(arg_19_1) then
		return
	end

	arg_19_0._txtGameTips.text = arg_19_1

	gohelper.setActive(arg_19_0._goGameTips, true)
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0.animator = arg_20_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_20_0._gyroSensitivity = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.GyroSensitivity, true)
	arg_20_0._cubeResetSpeed = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubeBalanceRestSpeed, true)
	arg_20_0.joystick = MonoHelper.addNoUpdateLuaComOnceToGo(arg_20_0._gojoystick, VirtualFixedJoystick)

	if not arg_20_0._isRunning then
		arg_20_0._isRunning = true

		LateUpdateBeat:Add(arg_20_0._onLateUpdate, arg_20_0)
	end

	arg_20_0.originalAutoLeft = UnityEngine.Screen.autorotateToLandscapeLeft
	arg_20_0.originalAutoRight = UnityEngine.Screen.autorotateToLandscapeRight
	UnityEngine.Screen.autorotateToLandscapeLeft = false
	UnityEngine.Screen.autorotateToLandscapeRight = false
	arg_20_0._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()

	if arg_20_0._isMobilePlayer then
		arg_20_0.gyro = UnityEngine.Input.gyro
		arg_20_0.originalGyroStatus = arg_20_0.gyro.enabled
		arg_20_0.gyro.enabled = true
	end

	arg_20_0:setTargetStar(false)

	local var_20_0 = CooperGarlandModel.instance:getAct192Id()
	local var_20_1 = CooperGarlandGameModel.instance:getEpisodeId()
	local var_20_2 = CooperGarlandConfig.instance:isExtraEpisode(var_20_0, var_20_1)

	gohelper.setActive(arg_20_0._goExtraTips, var_20_2)
end

local var_0_1 = 3

function var_0_0._onLateUpdate(arg_21_0)
	if CooperGarlandGameModel.instance:getIsJoystick() then
		local var_21_0
		local var_21_1

		if not arg_21_0._isMobilePlayer then
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
				var_21_0 = 1
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
				var_21_0 = -1
			end

			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
				var_21_1 = 1
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
				var_21_1 = -1
			end
		end

		if var_21_0 or var_21_1 then
			arg_21_0.joystick:setInPutValue(var_21_0, var_21_1)
		end

		if arg_21_0.joystick:getIsDragging() or var_21_0 or var_21_1 then
			local var_21_2 = arg_21_0.joystick:getInputValue()

			CooperGarlandController.instance:changePanelBalance(var_21_2.x, var_21_2.y)

			arg_21_0._needReset = true
		elseif arg_21_0._needReset then
			arg_21_0:_resetJoystick()
			CooperGarlandController.instance:resetPanelBalance(arg_21_0._cubeResetSpeed)

			arg_21_0._needReset = false
		end
	else
		local var_21_3 = 0
		local var_21_4 = 0

		if arg_21_0.gyro then
			local var_21_5 = arg_21_0.gyro.gravity.normalized

			var_21_3 = var_21_5.x
			var_21_4 = var_21_5.y
		end

		local var_21_6 = Mathf.Clamp(arg_21_0._gyroSensitivity * var_21_3, -1, 1)
		local var_21_7 = Mathf.Clamp(arg_21_0._gyroSensitivity * var_21_4, -1, 1)

		CooperGarlandController.instance:changePanelBalance(var_21_6, var_21_7)
	end

	local var_21_8 = CooperGarlandGameEntityMgr.instance:getBallVelocity().magnitude * var_0_1

	AudioMgr.instance:setRTPCValue(AudioEnum2_7.CooperGarlandBallRTPC, var_21_8)
end

function var_0_0.onUpdateParam(arg_22_0)
	return
end

function var_0_0.onOpen(arg_23_0)
	arg_23_0:refresh()
end

function var_0_0.refresh(arg_24_0)
	arg_24_0:refreshRemoveCount()
	arg_24_0:refreshRemoveMode()
	arg_24_0:refreshControlMode()
end

function var_0_0.refreshRemoveCount(arg_25_0, arg_25_1)
	local var_25_0 = CooperGarlandGameModel.instance:getGameId()
	local var_25_1 = CooperGarlandGameModel.instance:getGameRound()
	local var_25_2 = CooperGarlandConfig.instance:getRemoveCount(var_25_0, var_25_1)
	local var_25_3 = var_25_2 and var_25_2 > 0

	if var_25_3 then
		local var_25_4 = CooperGarlandGameModel.instance:getRemoveCount()
		local var_25_5 = var_25_4 and var_25_4 > 0

		gohelper.setActive(arg_25_0._goIcon1, not var_25_5)
		gohelper.setActive(arg_25_0._goIcon2, var_25_5)

		if arg_25_1 then
			arg_25_0._animCollect:Play("switch", 0, 0)
		end

		arg_25_0._txtLightNum.text = luaLang("multiple") .. (var_25_4 or 0)
	end

	gohelper.setActive(arg_25_0._goRemove, var_25_3)
end

function var_0_0.refreshRemoveMode(arg_26_0)
	local var_26_0 = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(arg_26_0._goleft, not var_26_0)
	gohelper.setActive(arg_26_0._btnReset, not var_26_0)
	gohelper.setActive(arg_26_0._goTopTips, var_26_0)
	gohelper.setActive(arg_26_0._goselectRemove, var_26_0)
end

function var_0_0.refreshControlMode(arg_27_0, arg_27_1)
	local var_27_0 = CooperGarlandGameModel.instance:getIsJoystick()

	if var_27_0 then
		local var_27_1 = arg_27_0._transJoyRightPoint
		local var_27_2 = "v2a7_coopergarland_right_joystick"
		local var_27_3 = "v2a7_coopergarland_game_controlicon1"

		if CooperGarlandGameModel.instance:getControlMode() == CooperGarlandEnum.Const.JoystickModeLeft then
			var_27_1 = arg_27_0._transJoyLeftPoint
			var_27_2 = "v2a7_coopergarland_left_joystick"
			var_27_3 = "v2a7_coopergarland_game_controlicon3"
		end

		arg_27_0._txtjoystick.text = luaLang(var_27_2)

		arg_27_0._gojoystick.transform:SetParent(var_27_1, false)
		UISpriteSetMgr.instance:setV2a7CooperGarlandSprite(arg_27_0._imgjoystick, var_27_3)
	end

	local var_27_4 = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(arg_27_0._gojoystick, not var_27_4 and var_27_0)
	gohelper.setActive(arg_27_0._goGyroscopeMode, not var_27_0)
	gohelper.setActive(arg_27_0._goJoystickMode, var_27_0)

	if arg_27_1 then
		local var_27_5 = var_27_0 and "switch2" or "switch1"

		arg_27_0._animControl:Play(var_27_5, 0, 0)
	end
end

function var_0_0.setTargetStar(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_2 and arg_28_0.animator then
		arg_28_0.animator.enabled = false
	end

	gohelper.setActive(arg_28_0._goTargetStar1, not arg_28_1)
	gohelper.setActive(arg_28_0._goTargetStar2, arg_28_1)
end

function var_0_0.onClose(arg_29_0)
	if arg_29_0._isRunning then
		arg_29_0._isRunning = false

		LateUpdateBeat:Remove(arg_29_0._onLateUpdate, arg_29_0)
	end

	if arg_29_0.originalAutoLeft ~= nil then
		UnityEngine.Screen.autorotateToLandscapeLeft = arg_29_0.originalAutoLeft
	end

	if arg_29_0.originalAutoRight ~= nil then
		UnityEngine.Screen.autorotateToLandscapeRight = arg_29_0.originalAutoRight
	end

	if arg_29_0.gyro then
		arg_29_0.gyro.enabled = arg_29_0.originalGyroStatus
	end

	TaskDispatcher.cancelTask(arg_29_0._afterPlayStarFinish, arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	return
end

return var_0_0
