module("modules.logic.versionactivity2_3.act174.view.Act174GameShopView", package.seeall)

slot0 = class("Act174GameShopView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtShopLevel = gohelper.findChildText(slot0.viewGO, "#go_Shop/ShopLevel/txt_ShopLevel")
	slot0._btnFreshShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Shop/btn_FreshShop")
	slot0._txtFreshCost = gohelper.findChildText(slot0.viewGO, "#go_Shop/btn_FreshShop/txt_FreshCost")
	slot0._btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Shop/ShopLevel/btn_detail")
	slot0._goDetail = gohelper.findChild(slot0.viewGO, "#go_Shop/ShopLevel/go_detail")
	slot0._btnCloseTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Shop/ShopLevel/go_detail/btn_closetip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnFreshShop, slot0._btnFreshShopOnClick, slot0)
	slot0:addClickCb(slot0._btnDetail, slot0._btnDetailOnClick, slot0)
	slot0:addClickCb(slot0._btnCloseTip, slot0._btnCloseTipOnClick, slot0)
end

function slot0._btnFreshShopOnClick(slot0)
	if slot0.gameInfo.coin < slot0.shopInfo.freshCost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	for slot4, slot5 in ipairs(slot0.shopItemList) do
		slot5.anim:Play("flushed", 0, 0)
	end

	TaskDispatcher.runDelay(slot0.delayFresh, slot0, 0.16)
end

function slot0._btnDetailOnClick(slot0)
	gohelper.setActive(slot0._goDetail, true)
end

function slot0._btnCloseTipOnClick(slot0)
	gohelper.setActive(slot0._goDetail, false)
end

function slot0.delayFresh(slot0)
	Activity174Rpc.instance:sendFresh174ShopRequest(slot0.actId)
end

function slot0._editableInitView(slot0)
	slot0.animBtnFresh = slot0._btnFreshShop.gameObject:GetComponent(gohelper.Type_Animator)

	slot0:initShopItem()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Activity174Model.instance:getCurActId()

	slot0:refreshShop()
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.FreshShopReply, slot0.refreshShop, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, slot0.refreshShop, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayFresh, slot0)
end

function slot0.initShopItem(slot0)
	slot0.shopItemList = {}

	for slot4 = 1, 8 do
		slot0.shopItemList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, "#go_Shop/bagRoot/bag" .. slot4), Act174GameShopItem)
	end
end

function slot0.refreshShop(slot0)
	slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	slot0.shopInfo = slot0.gameInfo:getShopInfo()
	slot0.goodInfos = slot0.shopInfo.goodInfo
	slot0._txtShopLevel.text = Activity174Config.instance:getShopCo(slot0.actId, slot0.shopInfo.level) and slot1.name or ""
	slot2 = slot0.shopInfo.freshCost
	slot0._txtFreshCost.text = slot2

	slot0.animBtnFresh:Play(slot2 == 0 and "first" or "idle")

	for slot7 = 1, 8 do
		slot0.shopItemList[slot7]:setData(slot0.goodInfos[slot7])
	end
end

return slot0
