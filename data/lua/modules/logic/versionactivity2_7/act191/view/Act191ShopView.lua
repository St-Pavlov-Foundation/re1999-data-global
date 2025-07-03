module("modules.logic.versionactivity2_7.act191.view.Act191ShopView", package.seeall)

local var_0_0 = class("Act191ShopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNodeList = gohelper.findChild(arg_1_0.viewGO, "#go_NodeList")
	arg_1_0._btnFreshShop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/shopRoot/#btn_FreshShop")
	arg_1_0._txtFreshCost = gohelper.findChildText(arg_1_0.viewGO, "Middle/shopRoot/#btn_FreshShop/#txt_FreshCost")
	arg_1_0._goFreeFresh = gohelper.findChild(arg_1_0.viewGO, "Middle/shopRoot/#btn_FreshShop/#go_FreeFresh")
	arg_1_0._goShopItem = gohelper.findChild(arg_1_0.viewGO, "Middle/shopRoot/#go_ShopItem")
	arg_1_0._goShopLevel = gohelper.findChild(arg_1_0.viewGO, "Middle/shopRoot/#go_ShopLevel")
	arg_1_0._txtShopLevel = gohelper.findChildText(arg_1_0.viewGO, "Middle/shopRoot/#go_ShopLevel/#txt_ShopLevel")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/shopRoot/#go_ShopLevel/#btn_Detail")
	arg_1_0._goDetail = gohelper.findChild(arg_1_0.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail")
	arg_1_0._btnCloseDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail/#btn_CloseDetail")
	arg_1_0._txtDetail = gohelper.findChildText(arg_1_0.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail/go_scroll/viewport/content/#txt_Detail")
	arg_1_0._btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Bottom/#btn_Next")
	arg_1_0._goTeam = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_Team")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._txtCoin = gohelper.findChildText(arg_1_0.viewGO, "go_topright/Coin/#txt_Coin")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "go_topright/Score/#txt_Score")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnFreshShop:AddClickListener(arg_2_0._btnFreshShopOnClick, arg_2_0)
	arg_2_0._btnDetail:AddClickListener(arg_2_0._btnDetailOnClick, arg_2_0)
	arg_2_0._btnCloseDetail:AddClickListener(arg_2_0._btnCloseDetailOnClick, arg_2_0)
	arg_2_0._btnNext:AddClickListener(arg_2_0._btnNextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnFreshShop:RemoveClickListener()
	arg_3_0._btnDetail:RemoveClickListener()
	arg_3_0._btnCloseDetail:RemoveClickListener()
	arg_3_0._btnNext:RemoveClickListener()
end

function var_0_0._btnCloseDetailOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._goDetail, false)
end

function var_0_0._btnDetailOnClick(arg_5_0)
	Act191StatController.instance:statButtonClick(arg_5_0.viewName, "_btnDetailOnClick")
	gohelper.setAsLastSibling(arg_5_0._goShopLevel)
	gohelper.setActive(arg_5_0._goDetail, true)
end

function var_0_0._btnFreshShopOnClick(arg_6_0)
	if arg_6_0.freshLimit and arg_6_0.freshLimit <= arg_6_0.nodeDetailMo.shopFreshNum then
		GameFacade.showToast(ToastEnum.Act191FreshLimit)

		return
	end

	Act191StatController.instance:statButtonClick(arg_6_0.viewName, "_btnFreshShopOnClick")

	if arg_6_0.gameInfo.coin < arg_6_0:getFreshShopCost() then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.shopItemList) do
		iter_6_1:playFreshAnim()
	end

	TaskDispatcher.runDelay(arg_6_0.delayFresh, arg_6_0, 0.16)
end

function var_0_0.delayFresh(arg_7_0)
	Activity191Rpc.instance:sendFresh191ShopRequest(arg_7_0.actId, arg_7_0._updateInfo, arg_7_0)
end

function var_0_0._btnNextOnClick(arg_8_0)
	if arg_8_0.isLeaving then
		return
	end

	arg_8_0.isLeaving = true

	Activity191Rpc.instance:sendLeave191ShopRequest(arg_8_0.actId, arg_8_0.onLeaveShop, arg_8_0)
	Act191StatController.instance:statButtonClick(arg_8_0.viewName, "_btnNextOnClick")
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._goShopItem, false)

	arg_9_0.actId = Activity191Model.instance:getCurActId()
	arg_9_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_9_0.nodeDetailMo = arg_9_0.gameInfo:getNodeDetailMo()

	local var_9_0

	if tabletool.indexOf(Activity191Enum.TagShopField, arg_9_0.nodeDetailMo.type) then
		var_9_0 = lua_activity191_const.configDict[Activity191Enum.ConstKey.TagShopFreshCost].value
		arg_9_0.freshLimit = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.TagShopFreshLimit].value)
	else
		var_9_0 = lua_activity191_const.configDict[Activity191Enum.ConstKey.ShopFreshCost].value
	end

	arg_9_0.freshCostList = GameUtil.splitString2(var_9_0, true)
	arg_9_0.shopItemList = {}
	arg_9_0.animBtnFresh = arg_9_0._btnFreshShop.gameObject:GetComponent(gohelper.Type_Animator)

	local var_9_1 = arg_9_0:getResInst(Activity191Enum.PrefabPath.NodeListItem, arg_9_0._goNodeList)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, Act191NodeListItem, arg_9_0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_unfold)

	local var_9_2 = arg_9_0:getResInst(Activity191Enum.PrefabPath.TeamComp, arg_9_0._goTeam)

	arg_9_0.teamComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_2, Act191TeamComp, arg_9_0)
end

function var_0_0._updateInfo(arg_10_0)
	if arg_10_0.isLeaving then
		return
	end

	arg_10_0.nodeDetailMo = arg_10_0.gameInfo:getNodeDetailMo()

	arg_10_0:refreshShop()
end

function var_0_0.onOpen(arg_11_0)
	Act191StatController.instance:onViewOpen(arg_11_0.viewName)
	arg_11_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, arg_11_0._updateInfo, arg_11_0)

	if arg_11_0.nodeDetailMo.type == Activity191Enum.NodeType.CollectionShop then
		arg_11_0.teamComp:onClickSwitch(true)
	end

	arg_11_0:refreshUI()
end

function var_0_0.onClose(arg_12_0)
	local var_12_0 = arg_12_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_12_0.viewName, var_12_0)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0.shopConfig = lua_activity191_shop.configDict[arg_13_0.actId][arg_13_0.nodeDetailMo.shopId]
	arg_13_0._txtShopLevel.text = arg_13_0.shopConfig.name
	arg_13_0._txtDetail.text = arg_13_0.shopConfig.desc
	arg_13_0._txtScore.text = arg_13_0.gameInfo.score

	arg_13_0:refreshShop()
end

function var_0_0.refreshShop(arg_14_0)
	if arg_14_0.freshLimit and arg_14_0.freshLimit <= arg_14_0.nodeDetailMo.shopFreshNum then
		ZProj.UGUIHelper.SetGrayscale(arg_14_0._btnFreshShop.gameObject, true)
	else
		ZProj.UGUIHelper.SetGrayscale(arg_14_0._btnFreshShop.gameObject, false)
	end

	local var_14_0 = arg_14_0:getFreshShopCost()
	local var_14_1 = var_14_0 == 0 and "first" or "idle"

	arg_14_0.animBtnFresh:Play(var_14_1, 0, 0)

	arg_14_0._txtFreshCost.text = var_14_0
	arg_14_0._txtCoin.text = arg_14_0.gameInfo.coin

	for iter_14_0 = 1, 6 do
		local var_14_2 = arg_14_0.nodeDetailMo.shopPosMap[tostring(iter_14_0)]
		local var_14_3 = arg_14_0.shopItemList[iter_14_0]

		if var_14_2 then
			var_14_3 = var_14_3 or arg_14_0:createShopItem(iter_14_0)

			local var_14_4 = tabletool.indexOf(arg_14_0.nodeDetailMo.boughtSet, iter_14_0)

			var_14_3:setData(var_14_2, var_14_4)
			gohelper.setActive(var_14_3.go, true)
		elseif var_14_3 then
			gohelper.setActive(var_14_3.go, false)
		end
	end
end

function var_0_0.createShopItem(arg_15_0, arg_15_1)
	local var_15_0 = gohelper.cloneInPlace(arg_15_0._goShopItem, "shopItem" .. arg_15_1)
	local var_15_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_0, Act191ShopItem, arg_15_0)

	var_15_1:setIndex(arg_15_1)

	arg_15_0.shopItemList[arg_15_1] = var_15_1

	return var_15_1
end

function var_0_0.onLeaveShop(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == 0 then
		Activity191Controller.instance:nextStep()
		ViewMgr.instance:closeView(arg_16_0.viewName)
	end

	arg_16_0.isLeaving = false
end

function var_0_0.getFreshShopCost(arg_17_0)
	local var_17_0 = arg_17_0.nodeDetailMo.shopFreshNum

	for iter_17_0 = #arg_17_0.freshCostList, 1, -1 do
		local var_17_1 = arg_17_0.freshCostList[iter_17_0]

		if var_17_1[1] <= var_17_0 + 1 then
			return var_17_1[2]
		end
	end
end

return var_0_0
