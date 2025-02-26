module("modules.logic.voyage.view.ActivityGiftForTheVoyage", package.seeall)

slot0 = class("ActivityGiftForTheVoyage", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "title/scroll/view/#txt_title")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "scroll_task/Viewport/content/#go_taskitem")
	slot0._goRewards = gohelper.findChild(slot0.viewGO, "scroll_task/Viewport/content/#go_taskitem/scroll_Rewards/Viewport/#go_Rewards")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")
	slot0._gomail = gohelper.findChild(slot0.viewGO, "#btn_jump/#go_mail")
	slot0._godungeon = gohelper.findChild(slot0.viewGO, "#btn_jump/#go_dungeon")
	slot0._gored = gohelper.findChild(slot0.viewGO, "#btn_jump/#go_red")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
end

function slot0._btnjumpOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	VoyageController.instance:jump()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gomail, false)
	gohelper.setActive(slot0._godungeon, false)

	slot0._txttitle.text = VoyageConfig.instance:getTitle()
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:_refresh()
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001UpdatePush, slot0._refresh, slot0)
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, slot0._refresh, slot0)
	Activity1001Rpc.instance:sendAct1001GetInfoRequest(VoyageConfig.instance:getActivityId())
	RedDotController.instance:addRedDot(slot0._gored, -11235, nil, slot0._addRedDotOverrideFunc, slot0)
end

function slot0.onClose(slot0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, slot0._refresh, slot0)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001UpdatePush, slot0._refresh, slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
end

function slot0._createItemList(slot0)
	if slot0._itemList then
		return
	end

	slot0._itemList = {}

	gohelper.setActive(slot0._gotaskitem, true)

	for slot5, slot6 in ipairs(VoyageConfig.instance:getTaskList()) do
		slot7 = slot0:_createItem(ActivityGiftForTheVoyageItem)
		slot7._index = slot5
		slot7._view = slot0

		slot7:onUpdateMO(slot6)
		slot7:setActiveLine(slot5 ~= #slot1)
		table.insert(slot0._itemList, slot7)
	end

	gohelper.setActive(slot0._gotaskitem, false)
end

function slot0._refresh(slot0)
	slot0:_createOrRefreshList()
	slot0:_refreshJumpBtn()
end

function slot0._createItem(slot0, slot1)
	return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gotaskitem, slot1.__name), slot1)
end

function slot0._createOrRefreshList(slot0)
	slot0:_createItemList()

	for slot4, slot5 in pairs(slot0._itemList) do
		slot5:onRefresh()
	end
end

function slot0._refreshJumpBtn(slot0)
	slot1 = VoyageModel.instance:hasAnyRewardAvailable()

	gohelper.setActive(slot0._gomail, slot1)
	gohelper.setActive(slot0._godungeon, not slot1)
end

function slot0._addRedDotOverrideFunc(slot0, slot1)
	slot1.show = VoyageModel.instance:hasAnyRewardAvailable()

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

return slot0
