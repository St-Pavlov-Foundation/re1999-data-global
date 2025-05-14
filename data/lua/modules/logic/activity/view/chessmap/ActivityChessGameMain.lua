module("modules.logic.activity.view.chessmap.ActivityChessGameMain", package.seeall)

local var_0_0 = class("ActivityChessGameMain", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagechessboard = gohelper.findChildSingleImage(arg_1_0.viewGO, "scroll/viewport/#go_content/#simage_chessboard")
	arg_1_0._txtcurround = gohelper.findChildText(arg_1_0.viewGO, "roundbg/anim/curround/#txt_curround")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_restart")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "scroll/viewport/#go_content")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_taskitem")
	arg_1_0._gooptip = gohelper.findChild(arg_1_0.viewGO, "#go_optip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrestart:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	local var_4_0 = ActivityChessGameModel.instance:getMapId()
	local var_4_1 = ActivityChessGameModel.instance:getActId()
	local var_4_2 = Activity109Config.instance:getMapCo(var_4_1, var_4_0)

	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._conditionItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetViewVictory, arg_6_0.onSetViewVictory, arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetViewFail, arg_6_0.onSetViewFail, arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.CurrentRoundUpdate, arg_6_0.refreshRound, arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameResultQuit, arg_6_0.onResultQuit, arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.CurrentConditionUpdate, arg_6_0.refreshConditions, arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameMapDataUpdate, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetCenterHintText, arg_6_0.setUICenterHintText, arg_6_0)
	arg_6_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.ResetGameByResultView, arg_6_0.handleResetByResult, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_7_0.delayRestartGame, arg_7_0)

	if arg_7_0.viewContainer:isManualClose() then
		Activity109ChessController.instance:statEnd(StatEnum.Result.Abort)
	end

	Activity109ChessController.instance:dispatchEvent(ActivityEvent.Play109EntryViewOpenAni)
end

function var_0_0.onSetViewVictory(arg_8_0)
	Activity109ChessController.instance:statEnd(StatEnum.Result.Success)

	local var_8_0 = Activity109ChessModel.instance:getActId()
	local var_8_1 = Activity109ChessModel.instance:getEpisodeId()

	if var_8_0 ~= nil and var_8_1 ~= nil then
		local var_8_2 = Activity109Config.instance:getEpisodeCo(var_8_0, var_8_1)

		if var_8_2 and var_8_2.storyClear == 0 then
			var_0_0.openWinResult()

			return
		end

		local var_8_3 = var_8_2.storyClear

		if not StoryModel.instance:isStoryHasPlayed(var_8_3) then
			StoryController.instance:playStories({
				var_8_3
			}, nil, var_0_0.openWinResult)
		else
			var_0_0.openWinResult()
		end
	end
end

function var_0_0.openWinResult()
	local var_9_0 = Activity109ChessModel.instance:getEpisodeId()
	local var_9_1 = "OnChessWinPause" .. var_9_0
	local var_9_2 = GuideEvent[var_9_1]
	local var_9_3 = GuideEvent.OnChessWinContinue
	local var_9_4 = var_0_0._openSuccessView
	local var_9_5

	GuideController.instance:GuideFlowPauseAndContinue(var_9_1, var_9_2, var_9_3, var_9_4, var_9_5)
end

function var_0_0._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.ActivityChessGameResultView, {
		result = true
	})
end

function var_0_0.onSetViewFail(arg_11_0)
	Activity109ChessController.instance:statEnd(StatEnum.Result.Fail)
	ViewMgr.instance:openView(ViewName.ActivityChessGameResultView, {
		result = false
	})
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshRound()
	arg_12_0:refreshConditions()
end

function var_0_0.refreshRound(arg_13_0)
	local var_13_0 = Activity109ChessModel.instance:getActId()
	local var_13_1 = Activity109ChessModel.instance:getEpisodeId()

	if not var_13_0 or not var_13_1 then
		return
	end

	local var_13_2 = Activity109Config.instance:getEpisodeCo(var_13_0, var_13_1)

	arg_13_0._txtcurround.text = string.format("%s/<size=36>%s</size>", tostring(ActivityChessGameModel.instance:getRound()), var_13_2.maxRound)
end

function var_0_0.refreshConditions(arg_14_0)
	arg_14_0:hideAllConditions()

	local var_14_0 = Activity109ChessModel.instance:getActId()
	local var_14_1 = Activity109ChessModel.instance:getEpisodeId()

	if not var_14_0 or not var_14_1 then
		return
	end

	local var_14_2 = Activity109Config.instance:getEpisodeCo(var_14_0, var_14_1)
	local var_14_3 = var_14_2.extStarCondition
	local var_14_4 = string.split(var_14_3, "|")
	local var_14_5 = string.split(var_14_2.conditionStr, "|")
	local var_14_6 = #var_14_4 + 1

	logNormal("taskLen : " .. tostring(var_14_6))

	for iter_14_0 = 1, var_14_6 do
		local var_14_7 = arg_14_0:getOrCreateConditionItem(iter_14_0)

		if iter_14_0 == 1 then
			arg_14_0:refreshConditionItem(var_14_7, nil, var_14_5[iter_14_0])
		else
			arg_14_0:refreshConditionItem(var_14_7, var_14_4[iter_14_0 - 1], var_14_5[iter_14_0])
		end
	end
end

function var_0_0.refreshConditionItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	gohelper.setActive(arg_15_1.go, true)

	local var_15_0 = Activity109ChessModel.instance:getActId()
	local var_15_1 = Activity109ChessModel.instance:getEpisodeId()
	local var_15_2
	local var_15_3 = false

	if not string.nilorempty(arg_15_2) then
		local var_15_4 = string.splitToNumber(arg_15_2, "#")

		var_15_2 = arg_15_3 or ActivityChessMapUtils.getClearConditionDesc(var_15_4, var_15_0)
		var_15_3 = ActivityChessMapUtils.isClearConditionFinish(var_15_4, var_15_0)
	else
		var_15_2 = arg_15_3 or luaLang("chessgame_clear_normal")
		var_15_3 = ActivityChessGameModel.instance:getResult() == true
	end

	arg_15_1.txtTaskDesc.text = var_15_2

	if not arg_15_1.goFinish.activeSelf and var_15_3 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.StarLight)
	end

	gohelper.setActive(arg_15_1.goFinish, var_15_3)
	gohelper.setActive(arg_15_1.goUnFinish, not var_15_3)
end

function var_0_0.setUICenterHintText(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.visible
	local var_16_1 = arg_16_1.text

	gohelper.setActive(arg_16_0._gooptip, var_16_0)
end

function var_0_0.getOrCreateConditionItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._conditionItems[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.go = gohelper.cloneInPlace(arg_17_0._gotaskitem, "taskitem_" .. tostring(arg_17_1))
		var_17_0.txtTaskDesc = gohelper.findChildText(var_17_0.go, "txt_desc")
		var_17_0.goFinish = gohelper.findChild(var_17_0.go, "star/go_finish")
		var_17_0.goUnFinish = gohelper.findChild(var_17_0.go, "star/go_unfinish")
		arg_17_0._conditionItems[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.hideAllConditions(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0._conditionItems) do
		gohelper.setActive(iter_18_1.go, false)
	end
end

function var_0_0.onResultQuit(arg_19_0)
	arg_19_0:closeThis()
end

function var_0_0.handleResetByResult(arg_20_0)
	arg_20_0._animRoot:Play("open", 0, 0)
end

var_0_0.UI_RESTART_BLOCK_KEY = "ActivityChessGameMainDelayRestart"

function var_0_0._btnrestartOnClick(arg_21_0)
	local function var_21_0()
		Activity109ChessController.instance:statEnd(StatEnum.Result.Reset)
		UIBlockMgr.instance:startBlock(var_0_0.UI_RESTART_BLOCK_KEY)
		arg_21_0._animRoot:Play("excessive", 0, 0)
		TaskDispatcher.runDelay(arg_21_0.delayRestartGame, arg_21_0, 0.56)
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, var_21_0)
end

function var_0_0.delayRestartGame(arg_23_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_23_0.delayRestartGame, arg_23_0)

	local var_23_0 = Activity109ChessModel.instance:getEpisodeId()

	if var_23_0 then
		Activity109ChessController.instance:startNewEpisode(var_23_0)
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameReset)
end

return var_0_0
