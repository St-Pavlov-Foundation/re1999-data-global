module("modules.logic.room.view.layout.RoomLayoutItemTips", package.seeall)

slot0 = class("RoomLayoutItemTips", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_content/Bg/#txt_title")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "#go_content/#scroll_ItemList")
	slot0._gonormalitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_normalitem")
	slot0._gobuildingicon = gohelper.findChild(slot0.viewGO, "#go_content/#go_normalitem/#go_buildingicon")
	slot0._godikuaiicon = gohelper.findChild(slot0.viewGO, "#go_content/#go_normalitem/#go_dikuaiicon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_content/#go_normalitem/#txt_name")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_content/#go_normalitem/#txt_num")
	slot0._txtdegree = gohelper.findChildText(slot0.viewGO, "#go_content/#go_normalitem/#txt_degree")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, slot0.onGainItem, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.NewBlockPackagePush, slot0.onGainItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, slot0.onGainItem, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.NewBlockPackagePush, slot0.onGainItem, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onGainItem(slot0)
	RoomLayoutItemListModel.instance:resortList()
end

function slot0._editableInitView(slot0)
	slot0._viewGOTrs = slot0.viewGO.transform
	slot0._gocontentTrs = slot0._gocontent.transform
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	recthelper.setHeight(slot0._gocontentTrs, slot0.viewContainer:getTipsHeight())

	if slot0.viewParam then
		if slot0.viewParam.titleStr then
			slot0._txttitle.text = slot0.viewParam.titleStr
		end

		if slot0.viewParam.uiWorldPos then
			slot0:layoutAnchor(slot0.viewParam.uiWorldPos, slot0.viewParam.offsetWidth, slot0.viewParam.offsetHeight)
		end
	end
end

function slot0.layoutAnchor(slot0, slot1, slot2, slot3)
	RoomLayoutHelper.tipLayoutAnchor(slot0._gocontentTrs, slot0._viewGOTrs, slot1, slot2, slot3)
end

function slot0.onClose(slot0)
	RoomLayoutController.instance:dispatchEvent(RoomEvent.UICancelLayoutPlanItemTab)
end

function slot0.onDestroyView(slot0)
end

return slot0
