module("modules.logic.popup.model.PopupCacheModel", package.seeall)

slot0 = class("PopupCacheModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.recordCachePopupParam(slot0, slot1)
	slot0:addAtLast(slot1)
end

function slot0.popNextPopupParam(slot0)
	return slot0:removeFirst()
end

slot0.instance = slot0.New()

return slot0
