module("modules.logic.versionactivity2_3.act174.view.Act174GameShopView", package.seeall)

local var_0_0 = class("Act174GameShopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtShopLevel = gohelper.findChildText(arg_1_0.viewGO, "#go_Shop/ShopLevel/txt_ShopLevel")
	arg_1_0._btnFreshShop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Shop/btn_FreshShop")
	arg_1_0._txtFreshCost = gohelper.findChildText(arg_1_0.viewGO, "#go_Shop/btn_FreshShop/txt_FreshCost")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Shop/ShopLevel/btn_detail")
	arg_1_0._goDetail = gohelper.findChild(arg_1_0.viewGO, "#go_Shop/ShopLevel/go_detail")
	arg_1_0._btnCloseTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Shop/ShopLevel/go_detail/btn_closetip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnFreshShop, arg_2_0._btnFreshShopOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnDetail, arg_2_0._btnDetailOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnCloseTip, arg_2_0._btnCloseTipOnClick, arg_2_0)
end

function var_0_0._btnFreshShopOnClick(arg_3_0)
	if arg_3_0.gameInfo.coin < arg_3_0.shopInfo.freshCost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.shopItemList) do
		iter_3_1.anim:Play("flushed", 0, 0)
	end

	TaskDispatcher.runDelay(arg_3_0.delayFresh, arg_3_0, 0.16)
end

function var_0_0._btnDetailOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._goDetail, true)
end

function var_0_0._btnCloseTipOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goDetail, false)
end

function var_0_0.delayFresh(arg_6_0)
	Activity174Rpc.instance:sendFresh174ShopRequest(arg_6_0.actId)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.animBtnFresh = arg_7_0._btnFreshShop.gameObject:GetComponent(gohelper.Type_Animator)

	arg_7_0:initShopItem()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.actId = Activity174Model.instance:getCurActId()

	arg_9_0:refreshShop()
	arg_9_0:addEventCb(Activity174Controller.instance, Activity174Event.FreshShopReply, arg_9_0.refreshShop, arg_9_0)
	arg_9_0:addEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, arg_9_0.refreshShop, arg_9_0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.delayFresh, arg_11_0)
end

function var_0_0.initShopItem(arg_12_0)
	arg_12_0.shopItemList = {}

	for iter_12_0 = 1, 8 do
		local var_12_0 = gohelper.findChild(arg_12_0.viewGO, "#go_Shop/bagRoot/bag" .. iter_12_0)
		local var_12_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0, Act174GameShopItem)

		arg_12_0.shopItemList[iter_12_0] = var_12_1
	end
end

function var_0_0.refreshShop(arg_13_0)
	arg_13_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	arg_13_0.shopInfo = arg_13_0.gameInfo:getShopInfo()
	arg_13_0.goodInfos = arg_13_0.shopInfo.goodInfo

	local var_13_0 = Activity174Config.instance:getShopCo(arg_13_0.actId, arg_13_0.shopInfo.level)

	arg_13_0._txtShopLevel.text = var_13_0 and var_13_0.name or ""

	local var_13_1 = arg_13_0.shopInfo.freshCost

	arg_13_0._txtFreshCost.text = var_13_1

	local var_13_2 = var_13_1 == 0 and "first" or "idle"

	arg_13_0.animBtnFresh:Play(var_13_2)

	for iter_13_0 = 1, 8 do
		local var_13_3 = arg_13_0.goodInfos[iter_13_0]

		arg_13_0.shopItemList[iter_13_0]:setData(var_13_3)
	end
end

return var_0_0
