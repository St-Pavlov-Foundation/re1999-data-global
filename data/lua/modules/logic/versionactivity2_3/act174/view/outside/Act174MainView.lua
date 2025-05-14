module("modules.logic.versionactivity2_3.act174.view.outside.Act174MainView", package.seeall)

local var_0_0 = class("Act174MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goachieve = gohelper.findChild(arg_1_0.viewGO, "#go_achieve")
	arg_1_0.badgeGoParent = gohelper.findChild(arg_1_0.viewGO, "#go_achieve/scroll_achieve/viewport/content")
	arg_1_0.badgeGo = gohelper.findChild(arg_1_0.viewGO, "#go_achieve/scroll_achieve/viewport/content/go_achievementicon")
	arg_1_0._btnBadge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_achieve/scroll_achieve/#btn_Badge")
	arg_1_0._gorule = gohelper.findChild(arg_1_0.viewGO, "#go_rule")
	arg_1_0._btnrule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rule/#btn_rule")
	arg_1_0._btnEndGame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_EndGame")
	arg_1_0._btnShop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_Shop")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "layout/#btn_Shop/#txt_num")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "layout/#go_progress")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "layout/#go_progress/#txt_Round")
	arg_1_0._goHp = gohelper.findChild(arg_1_0.viewGO, "layout/#go_progress/#go_Hp")
	arg_1_0._imageHpPercent = gohelper.findChildImage(arg_1_0.viewGO, "layout/#go_progress/#go_Hp/bg/#image_HpPercent")
	arg_1_0._btnEnterGame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_EnterGame")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBadge:AddClickListener(arg_2_0._btnBadgeOnClick, arg_2_0)
	arg_2_0._btnrule:AddClickListener(arg_2_0._btnruleOnClick, arg_2_0)
	arg_2_0._btnEndGame:AddClickListener(arg_2_0._btnEndGameOnClick, arg_2_0)
	arg_2_0._btnShop:AddClickListener(arg_2_0._btnShopOnClick, arg_2_0)
	arg_2_0._btnEnterGame:AddClickListener(arg_2_0._btnEnterGameOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBadge:RemoveClickListener()
	arg_3_0._btnrule:RemoveClickListener()
	arg_3_0._btnEndGame:RemoveClickListener()
	arg_3_0._btnShop:RemoveClickListener()
	arg_3_0._btnEnterGame:RemoveClickListener()
end

function var_0_0._btnEndGameOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndGameConfirm, MsgBoxEnum.BoxType.Yes_No, arg_4_0.endGame, nil, nil, arg_4_0)
end

function var_0_0._btnBadgeOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.Act174BadgeWallView)
end

function var_0_0._btnruleOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.Act174RotationView)
end

function var_0_0._btnShopOnClick(arg_7_0)
	Activity174Controller.instance:openStoreView(VersionActivity2_3Enum.ActivityId.Act174Store)
end

function var_0_0._btnEnterGameOnClick(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.actInfo:getGameInfo()

	if var_8_0 and var_8_0:isInGame() then
		local var_8_1 = var_8_0.state

		if var_8_1 == Activity174Enum.GameState.ForceSelect then
			Activity174Controller.instance:openForcePickView(var_8_0:getForceBagsInfo())
		elseif var_8_1 == Activity174Enum.GameState.BeforeFight then
			Activity174Controller.instance:openFightReadyView()
		elseif var_8_1 == Activity174Enum.GameState.Free then
			Activity174Controller.instance:openGameView()
		elseif var_8_1 == Activity174Enum.GameState.AfterFight then
			Activity174Controller.instance:openFightResultView()
		elseif var_8_1 == Activity174Enum.GameState.EnterEndless then
			Activity174Controller.instance:openEndLessView()
		else
			logError("GameState need do" .. var_8_1)
		end

		if not arg_8_1 and (var_8_1 == Activity174Enum.GameState.Free or var_8_1 == Activity174Enum.GameState.BeforeFight) then
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_match_start)
		end
	else
		Activity174Rpc.instance:sendStart174GameRequest(arg_8_0.actId, arg_8_0.enterGameCallback, arg_8_0)
	end
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.actId = arg_11_0.viewParam.actId

	if arg_11_0.viewParam.exitFromFight then
		arg_11_0:_onOpen()
	else
		Activity174Rpc.instance:sendGetAct174InfoRequest(arg_11_0.actId, arg_11_0._onOpen, arg_11_0)
	end
end

function var_0_0._onOpen(arg_12_0)
	arg_12_0.actInfo = Activity174Model.instance:getActInfo()

	if not arg_12_0:checkGameEndInfo() then
		if arg_12_0.viewParam and arg_12_0.viewParam.exitFromFight then
			arg_12_0:_nextReply()
		else
			AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
		end
	end

	arg_12_0:checkSeason()
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateBadgeMo, arg_12_0.refreshBadge, arg_12_0)
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, arg_12_0.refreshUI, arg_12_0)
	arg_12_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_12_0.refreshCurrency, arg_12_0)
	arg_12_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_12_0.dailyRefresh, arg_12_0)
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.EndGame, arg_12_0.checkGameEndInfo, arg_12_0)
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.ClickStartGame, arg_12_0._btnEnterGameOnClick, arg_12_0)
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.EnterNextAct174FightReply, arg_12_0._nextReply, arg_12_0)
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:removeEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, arg_13_0.refreshUI, arg_13_0)
	arg_13_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0.refreshCurrency, arg_13_0)
	arg_13_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_13_0.dailyRefresh, arg_13_0)
	arg_13_0:removeEventCb(Activity174Controller.instance, Activity174Event.EndGame, arg_13_0.refreshUI, arg_13_0)
	arg_13_0:removeEventCb(Activity174Controller.instance, Activity174Event.EnterNextAct174FightReply, arg_13_0._nextReply, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.ruleHeroIconList) do
		iter_14_1:UnLoadImage()
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0.badgeItemDic) do
		iter_14_3.simageIcon:UnLoadImage()
	end
end

function var_0_0.checkGameEndInfo(arg_15_0)
	if arg_15_0.actInfo:getGameEndInfo() then
		Activity174Controller.instance:openSettlementView()
		arg_15_0:refreshUI()

		return true
	end
end

function var_0_0.refreshUI(arg_16_0)
	local var_16_0 = arg_16_0.actInfo:getGameInfo()
	local var_16_1 = var_16_0:isInGame()

	gohelper.setActive(arg_16_0._btnEndGame, var_16_1)
	gohelper.setActive(arg_16_0._goprogress, var_16_1)

	if var_16_1 then
		local var_16_2, var_16_3 = Activity174Config.instance:getMaxRound(arg_16_0.actId, var_16_0.gameCount)

		arg_16_0._txtRound.text = string.format("%s/%s", var_16_0.gameCount, var_16_2)

		local var_16_4 = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

		arg_16_0._imageHpPercent.fillAmount = var_16_0.hp / var_16_4

		gohelper.setActive(arg_16_0._goHp, not var_16_3)
	end

	arg_16_0:initRule()
	arg_16_0:refreshBadge()
	arg_16_0:refreshCurrency()
end

function var_0_0.refreshCurrency(arg_17_0)
	local var_17_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a3DouQuQu)

	arg_17_0._txtnum.text = var_17_0.quantity
end

function var_0_0.enterGameCallback(arg_18_0)
	Activity174Model.instance:clearUnlockNewTeamTipCache()

	local var_18_0 = arg_18_0.actInfo:getGameInfo()

	Activity174Controller.instance:openForcePickView(var_18_0.forceBagInfo)
end

function var_0_0.endGame(arg_19_0)
	Activity174Rpc.instance:sendEndAct174GameRequest(arg_19_0.actId, arg_19_0.endGameCallback, arg_19_0)
end

function var_0_0.endGameCallback(arg_20_0)
	if arg_20_0.actInfo:getGameEndInfo() then
		Activity174Controller.instance:openSettlementView()

		local var_20_0 = arg_20_0.actInfo:getBadgeScoreChangeDic()

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			local var_20_1 = arg_20_0.actInfo:getBadgeMo(iter_20_0)

			arg_20_0:refreshBadgeItem(iter_20_0, var_20_1)
		end

		arg_20_0:refreshUI()
	else
		logError("gameEndInfo is nil")
	end
end

function var_0_0.refreshBadge(arg_21_0)
	arg_21_0.badgeItemDic = {}

	local var_21_0 = arg_21_0.actInfo:getBadgeMoList()

	gohelper.CreateObjList(arg_21_0, arg_21_0._onSetBadgeItem, var_21_0, arg_21_0.badgeGoParent, arg_21_0.badgeGo)
end

function var_0_0._onSetBadgeItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0:getUserDataTb_()
	local var_22_1 = arg_22_2.id

	var_22_0.simageIcon = gohelper.findChildSingleImage(arg_22_1, "root/image_icon")
	var_22_0.txtNum = gohelper.findChildText(arg_22_1, "root/txt_num")
	arg_22_0.badgeItemDic[var_22_1] = var_22_0

	arg_22_0:refreshBadgeItem(var_22_1, arg_22_2)
end

function var_0_0.refreshBadgeItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.badgeItemDic[arg_23_1]
	local var_23_1 = arg_23_2:getState()
	local var_23_2 = ResUrl.getAct174BadgeIcon(arg_23_2.config.icon, var_23_1)

	var_23_0.simageIcon:LoadImage(var_23_2)

	var_23_0.txtNum.text = arg_23_2.count
end

function var_0_0.initRule(arg_24_0)
	local var_24_0 = arg_24_0.actInfo:getRuleHeroCoList()
	local var_24_1 = #var_24_0
	local var_24_2 = {}

	for iter_24_0 = 0, 2 do
		table.insert(var_24_2, var_24_0[var_24_1 - iter_24_0])
	end

	table.sort(var_24_2, Activity174Helper.sortActivity174RoleCo)

	arg_24_0.ruleHeroIconList = {}

	for iter_24_1, iter_24_2 in ipairs(var_24_2) do
		local var_24_3 = gohelper.findChild(arg_24_0._gorule, "role/" .. iter_24_1)
		local var_24_4 = gohelper.findChildImage(var_24_3, "rare")
		local var_24_5 = gohelper.findChildSingleImage(var_24_3, "heroicon")
		local var_24_6 = gohelper.findChildImage(var_24_3, "career")
		local var_24_7 = gohelper.findChildText(var_24_3, "name")

		var_24_5:LoadImage(ResUrl.getHeadIconSmall(iter_24_2.skinId))
		UISpriteSetMgr.instance:setCommonSprite(var_24_4, "bgequip" .. tostring(CharacterEnum.Color[iter_24_2.rare]))
		UISpriteSetMgr.instance:setCommonSprite(var_24_6, "lssx_" .. tostring(iter_24_2.career))

		var_24_7.text = iter_24_2.name
		arg_24_0.ruleHeroIconList[iter_24_1] = var_24_5
	end
end

function var_0_0.dailyRefresh(arg_25_0)
	Activity174Rpc.instance:sendGetAct174InfoRequest(arg_25_0.actId, arg_25_0.checkSeason, arg_25_0)
end

function var_0_0.checkSeason(arg_26_0)
	arg_26_0:refreshUI()

	local var_26_0 = arg_26_0.actInfo:getGameInfo()

	if not var_26_0:isInGame() then
		return
	end

	if arg_26_0.actInfo.season ~= var_26_0.season then
		Activity174Rpc.instance:sendChangeSeasonEndAct174Request(arg_26_0.actId, arg_26_0.seasonChangeEnd, arg_26_0)
	end
end

function var_0_0.seasonChangeEnd(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_2 == 0 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.SeasonChange)

		if Activity174Model.instance:getActInfo():getGameEndInfo() then
			Activity174Controller.instance:openSettlementView()
		end
	end
end

function var_0_0._nextReply(arg_28_0)
	local var_28_0 = Activity174Config.instance:getMaxRound(arg_28_0.actId, 1)

	if arg_28_0.actInfo:getGameInfo().gameCount > var_28_0 + 1 then
		Activity174Controller.instance:openEndLessView({
			showScore = true
		})
	else
		arg_28_0:_btnEnterGameOnClick(true)
	end
end

return var_0_0
