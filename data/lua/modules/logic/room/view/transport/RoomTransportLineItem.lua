module("modules.logic.room.view.transport.RoomTransportLineItem", package.seeall)

slot0 = class("RoomTransportLineItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btnitemclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_itemclick")
	slot0._imagetype1 = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_type1")
	slot0._imagetype2 = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_type2")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_content/#go_select")
	slot0._btndelectPath = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_delectPath")
	slot0._golinkfail = gohelper.findChild(slot0.viewGO, "#go_content/#go_linkfail")
	slot0._golinksuccess = gohelper.findChild(slot0.viewGO, "#go_content/#go_linksuccess")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnitemclick:AddClickListener(slot0._btnitemclickOnClick, slot0)
	slot0._btndelectPath:AddClickListener(slot0._btndelectPathOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnitemclick:RemoveClickListener()
	slot0._btndelectPath:RemoveClickListener()
end

function slot0._btnitemclickOnClick(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(RoomEvent.TransportPathSelectLineItem, slot0:getDataMO())
	end
end

function slot0._btndelectPathOnClick(slot0)
	if slot0:getTransportPathMO() and slot1:isLinkFinish() or slot1:getHexPointCount() > 0 then
		slot1:clear()
		slot1:setIsEdit(true)
		slot0:refreshLinkUI()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
	end
end

function slot0._editableInitView(slot0)
	slot0._gofinishAnim = gohelper.findChild(slot0._golinksuccess, "finish")

	gohelper.setActive(slot0._goselect, false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._dataMO = slot1

	slot0:refreshUI()
end

function slot0.getDataMO(slot0)
	return slot0._dataMO
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._gocontent, slot0._dataMO ~= nil)

	if slot0._dataMO then
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagetype1, RoomBuildingEnum.BuildingTypeLineIcon[slot0._dataMO.fromType])
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagetype2, RoomBuildingEnum.BuildingTypeLineIcon[slot0._dataMO.toType])
	end

	slot0:refreshLinkUI()
end

function slot0.refreshLinkUI(slot0)
	slot1 = slot0:_isCheckLinkFinish()

	gohelper.setActive(slot0._btndelectPath, slot1)
	gohelper.setActive(slot0._golinksuccess, slot1)
	gohelper.setActive(slot0._golinkfail, slot1 == false)

	if slot0._isLinkFinishAnim ~= slot1 then
		if slot0._isLinkFinishAnim ~= nil then
			gohelper.setActive(slot0._gofinishAnim, slot1)
		end

		slot0._isLinkFinishAnim = slot1
	end
end

function slot0._isCheckLinkFinish(slot0)
	if slot0:getTransportPathMO() and slot1:isLinkFinish() then
		return true
	end

	return false
end

function slot0.getTransportPathMO(slot0)
	if slot0._dataMO then
		return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot0._dataMO.fromType, slot0._dataMO.toType)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
