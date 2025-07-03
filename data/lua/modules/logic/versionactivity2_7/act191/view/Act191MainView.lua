module("modules.logic.versionactivity2_7.act191.view.Act191MainView", package.seeall)

local var_0_0 = class("Act191MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetitleeff = gohelper.findChildSingleImage(arg_1_0.viewGO, "simage_title/#simage_titleeff")
	arg_1_0._btnBadge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_achieve/scroll_achieve/#btn_Badge")
	arg_1_0._btnRule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rule/#btn_Rule")
	arg_1_0._btnEndGame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_EndGame")
	arg_1_0._btnShop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_Shop")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "layout/#btn_Shop/#txt_num")
	arg_1_0._goProgress = gohelper.findChild(arg_1_0.viewGO, "layout/#go_Progress")
	arg_1_0._goHp = gohelper.findChild(arg_1_0.viewGO, "layout/#go_Progress/#go_Hp")
	arg_1_0._imageHpPercent = gohelper.findChildImage(arg_1_0.viewGO, "layout/#go_Progress/#go_Hp/bg/#image_HpPercent")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "layout/#go_Progress/#txt_Round")
	arg_1_0._btnEnterGame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_EnterGame")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBadge:AddClickListener(arg_2_0._btnBadgeOnClick, arg_2_0)
	arg_2_0._btnRule:AddClickListener(arg_2_0._btnRuleOnClick, arg_2_0)
	arg_2_0._btnEndGame:AddClickListener(arg_2_0._btnEndGameOnClick, arg_2_0)
	arg_2_0._btnShop:AddClickListener(arg_2_0._btnShopOnClick, arg_2_0)
	arg_2_0._btnEnterGame:AddClickListener(arg_2_0._btnEnterGameOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBadge:RemoveClickListener()
	arg_3_0._btnRule:RemoveClickListener()
	arg_3_0._btnEndGame:RemoveClickListener()
	arg_3_0._btnShop:RemoveClickListener()
	arg_3_0._btnEnterGame:RemoveClickListener()
end

function var_0_0._btnBadgeOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.Act191BadgeView)
	Act191StatController.instance:statButtonClick(arg_4_0.viewName, "_btnBadgeOnClick")
end

function var_0_0._btnRuleOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.Act191InfoView)
	Act191StatController.instance:statButtonClick(arg_5_0.viewName, "_btnRuleOnClick")
end

function var_0_0._btnEndGameOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndGameConfirm, MsgBoxEnum.BoxType.Yes_No, arg_6_0.endGame, nil, nil, arg_6_0)
	Act191StatController.instance:statButtonClick(arg_6_0.viewName, "_btnEndGameOnClick")
end

function var_0_0.endGame(arg_7_0)
	Activity191Rpc.instance:sendEndAct191GameRequest(arg_7_0.actId)
end

function var_0_0._btnShopOnClick(arg_8_0)
	Activity191Controller.instance:openStoreView(VersionActivity2_7Enum.ActivityId.Act191Store)
	Act191StatController.instance:statButtonClick(arg_8_0.viewName, "_btnShopOnClick")
end

function var_0_0._btnEnterGameOnClick(arg_9_0)
	Activity191Controller.instance:nextStep()
	Act191StatController.instance:statButtonClick(arg_9_0.viewName, "_btnEnterGameOnClick")
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.badgeGoParent = gohelper.findChild(arg_10_0.viewGO, "go_achieve/scroll_achieve/viewport/content")
	arg_10_0.badgeGo = gohelper.findChild(arg_10_0.viewGO, "go_achieve/scroll_achieve/viewport/content/go_achievementicon")
	arg_10_0.actId = Activity191Model.instance:getCurActId()
end

function var_0_0.onOpen(arg_11_0)
	Act191StatController.instance:onViewOpen(arg_11_0.viewName)
	arg_11_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0.refreshCurrency, arg_11_0)
	arg_11_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, arg_11_0.refreshUI, arg_11_0)
	arg_11_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateBadgeMo, arg_11_0.refreshBadge, arg_11_0)
	arg_11_0:addEventCb(Activity191Controller.instance, Activity191Event.EndGame, arg_11_0.checkGameEndInfo, arg_11_0)
	arg_11_0:refreshUI()

	if arg_11_0.viewParam and arg_11_0.viewParam.exitFromFight and not Activity191Controller.instance:checkOpenGetView() then
		arg_11_0:_btnEnterGameOnClick()
	end
end

function var_0_0.onClose(arg_12_0)
	local var_12_0 = arg_12_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_12_0.viewName, var_12_0)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0.actInfo = Activity191Model.instance:getActInfo()

	gohelper.setActive(arg_13_0._btnEndGame, arg_13_0.actInfo:getGameInfo().state ~= Activity191Enum.GameState.None)
	arg_13_0:initRule()
	arg_13_0:refreshBadge()
	arg_13_0:refreshCurrency()
end

function var_0_0.initRule(arg_14_0)
	local var_14_0 = Activity191Config.instance:getShowRoleCoList()
	local var_14_1 = #var_14_0
	local var_14_2 = {}

	for iter_14_0 = 3, 1, -1 do
		var_14_2[#var_14_2 + 1] = var_14_0[var_14_1 + 1 - iter_14_0]
	end

	for iter_14_1, iter_14_2 in ipairs(var_14_2) do
		local var_14_3 = gohelper.findChild(arg_14_0.viewGO, "rule/role/" .. iter_14_1)
		local var_14_4 = gohelper.findChildImage(var_14_3, "rare")
		local var_14_5 = gohelper.findChildSingleImage(var_14_3, "heroicon")
		local var_14_6 = gohelper.findChildImage(var_14_3, "career")

		var_14_5:LoadImage(Activity191Helper.getHeadIconSmall(iter_14_2))
		UISpriteSetMgr.instance:setAct174Sprite(var_14_4, "act174_roleframe_" .. tostring(iter_14_2.quality))
		UISpriteSetMgr.instance:setCommonSprite(var_14_6, "lssx_" .. tostring(iter_14_2.career))
	end
end

function var_0_0.refreshCurrency(arg_15_0)
	local var_15_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act191)

	arg_15_0._txtnum.text = var_15_0.quantity
end

function var_0_0.refreshBadge(arg_16_0)
	arg_16_0.badgeItemDic = {}

	local var_16_0 = arg_16_0.actInfo:getBadgeMoList()

	gohelper.CreateObjList(arg_16_0, arg_16_0._onSetBadgeItem, var_16_0, arg_16_0.badgeGoParent, arg_16_0.badgeGo)
end

function var_0_0._onSetBadgeItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0:getUserDataTb_()
	local var_17_1 = arg_17_2.id

	var_17_0.simageIcon = gohelper.findChildSingleImage(arg_17_1, "root/image_icon")
	var_17_0.txtNum = gohelper.findChildText(arg_17_1, "root/txt_num")
	arg_17_0.badgeItemDic[var_17_1] = var_17_0

	arg_17_0:refreshBadgeItem(var_17_1, arg_17_2)
end

function var_0_0.refreshBadgeItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.badgeItemDic[arg_18_1]
	local var_18_1 = arg_18_2:getState()
	local var_18_2 = ResUrl.getAct174BadgeIcon(arg_18_2.config.icon, var_18_1)

	var_18_0.simageIcon:LoadImage(var_18_2)

	var_18_0.txtNum.text = arg_18_2.count
end

function var_0_0.checkGameEndInfo(arg_19_0)
	if arg_19_0.actInfo:getGameEndInfo() then
		local var_19_0 = Activity191Model.instance:getActInfo():getGameInfo()

		if var_19_0.curNode ~= 0 and var_19_0.curStage ~= 0 then
			Activity191Controller.instance:openSettlementView()
		end

		arg_19_0:refreshUI()

		return true
	end
end

return var_0_0
