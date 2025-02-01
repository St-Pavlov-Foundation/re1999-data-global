module("modules.logic.rouge.map.view.store.RougeMapStoreView", package.seeall)

slot0 = class("RougeMapStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollstore = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_store")
	slot0._gostoregoodsitem = gohelper.findChild(slot0.viewGO, "#scroll_store/Viewport/Content/#go_storegoodsitem")
	slot0._btnexit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_exit")
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_refresh")
	slot0._txtrefresh = gohelper.findChildText(slot0.viewGO, "#btn_refresh/#txt_refresh")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "#btn_refresh/#txt_refresh/image_coin/#txt_cost")
	slot0._gorougefunctionitem2 = gohelper.findChild(slot0.viewGO, "#go_rougefunctionitem2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnexit:AddClickListener(slot0._btnexitOnClick, slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnexit:RemoveClickListener()
	slot0._btnrefresh:RemoveClickListener()
end

function slot0._btnexitOnClick(slot0)
	slot0.leaveCallbackId = RougeRpc.instance:sendRougeEndShopEventRequest(slot0.eventMo.eventId, slot0.closeThis, slot0)
end

function slot0._btnrefreshOnClick(slot0)
	if not slot0:checkCanRefresh() then
		GameFacade.showToast(ToastEnum.RougeRefreshCoinNotEnough)

		return
	end

	slot0.refreshCallbackId = RougeRpc.instance:sendRougeShopRefreshRequest(slot0.eventMo.eventId, slot0.onReceiveMsg, slot0)
end

slot0.WaitRefreshAnim = "WaitRefreshAnim"

function slot0.onReceiveMsg(slot0, slot1, slot2)
	slot0.animator:Play("refresh", 0, 0)
	TaskDispatcher.runDelay(slot0.refreshUI, slot0, RougeMapEnum.WaitStoreRefreshAnimDuration)
	UIBlockMgr.instance:startBlock(uv0.WaitRefreshAnim)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage("singlebg/rouge/rouge_reward_fullbg.png")
	gohelper.setActive(slot0._gostoregoodsitem, false)

	slot0.goodsItemList = {}

	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, slot0.onCoinChange, slot0)

	slot0.goCollection = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, slot0._gorougefunctionitem2)
	slot0.collectionComp = RougeCollectionComp.Get(slot0.goCollection)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.blockEsc)

	slot0._txtrefresh.text = luaLang("refresh")
end

function slot0.onCoinChange(slot0)
	slot0:refreshRefreshCount()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.StoreOpen)

	slot0.eventMo = slot0.viewParam

	slot0:refreshUI()
	slot0.collectionComp:onOpen()
end

function slot0.refreshUI(slot0)
	UIBlockMgr.instance:endBlock(uv0.WaitRefreshAnim)
	slot0:refreshGoods()
	slot0:refreshRefreshCount()
end

function slot0.refreshGoods(slot0)
	for slot5, slot6 in pairs(slot0.eventMo.posGoodsList) do
		if not slot0.goodsItemList[slot5] then
			slot7 = RougeMapStoreGoodsItem.New()

			slot7:init(gohelper.cloneInPlace(slot0._gostoregoodsitem))
			table.insert(slot0.goodsItemList, slot7)
		end

		slot7:update(slot0.eventMo, tonumber(slot5), slot6)
	end

	for slot5 = #slot1 + 1, #slot0.goodsItemList do
		slot0.goodsItemList[slot5]:hide()
	end
end

slot0.NormalCostFormat = "<color=#D68A31>%s</color>"
slot0.NotEnoughCostFormat = "<color=#EC6363>%s</color>"

function slot0.refreshRefreshCount(slot0)
	slot0.cost = slot0.eventMo.refreshNeedCoin or 0
	slot0._txtcost.text = string.format(slot0:checkCanRefresh() and uv0.NormalCostFormat or uv0.NotEnoughCostFormat, slot0.cost)
end

function slot0.checkCanRefresh(slot0)
	return RougeModel.instance:getRougeInfo() and slot0.cost <= slot1.coin
end

function slot0.onClose(slot0)
	if slot0.leaveCallbackId then
		RougeRpc.instance:removeCallbackById(slot0.leaveCallbackId)
	end

	if slot0.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(slot0.refreshCallbackId)
	end

	slot0.collectionComp:onClose()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.goodsItemList) do
		slot5:destroy()
	end

	slot0.goodsItemList = nil

	slot0._simagebg:UnLoadImage()
	slot0.collectionComp:destroy()
end

return slot0
