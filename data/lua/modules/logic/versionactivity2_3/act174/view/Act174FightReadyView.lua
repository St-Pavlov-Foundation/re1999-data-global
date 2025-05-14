module("modules.logic.versionactivity2_3.act174.view.Act174FightReadyView", package.seeall)

local var_0_0 = class("Act174FightReadyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._goLeft = gohelper.findChild(arg_1_0.viewGO, "#go_Left")
	arg_1_0._btnEnemyBuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Left/enemy/txt_enemy/#btn_EnemyBuff")
	arg_1_0._goFrame = gohelper.findChild(arg_1_0.viewGO, "#go_Frame")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "#go_Right")
	arg_1_0._btnPlayerBuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/player/txt_player/#btn_PlayerBuff")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "go_top/tips/#txt_Round")
	arg_1_0._imageHpPercent = gohelper.findChildImage(arg_1_0.viewGO, "go_top/hp/bg/#image_HpPercent")
	arg_1_0._btnBet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Bet")
	arg_1_0._btnBetCancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_BetCancel")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Start")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_Right/tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnemyBuff:AddClickListener(arg_2_0._btnEnemyBuffOnClick, arg_2_0)
	arg_2_0._btnPlayerBuff:AddClickListener(arg_2_0._btnPlayerBuffOnClick, arg_2_0)
	arg_2_0._btnBet:AddClickListener(arg_2_0._btnBetOnClick, arg_2_0)
	arg_2_0._btnBetCancel:AddClickListener(arg_2_0._btnBetCancelOnClick, arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnemyBuff:RemoveClickListener()
	arg_3_0._btnPlayerBuff:RemoveClickListener()
	arg_3_0._btnBet:RemoveClickListener()
	arg_3_0._btnBetCancel:RemoveClickListener()
	arg_3_0._btnStart:RemoveClickListener()
end

function var_0_0._btnEnemyBuffOnClick(arg_4_0)
	Activity174Controller.instance:openBuffTipView(true, Vector2.New(-450, 80))
end

function var_0_0._btnPlayerBuffOnClick(arg_5_0)
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(475, 80))
end

function var_0_0._btnBetOnClick(arg_6_0)
	Activity174Rpc.instance:sendBetHpBeforeAct174FightRequest(arg_6_0.actId, true, arg_6_0.betReply, arg_6_0)
end

function var_0_0._btnBetCancelOnClick(arg_7_0)
	Activity174Rpc.instance:sendBetHpBeforeAct174FightRequest(arg_7_0.actId, false, arg_7_0.betReply, arg_7_0)
end

function var_0_0._btnStartOnClick(arg_8_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174FightReadyView")
	arg_8_0._animatorPlayer:Play(UIAnimationName.Close, arg_8_0._starFight, arg_8_0)
end

function var_0_0._starFight(arg_9_0)
	Activity174Rpc.instance:sendStartAct174FightRequest(arg_9_0.actId, arg_9_0._fightReply, arg_9_0)
end

function var_0_0._fightReply(arg_10_0)
	Activity174Controller.instance:playFight()
	UIBlockMgr.instance:endBlock("Act174FightReadyView")
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_11_0.viewGO)
	arg_11_0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)
	arg_11_0.hpEffList = arg_11_0:getUserDataTb_()

	for iter_11_0 = 1, arg_11_0.maxHp do
		local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "go_top/hp/bg/#hp0" .. iter_11_0)

		arg_11_0.hpEffList[#arg_11_0.hpEffList + 1] = var_11_0
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.actId = Activity174Model.instance:getCurActId()
	arg_13_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	local var_13_0 = arg_13_0.gameInfo.gameCount

	arg_13_0.unLockTeamCnt = Activity174Config.instance:getTurnCo(arg_13_0.actId, var_13_0).groupNum

	arg_13_0:initLeftArea()
	arg_13_0:initMiddleArea()
	arg_13_0:initRightArea()

	local var_13_1 = arg_13_0.gameInfo:getWarehouseInfo()
	local var_13_2 = arg_13_0.gameInfo:getFightInfo().matchInfo.enhanceId

	gohelper.setActive(arg_13_0._btnPlayerBuff, #var_13_1.enhanceId ~= 0)
	gohelper.setActive(arg_13_0._btnEnemyBuff, #var_13_2 ~= 0)
	arg_13_0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, arg_13_0.closeThis, arg_13_0)
end

function var_0_0.onOpenFinish(arg_14_0)
	local var_14_0 = arg_14_0.gameInfo.gameCount

	Activity174Controller.instance:dispatchEvent(Activity174Event.FightReadyViewLevelCount, var_14_0)
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

function var_0_0.initLeftArea(arg_17_0)
	local var_17_0 = gohelper.findChild(arg_17_0.viewGO, "#go_Left/EnemyGroup")
	local var_17_1 = arg_17_0.gameInfo:getFightInfo().matchInfo.teamInfo

	for iter_17_0 = 1, arg_17_0.unLockTeamCnt do
		local var_17_2 = gohelper.cloneInPlace(var_17_0, "EnemyGroup" .. iter_17_0)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_17_2, Act174FightReadyItem, arg_17_0):setData(var_17_1[iter_17_0], true)
	end

	gohelper.setActive(var_17_0, false)
end

function var_0_0.initMiddleArea(arg_18_0)
	local var_18_0 = Activity174Config.instance:getMaxRound(arg_18_0.actId, arg_18_0.gameInfo.gameCount)

	arg_18_0._txtRound.text = string.format("%s/%s", arg_18_0.gameInfo.gameCount, var_18_0)
	arg_18_0.maxHp = lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value
	arg_18_0._imageHpPercent.fillAmount = arg_18_0.gameInfo.hp / arg_18_0.maxHp

	arg_18_0:refreshBetStatus()
end

function var_0_0.refreshBetStatus(arg_19_0)
	local var_19_0 = Activity174Config.instance:getTurnCo(arg_19_0.actId, arg_19_0.gameInfo.gameCount).winCoin
	local var_19_1 = arg_19_0.gameInfo.fightInfo.betHp

	if var_19_0 == 0 or arg_19_0.gameInfo.hp <= 1 then
		for iter_19_0 = 1, arg_19_0.maxHp do
			gohelper.setActive(arg_19_0.hpEffList[iter_19_0], false)
		end

		gohelper.setActive(arg_19_0._btnBet, false)
		gohelper.setActive(arg_19_0._btnBetCancel, false)
	else
		arg_19_0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

		for iter_19_1 = 1, arg_19_0.maxHp do
			gohelper.setActive(arg_19_0.hpEffList[iter_19_1], var_19_1 and iter_19_1 == arg_19_0.gameInfo.hp)
		end

		gohelper.setActive(arg_19_0._btnBet, not var_19_1)
		gohelper.setActive(arg_19_0._btnBetCancel, var_19_1)
	end
end

function var_0_0.initRightArea(arg_20_0)
	local var_20_0 = arg_20_0.unLockTeamCnt

	gohelper.setActive(arg_20_0._goTips, var_20_0 > 1)

	arg_20_0.frameTrList = {}

	local var_20_1 = gohelper.findChild(arg_20_0.viewGO, "#go_Frame/frame")

	for iter_20_0 = 1, var_20_0 do
		local var_20_2 = gohelper.cloneInPlace(var_20_1)

		arg_20_0.frameTrList[iter_20_0] = var_20_2.transform
	end

	gohelper.setActive(var_20_1, false)
	ZProj.UGUIHelper.RebuildLayout(var_20_1.transform.parent)

	local var_20_3 = 211 * var_20_0 + 65

	recthelper.setHeight(arg_20_0._goRight.transform, var_20_3)

	arg_20_0.readyItemList = {}

	local var_20_4 = gohelper.findChild(arg_20_0.viewGO, "#go_Right/PlayerGroup")
	local var_20_5 = arg_20_0.gameInfo:getTeamMoList()

	for iter_20_1 = 1, var_20_0 do
		local var_20_6 = gohelper.cloneInPlace(var_20_4, "PlayerGroup" .. iter_20_1)
		local var_20_7 = recthelper.rectToRelativeAnchorPos(arg_20_0.frameTrList[iter_20_1].position, arg_20_0._goRight.transform)

		recthelper.setAnchor(var_20_6.transform, var_20_7.x, var_20_7.y)

		local var_20_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_6, Act174FightReadyItem, arg_20_0)

		var_20_8:setData(var_20_5[iter_20_1], false)

		arg_20_0.readyItemList[iter_20_1] = var_20_8
	end

	gohelper.setActive(var_20_4, false)
end

function var_0_0.exchangeItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.readyItemList[arg_21_1]

	arg_21_0.readyItemList[arg_21_1] = arg_21_0.readyItemList[arg_21_2]
	arg_21_0.readyItemList[arg_21_2] = var_21_0

	Activity174Rpc.instance:sendSwitchAct174TeamRequest(arg_21_0.actId, arg_21_1, arg_21_2, arg_21_0.switchReply, arg_21_0)
end

function var_0_0.switchReply(arg_22_0)
	local var_22_0 = arg_22_0.gameInfo:getTeamMoList()

	for iter_22_0 = 1, #arg_22_0.readyItemList do
		local var_22_1 = arg_22_0.readyItemList[iter_22_0]

		if var_22_0[iter_22_0] then
			var_22_1:setData(var_22_0[iter_22_0], false)
		else
			logError("dont esixt teamInfo" .. iter_22_0)
		end
	end
end

function var_0_0.betReply(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 == 0 then
		if arg_23_3.bet then
			ViewMgr.instance:openView(ViewName.Act174BetSuccessView)
		end

		arg_23_0:refreshBetStatus()
	end
end

return var_0_0
