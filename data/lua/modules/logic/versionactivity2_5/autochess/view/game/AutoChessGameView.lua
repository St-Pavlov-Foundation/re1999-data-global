module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameView", package.seeall)

local var_0_0 = class("AutoChessGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "UI/#go_touch")
	arg_1_0._goFightRoot = gohelper.findChild(arg_1_0.viewGO, "UI/#go_FightRoot")
	arg_1_0._btnStop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Stop")
	arg_1_0._btnResume = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Resume")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Skip")
	arg_1_0._btnSpeed1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Speed1")
	arg_1_0._btnSpeed2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_FightRoot/#btn_Speed2")
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
	arg_2_0._btnSpeed1:AddClickListener(arg_2_0._btnSpeed1OnClick, arg_2_0)
	arg_2_0._btnSpeed2:AddClickListener(arg_2_0._btnSpeed2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStop:RemoveClickListener()
	arg_3_0._btnResume:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
	arg_3_0._btnSpeed1:RemoveClickListener()
	arg_3_0._btnSpeed2:RemoveClickListener()
end

function var_0_0._onEscapeBtnClick(arg_4_0)
	return
end

function var_0_0._btnSpeed1OnClick(arg_5_0)
	arg_5_0.curSpeed = 2

	AutoChessHelper.setPlayerPrefs("AutoChessFightSpeed", arg_5_0.curSpeed)
	arg_5_0:refreshSpeed()
end

function var_0_0._btnSpeed2OnClick(arg_6_0)
	arg_6_0.curSpeed = 1

	AutoChessHelper.setPlayerPrefs("AutoChessFightSpeed", arg_6_0.curSpeed)
	arg_6_0:refreshSpeed()
end

function var_0_0._btnResumeOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._btnStop, true)
	gohelper.setActive(arg_7_0._btnResume, false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, false)
end

function var_0_0._btnStopOnClick(arg_8_0)
	gohelper.setActive(arg_8_0._btnStop, false)
	gohelper.setActive(arg_8_0._btnResume, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, true)
end

function var_0_0._btnSkipOnClick(arg_9_0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SkipFight)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.moduleId = AutoChessModel.instance.moduleId

	NavigateMgr.instance:addEscape(arg_10_0.viewName, arg_10_0._onEscapeBtnClick, arg_10_0)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:addEventCb(AutoChessController.instance, AutoChessEvent.StartFight, arg_11_0.onStartFight, arg_11_0)
	arg_11_0:addEventCb(AutoChessController.instance, AutoChessEvent.EndFight, arg_11_0.onEndFight, arg_11_0)
	arg_11_0:addEventCb(AutoChessController.instance, AutoChessEvent.NextRound, arg_11_0.onNextRound, arg_11_0)
	arg_11_0:addEventCb(AutoChessController.instance, AutoChessEvent.CheckEnemyTeam, arg_11_0.onCheckEnemy, arg_11_0)

	arg_11_0.chessMo = AutoChessModel.instance:getChessMo()
	arg_11_0.actId = Activity182Model.instance:getCurActId()
	arg_11_0.curSpeed = AutoChessHelper.getPlayerPrefs("AutoChessFightSpeed", 1)

	arg_11_0:refreshUI()
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:recoverSpeed()
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.delayShowFightRoot, arg_13_0)
end

function var_0_0.refreshUI(arg_14_0)
	if arg_14_0.moduleId == AutoChessEnum.ModuleId.Friend then
		return
	end

	local var_14_0 = lua_auto_chess_round.configDict[arg_14_0.actId][arg_14_0.chessMo.sceneRound]
	local var_14_1 = luaLang("autochess_gameview_damagelimit")

	arg_14_0._txtDamageTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_14_1, var_14_0.maxdamage)
end

function var_0_0.onStartFight(arg_15_0)
	ViewMgr.instance:openView(ViewName.AutoChessStartFightView)
	TaskDispatcher.runDelay(arg_15_0.delayShowFightRoot, arg_15_0, 0.5)
end

function var_0_0.delayShowFightRoot(arg_16_0)
	arg_16_0:refreshSpeed()
	gohelper.setActive(arg_16_0._gotouch, false)
	gohelper.setActive(arg_16_0._goFightRoot, true)
	gohelper.setActive(arg_16_0._goDamageTip, arg_16_0.moduleId ~= AutoChessEnum.ModuleId.Friend)
end

function var_0_0.onEndFight(arg_17_0)
	arg_17_0:recoverSpeed()

	if AutoChessModel.instance.resultData then
		AutoChessController.instance:openResultView()
	else
		AutoChessController.instance:onResultViewClose()
	end
end

function var_0_0.onNextRound(arg_18_0)
	arg_18_0:refreshUI()
	gohelper.setActive(arg_18_0._btnStop, true)
	gohelper.setActive(arg_18_0._btnResume, false)
	gohelper.setActive(arg_18_0._gotouch, true)
	gohelper.setActive(arg_18_0._goFightRoot, false)
	gohelper.setActive(arg_18_0._goDamageTip, false)
end

function var_0_0.onCheckEnemy(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goDamageTip, arg_19_1)
end

function var_0_0.refreshSpeed(arg_20_0)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.AutoChess, arg_20_0.curSpeed)
	gohelper.setActive(arg_20_0._btnSpeed1, arg_20_0.curSpeed == 1)
	gohelper.setActive(arg_20_0._btnSpeed2, arg_20_0.curSpeed == 2)
end

function var_0_0.recoverSpeed(arg_21_0)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.AutoChess, 1)
end

return var_0_0
