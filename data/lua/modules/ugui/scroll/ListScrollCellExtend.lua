module("modules.ugui.scroll.ListScrollCellExtend", package.seeall)

slot0 = class("ListScrollCellExtend", ListScrollCell)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
	slot0:_editableAddEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
	slot0:_editableRemoveEvents()
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

return slot0
