module("modules.logic.versionactivity2_3.act174.view.Act174EndLessView", package.seeall)

slot0 = class("Act174EndLessView", BaseView)

function slot0.onInitView(slot0)
	slot0._goTip1 = gohelper.findChild(slot0.viewGO, "Tips/#go_Tip1")
	slot0._txtTip1 = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip1/#txt_Tip1")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip1/#txt_Score")
	slot0._btnEscape1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tip1/#btn_Escape1")
	slot0._btnEnter1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tip1/#btn_Enter1")
	slot0._goTip2 = gohelper.findChild(slot0.viewGO, "Tips/#go_Tip2")
	slot0._btnBet1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet1")
	slot0._txtBet1 = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet1/#txt_Bet1")
	slot0._btnBet2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet2")
	slot0._txtBet2 = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet2/#txt_Bet2")
	slot0._btnBet3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet3")
	slot0._txtBet3 = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet3/#txt_Bet3")
	slot0._txtCoinNum = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip2/go_topright/#go_Coin/#txt_CoinCnt2")
	slot0._goTip3 = gohelper.findChild(slot0.viewGO, "Tips/#go_Tip3")
	slot0._txtTip3 = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip3/txt_Tip3")
	slot0._txtcurScore = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip3/go_Score/#txt_curScore")
	slot0._txtunbetScore = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip3/go_Score/#txt_unbetScore")
	slot0._txtbetScore = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip3/go_Score/#txt_betScore")
	slot0._txttimes = gohelper.findChildText(slot0.viewGO, "Tips/#go_Tip3/go_Score/#txt_times")
	slot0._btnEscape3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tip3/#btn_Escape3")
	slot0._btnEnter3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tip3/#btn_Enter3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEscape1:AddClickListener(slot0._btnEscape1OnClick, slot0)
	slot0._btnEnter1:AddClickListener(slot0._btnEnter1OnClick, slot0)
	slot0._btnBet1:AddClickListener(slot0._btnBet1OnClick, slot0)
	slot0._btnBet2:AddClickListener(slot0._btnBet2OnClick, slot0)
	slot0._btnBet3:AddClickListener(slot0._btnBet3OnClick, slot0)
	slot0._btnEscape3:AddClickListener(slot0._btnEscape3OnClick, slot0)
	slot0._btnEnter3:AddClickListener(slot0._btnEnter3OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEscape1:RemoveClickListener()
	slot0._btnEnter1:RemoveClickListener()
	slot0._btnBet1:RemoveClickListener()
	slot0._btnBet2:RemoveClickListener()
	slot0._btnBet3:RemoveClickListener()
	slot0._btnEscape3:RemoveClickListener()
	slot0._btnEnter3:RemoveClickListener()
end

function slot0._btnEscape1OnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessEscape, MsgBoxEnum.BoxType.Yes_No, slot0.notEnterGame, nil, , slot0)
end

function slot0.notEnterGame(slot0)
	Activity174Rpc.instance:sendEnterEndLessAct174FightRequest(slot0.actId, false, slot0.betLevel, slot0.closeThis, slot0)
end

function slot0._btnEnter1OnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessChallenge1, MsgBoxEnum.BoxType.Yes_No, slot0.startBet, nil, , slot0)
end

function slot0.startBet(slot0)
	gohelper.setActive(slot0._goTip1, false)
	gohelper.setActive(slot0._goTip2, true)
	gohelper.setActive(slot0._goTip3, false)
	slot0:refreshBetTxt()
	Activity174Controller.instance:dispatchEvent(Activity174Event.SureEnterEndlessMode)
end

function slot0.refreshBetTxt(slot0)
	for slot5 = 1, 3 do
		if slot0.betConfigList[slot5] then
			slot0["_txtBet" .. slot5].text = math.floor(slot0.gameInfo.score * slot6.ratio / 1000 + 0.5)
		else
			gohelper.setActive(slot0["_btnBet" .. slot5], false)
		end
	end
end

function slot0._btnBet1OnClick(slot0)
	slot0.betLevel = 1

	slot0:enterGame()
end

function slot0._btnBet2OnClick(slot0)
	slot0.betLevel = 2

	slot0:enterGame()
end

function slot0._btnBet3OnClick(slot0)
	slot0.betLevel = 3

	slot0:enterGame()
end

function slot0.enterGame(slot0)
	Activity174Rpc.instance:sendEnterEndLessAct174FightRequest(slot0.actId, true, slot0.betLevel, slot0.enterGameReply, slot0)
end

function slot0.enterGameReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.ClickStartGame)
		slot0:closeThis()
	end
end

function slot0._btnEscape3OnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessEscape, MsgBoxEnum.BoxType.Yes_No, slot0.endGame, nil, , slot0)
end

function slot0.endGame(slot0)
	Activity174Rpc.instance:sendEndAct174GameRequest(slot0.actId, slot0.endGameReply, slot0)
end

function slot0.endGameReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		FightController.instance:dispatchEvent(FightEvent.DouQuQuSettlementFinish)
		slot0:closeThis()
	end
end

function slot0._btnEnter3OnClick(slot0)
	Activity174Controller.instance:dispatchEvent(Activity174Event.ClickStartGame)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Activity174Model.instance:getCurActId()
	slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	slot0.betConfigList = lua_activity174_bet.configDict[slot0.actId]

	if slot0.viewParam and slot0.viewParam.showScore then
		slot0:betEnd()
	else
		slot0.betLevel = 0

		slot0:refreshUI()
	end
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goTip1, true)
	gohelper.setActive(slot0._goTip2, false)
	gohelper.setActive(slot0._goTip3, false)

	slot0._txtTip1.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act174_endless_tip1"), Activity174Config.instance:getMaxRound(slot0.actId, slot0.gameInfo.gameCount))
	slot0._txtScore.text = slot0.gameInfo.score
	slot0._txtCoinNum.text = slot0.gameInfo.score
end

function slot0.betEnd(slot0)
	slot2 = Activity174Config.instance:getTurnCo(slot0.actId, slot0.gameInfo.gameCount - 1) and slot1.point / 1000 or ""

	gohelper.setActive(slot0._goTip1, false)
	gohelper.setActive(slot0._goTip2, false)
	gohelper.setActive(slot0._goTip3, true)

	slot3 = slot0.gameInfo:getBetScore()
	slot4 = slot0.gameInfo.score
	slot0._txtcurScore.text = slot4 + slot3
	slot0._txtunbetScore.text = slot4
	slot0._txtbetScore.text = math.floor(slot3 / slot2 + 0.5)
	slot0._txttimes.text = slot2
	slot0._txtTip3.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act174_endless_tip3"), Activity174Config.instance:getTurnCo(slot0.actId, slot0.gameInfo.gameCount) and slot1.point / 1000 or "")
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
