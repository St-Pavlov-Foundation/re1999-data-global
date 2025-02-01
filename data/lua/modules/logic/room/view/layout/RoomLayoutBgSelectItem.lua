module("modules.logic.room.view.layout.RoomLayoutBgSelectItem", package.seeall)

slot0 = class("RoomLayoutBgSelectItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_item")
	slot0._simagecover = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_cover")
	slot0._txtcovername = gohelper.findChildText(slot0.viewGO, "content/covernamebg/#txt_covername")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "content/#go_select")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnitem:AddClickListener(slot0._btnitemOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnitem:RemoveClickListener()
end

function slot0._btnitemOnClick(slot0)
	slot0:_selectThis()
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._selectThis(slot0)
	if slot0._bgResMO then
		RoomLayoutBgResListModel.instance:setSelect(slot0._bgResMO.id)
		RoomLayoutController.instance:dispatchEvent(RoomEvent.UISelectLayoutPlanCoverItem)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._bgResMO = slot1

	if slot1 then
		slot0._simagecover:LoadImage(slot1:getResPath())

		slot0._txtcovername.text = slot1:getName()
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagecover:UnLoadImage()
end

return slot0
