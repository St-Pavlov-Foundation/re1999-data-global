module("modules.logic.room.view.layout.RoomLayoutBgSelectView", package.seeall)

slot0 = class("RoomLayoutBgSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_content/Bg/#txt_title")
	slot0._scrollCoverItemList = gohelper.findChildScrollRect(slot0.viewGO, "#go_content/#scroll_CoverItemList")
	slot0._gocoveritem = gohelper.findChild(slot0.viewGO, "#go_content/#go_coveritem")
	slot0._simagecover = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#go_coveritem/bg/#simage_cover")
	slot0._txtcovername = gohelper.findChildText(slot0.viewGO, "#go_content/#go_coveritem/bg/covernamebg/#txt_covername")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()

	slot2 = RoomLayoutListModel.instance:getSelectMO()

	if RoomLayoutBgResListModel.instance:getSelectMO() and slot2 and slot1.id ~= slot2:getCoverId() then
		RoomRpc.instance:sendSetRoomPlanCoverRequest(slot2.id, slot1.id)
	end
end

function slot0._editableInitView(slot0)
	slot0._viewGOTrs = slot0.viewGO.transform
	slot0._gocontentTrs = slot0._gocontent.transform
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._txttitle.text = RoomLayoutListModel.instance:getSelectMO() and slot1.name or ""

	RoomLayoutBgResListModel.instance:setSelect(RoomLayoutListModel.instance:getSelectMO() and slot2:getCoverId())

	if slot0.viewParam and slot0.viewParam.uiWorldPos then
		slot0:layoutAnchor(slot0.viewParam.uiWorldPos, slot0.viewParam.offsetWidth, slot0.viewParam.offsetHeight)
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
