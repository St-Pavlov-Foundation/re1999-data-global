module("modules.logic.versionactivity2_3.act174.view.Act174EndLessView", package.seeall)

local var_0_0 = class("Act174EndLessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTip1 = gohelper.findChild(arg_1_0.viewGO, "Tips/#go_Tip1")
	arg_1_0._txtTip1 = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip1/#txt_Tip1")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip1/#txt_Score")
	arg_1_0._btnEscape1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tip1/#btn_Escape1")
	arg_1_0._btnEnter1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tip1/#btn_Enter1")
	arg_1_0._goTip2 = gohelper.findChild(arg_1_0.viewGO, "Tips/#go_Tip2")
	arg_1_0._btnBet1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet1")
	arg_1_0._txtBet1 = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet1/#txt_Bet1")
	arg_1_0._btnBet2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet2")
	arg_1_0._txtBet2 = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet2/#txt_Bet2")
	arg_1_0._btnBet3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet3")
	arg_1_0._txtBet3 = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip2/go_BetPercent/#btn_Bet3/#txt_Bet3")
	arg_1_0._txtCoinNum = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip2/go_topright/#go_Coin/#txt_CoinCnt2")
	arg_1_0._goTip3 = gohelper.findChild(arg_1_0.viewGO, "Tips/#go_Tip3")
	arg_1_0._txtTip3 = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip3/txt_Tip3")
	arg_1_0._txtcurScore = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip3/go_Score/#txt_curScore")
	arg_1_0._txtunbetScore = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip3/go_Score/#txt_unbetScore")
	arg_1_0._txtbetScore = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip3/go_Score/#txt_betScore")
	arg_1_0._txttimes = gohelper.findChildText(arg_1_0.viewGO, "Tips/#go_Tip3/go_Score/#txt_times")
	arg_1_0._btnEscape3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tip3/#btn_Escape3")
	arg_1_0._btnEnter3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tip3/#btn_Enter3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEscape1:AddClickListener(arg_2_0._btnEscape1OnClick, arg_2_0)
	arg_2_0._btnEnter1:AddClickListener(arg_2_0._btnEnter1OnClick, arg_2_0)
	arg_2_0._btnBet1:AddClickListener(arg_2_0._btnBet1OnClick, arg_2_0)
	arg_2_0._btnBet2:AddClickListener(arg_2_0._btnBet2OnClick, arg_2_0)
	arg_2_0._btnBet3:AddClickListener(arg_2_0._btnBet3OnClick, arg_2_0)
	arg_2_0._btnEscape3:AddClickListener(arg_2_0._btnEscape3OnClick, arg_2_0)
	arg_2_0._btnEnter3:AddClickListener(arg_2_0._btnEnter3OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEscape1:RemoveClickListener()
	arg_3_0._btnEnter1:RemoveClickListener()
	arg_3_0._btnBet1:RemoveClickListener()
	arg_3_0._btnBet2:RemoveClickListener()
	arg_3_0._btnBet3:RemoveClickListener()
	arg_3_0._btnEscape3:RemoveClickListener()
	arg_3_0._btnEnter3:RemoveClickListener()
end

function var_0_0._btnEscape1OnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessEscape, MsgBoxEnum.BoxType.Yes_No, arg_4_0.notEnterGame, nil, nil, arg_4_0)
end

function var_0_0.notEnterGame(arg_5_0)
	Activity174Rpc.instance:sendEnterEndLessAct174FightRequest(arg_5_0.actId, false, arg_5_0.betLevel, arg_5_0.closeThis, arg_5_0)
end

function var_0_0._btnEnter1OnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessChallenge1, MsgBoxEnum.BoxType.Yes_No, arg_6_0.startBet, nil, nil, arg_6_0)
end

function var_0_0.startBet(arg_7_0)
	gohelper.setActive(arg_7_0._goTip1, false)
	gohelper.setActive(arg_7_0._goTip2, true)
	gohelper.setActive(arg_7_0._goTip3, false)
	arg_7_0:refreshBetTxt()
	Activity174Controller.instance:dispatchEvent(Activity174Event.SureEnterEndlessMode)
end

function var_0_0.refreshBetTxt(arg_8_0)
	local var_8_0 = arg_8_0.gameInfo.score

	for iter_8_0 = 1, 3 do
		local var_8_1 = arg_8_0.betConfigList[iter_8_0]

		if var_8_1 then
			local var_8_2 = var_8_0 * var_8_1.ratio / 1000

			arg_8_0["_txtBet" .. iter_8_0].text = math.floor(var_8_2 + 0.5)
		else
			gohelper.setActive(arg_8_0["_btnBet" .. iter_8_0], false)
		end
	end
end

function var_0_0._btnBet1OnClick(arg_9_0)
	arg_9_0.betLevel = 1

	arg_9_0:enterGame()
end

function var_0_0._btnBet2OnClick(arg_10_0)
	arg_10_0.betLevel = 2

	arg_10_0:enterGame()
end

function var_0_0._btnBet3OnClick(arg_11_0)
	arg_11_0.betLevel = 3

	arg_11_0:enterGame()
end

function var_0_0.enterGame(arg_12_0)
	Activity174Rpc.instance:sendEnterEndLessAct174FightRequest(arg_12_0.actId, true, arg_12_0.betLevel, arg_12_0.enterGameReply, arg_12_0)
end

function var_0_0.enterGameReply(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == 0 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.ClickStartGame)
		arg_13_0:closeThis()
	end
end

function var_0_0._btnEscape3OnClick(arg_14_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndLessEscape, MsgBoxEnum.BoxType.Yes_No, arg_14_0.endGame, nil, nil, arg_14_0)
end

function var_0_0.endGame(arg_15_0)
	Activity174Rpc.instance:sendEndAct174GameRequest(arg_15_0.actId, arg_15_0.endGameReply, arg_15_0)
end

function var_0_0.endGameReply(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 == 0 then
		FightController.instance:dispatchEvent(FightEvent.DouQuQuSettlementFinish)
		arg_16_0:closeThis()
	end
end

function var_0_0._btnEnter3OnClick(arg_17_0)
	Activity174Controller.instance:dispatchEvent(Activity174Event.ClickStartGame)
	arg_17_0:closeThis()
end

function var_0_0._editableInitView(arg_18_0)
	return
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0.actId = Activity174Model.instance:getCurActId()
	arg_20_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	arg_20_0.betConfigList = lua_activity174_bet.configDict[arg_20_0.actId]

	if arg_20_0.viewParam and arg_20_0.viewParam.showScore then
		arg_20_0:betEnd()
	else
		arg_20_0.betLevel = 0

		arg_20_0:refreshUI()
	end
end

function var_0_0.refreshUI(arg_21_0)
	gohelper.setActive(arg_21_0._goTip1, true)
	gohelper.setActive(arg_21_0._goTip2, false)
	gohelper.setActive(arg_21_0._goTip3, false)

	local var_21_0 = Activity174Config.instance:getMaxRound(arg_21_0.actId, arg_21_0.gameInfo.gameCount)
	local var_21_1 = luaLang("act174_endless_tip1")

	arg_21_0._txtTip1.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_21_1, var_21_0)
	arg_21_0._txtScore.text = arg_21_0.gameInfo.score
	arg_21_0._txtCoinNum.text = arg_21_0.gameInfo.score
end

function var_0_0.betEnd(arg_22_0)
	local var_22_0 = Activity174Config.instance:getTurnCo(arg_22_0.actId, arg_22_0.gameInfo.gameCount - 1)
	local var_22_1 = var_22_0 and var_22_0.point / 1000 or ""

	gohelper.setActive(arg_22_0._goTip1, false)
	gohelper.setActive(arg_22_0._goTip2, false)
	gohelper.setActive(arg_22_0._goTip3, true)

	local var_22_2 = arg_22_0.gameInfo:getBetScore()
	local var_22_3 = arg_22_0.gameInfo.score

	arg_22_0._txtcurScore.text = var_22_3 + var_22_2
	arg_22_0._txtunbetScore.text = var_22_3
	arg_22_0._txtbetScore.text = math.floor(var_22_2 / var_22_1 + 0.5)
	arg_22_0._txttimes.text = var_22_1

	local var_22_4 = Activity174Config.instance:getTurnCo(arg_22_0.actId, arg_22_0.gameInfo.gameCount)
	local var_22_5 = var_22_4 and var_22_4.point / 1000 or ""
	local var_22_6 = luaLang("act174_endless_tip3")

	arg_22_0._txtTip3.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_22_6, var_22_5)
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
