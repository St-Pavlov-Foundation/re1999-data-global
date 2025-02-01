module("modules.logic.gift.view.GiftInsightHeroChoiceView", package.seeall)

slot0 = class("GiftInsightHeroChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._goconfirm = gohelper.findChild(slot0.viewGO, "#btn_confirm/#go_confirm")
	slot0._gonoconfirm = gohelper.findChild(slot0.viewGO, "#btn_confirm/#go_noconfirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._scrollrule = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_rule")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	slot0._gotitle1 = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	slot0._gonogain = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	slot0._gotitle2 = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	slot0._goown = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if ItemInsightModel.instance:getInsightItemCount(slot0.viewParam.uid) < 1 then
		GameFacade.showToast(ToastEnum.GiftInsightNoEnoughItem)

		return
	end

	if GiftInsightHeroChoiceModel.instance:getCurHeroId() > 0 then
		ItemRpc.instance:sendUseInsightItemRequest(slot1, slot2, slot0._onUseFinished, slot0)

		return
	end

	GameFacade.showToast(ToastEnum.GiftInsightNoChooseHero)
end

function slot0._onUseFinished(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	TaskDispatcher.runDelay(slot0._useItemSuccess, slot0, 0.5)
end

function slot0._useItemSuccess(slot0)
	slot0:_refreshHeros()
	slot0:closeThis()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._addEvents(slot0)
end

function slot0._removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._upHeroItems = {}
	slot0._noUpHeroItems = {}

	slot0:_addEvents()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._itemConfig = ItemConfig.instance:getInsightItemCo(slot0.viewParam.id)
	slot0._txtTitle.text = slot0._itemConfig.useTitle

	slot0:_refreshHeros()
end

function slot0.onClose(slot0)
	GiftInsightHeroChoiceModel.instance:setCurHeroId(0)
end

function slot0._refreshHeros(slot0)
	slot1, slot2 = GiftInsightHeroChoiceModel.instance:getFitHeros(slot0.viewParam.id)

	gohelper.setActive(slot0._gotitle1, slot1 and #slot1 > 0)
	gohelper.setActive(slot0._gonoconfirm, not slot1 or #slot1 < 1)
	gohelper.setActive(slot0._goconfirm, slot1 and #slot1 > 0)
	slot0:_refreshUpHeros(slot1)
	gohelper.setActive(slot0._gotitle2, #slot2 > 0)
	slot0:_refreshNoUpHeros(slot2)
end

function slot0._refreshUpHeros(slot0, slot1)
	for slot5, slot6 in pairs(slot0._upHeroItems) do
		slot6:hide()
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._upHeroItems[slot5] then
			slot0._upHeroItems[slot5] = GiftInsightHeroChoiceListItem.New()

			slot0._upHeroItems[slot5]:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gonogain))
		end

		slot0._upHeroItems[slot5]:refreshItem(slot6)
		slot0._upHeroItems[slot5]:showUp(true)
	end
end

function slot0._refreshNoUpHeros(slot0, slot1)
	for slot5, slot6 in pairs(slot0._noUpHeroItems) do
		slot6:hide()
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._noUpHeroItems[slot5] then
			slot0._noUpHeroItems[slot5] = GiftInsightHeroChoiceListItem.New()

			slot0._noUpHeroItems[slot5]:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goown))
		end

		slot0._noUpHeroItems[slot5]:refreshItem(slot6)
		slot0._noUpHeroItems[slot5]:showUp(false)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._useItemSuccess, slot0)
	slot0:_removeEvents()

	if slot0._upHeroItems then
		for slot4, slot5 in pairs(slot0._upHeroItems) do
			slot5:destroy()
		end

		slot0._upHeroItems = nil
	end

	if slot0._noUpHeroItems then
		for slot4, slot5 in pairs(slot0._noUpHeroItems) do
			slot5:destroy()
		end

		slot0._noUpHeroItems = nil
	end
end

return slot0
