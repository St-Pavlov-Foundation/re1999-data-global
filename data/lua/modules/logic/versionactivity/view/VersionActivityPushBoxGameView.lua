module("modules.logic.versionactivity.view.VersionActivityPushBoxGameView", package.seeall)

slot0 = class("VersionActivityPushBoxGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnforward = gohelper.findChildButton(slot0.viewGO, "controllarea/#btn_forward")
	slot0._btnleft = gohelper.findChildButton(slot0.viewGO, "controllarea/#btn_left")
	slot0._btnright = gohelper.findChildButton(slot0.viewGO, "controllarea/#btn_right")
	slot0._btnback = gohelper.findChildButton(slot0.viewGO, "controllarea/#btn_back")
	slot0._btnundo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_undo")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._txtsecurityvalue = gohelper.findChildText(slot0.viewGO, "securitybg/#txt_securityvalue")
	slot0._txtsecurityvalueeffect = gohelper.findChildText(slot0.viewGO, "securitybg/#txt_securityvalue_effect")
	slot0._goresult = gohelper.findChild(slot0.viewGO, "#go_result")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_result/#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_result/#go_fail")
	slot0._simageresulticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/#go_success/succeed")
	slot0._simagedecorate = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/#simage_decorate")
	slot0._simageleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/#simage_left")
	slot0._simageright = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/#simage_right")
	slot0._btnquit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#go_fail/#btn_quit")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#go_fail/#btn_restart")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnforward:AddClickListener(slot0._btnforwardOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnundo:AddClickListener(slot0._btnundoOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnquit:AddClickListener(slot0._btnquitOnClick, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshWarningNum, slot0._onRefreshWarningNum, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.GameWin, slot0._onGameWin, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.GameOver, slot0._onGameOver, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnforward:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnback:RemoveClickListener()
	slot0._btnundo:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnquit:RemoveClickListener()
end

function slot0._btnforwardOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Up)
end

function slot0._btnbackOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Down)
end

function slot0._btnleftOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Left)
end

function slot0._btnrightOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Right)
end

function slot0._btnundoOnClick(slot0)
	slot0._game_mgr:revertStep()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.ResetPushBox, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_statEnd(StatEnum.Result.Reset)
		uv0:_statStart()
		uv0._game_mgr:revertGame()
	end)
end

function slot0._btnrestartOnClick(slot0)
	slot0._game_mgr:revertGame()

	slot0._gameDone = nil

	gohelper.setActive(slot0._goresult, false)
	slot0:_statStart()
end

function slot0._btnquitOnClick(slot0)
	if slot0._gameDone and Time.realtimeSinceStartup - slot0._gameDone < 1.5 then
		return
	end

	slot0:_onBtnClose()
end

function slot0._btntaskrewardOnClick(slot0)
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, 1)
end

function slot0._editableInitView(slot0)
	slot0._simagedecorate:LoadImage(ResUrl.getActivityWarmUpBg("bg_bodian"))

	slot0._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._simagedecorate.gameObject, SingleBgToMaterial)

	slot0._bgMaterial:loadMaterial(slot0._simagedecorate, "ui_black2transparent")
	slot0._simageleft:LoadImage(ResUrl.getVersionActivityIcon("pushbox/btn_zt1"))
	slot0._simageright:LoadImage(ResUrl.getVersionActivityIcon("pushbox/btn_zt2"))

	slot0._statViewTime = nil
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.viewContainer._navigateButtonView:setOverrideClose(slot0._onNavigateCloseCallback, slot0)

	slot0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	slot0._txtsecurityvalue.text = 0
	slot0._success_click = gohelper.findChildClickWithAudio(slot0.viewGO, "#go_result/#go_success")

	slot0._success_click:AddClickListener(slot0._successClick, slot0)
	TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.001)
	slot0:_statStart()
end

function slot0._onFrame(slot0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.W) then
		slot0:_walk(PushBoxGameMgr.Direction.Up)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.S) then
		slot0:_walk(PushBoxGameMgr.Direction.Down)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.A) then
		slot0:_walk(PushBoxGameMgr.Direction.Left)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.D) then
		slot0:_walk(PushBoxGameMgr.Direction.Right)
	end
end

function slot0._onRefreshWarningNum(slot0, slot1)
	if slot0._game_mgr:gameIsFinish() then
		return
	end

	if not slot0._last_num then
		slot0._last_num = 0
	end

	slot0._txtsecurityvalue.text = slot1
	slot0._txtsecurityvalueeffect.text = slot1

	if slot0._last_num ~= slot1 then
		gohelper.setActive(slot0._txtsecurityvalueeffect.gameObject, false)
		gohelper.setActive(slot0._txtsecurityvalueeffect.gameObject, true)
	end

	slot0._last_num = slot1
end

function slot0._onGameWin(slot0, slot1)
	slot0._cur_warning = slot1
	slot4 = "OnPushBoxWinPause" .. slot0._game_mgr:getConfig().id

	GuideController.instance:GuideFlowPauseAndContinue(slot4, GuideEvent[slot4], GuideEvent.OnPushBoxWinContinue, slot0._onWinPauseGuideOver, slot0)
end

function slot0._onWinPauseGuideOver(slot0)
	slot0._gameDone = Time.realtimeSinceStartup
	slot1 = nil

	slot0._simageresulticon:LoadImage(ResUrl.getPushBoxResultIcon(slot0._cur_warning >= 60 and "img_tcst" or slot0._cur_warning >= 30 and "img_scgm" or "img_jctq"))
	gohelper.setActive(slot0._goresult, true)
	gohelper.setActive(slot0._gosuccess, true)
	gohelper.setActive(slot0._gofail, false)

	slot0._win = PushBoxGameMgr.finishNewEpisode

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_develop_success)
	slot0:_statEnd(StatEnum.Result.Success)
end

function slot0._onGameOver(slot0)
	slot0._gameDone = Time.realtimeSinceStartup

	slot0._simageresulticon:LoadImage(ResUrl.getPushBoxResultIcon("img_shibai_jhsb"))
	gohelper.setActive(slot0._goresult, true)
	gohelper.setActive(slot0._gofail, true)
	gohelper.setActive(slot0._gosuccess, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_develop_fail)
	slot0:_statEnd(StatEnum.Result.Fail)
end

function slot0._successClick(slot0)
	if slot0._gameDone and Time.realtimeSinceStartup - slot0._gameDone < 1.5 then
		return
	end

	slot0:_onBtnClose()
end

function slot0._walk(slot0, slot1)
	if slot0._gameDone then
		return
	end

	if not slot0._last_time then
		slot0._last_time = Time.realtimeSinceStartup
	elseif Time.realtimeSinceStartup - slot0._last_time < 0.3 then
		return
	end

	slot0._last_time = Time.realtimeSinceStartup

	slot0._game_mgr:_onMove(slot1)
end

function slot0._onBtnClose(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxLevelView, {
		id = GameSceneMgr.instance:getCurScene().gameMgr:getCurStageID(),
		win = slot0._win
	})
	slot0:closeThis()
end

function slot0.onClose(slot0)
	slot0.viewContainer._navigateButtonView:setOverrideClose(nil, )
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
	slot0._success_click:RemoveClickListener()
	slot0._simageresulticon:UnLoadImage()
	slot0:_statEnd(StatEnum.Result.Abort)
end

function slot0._onNavigateCloseCallback(slot0)
	if TimeUtil.getDayFirstLoginRed("PushBoxFirstQuitGameNotice") then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, function ()
			TimeUtil.setDayFirstLoginRed("PushBoxFirstQuitGameNotice")
			uv0:_onBtnClose()
		end)
	else
		slot0:_onBtnClose()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagedecorate:UnLoadImage()
	slot0._bgMaterial:dispose()
	slot0._simageleft:UnLoadImage()
	slot0._simageright:UnLoadImage()
end

function slot0._statStart(slot0)
	if slot0._statViewTime then
		return
	end

	slot0._statViewTime = ServerTime.now()
end

function slot0._statEnd(slot0, slot1)
	if not slot0._statViewTime then
		return
	end

	slot3 = slot0._game_mgr:getConfig()
	slot0._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitSokoban, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._statViewTime,
		[StatEnum.EventProperties.MapId] = tostring(slot3.id),
		[StatEnum.EventProperties.MapName] = slot3.name,
		[StatEnum.EventProperties.Result] = slot1
	})
end

return slot0
