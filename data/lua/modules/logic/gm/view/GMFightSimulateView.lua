module("modules.logic.gm.view.GMFightSimulateView", package.seeall)

slot0 = class("GMFightSimulateView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	GMFightSimulateLeftModel.instance:onOpen()
end

function slot0.onClose(slot0)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

return slot0
