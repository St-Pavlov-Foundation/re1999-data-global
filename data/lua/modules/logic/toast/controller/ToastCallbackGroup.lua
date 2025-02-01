module("modules.logic.toast.controller.ToastCallbackGroup", package.seeall)

slot0 = class("ToastCallbackGroup")

function slot0.ctor(slot0)
	slot0.onOpen = nil
	slot0.onOpenObj = nil
	slot0.onOpenParam = nil
	slot0.onClose = nil
	slot0.onCloseObj = nil
	slot0.onCloseParam = nil
end

function slot0.tryOnOpen(slot0, slot1)
	if slot0.onOpen then
		slot0.onOpen(slot0.onOpenObj, slot0.onOpenParam, slot1)
	end
end

function slot0.tryOnClose(slot0, slot1)
	if slot0.onClose then
		slot0.onClose(slot0.onCloseObj, slot0.onCloseParam, slot1)
	end
end

return slot0
