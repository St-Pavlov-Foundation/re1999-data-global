module("modules.logic.versionactivity2_5.autochess.view.AutoChessMainView", package.seeall)

slot0 = class("AutoChessMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._goSpine = gohelper.findChild(slot0.viewGO, "simage_fullbg/#go_Spine")
	slot0._txtLeftTime = gohelper.findChildText(slot0.viewGO, "#txt_LeftTime")
	slot0._btnPVE = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_PVE")
	slot0._btnGiveUpE = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_PVE/#btn_GiveUpE")
	slot0._goRoundE = gohelper.findChild(slot0.viewGO, "#btn_PVE/#go_RoundE")
	slot0._txtRoundE = gohelper.findChildText(slot0.viewGO, "#btn_PVE/#go_RoundE/#txt_RoundE")
	slot0._goFinishPVE = gohelper.findChild(slot0.viewGO, "#btn_PVE/#go_FinishPVE")
	slot0._btnPVP = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_PVP")
	slot0._btnGiveUpP = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_PVP/#btn_GiveUpP")
	slot0._goRoundP = gohelper.findChild(slot0.viewGO, "#btn_PVP/#go_RoundP")
	slot0._txtRoundP = gohelper.findChildText(slot0.viewGO, "#btn_PVP/#go_RoundP/#txt_RoundP")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._btnCourse = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Course")
	slot0._goBadgeContent = gohelper.findChild(slot0.viewGO, "#go_BadgeContent")
	slot0._btnAchievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Achievement")
	slot0._goTip = gohelper.findChild(slot0.viewGO, "#go_Tip")
	slot0._txtTip = gohelper.findChildText(slot0.viewGO, "#go_Tip/#txt_Tip")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPVE:AddClickListener(slot0._btnPVEOnClick, slot0)
	slot0._btnGiveUpE:AddClickListener(slot0._btnGiveUpEOnClick, slot0)
	slot0._btnPVP:AddClickListener(slot0._btnPVPOnClick, slot0)
	slot0._btnGiveUpP:AddClickListener(slot0._btnGiveUpPOnClick, slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._btnCourse:AddClickListener(slot0._btnCourseOnClick, slot0)
	slot0._btnAchievement:AddClickListener(slot0._btnAchievementOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPVE:RemoveClickListener()
	slot0._btnGiveUpE:RemoveClickListener()
	slot0._btnPVP:RemoveClickListener()
	slot0._btnGiveUpP:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
	slot0._btnCourse:RemoveClickListener()
	slot0._btnAchievement:RemoveClickListener()
end

slot1 = "roles/v2a5_autochess_toycar/autochess_toycar_ui.prefab"

function slot0._btnGiveUpEOnClick(slot0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function ()
		AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE)
	end)
end

function slot0._btnGiveUpPOnClick(slot0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function ()
		AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVP)
	end)
end

function slot0._btnCourseOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessCourseView)
end

function slot0._btnAchievementOnClick(slot0)
	JumpController.instance:jump(ActivityConfig.instance:getActivityCo(slot0.actId).achievementJumpId)
end

function slot0._btnPVEOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessLevelView)
end

function slot0._btnPVPOnClick(slot0)
	slot1 = AutoChessEnum.PvpEpisodeId

	if not slot0.actMo:isEpisodeUnlock(slot1) then
		GameFacade.showToast(ToastEnum.AutoChessPvpLock, lua_auto_chess_episode.configDict[lua_auto_chess_episode.configDict[slot1].preEpisode].name)

		return
	end

	slot0.tempEpisodeId = slot1

	AutoChessController.instance:startGame(AutoChessEnum.ModuleId.PVP, slot0.tempEpisodeId)
end

function slot0._btnTaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessTaskView, {
		actId = slot0.actId
	})
end

function slot0._editableInitView(slot0)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0._btnTask.gameObject, "go_reddot"), RedDotEnum.DotNode.V2a5_AutoChess)

	slot0._uiSpine = GuiSpine.Create(slot0._goSpine, true)

	slot0._uiSpine:setResPath(uv0, slot0._onSpineLoaded, slot0, true)
end

function slot0._onSpineLoaded(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:play(SpineAnimState.born)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_toycar_appear)
		TaskDispatcher.runDelay(slot0._bornFinish, slot0, 1.83)
	end
end

function slot0._bornFinish(slot0)
	slot0:checkStartLoopSpine()
end

function slot0.onRandomMasterReply(slot0)
	if slot0.tempEpisodeId then
		AutoChessController.instance:openLeaderView({
			episodeId = slot0.tempEpisodeId
		})
		slot0:refreshBtnStatus()

		slot0.tempEpisodeId = nil
	end
end

function slot0.onSettlPush(slot0)
	if not ViewMgr.instance:isOpen(ViewName.AutoChessGameView) and AutoChessModel.instance.settleData then
		if slot1.moduleId == AutoChessEnum.ModuleId.PVP then
			if slot1.episodeId == 0 then
				slot0.badgeItem:playProgressAnim(slot1.score)

				AutoChessModel.instance.settleData = nil
			else
				ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
			end
		else
			AutoChessModel.instance.settleData = nil
		end
	end
end

function slot0.onOpen(slot0)
	slot0.actId = Activity182Model.instance:getCurActId()

	slot0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity182Controller.instance, Activity182Event.RandomMasterReply, slot0.onRandomMasterReply, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.SettlePush, slot0.onSettlPush, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.checkStopAudio, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.checkStartLoopSpine, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:checkStopAudio()
	TaskDispatcher.cancelTask(slot0._bornFinish, slot0)
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
end

function slot0.refreshUI(slot0)
	slot0.actMo = Activity182Model.instance:getActMo()

	ZProj.UGUIHelper.SetGrayscale(slot0._btnPVP.gameObject, not slot0.actMo:isEpisodeUnlock(AutoChessEnum.PvpEpisodeId))
	slot0:refreshLeftTime()
	TaskDispatcher.runRepeat(slot0.refreshLeftTime, slot0, TimeUtil.OneSecond)

	if not slot0.badgeItem then
		slot0.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.BadgeItemPath, slot0._goBadgeContent), AutoChessBadgeItem)
	end

	slot0.badgeItem:setData(slot0.actMo.rank, slot0.actMo.score, AutoChessBadgeItem.ShowType.MainView)
	slot0:refreshBtnStatus()
	slot0:refreshDoubleRankTip()
end

function slot0.refreshBtnStatus(slot0)
	gohelper.setActive(slot0._goFinishPVE, slot0.actMo:isEpisodePass(11006))

	slot2 = slot0.actMo.gameMoDic[AutoChessEnum.ModuleId.PVE]
	slot3 = slot2.episodeId

	gohelper.setActive(slot0._btnGiveUpE, slot2.start and GuideModel.instance:isGuideFinish(25406) and not slot1)

	if not slot1 and slot3 ~= 0 then
		slot0._txtRoundE.text = string.format("%d/%d", slot2.currRound, lua_auto_chess_episode.configDict[slot3].maxRound)

		gohelper.setActive(slot0._goRoundE, true)
	else
		gohelper.setActive(slot0._goRoundE, false)
	end

	slot2 = slot0.actMo.gameMoDic[AutoChessEnum.ModuleId.PVP]

	gohelper.setActive(slot0._btnGiveUpP, slot2.start)

	if slot2.episodeId ~= 0 then
		slot0._txtRoundP.text = string.format("%d/%d", slot2.currRound, lua_auto_chess_episode.configDict[slot3].maxRound)

		gohelper.setActive(slot0._goRoundP, true)
	else
		gohelper.setActive(slot0._goRoundP, false)
	end
end

function slot0.refreshLeftTime(slot0)
	slot0._txtLeftTime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.refreshDoubleRankTip(slot0)
	slot1 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreRank].value)
	slot3 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreCnt].value)

	if slot0.actMo.rank <= slot1 then
		slot0._txtTip.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("autochess_mainview_tips1"), lua_auto_chess_rank.configDict[slot0.actId][slot1].name, slot3, string.format("（%d/%d）", slot0.actMo.doubleScoreTimes, slot3))

		gohelper.setActive(slot0._goTip, true)
	else
		gohelper.setActive(slot0._goTip, false)
	end
end

function slot0.checkStopAudio(slot0, slot1)
	if slot1 ~= slot0.viewName then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	end
end

function slot0.checkStartLoopSpine(slot0)
	slot1 = ViewMgr.instance:getOpenViewNameList()

	if slot1[#slot1] == slot0.viewName then
		slot0._uiSpine:play(SpineAnimState.idle1, true)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_toycar_standby_loop)
	end
end

return slot0
