module("modules.logic.room.view.backpack.RoomBackpackPropView", package.seeall)

slot0 = class("RoomBackpackPropView", BaseView)

function slot0.onInitView(slot0)
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0._onItemChange(slot0)
	slot0:refreshPropList()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshPropList()
end

function slot0.refreshPropList(slot0)
	RoomBackpackController.instance:refreshPropBackpackList()
	slot0:refreshIsEmpty()
end

function slot0.refreshIsEmpty(slot0)
	gohelper.setActive(slot0._goempty, RoomBackpackPropListModel.instance:isBackpackEmpty())
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
