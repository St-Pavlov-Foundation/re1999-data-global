module("modules.logic.antique.controller.AntiqueController", package.seeall)

slot0 = class("AntiqueController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openAntiqueView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AntiqueView, slot1)
end

slot0.instance = slot0.New()

return slot0
