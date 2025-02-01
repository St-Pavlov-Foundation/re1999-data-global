module("modules.logic.battlepass.flow.BpCloseViewWork", package.seeall)

slot0 = class("BpCloseViewWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._viewName = slot1
end

function slot0.onStart(slot0)
	ViewMgr.instance:closeView(slot0._viewName)
	slot0:onDone(true)
end

return slot0
