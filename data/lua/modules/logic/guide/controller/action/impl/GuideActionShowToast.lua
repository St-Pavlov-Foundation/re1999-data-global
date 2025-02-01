module("modules.logic.guide.controller.action.impl.GuideActionShowToast", package.seeall)

slot0 = class("GuideActionShowToast", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._toastId = tonumber(slot3)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0._toastId then
		GameFacade.showToast(slot0._toastId)
	else
		logError("指引飘字失败，没配飘字id")
	end

	slot0:onDone(true)
end

return slot0
