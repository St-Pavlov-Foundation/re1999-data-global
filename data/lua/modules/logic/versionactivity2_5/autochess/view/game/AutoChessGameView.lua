module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameView", package.seeall)

local var_0_0 = class("AutoChessGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "UI/#go_touch")
	arg_1_0._goFightRoot = gohelper.findChild(arg_1_0.viewGO, "UI/#go_FightRoot")
	arg_1_0._btnStop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Stop")
	arg_1_0._btnResume = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Resume")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Skip")
	arg_1_0._goScoreTarget = gohelper.findChild(arg_1_0.viewGO, "UI/#go_ScoreTarget")
	arg_1_0._goLight1 = gohelper.findChild(arg_1_0.viewGO, "UI/#go_ScoreTarget/icon/#go_Light1")
	arg_1_0._goLight2 = gohelper.findChild(arg_1_0.viewGO, "UI/#go_ScoreTarget/icon1/#go_Light2")
	arg_1_0._goLight3 = gohelper.findChild(arg_1_0.viewGO, "UI/#go_ScoreTarget/icon2/#go_Light3")
	arg_1_0._txtScoreTarget = gohelper.findChildText(arg_1_0.viewGO, "UI/#go_ScoreTarget/#txt_ScoreTarget")
	arg_1_0._goDamageTip = gohelper.findChild(arg_1_0.viewGO, "UI/#go_DamageTip")
	arg_1_0._txtDamageTip = gohelper.findChildText(arg_1_0.viewGO, "UI/#go_DamageTip/#txt_DamageTip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStop:AddClickListener(arg_2_0._btnStopOnClick, arg_2_0)
	arg_2_0._btnResume:AddClickListener(arg_2_0._btnResumeOnClick, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._btnSkipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStop:RemoveClickListener()
	arg_3_0._btnResume:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
end

function var_0_0._onEscapeBtnClick(arg_4_0)
	return
end

function var_0_0._btnResumeOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._btnStop, true)
	gohelper.setActive(arg_5_0._btnResume, false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, false)
end

function var_0_0._btnStopOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._btnStop, false)
	gohelper.setActive(arg_6_0._btnResume, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, true)
end

function var_0_0._btnSkipOnClick(arg_7_0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SkipFight)
end

function var_0_0._editableInitView(arg_8_0)
	NavigateMgr.instance:addEscape(arg_8_0.viewName, arg_8_0._onEscapeBtnClick, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(AutoChessController.instance, AutoChessEvent.StartFight, arg_10_0.onStartFight, arg_10_0)
	arg_10_0:addEventCb(AutoChessController.instance, AutoChessEvent.EndFight, arg_10_0.onEndFight, arg_10_0)
	arg_10_0:addEventCb(AutoChessController.instance, AutoChessEvent.NextRound, arg_10_0.onNextRound, arg_10_0)
	arg_10_0:addEventCb(AutoChessController.instance, AutoChessEvent.CheckEnemyTeam, arg_10_0.onCheckEnemy, arg_10_0)

	arg_10_0.chessMo = AutoChessModel.instance:getChessMo()
	arg_10_0.actId = Activity182Model.instance:getCurActId()

	arg_10_0:refreshUI()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.delayShowFightRoot, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.delayLightStar, arg_12_0)
end

function var_0_0.refreshUI(arg_13_0)
	gohelper.setActive(arg_13_0._goLight1, false)
	gohelper.setActive(arg_13_0._goLight2, false)
	gohelper.setActive(arg_13_0._goLight3, false)

	local var_13_0 = lua_auto_chess_round.configDict[arg_13_0.actId][arg_13_0.chessMo.sceneRound]
	local var_13_1 = string.split(var_13_0.assess, "#")
	local var_13_2 = string.format("%s/%s/%s", var_13_1[1], var_13_1[2], var_13_1[3])
	local var_13_3 = luaLang("autochess_gameview_startarget")

	arg_13_0._txtScoreTarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_3, var_13_2)

	local var_13_4 = luaLang("autochess_gameview_damagelimit")

	arg_13_0._txtDamageTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_4, var_13_0.maxdamage)
end

function var_0_0.onStartFight(arg_14_0)
	ViewMgr.instance:openView(ViewName.AutoChessStartFightView)
	TaskDispatcher.runDelay(arg_14_0.delayShowFightRoot, arg_14_0, 0.5)
end

function var_0_0.delayShowFightRoot(arg_15_0)
	gohelper.setActive(arg_15_0._gotouch, false)
	gohelper.setActive(arg_15_0._goFightRoot, true)
	gohelper.setActive(arg_15_0._goScoreTarget, true)
	gohelper.setActive(arg_15_0._goDamageTip, true)
end

function var_0_0.onEndFight(arg_16_0)
	local var_16_0 = AutoChessModel.instance.resultData

	if var_16_0 and var_16_0.star ~= 0 then
		AutoChessHelper.lockScreen("AutoChessGameViewLightStar", true)

		arg_16_0.maxStar = var_16_0.star <= 3 and var_16_0.star or 3
		arg_16_0.lightIndex = 0

		arg_16_0:delayLightStar()
		TaskDispatcher.runRepeat(arg_16_0.delayLightStar, arg_16_0, 0.5)
	else
		AutoChessController.instance:openResultView()
	end
end

function var_0_0.delayLightStar(arg_17_0)
	arg_17_0.lightIndex = arg_17_0.lightIndex + 1

	if arg_17_0.lightIndex > arg_17_0.maxStar then
		TaskDispatcher.cancelTask(arg_17_0.delayLightStar, arg_17_0)
		AutoChessHelper.lockScreen("AutoChessGameViewLightStar", false)
		AutoChessController.instance:openResultView()
	else
		gohelper.setActive(arg_17_0["_goLight" .. arg_17_0.lightIndex], true)
	end
end

function var_0_0.onNextRound(arg_18_0)
	arg_18_0:refreshUI()
	gohelper.setActive(arg_18_0._btnStop, true)
	gohelper.setActive(arg_18_0._btnResume, false)
	gohelper.setActive(arg_18_0._gotouch, true)
	gohelper.setActive(arg_18_0._goFightRoot, false)
	gohelper.setActive(arg_18_0._goScoreTarget, false)
	gohelper.setActive(arg_18_0._goDamageTip, false)
end

function var_0_0.onCheckEnemy(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goScoreTarget, arg_19_1)
	gohelper.setActive(arg_19_0._goDamageTip, arg_19_1)
end

return var_0_0
