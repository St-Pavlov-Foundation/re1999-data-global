module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameView", package.seeall)

slot0 = class("AutoChessGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "UI/#go_touch")
	slot0._goFightRoot = gohelper.findChild(slot0.viewGO, "UI/#go_FightRoot")
	slot0._btnStop = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_FightRoot/#btn_Stop")
	slot0._btnResume = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_FightRoot/#btn_Resume")
	slot0._btnSkip = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_FightRoot/#btn_Skip")
	slot0._goScoreTarget = gohelper.findChild(slot0.viewGO, "UI/#go_ScoreTarget")
	slot0._goLight1 = gohelper.findChild(slot0.viewGO, "UI/#go_ScoreTarget/icon/#go_Light1")
	slot0._goLight2 = gohelper.findChild(slot0.viewGO, "UI/#go_ScoreTarget/icon1/#go_Light2")
	slot0._goLight3 = gohelper.findChild(slot0.viewGO, "UI/#go_ScoreTarget/icon2/#go_Light3")
	slot0._txtScoreTarget = gohelper.findChildText(slot0.viewGO, "UI/#go_ScoreTarget/#txt_ScoreTarget")
	slot0._goDamageTip = gohelper.findChild(slot0.viewGO, "UI/#go_DamageTip")
	slot0._txtDamageTip = gohelper.findChildText(slot0.viewGO, "UI/#go_DamageTip/#txt_DamageTip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStop:AddClickListener(slot0._btnStopOnClick, slot0)
	slot0._btnResume:AddClickListener(slot0._btnResumeOnClick, slot0)
	slot0._btnSkip:AddClickListener(slot0._btnSkipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStop:RemoveClickListener()
	slot0._btnResume:RemoveClickListener()
	slot0._btnSkip:RemoveClickListener()
end

function slot0._onEscapeBtnClick(slot0)
end

function slot0._btnResumeOnClick(slot0)
	gohelper.setActive(slot0._btnStop, true)
	gohelper.setActive(slot0._btnResume, false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, false)
end

function slot0._btnStopOnClick(slot0)
	gohelper.setActive(slot0._btnStop, false)
	gohelper.setActive(slot0._btnResume, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, true)
end

function slot0._btnSkipOnClick(slot0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SkipFight)
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscapeBtnClick, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.StartFight, slot0.onStartFight, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.EndFight, slot0.onEndFight, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.NextRound, slot0.onNextRound, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.CheckEnemyTeam, slot0.onCheckEnemy, slot0)

	slot0.chessMo = AutoChessModel.instance:getChessMo()
	slot0.actId = Activity182Model.instance:getCurActId()

	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayShowFightRoot, slot0)
	TaskDispatcher.cancelTask(slot0.delayLightStar, slot0)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goLight1, false)
	gohelper.setActive(slot0._goLight2, false)
	gohelper.setActive(slot0._goLight3, false)

	slot1 = lua_auto_chess_round.configDict[slot0.actId][slot0.chessMo.sceneRound]
	slot2 = string.split(slot1.assess, "#")
	slot0._txtScoreTarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_gameview_startarget"), string.format("%s/%s/%s", slot2[1], slot2[2], slot2[3]))
	slot0._txtDamageTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_gameview_damagelimit"), slot1.maxdamage)
end

function slot0.onStartFight(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessStartFightView)
	TaskDispatcher.runDelay(slot0.delayShowFightRoot, slot0, 0.5)
end

function slot0.delayShowFightRoot(slot0)
	gohelper.setActive(slot0._gotouch, false)
	gohelper.setActive(slot0._goFightRoot, true)
	gohelper.setActive(slot0._goScoreTarget, true)
	gohelper.setActive(slot0._goDamageTip, true)
end

function slot0.onEndFight(slot0)
	if AutoChessModel.instance.resultData and slot1.star ~= 0 then
		AutoChessHelper.lockScreen("AutoChessGameViewLightStar", true)

		slot0.maxStar = slot1.star <= 3 and slot1.star or 3
		slot0.lightIndex = 0

		slot0:delayLightStar()
		TaskDispatcher.runRepeat(slot0.delayLightStar, slot0, 0.5)
	else
		AutoChessController.instance:openResultView()
	end
end

function slot0.delayLightStar(slot0)
	slot0.lightIndex = slot0.lightIndex + 1

	if slot0.maxStar < slot0.lightIndex then
		TaskDispatcher.cancelTask(slot0.delayLightStar, slot0)
		AutoChessHelper.lockScreen("AutoChessGameViewLightStar", false)
		AutoChessController.instance:openResultView()
	else
		gohelper.setActive(slot0["_goLight" .. slot0.lightIndex], true)
	end
end

function slot0.onNextRound(slot0)
	slot0:refreshUI()
	gohelper.setActive(slot0._btnStop, true)
	gohelper.setActive(slot0._btnResume, false)
	gohelper.setActive(slot0._gotouch, true)
	gohelper.setActive(slot0._goFightRoot, false)
	gohelper.setActive(slot0._goScoreTarget, false)
	gohelper.setActive(slot0._goDamageTip, false)
end

function slot0.onCheckEnemy(slot0, slot1)
	gohelper.setActive(slot0._goScoreTarget, slot1)
	gohelper.setActive(slot0._goDamageTip, slot1)
end

return slot0
