module("modules.logic.versionactivity2_5.autochess.view.AutoChessMainView", package.seeall)

local var_0_0 = class("AutoChessMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSpine = gohelper.findChild(arg_1_0.viewGO, "simage_fullbg/#go_Spine")
	arg_1_0._txtLeftTime = gohelper.findChildText(arg_1_0.viewGO, "#txt_LeftTime")
	arg_1_0._btnPVE = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVE")
	arg_1_0._btnGiveUpE = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVE/#btn_GiveUpE")
	arg_1_0._goRoundE = gohelper.findChild(arg_1_0.viewGO, "#btn_PVE/#go_RoundE")
	arg_1_0._txtRoundE = gohelper.findChildText(arg_1_0.viewGO, "#btn_PVE/#go_RoundE/#txt_RoundE")
	arg_1_0._goFinishPVE = gohelper.findChild(arg_1_0.viewGO, "#btn_PVE/#go_FinishPVE")
	arg_1_0._btnPVP = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVP")
	arg_1_0._btnGiveUpP = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVP/#btn_GiveUpP")
	arg_1_0._goRoundP = gohelper.findChild(arg_1_0.viewGO, "#btn_PVP/#go_RoundP")
	arg_1_0._txtRoundP = gohelper.findChildText(arg_1_0.viewGO, "#btn_PVP/#go_RoundP/#txt_RoundP")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._btnCourse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Course")
	arg_1_0._goBadgeContent = gohelper.findChild(arg_1_0.viewGO, "#go_BadgeContent")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Achievement")
	arg_1_0._goTip = gohelper.findChild(arg_1_0.viewGO, "#go_Tip")
	arg_1_0._txtTip = gohelper.findChildText(arg_1_0.viewGO, "#go_Tip/#txt_Tip")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPVE:AddClickListener(arg_2_0._btnPVEOnClick, arg_2_0)
	arg_2_0._btnGiveUpE:AddClickListener(arg_2_0._btnGiveUpEOnClick, arg_2_0)
	arg_2_0._btnPVP:AddClickListener(arg_2_0._btnPVPOnClick, arg_2_0)
	arg_2_0._btnGiveUpP:AddClickListener(arg_2_0._btnGiveUpPOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._btnCourse:AddClickListener(arg_2_0._btnCourseOnClick, arg_2_0)
	arg_2_0._btnAchievement:AddClickListener(arg_2_0._btnAchievementOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPVE:RemoveClickListener()
	arg_3_0._btnGiveUpE:RemoveClickListener()
	arg_3_0._btnPVP:RemoveClickListener()
	arg_3_0._btnGiveUpP:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._btnCourse:RemoveClickListener()
	arg_3_0._btnAchievement:RemoveClickListener()
end

local var_0_1 = "roles/v2a5_autochess_toycar/autochess_toycar_ui.prefab"

function var_0_0._btnGiveUpEOnClick(arg_4_0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE)
	end)
end

function var_0_0._btnGiveUpPOnClick(arg_6_0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVP)
	end)
end

function var_0_0._btnCourseOnClick(arg_8_0)
	ViewMgr.instance:openView(ViewName.AutoChessCourseView)
end

function var_0_0._btnAchievementOnClick(arg_9_0)
	local var_9_0 = ActivityConfig.instance:getActivityCo(arg_9_0.actId).achievementJumpId

	JumpController.instance:jump(var_9_0)
end

function var_0_0._btnPVEOnClick(arg_10_0)
	ViewMgr.instance:openView(ViewName.AutoChessLevelView)
end

function var_0_0._btnPVPOnClick(arg_11_0)
	local var_11_0 = AutoChessEnum.PvpEpisodeId
	local var_11_1 = lua_auto_chess_episode.configDict[var_11_0].preEpisode
	local var_11_2 = lua_auto_chess_episode.configDict[var_11_1]

	if not arg_11_0.actMo:isEpisodeUnlock(var_11_0) then
		GameFacade.showToast(ToastEnum.AutoChessPvpLock, var_11_2.name)

		return
	end

	local var_11_3 = AutoChessEnum.ModuleId.PVP

	arg_11_0.tempEpisodeId = var_11_0

	AutoChessController.instance:startGame(var_11_3, arg_11_0.tempEpisodeId)
end

function var_0_0._btnTaskOnClick(arg_12_0)
	ViewMgr.instance:openView(ViewName.AutoChessTaskView, {
		actId = arg_12_0.actId
	})
end

function var_0_0._editableInitView(arg_13_0)
	local var_13_0 = gohelper.findChild(arg_13_0._btnTask.gameObject, "go_reddot")

	RedDotController.instance:addRedDot(var_13_0, RedDotEnum.DotNode.V2a5_AutoChess)

	arg_13_0._uiSpine = GuiSpine.Create(arg_13_0._goSpine, true)

	arg_13_0._uiSpine:setResPath(var_0_1, arg_13_0._onSpineLoaded, arg_13_0, true)
end

function var_0_0._onSpineLoaded(arg_14_0)
	if arg_14_0._uiSpine then
		arg_14_0._uiSpine:play(SpineAnimState.born)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_toycar_appear)
		TaskDispatcher.runDelay(arg_14_0._bornFinish, arg_14_0, 1.83)
	end
end

function var_0_0._bornFinish(arg_15_0)
	arg_15_0:checkStartLoopSpine()
end

function var_0_0.onRandomMasterReply(arg_16_0)
	if arg_16_0.tempEpisodeId then
		AutoChessController.instance:openLeaderView({
			episodeId = arg_16_0.tempEpisodeId
		})
		arg_16_0:refreshBtnStatus()

		arg_16_0.tempEpisodeId = nil
	end
end

function var_0_0.onSettlPush(arg_17_0)
	if not ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		local var_17_0 = AutoChessModel.instance.settleData

		if var_17_0 then
			if var_17_0.moduleId == AutoChessEnum.ModuleId.PVP then
				if var_17_0.episodeId == 0 then
					arg_17_0.badgeItem:playProgressAnim(var_17_0.score)

					AutoChessModel.instance.settleData = nil
				else
					ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
				end
			else
				AutoChessModel.instance.settleData = nil
			end
		end
	end
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0.actId = Activity182Model.instance:getCurActId()

	arg_18_0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, arg_18_0.refreshUI, arg_18_0)
	arg_18_0:addEventCb(Activity182Controller.instance, Activity182Event.RandomMasterReply, arg_18_0.onRandomMasterReply, arg_18_0)
	arg_18_0:addEventCb(AutoChessController.instance, AutoChessEvent.SettlePush, arg_18_0.onSettlPush, arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_18_0.checkStopAudio, arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_18_0.checkStartLoopSpine, arg_18_0)
	arg_18_0:refreshUI()
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0:checkStopAudio()
	TaskDispatcher.cancelTask(arg_20_0._bornFinish, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0.refreshLeftTime, arg_20_0)
end

function var_0_0.refreshUI(arg_21_0)
	arg_21_0.actMo = Activity182Model.instance:getActMo()

	local var_21_0 = arg_21_0.actMo:isEpisodeUnlock(AutoChessEnum.PvpEpisodeId)

	ZProj.UGUIHelper.SetGrayscale(arg_21_0._btnPVP.gameObject, not var_21_0)
	arg_21_0:refreshLeftTime()
	TaskDispatcher.runRepeat(arg_21_0.refreshLeftTime, arg_21_0, TimeUtil.OneSecond)

	if not arg_21_0.badgeItem then
		local var_21_1 = arg_21_0:getResInst(AutoChessEnum.BadgeItemPath, arg_21_0._goBadgeContent)

		arg_21_0.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_1, AutoChessBadgeItem)
	end

	arg_21_0.badgeItem:setData(arg_21_0.actMo.rank, arg_21_0.actMo.score, AutoChessBadgeItem.ShowType.MainView)
	arg_21_0:refreshBtnStatus()
	arg_21_0:refreshDoubleRankTip()
end

function var_0_0.refreshBtnStatus(arg_22_0)
	local var_22_0 = arg_22_0.actMo:isEpisodePass(11006)

	gohelper.setActive(arg_22_0._goFinishPVE, var_22_0)

	local var_22_1 = arg_22_0.actMo.gameMoDic[AutoChessEnum.ModuleId.PVE]
	local var_22_2 = var_22_1.episodeId

	gohelper.setActive(arg_22_0._btnGiveUpE, var_22_1.start and GuideModel.instance:isGuideFinish(25406) and not var_22_0)

	if not var_22_0 and var_22_2 ~= 0 then
		local var_22_3 = lua_auto_chess_episode.configDict[var_22_2]

		arg_22_0._txtRoundE.text = string.format("%d/%d", var_22_1.currRound, var_22_3.maxRound)

		gohelper.setActive(arg_22_0._goRoundE, true)
	else
		gohelper.setActive(arg_22_0._goRoundE, false)
	end

	local var_22_4 = arg_22_0.actMo.gameMoDic[AutoChessEnum.ModuleId.PVP]
	local var_22_5 = var_22_4.episodeId

	gohelper.setActive(arg_22_0._btnGiveUpP, var_22_4.start)

	if var_22_5 ~= 0 then
		local var_22_6 = lua_auto_chess_episode.configDict[var_22_5]

		arg_22_0._txtRoundP.text = string.format("%d/%d", var_22_4.currRound, var_22_6.maxRound)

		gohelper.setActive(arg_22_0._goRoundP, true)
	else
		gohelper.setActive(arg_22_0._goRoundP, false)
	end
end

function var_0_0.refreshLeftTime(arg_23_0)
	arg_23_0._txtLeftTime.text = ActivityHelper.getActivityRemainTimeStr(arg_23_0.actId)
end

function var_0_0.refreshDoubleRankTip(arg_24_0)
	local var_24_0 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreRank].value)
	local var_24_1 = lua_auto_chess_rank.configDict[arg_24_0.actId][var_24_0].name
	local var_24_2 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreCnt].value)

	if var_24_0 >= arg_24_0.actMo.rank then
		local var_24_3 = luaLang("autochess_mainview_tips1")
		local var_24_4 = string.format("（%d/%d）", arg_24_0.actMo.doubleScoreTimes, var_24_2)

		arg_24_0._txtTip.text = GameUtil.getSubPlaceholderLuaLangThreeParam(var_24_3, var_24_1, var_24_2, var_24_4)

		gohelper.setActive(arg_24_0._goTip, true)
	else
		gohelper.setActive(arg_24_0._goTip, false)
	end
end

function var_0_0.checkStopAudio(arg_25_0, arg_25_1)
	if arg_25_1 ~= arg_25_0.viewName then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	end
end

function var_0_0.checkStartLoopSpine(arg_26_0)
	local var_26_0 = ViewMgr.instance:getOpenViewNameList()

	if var_26_0[#var_26_0] == arg_26_0.viewName then
		arg_26_0._uiSpine:play(SpineAnimState.idle1, true)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_toycar_standby_loop)
	end
end

return var_0_0
