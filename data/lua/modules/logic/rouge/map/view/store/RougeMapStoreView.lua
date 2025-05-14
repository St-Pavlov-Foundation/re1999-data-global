module("modules.logic.rouge.map.view.store.RougeMapStoreView", package.seeall)

local var_0_0 = class("RougeMapStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/Content/#go_storegoodsitem")
	arg_1_0._btnexit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_exit")
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_refresh")
	arg_1_0._txtrefresh = gohelper.findChildText(arg_1_0.viewGO, "#btn_refresh/#txt_refresh")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "#btn_refresh/#txt_refresh/image_coin/#txt_cost")
	arg_1_0._gorougefunctionitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_rougefunctionitem2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnexit:AddClickListener(arg_2_0._btnexitOnClick, arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnexit:RemoveClickListener()
	arg_3_0._btnrefresh:RemoveClickListener()
end

function var_0_0._btnexitOnClick(arg_4_0)
	arg_4_0.leaveCallbackId = RougeRpc.instance:sendRougeEndShopEventRequest(arg_4_0.eventMo.eventId, arg_4_0.closeThis, arg_4_0)
end

function var_0_0._btnrefreshOnClick(arg_5_0)
	if not arg_5_0:checkCanRefresh() then
		GameFacade.showToast(ToastEnum.RougeRefreshCoinNotEnough)

		return
	end

	arg_5_0.refreshCallbackId = RougeRpc.instance:sendRougeShopRefreshRequest(arg_5_0.eventMo.eventId, arg_5_0.onReceiveMsg, arg_5_0)
end

var_0_0.WaitRefreshAnim = "WaitRefreshAnim"

function var_0_0.onReceiveMsg(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.animator:Play("refresh", 0, 0)
	TaskDispatcher.runDelay(arg_6_0.refreshUI, arg_6_0, RougeMapEnum.WaitStoreRefreshAnimDuration)
	UIBlockMgr.instance:startBlock(var_0_0.WaitRefreshAnim)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg:LoadImage("singlebg/rouge/rouge_reward_fullbg.png")
	gohelper.setActive(arg_7_0._gostoregoodsitem, false)

	arg_7_0.goodsItemList = {}

	arg_7_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, arg_7_0.onCoinChange, arg_7_0)

	arg_7_0.goCollection = arg_7_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_7_0._gorougefunctionitem2)
	arg_7_0.collectionComp = RougeCollectionComp.Get(arg_7_0.goCollection)
	arg_7_0.animator = arg_7_0.viewGO:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(arg_7_0.viewName, RougeMapHelper.blockEsc)

	arg_7_0._txtrefresh.text = luaLang("refresh")
end

function var_0_0.onCoinChange(arg_8_0)
	arg_8_0:refreshRefreshCount()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.StoreOpen)

	arg_10_0.eventMo = arg_10_0.viewParam

	arg_10_0:refreshUI()
	arg_10_0.collectionComp:onOpen()
end

function var_0_0.refreshUI(arg_11_0)
	UIBlockMgr.instance:endBlock(var_0_0.WaitRefreshAnim)
	arg_11_0:refreshGoods()
	arg_11_0:refreshRefreshCount()
end

function var_0_0.refreshGoods(arg_12_0)
	local var_12_0 = arg_12_0.eventMo.posGoodsList

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		local var_12_1 = arg_12_0.goodsItemList[iter_12_0]

		if not var_12_1 then
			local var_12_2 = gohelper.cloneInPlace(arg_12_0._gostoregoodsitem)

			var_12_1 = RougeMapStoreGoodsItem.New()

			var_12_1:init(var_12_2)
			table.insert(arg_12_0.goodsItemList, var_12_1)
		end

		var_12_1:update(arg_12_0.eventMo, tonumber(iter_12_0), iter_12_1)
	end

	for iter_12_2 = #var_12_0 + 1, #arg_12_0.goodsItemList do
		arg_12_0.goodsItemList[iter_12_2]:hide()
	end
end

var_0_0.NormalCostFormat = "<color=#D68A31>%s</color>"
var_0_0.NotEnoughCostFormat = "<color=#EC6363>%s</color>"

function var_0_0.refreshRefreshCount(arg_13_0)
	arg_13_0.cost = arg_13_0.eventMo.refreshNeedCoin or 0

	local var_13_0 = arg_13_0:checkCanRefresh() and var_0_0.NormalCostFormat or var_0_0.NotEnoughCostFormat

	arg_13_0._txtcost.text = string.format(var_13_0, arg_13_0.cost)
end

function var_0_0.checkCanRefresh(arg_14_0)
	local var_14_0 = RougeModel.instance:getRougeInfo()

	return var_14_0 and var_14_0.coin >= arg_14_0.cost
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0.leaveCallbackId then
		RougeRpc.instance:removeCallbackById(arg_15_0.leaveCallbackId)
	end

	if arg_15_0.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(arg_15_0.refreshCallbackId)
	end

	arg_15_0.collectionComp:onClose()
end

function var_0_0.onDestroyView(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.goodsItemList) do
		iter_16_1:destroy()
	end

	arg_16_0.goodsItemList = nil

	arg_16_0._simagebg:UnLoadImage()
	arg_16_0.collectionComp:destroy()
end

return var_0_0
