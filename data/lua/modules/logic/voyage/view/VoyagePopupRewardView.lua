module("modules.logic.voyage.view.VoyagePopupRewardView", package.seeall)

slot0 = class("VoyagePopupRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._goclickmask = gohelper.findChild(slot0.viewGO, "Root/#go_clickmask")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_bg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "Root/desc_scroll/viewport/#txt_title")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "Root/reward_scroll/viewport/content/#go_normal")
	slot0._imagenum = gohelper.findChildImage(slot0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#image_num")
	slot0._goimgall = gohelper.findChild(slot0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#go_imgall")
	slot0._txttaskdesc = gohelper.findChildText(slot0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#txt_taskdesc")
	slot0._goRewards = gohelper.findChild(slot0.viewGO, "Root/reward_scroll/viewport/content/#go_normal/scroll_Rewards/Viewport/#go_Rewards")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_jump")
	slot0._gomail = gohelper.findChild(slot0.viewGO, "Root/#btn_jump/#go_mail")
	slot0._godungeon = gohelper.findChild(slot0.viewGO, "Root/#btn_jump/#go_dungeon")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnjumpOnClick(slot0)
	VoyageController.instance:jump()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:addClickCb(gohelper.getClick(slot0._goclickmask), slot0.closeThis, slot0)

	slot0._txttitle.text = VoyageConfig.instance:getTitle()

	gohelper.setActive(slot0._gomail, false)
	gohelper.setActive(slot0._godungeon, false)
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	slot0:_refresh()
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001UpdatePush, slot0._refresh, slot0)
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, slot0._refresh, slot0)
end

function slot0.onClose(slot0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, slot0._refresh, slot0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001UpdatePush, slot0._refresh, slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
end

function slot0._createOrRefreshList(slot0)
	slot0:_createItemList()

	for slot4, slot5 in pairs(slot0._itemList) do
		slot5:onRefresh()
	end
end

function slot0._createItemList(slot0)
	if slot0._itemList then
		return
	end

	slot0._itemList = {}

	gohelper.setActive(slot0._gonormal, true)

	for slot5, slot6 in ipairs(VoyageConfig.instance:getTaskList()) do
		slot7 = slot0:_createItem(VoyagePopupRewardViewItem)
		slot7._index = slot5
		slot7._view = slot0

		slot7:onUpdateMO(slot6)
		table.insert(slot0._itemList, slot7)
	end

	gohelper.setActive(slot0._gonormal, false)
end

function slot0._refresh(slot0)
	slot0:_createOrRefreshList()
	slot0:_refreshJumpBtn()
end

function slot0._createItem(slot0, slot1)
	return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gonormal, slot1.__name), slot1)
end

function slot0._refreshJumpBtn(slot0)
	slot1 = VoyageModel.instance:hasAnyRewardAvailable()

	gohelper.setActive(slot0._gomail, slot1)
	gohelper.setActive(slot0._godungeon, not slot1)
end

return slot0
