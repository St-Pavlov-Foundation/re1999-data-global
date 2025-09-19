module("modules.logic.versionactivity2_5.autochess.view.AutoChessMainView", package.seeall)

local var_0_0 = class("AutoChessMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSpine = gohelper.findChild(arg_1_0.viewGO, "simage_fullbg/#go_Spine")
	arg_1_0._txtLeftTime = gohelper.findChildText(arg_1_0.viewGO, "#txt_LeftTime")
	arg_1_0._btnPVE = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVE")
	arg_1_0._goRuleTime = gohelper.findChild(arg_1_0.viewGO, "#btn_PVE/#go_RuleTime")
	arg_1_0._txtRuleTime = gohelper.findChildText(arg_1_0.viewGO, "#btn_PVE/#go_RuleTime/#txt_RuleTime")
	arg_1_0._goRoundE = gohelper.findChild(arg_1_0.viewGO, "#btn_PVE/#go_RoundE")
	arg_1_0._txtRoundE = gohelper.findChildText(arg_1_0.viewGO, "#btn_PVE/#go_RoundE/#txt_RoundE")
	arg_1_0._btnGiveUpE = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVE/#btn_GiveUpE")
	arg_1_0._btnPVP = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVP")
	arg_1_0._goRoundP = gohelper.findChild(arg_1_0.viewGO, "#btn_PVP/#go_RoundP")
	arg_1_0._txtRoundP = gohelper.findChildText(arg_1_0.viewGO, "#btn_PVP/#go_RoundP/#txt_RoundP")
	arg_1_0._btnGiveUpP = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_PVP/#btn_GiveUpP")
	arg_1_0._btnFriend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Friend")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._btnHandBook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_HandBook")
	arg_1_0._goBadgeContent = gohelper.findChild(arg_1_0.viewGO, "#go_BadgeContent")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Achievement")
	arg_1_0._btnCourse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Course")
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
	arg_2_0._btnFriend:AddClickListener(arg_2_0._btnFriendOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._btnHandBook:AddClickListener(arg_2_0._btnHandBookOnClick, arg_2_0)
	arg_2_0._btnAchievement:AddClickListener(arg_2_0._btnAchievementOnClick, arg_2_0)
	arg_2_0._btnCourse:AddClickListener(arg_2_0._btnCourseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPVE:RemoveClickListener()
	arg_3_0._btnGiveUpE:RemoveClickListener()
	arg_3_0._btnPVP:RemoveClickListener()
	arg_3_0._btnGiveUpP:RemoveClickListener()
	arg_3_0._btnFriend:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._btnHandBook:RemoveClickListener()
	arg_3_0._btnAchievement:RemoveClickListener()
	arg_3_0._btnCourse:RemoveClickListener()
end

function var_0_0._btnHandBookOnClick(arg_4_0)
	AutoChessController.instance:statButtonClick(arg_4_0.viewName, "_btnHandBookOnClick")
	AutoChessController.instance:openAutoChessHandbook()
end

function var_0_0._btnFriendOnClick(arg_5_0)
	AutoChessController.instance:statButtonClick(arg_5_0.viewName, "_btnFriendOnClick")
	Activity182Rpc.instance:sendAct182GetHasSnapshotFriendRequest(arg_5_0.actId, arg_5_0._getHasSnapshotReply, arg_5_0)
end

function var_0_0._getHasSnapshotReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == 0 then
		AutoChessController.instance:openFriendBattleView()
		arg_6_0:closeThis()
	end
end

function var_0_0._btnGiveUpEOnClick(arg_7_0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVP2)
	end)
end

function var_0_0._btnGiveUpPOnClick(arg_9_0)
	local var_9_0 = AutoChessEnum.ModuleId.PVP
	local var_9_1 = lua_auto_chess_rank.configDict[arg_9_0.actId][arg_9_0.actMo.rank]
	local var_9_2 = string.splitToNumber(var_9_1.round2Score, "|")
	local var_9_3 = arg_9_0.actMo:getGameMo(arg_9_0.actId, var_9_0)
	local var_9_4 = var_9_2[var_9_3.currRound ~= 0 and var_9_3.currRound or var_9_3.currRound + 1]

	if var_9_4 < 0 and var_9_1.protection then
		local var_9_5 = lua_auto_chess_rank.configDict[arg_9_0.actId][arg_9_0.actMo.rank - 1]
		local var_9_6 = (var_9_5 and var_9_5.score or 0) - arg_9_0.actMo.score

		var_9_4 = var_9_6 < var_9_4 and var_9_4 or var_9_6
	end

	if var_9_4 == 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.AutoChessGiveUpTip2, MsgBoxEnum.BoxType.Yes_No, function()
			AutoChessRpc.instance:sendAutoChessGiveUpRequest(var_9_0)
		end)
	else
		local var_9_7

		if var_9_4 < 0 then
			var_9_7 = string.format("<color=#9f342c>%s</color>", var_9_4)
		else
			var_9_7 = string.format("<color=#27682e>+%s</color>", var_9_4)
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.AutoChessGiveUpTip1, MsgBoxEnum.BoxType.Yes_No, function()
			AutoChessRpc.instance:sendAutoChessGiveUpRequest(var_9_0)
		end, nil, nil, nil, nil, nil, var_9_7)
	end
end

function var_0_0._btnCourseOnClick(arg_12_0)
	AutoChessController.instance:statButtonClick(arg_12_0.viewName, "_btnCourseOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessCourseView)
end

function var_0_0._btnAchievementOnClick(arg_13_0)
	AutoChessController.instance:statButtonClick(arg_13_0.viewName, "_btnAchievementOnClick")

	local var_13_0 = ActivityConfig.instance:getActivityCo(arg_13_0.actId).achievementJumpId

	JumpController.instance:jump(var_13_0)
end

function var_0_0._btnPVEOnClick(arg_14_0)
	AutoChessController.instance:statButtonClick(arg_14_0.viewName, "_btnPVEOnClick")

	if arg_14_0.crazyActId then
		local var_14_0 = AutoChessConfig.instance:getPvpEpisodeCo(arg_14_0.crazyActId)

		AutoChessController.instance:startGame(arg_14_0.crazyActId, AutoChessEnum.ModuleId.PVP2, var_14_0)
	end
end

function var_0_0._btnPVPOnClick(arg_15_0)
	AutoChessController.instance:statButtonClick(arg_15_0.viewName, "_btnPVPOnClick")

	if not arg_15_0.actMo:isEpisodeUnlock(arg_15_0.pvpEpisodeCo.id) then
		local var_15_0 = arg_15_0.pvpEpisodeCo.preEpisode
		local var_15_1 = AutoChessConfig.instance:getEpisodeCO(var_15_0)

		GameFacade.showToast(ToastEnum.AutoChessPvpLock, var_15_1.name)

		return
	end

	local var_15_2 = AutoChessEnum.ModuleId.PVP

	AutoChessController.instance:startGame(arg_15_0.actId, var_15_2, arg_15_0.pvpEpisodeCo)
end

function var_0_0._btnTaskOnClick(arg_16_0)
	AutoChessController.instance:statButtonClick(arg_16_0.viewName, "_btnTaskOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessTaskView, {
		actId = arg_16_0.actId
	})
end

local var_0_1 = "roles/v2a5_autochess_toycar/autochess_toycar_ui.prefab"

function var_0_0._editableInitView(arg_17_0)
	local var_17_0 = gohelper.findChild(arg_17_0._btnTask.gameObject, "go_reddot")

	RedDotController.instance:addRedDot(var_17_0, RedDotEnum.DotNode.V2a5_AutoChess)

	arg_17_0._uiSpine = GuiSpine.Create(arg_17_0._goSpine, true)

	arg_17_0._uiSpine:setResPath(var_0_1, arg_17_0._onSpineLoaded, arg_17_0, true)

	arg_17_0.actId = Activity182Model.instance:getCurActId()
	arg_17_0.pvpEpisodeCo = AutoChessConfig.instance:getPvpEpisodeCo(arg_17_0.actId)
end

function var_0_0._onSpineLoaded(arg_18_0)
	if arg_18_0._uiSpine then
		arg_18_0._uiSpine:play(SpineAnimState.born)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_toycar_appear)
		TaskDispatcher.runDelay(arg_18_0._bornFinish, arg_18_0, 1.83)
	end
end

function var_0_0._bornFinish(arg_19_0)
	arg_19_0:checkStartLoopSpine()
end

function var_0_0.onRandomMasterReply(arg_20_0)
	AutoChessController.instance:openLeaderView({
		actId = arg_20_0.actId,
		moduleId = AutoChessEnum.ModuleId.PVP
	})
	arg_20_0:refreshBtnStatus()
end

function var_0_0.onSettlPush(arg_21_0)
	if not ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		local var_21_0 = AutoChessModel.instance.settleData

		if var_21_0 then
			local var_21_1 = var_21_0.moduleId

			if var_21_1 == AutoChessEnum.ModuleId.PVP then
				if var_21_0.episodeId == 0 then
					arg_21_0.badgeItem:playProgressAnim(var_21_0.score)

					AutoChessModel.instance.settleData = nil
				else
					ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
				end
			elseif var_21_1 == AutoChessEnum.ModuleId.PVP2 then
				ViewMgr.instance:openView(ViewName.AutoChessCrazySettleView)
			else
				AutoChessModel.instance.settleData = nil
			end
		end
	end
end

function var_0_0.onOpen(arg_22_0)
	arg_22_0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, arg_22_0.refreshUI, arg_22_0)
	arg_22_0:addEventCb(Activity182Controller.instance, Activity182Event.RandomMasterReply, arg_22_0.onRandomMasterReply, arg_22_0)
	arg_22_0:addEventCb(AutoChessController.instance, AutoChessEvent.SettlePush, arg_22_0.onSettlPush, arg_22_0)
	arg_22_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_22_0.checkStopAudio, arg_22_0)
	arg_22_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_22_0.checkStartLoopSpine, arg_22_0)
	arg_22_0:refreshUI()
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0:checkStopAudio()
	TaskDispatcher.cancelTask(arg_23_0._bornFinish, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.refreshLeftTime, arg_23_0)
end

function var_0_0.refreshUI(arg_24_0)
	arg_24_0.crazyActId = Activity182Controller.instance:getCrazyActId()
	arg_24_0.actMo = Activity182Model.instance:getActMo()

	local var_24_0 = arg_24_0.actMo:isEpisodeUnlock(arg_24_0.pvpEpisodeCo.id)

	ZProj.UGUIHelper.SetGrayscale(arg_24_0._btnPVP.gameObject, not var_24_0)
	arg_24_0:refreshLeftTime()
	TaskDispatcher.runRepeat(arg_24_0.refreshLeftTime, arg_24_0, TimeUtil.OneMinuteSecond)

	if not arg_24_0.badgeItem then
		local var_24_1 = arg_24_0:getResInst(AutoChessStrEnum.ResPath.BadgeItem, arg_24_0._goBadgeContent)

		arg_24_0.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_1, AutoChessBadgeItem)
	end

	arg_24_0.badgeItem:setData(arg_24_0.actMo.rank, arg_24_0.actMo.score, AutoChessBadgeItem.ShowType.MainView)
	arg_24_0:refreshBtnStatus()
	arg_24_0:refreshDoubleRankTip()
end

function var_0_0.refreshBtnStatus(arg_25_0)
	if arg_25_0.crazyActId then
		local var_25_0 = arg_25_0.actMo:getGameMo(arg_25_0.crazyActId, AutoChessEnum.ModuleId.PVP2)
		local var_25_1 = var_25_0.episodeId

		gohelper.setActive(arg_25_0._btnGiveUpE, var_25_0.start)

		if var_25_1 ~= 0 then
			local var_25_2 = AutoChessConfig.instance:getEpisodeCO(var_25_1)

			arg_25_0._txtRoundE.text = string.format("%d/%d", var_25_0.currRound, var_25_2.maxRound)
		end

		gohelper.setActive(arg_25_0._goRoundE, var_25_1 ~= 0)
		gohelper.setActive(arg_25_0._goRuleTime, arg_25_0.crazyActId == Activity182Enum.CrazyActId.Crazy1)
	else
		gohelper.setActive(arg_25_0._btnGiveUpE, false)
		gohelper.setActive(arg_25_0._goRoundE, false)
		gohelper.setActive(arg_25_0._goRuleTime, false)
	end

	local var_25_3 = arg_25_0.actMo:getGameMo(arg_25_0.actId, AutoChessEnum.ModuleId.PVP)
	local var_25_4 = var_25_3.episodeId

	gohelper.setActive(arg_25_0._btnGiveUpP, var_25_3.start)

	if var_25_4 ~= 0 then
		local var_25_5 = AutoChessConfig.instance:getEpisodeCO(var_25_4)

		arg_25_0._txtRoundP.text = string.format("%d/%d", var_25_3.currRound, var_25_5.maxRound)

		gohelper.setActive(arg_25_0._goRoundP, true)
	else
		gohelper.setActive(arg_25_0._goRoundP, false)
	end
end

function var_0_0.refreshLeftTime(arg_26_0)
	arg_26_0._txtLeftTime.text = ActivityHelper.getActivityRemainTimeStr(arg_26_0.actId)

	if arg_26_0.crazyActId == Activity182Enum.CrazyActId.Crazy1 then
		local var_26_0 = ActivityHelper.getActivityRemainTimeStr(arg_26_0.crazyActId)

		arg_26_0._txtRuleTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_mainview_timetip"), var_26_0)
	end
end

function var_0_0.refreshDoubleRankTip(arg_27_0)
	local var_27_0 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreRank].value)
	local var_27_1 = lua_auto_chess_rank.configDict[arg_27_0.actId][var_27_0].name
	local var_27_2 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreCnt].value)

	if var_27_0 >= arg_27_0.actMo.rank then
		local var_27_3 = luaLang("autochess_mainview_tips1")
		local var_27_4 = string.format(luaLang("AutoChessMainView_refreshDoubleRankTip_allCnt"), arg_27_0.actMo.doubleScoreTimes, var_27_2)

		arg_27_0._txtTip.text = GameUtil.getSubPlaceholderLuaLangThreeParam(var_27_3, var_27_1, var_27_2, var_27_4)

		gohelper.setActive(arg_27_0._goTip, true)
	else
		gohelper.setActive(arg_27_0._goTip, false)
	end
end

function var_0_0.checkStopAudio(arg_28_0, arg_28_1)
	if arg_28_1 ~= arg_28_0.viewName then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	end
end

function var_0_0.checkStartLoopSpine(arg_29_0)
	local var_29_0 = ViewMgr.instance:getOpenViewNameList()

	if var_29_0[#var_29_0] == arg_29_0.viewName then
		arg_29_0._uiSpine:play(SpineAnimState.idle1, true)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_toycar_standby_loop)
	end
end

return var_0_0
