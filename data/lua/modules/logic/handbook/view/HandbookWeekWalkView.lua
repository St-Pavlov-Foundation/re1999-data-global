module("modules.logic.handbook.view.HandbookWeekWalkView", package.seeall)

slot0 = class("HandbookWeekWalkView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.mapId = slot0.viewParam.id
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
