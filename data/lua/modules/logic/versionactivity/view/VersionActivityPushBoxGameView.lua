module("modules.logic.versionactivity.view.VersionActivityPushBoxGameView", package.seeall)

local var_0_0 = class("VersionActivityPushBoxGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnforward = gohelper.findChildButton(arg_1_0.viewGO, "controllarea/#btn_forward")
	arg_1_0._btnleft = gohelper.findChildButton(arg_1_0.viewGO, "controllarea/#btn_left")
	arg_1_0._btnright = gohelper.findChildButton(arg_1_0.viewGO, "controllarea/#btn_right")
	arg_1_0._btnback = gohelper.findChildButton(arg_1_0.viewGO, "controllarea/#btn_back")
	arg_1_0._btnundo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_undo")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._txtsecurityvalue = gohelper.findChildText(arg_1_0.viewGO, "securitybg/#txt_securityvalue")
	arg_1_0._txtsecurityvalueeffect = gohelper.findChildText(arg_1_0.viewGO, "securitybg/#txt_securityvalue_effect")
	arg_1_0._goresult = gohelper.findChild(arg_1_0.viewGO, "#go_result")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_result/#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_result/#go_fail")
	arg_1_0._simageresulticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/#go_success/succeed")
	arg_1_0._simagedecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/#simage_decorate")
	arg_1_0._simageleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/#simage_left")
	arg_1_0._simageright = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/#simage_right")
	arg_1_0._btnquit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#go_fail/#btn_quit")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#go_fail/#btn_restart")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnforward:AddClickListener(arg_2_0._btnforwardOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnundo:AddClickListener(arg_2_0._btnundoOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnquit:AddClickListener(arg_2_0._btnquitOnClick, arg_2_0)
	arg_2_0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshWarningNum, arg_2_0._onRefreshWarningNum, arg_2_0)
	arg_2_0:addEventCb(PushBoxController.instance, PushBoxEvent.GameWin, arg_2_0._onGameWin, arg_2_0)
	arg_2_0:addEventCb(PushBoxController.instance, PushBoxEvent.GameOver, arg_2_0._onGameOver, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnforward:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnundo:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnquit:RemoveClickListener()
end

function var_0_0._btnforwardOnClick(arg_4_0)
	arg_4_0:_walk(PushBoxGameMgr.Direction.Up)
end

function var_0_0._btnbackOnClick(arg_5_0)
	arg_5_0:_walk(PushBoxGameMgr.Direction.Down)
end

function var_0_0._btnleftOnClick(arg_6_0)
	arg_6_0:_walk(PushBoxGameMgr.Direction.Left)
end

function var_0_0._btnrightOnClick(arg_7_0)
	arg_7_0:_walk(PushBoxGameMgr.Direction.Right)
end

function var_0_0._btnundoOnClick(arg_8_0)
	arg_8_0._game_mgr:revertStep()
end

function var_0_0._btnresetOnClick(arg_9_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.ResetPushBox, MsgBoxEnum.BoxType.Yes_No, function()
		arg_9_0:_statEnd(StatEnum.Result.Reset)
		arg_9_0:_statStart()
		arg_9_0._game_mgr:revertGame()
	end)
end

function var_0_0._btnrestartOnClick(arg_11_0)
	arg_11_0._game_mgr:revertGame()

	arg_11_0._gameDone = nil

	gohelper.setActive(arg_11_0._goresult, false)
	arg_11_0:_statStart()
end

function var_0_0._btnquitOnClick(arg_12_0)
	if arg_12_0._gameDone and Time.realtimeSinceStartup - arg_12_0._gameDone < 1.5 then
		return
	end

	arg_12_0:_onBtnClose()
end

function var_0_0._btntaskrewardOnClick(arg_13_0)
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, 1)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._simagedecorate:LoadImage(ResUrl.getActivityWarmUpBg("bg_bodian"))

	arg_14_0._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(arg_14_0._simagedecorate.gameObject, SingleBgToMaterial)

	arg_14_0._bgMaterial:loadMaterial(arg_14_0._simagedecorate, "ui_black2transparent")
	arg_14_0._simageleft:LoadImage(ResUrl.getVersionActivityIcon("pushbox/btn_zt1"))
	arg_14_0._simageright:LoadImage(ResUrl.getVersionActivityIcon("pushbox/btn_zt2"))

	arg_14_0._statViewTime = nil
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0.viewContainer._navigateButtonView:setOverrideClose(arg_16_0._onNavigateCloseCallback, arg_16_0)

	arg_16_0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	arg_16_0._txtsecurityvalue.text = 0
	arg_16_0._success_click = gohelper.findChildClickWithAudio(arg_16_0.viewGO, "#go_result/#go_success")

	arg_16_0._success_click:AddClickListener(arg_16_0._successClick, arg_16_0)
	TaskDispatcher.runRepeat(arg_16_0._onFrame, arg_16_0, 0.001)
	arg_16_0:_statStart()
end

function var_0_0._onFrame(arg_17_0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.W) then
		arg_17_0:_walk(PushBoxGameMgr.Direction.Up)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.S) then
		arg_17_0:_walk(PushBoxGameMgr.Direction.Down)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.A) then
		arg_17_0:_walk(PushBoxGameMgr.Direction.Left)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.D) then
		arg_17_0:_walk(PushBoxGameMgr.Direction.Right)
	end
end

function var_0_0._onRefreshWarningNum(arg_18_0, arg_18_1)
	if arg_18_0._game_mgr:gameIsFinish() then
		return
	end

	if not arg_18_0._last_num then
		arg_18_0._last_num = 0
	end

	arg_18_0._txtsecurityvalue.text = arg_18_1
	arg_18_0._txtsecurityvalueeffect.text = arg_18_1

	if arg_18_0._last_num ~= arg_18_1 then
		gohelper.setActive(arg_18_0._txtsecurityvalueeffect.gameObject, false)
		gohelper.setActive(arg_18_0._txtsecurityvalueeffect.gameObject, true)
	end

	arg_18_0._last_num = arg_18_1
end

function var_0_0._onGameWin(arg_19_0, arg_19_1)
	arg_19_0._cur_warning = arg_19_1

	local var_19_0 = arg_19_0._game_mgr:getConfig().id
	local var_19_1 = "OnPushBoxWinPause" .. var_19_0
	local var_19_2 = GuideEvent[var_19_1]
	local var_19_3 = GuideEvent.OnPushBoxWinContinue
	local var_19_4 = arg_19_0._onWinPauseGuideOver
	local var_19_5 = arg_19_0

	GuideController.instance:GuideFlowPauseAndContinue(var_19_1, var_19_2, var_19_3, var_19_4, var_19_5)
end

function var_0_0._onWinPauseGuideOver(arg_20_0)
	arg_20_0._gameDone = Time.realtimeSinceStartup

	local var_20_0
	local var_20_1 = arg_20_0._cur_warning >= 60 and "img_tcst" or arg_20_0._cur_warning >= 30 and "img_scgm" or "img_jctq"

	arg_20_0._simageresulticon:LoadImage(ResUrl.getPushBoxResultIcon(var_20_1))
	gohelper.setActive(arg_20_0._goresult, true)
	gohelper.setActive(arg_20_0._gosuccess, true)
	gohelper.setActive(arg_20_0._gofail, false)

	arg_20_0._win = PushBoxGameMgr.finishNewEpisode

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_develop_success)
	arg_20_0:_statEnd(StatEnum.Result.Success)
end

function var_0_0._onGameOver(arg_21_0)
	arg_21_0._gameDone = Time.realtimeSinceStartup

	arg_21_0._simageresulticon:LoadImage(ResUrl.getPushBoxResultIcon("img_shibai_jhsb"))
	gohelper.setActive(arg_21_0._goresult, true)
	gohelper.setActive(arg_21_0._gofail, true)
	gohelper.setActive(arg_21_0._gosuccess, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_develop_fail)
	arg_21_0:_statEnd(StatEnum.Result.Fail)
end

function var_0_0._successClick(arg_22_0)
	if arg_22_0._gameDone and Time.realtimeSinceStartup - arg_22_0._gameDone < 1.5 then
		return
	end

	arg_22_0:_onBtnClose()
end

function var_0_0._walk(arg_23_0, arg_23_1)
	if arg_23_0._gameDone then
		return
	end

	if not arg_23_0._last_time then
		arg_23_0._last_time = Time.realtimeSinceStartup
	elseif Time.realtimeSinceStartup - arg_23_0._last_time < 0.3 then
		return
	end

	arg_23_0._last_time = Time.realtimeSinceStartup

	arg_23_0._game_mgr:_onMove(arg_23_1)
end

function var_0_0._onBtnClose(arg_24_0)
	local var_24_0 = {
		id = GameSceneMgr.instance:getCurScene().gameMgr:getCurStageID(),
		win = arg_24_0._win
	}

	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxLevelView, var_24_0)
	arg_24_0:closeThis()
end

function var_0_0.onClose(arg_25_0)
	arg_25_0.viewContainer._navigateButtonView:setOverrideClose(nil, nil)
	TaskDispatcher.cancelTask(arg_25_0._onFrame, arg_25_0)
	arg_25_0._success_click:RemoveClickListener()
	arg_25_0._simageresulticon:UnLoadImage()
	arg_25_0:_statEnd(StatEnum.Result.Abort)
end

function var_0_0._onNavigateCloseCallback(arg_26_0)
	if TimeUtil.getDayFirstLoginRed("PushBoxFirstQuitGameNotice") then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, function()
			TimeUtil.setDayFirstLoginRed("PushBoxFirstQuitGameNotice")
			arg_26_0:_onBtnClose()
		end)
	else
		arg_26_0:_onBtnClose()
	end
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._simagedecorate:UnLoadImage()
	arg_28_0._bgMaterial:dispose()
	arg_28_0._simageleft:UnLoadImage()
	arg_28_0._simageright:UnLoadImage()
end

function var_0_0._statStart(arg_29_0)
	if arg_29_0._statViewTime then
		return
	end

	arg_29_0._statViewTime = ServerTime.now()
end

function var_0_0._statEnd(arg_30_0, arg_30_1)
	if not arg_30_0._statViewTime then
		return
	end

	local var_30_0 = ServerTime.now() - arg_30_0._statViewTime
	local var_30_1 = arg_30_0._game_mgr:getConfig()
	local var_30_2 = var_30_1.id
	local var_30_3 = var_30_1.name

	arg_30_0._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitSokoban, {
		[StatEnum.EventProperties.UseTime] = var_30_0,
		[StatEnum.EventProperties.MapId] = tostring(var_30_2),
		[StatEnum.EventProperties.MapName] = var_30_3,
		[StatEnum.EventProperties.Result] = arg_30_1
	})
end

return var_0_0
