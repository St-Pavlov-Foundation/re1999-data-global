module("modules.logic.versionactivity2_3.act174.view.outside.Act174MainView", package.seeall)

slot0 = class("Act174MainView", BaseView)

function slot0.onInitView(slot0)
	slot0._goachieve = gohelper.findChild(slot0.viewGO, "#go_achieve")
	slot0.badgeGoParent = gohelper.findChild(slot0.viewGO, "#go_achieve/scroll_achieve/viewport/content")
	slot0.badgeGo = gohelper.findChild(slot0.viewGO, "#go_achieve/scroll_achieve/viewport/content/go_achievementicon")
	slot0._btnBadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_achieve/scroll_achieve/#btn_Badge")
	slot0._gorule = gohelper.findChild(slot0.viewGO, "#go_rule")
	slot0._btnrule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rule/#btn_rule")
	slot0._btnEndGame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_EndGame")
	slot0._btnShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_Shop")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "layout/#btn_Shop/#txt_num")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "layout/#go_progress")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "layout/#go_progress/#txt_Round")
	slot0._goHp = gohelper.findChild(slot0.viewGO, "layout/#go_progress/#go_Hp")
	slot0._imageHpPercent = gohelper.findChildImage(slot0.viewGO, "layout/#go_progress/#go_Hp/bg/#image_HpPercent")
	slot0._btnEnterGame = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_EnterGame")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnBadge:AddClickListener(slot0._btnBadgeOnClick, slot0)
	slot0._btnrule:AddClickListener(slot0._btnruleOnClick, slot0)
	slot0._btnEndGame:AddClickListener(slot0._btnEndGameOnClick, slot0)
	slot0._btnShop:AddClickListener(slot0._btnShopOnClick, slot0)
	slot0._btnEnterGame:AddClickListener(slot0._btnEnterGameOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBadge:RemoveClickListener()
	slot0._btnrule:RemoveClickListener()
	slot0._btnEndGame:RemoveClickListener()
	slot0._btnShop:RemoveClickListener()
	slot0._btnEnterGame:RemoveClickListener()
end

function slot0._btnEndGameOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndGameConfirm, MsgBoxEnum.BoxType.Yes_No, slot0.endGame, nil, , slot0)
end

function slot0._btnBadgeOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Act174BadgeWallView)
end

function slot0._btnruleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Act174RotationView)
end

function slot0._btnShopOnClick(slot0)
	Activity174Controller.instance:openStoreView(VersionActivity2_3Enum.ActivityId.Act174Store)
end

function slot0._btnEnterGameOnClick(slot0, slot1)
	if slot0.actInfo:getGameInfo() and slot2:isInGame() then
		if slot2.state == Activity174Enum.GameState.ForceSelect then
			Activity174Controller.instance:openForcePickView(slot2:getForceBagsInfo())
		elseif slot3 == Activity174Enum.GameState.BeforeFight then
			Activity174Controller.instance:openFightReadyView()
		elseif slot3 == Activity174Enum.GameState.Free then
			Activity174Controller.instance:openGameView()
		elseif slot3 == Activity174Enum.GameState.AfterFight then
			Activity174Controller.instance:openFightResultView()
		elseif slot3 == Activity174Enum.GameState.EnterEndless then
			Activity174Controller.instance:openEndLessView()
		else
			logError("GameState need do" .. slot3)
		end

		if not slot1 and (slot3 == Activity174Enum.GameState.Free or slot3 == Activity174Enum.GameState.BeforeFight) then
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_match_start)
		end
	else
		Activity174Rpc.instance:sendStart174GameRequest(slot0.actId, slot0.enterGameCallback, slot0)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	if slot0.viewParam.exitFromFight then
		slot0:_onOpen()
	else
		Activity174Rpc.instance:sendGetAct174InfoRequest(slot0.actId, slot0._onOpen, slot0)
	end
end

function slot0._onOpen(slot0)
	slot0.actInfo = Activity174Model.instance:getActInfo()

	if not slot0:checkGameEndInfo() then
		if slot0.viewParam and slot0.viewParam.exitFromFight then
			slot0:_nextReply()
		else
			AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
		end
	end

	slot0:checkSeason()
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateBadgeMo, slot0.refreshBadge, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, slot0.refreshUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.EndGame, slot0.checkGameEndInfo, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.ClickStartGame, slot0._btnEnterGameOnClick, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.EnterNextAct174FightReply, slot0._nextReply, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, slot0.refreshUI, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0:removeEventCb(Activity174Controller.instance, Activity174Event.EndGame, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity174Controller.instance, Activity174Event.EnterNextAct174FightReply, slot0._nextReply, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.ruleHeroIconList) do
		slot5:UnLoadImage()
	end

	for slot4, slot5 in pairs(slot0.badgeItemDic) do
		slot5.simageIcon:UnLoadImage()
	end
end

function slot0.checkGameEndInfo(slot0)
	if slot0.actInfo:getGameEndInfo() then
		Activity174Controller.instance:openSettlementView()
		slot0:refreshUI()

		return true
	end
end

function slot0.refreshUI(slot0)
	slot2 = slot0.actInfo:getGameInfo():isInGame()

	gohelper.setActive(slot0._btnEndGame, slot2)
	gohelper.setActive(slot0._goprogress, slot2)

	if slot2 then
		slot3, slot4 = Activity174Config.instance:getMaxRound(slot0.actId, slot1.gameCount)
		slot0._txtRound.text = string.format("%s/%s", slot1.gameCount, slot3)
		slot0._imageHpPercent.fillAmount = slot1.hp / tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

		gohelper.setActive(slot0._goHp, not slot4)
	end

	slot0:initRule()
	slot0:refreshBadge()
	slot0:refreshCurrency()
end

function slot0.refreshCurrency(slot0)
	slot0._txtnum.text = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a3DouQuQu).quantity
end

function slot0.enterGameCallback(slot0)
	Activity174Model.instance:clearUnlockNewTeamTipCache()
	Activity174Controller.instance:openForcePickView(slot0.actInfo:getGameInfo().forceBagInfo)
end

function slot0.endGame(slot0)
	Activity174Rpc.instance:sendEndAct174GameRequest(slot0.actId, slot0.endGameCallback, slot0)
end

function slot0.endGameCallback(slot0)
	if slot0.actInfo:getGameEndInfo() then
		Activity174Controller.instance:openSettlementView()

		for slot6, slot7 in pairs(slot0.actInfo:getBadgeScoreChangeDic()) do
			slot0:refreshBadgeItem(slot6, slot0.actInfo:getBadgeMo(slot6))
		end

		slot0:refreshUI()
	else
		logError("gameEndInfo is nil")
	end
end

function slot0.refreshBadge(slot0)
	slot0.badgeItemDic = {}

	gohelper.CreateObjList(slot0, slot0._onSetBadgeItem, slot0.actInfo:getBadgeMoList(), slot0.badgeGoParent, slot0.badgeGo)
end

function slot0._onSetBadgeItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot5 = slot2.id
	slot4.simageIcon = gohelper.findChildSingleImage(slot1, "root/image_icon")
	slot4.txtNum = gohelper.findChildText(slot1, "root/txt_num")
	slot0.badgeItemDic[slot5] = slot4

	slot0:refreshBadgeItem(slot5, slot2)
end

function slot0.refreshBadgeItem(slot0, slot1, slot2)
	slot3 = slot0.badgeItemDic[slot1]

	slot3.simageIcon:LoadImage(ResUrl.getAct174BadgeIcon(slot2.config.icon, slot2:getState()))

	slot3.txtNum.text = slot2.count
end

function slot0.initRule(slot0)
	slot3 = {}

	for slot7 = 0, 2 do
		table.insert(slot3, slot1[#slot0.actInfo:getRuleHeroCoList() - slot7])
	end

	slot7 = Activity174Helper.sortActivity174RoleCo

	table.sort(slot3, slot7)

	slot0.ruleHeroIconList = {}

	for slot7, slot8 in ipairs(slot3) do
		slot9 = gohelper.findChild(slot0._gorule, "role/" .. slot7)
		slot11 = gohelper.findChildSingleImage(slot9, "heroicon")

		slot11:LoadImage(ResUrl.getHeadIconSmall(slot8.skinId))
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot9, "rare"), "bgequip" .. tostring(CharacterEnum.Color[slot8.rare]))
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot9, "career"), "lssx_" .. tostring(slot8.career))

		gohelper.findChildText(slot9, "name").text = slot8.name
		slot0.ruleHeroIconList[slot7] = slot11
	end
end

function slot0.dailyRefresh(slot0)
	Activity174Rpc.instance:sendGetAct174InfoRequest(slot0.actId, slot0.checkSeason, slot0)
end

function slot0.checkSeason(slot0)
	slot0:refreshUI()

	if not slot0.actInfo:getGameInfo():isInGame() then
		return
	end

	if slot0.actInfo.season ~= slot1.season then
		Activity174Rpc.instance:sendChangeSeasonEndAct174Request(slot0.actId, slot0.seasonChangeEnd, slot0)
	end
end

function slot0.seasonChangeEnd(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.SeasonChange)

		if Activity174Model.instance:getActInfo():getGameEndInfo() then
			Activity174Controller.instance:openSettlementView()
		end
	end
end

function slot0._nextReply(slot0)
	if slot0.actInfo:getGameInfo().gameCount > Activity174Config.instance:getMaxRound(slot0.actId, 1) + 1 then
		Activity174Controller.instance:openEndLessView({
			showScore = true
		})
	else
		slot0:_btnEnterGameOnClick(true)
	end
end

return slot0
