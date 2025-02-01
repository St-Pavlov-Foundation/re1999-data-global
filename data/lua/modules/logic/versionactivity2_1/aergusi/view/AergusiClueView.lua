module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueView", package.seeall)

slot0 = class("AergusiClueView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagenotebg = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_notebg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:_addEvents()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0._addEvents(slot0)
end

function slot0._removeEvents(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
end

return slot0
