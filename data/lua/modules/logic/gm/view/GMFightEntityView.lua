module("modules.logic.gm.view.GMFightEntityView", package.seeall)

slot0 = class("GMFightEntityView", BaseView)
slot0.Evt_OnGetEntityDetailInfos = GameUtil.getEventId()
slot0.Evt_SelectHero = GameUtil.getEventId()

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
	GMFightEntityModel.instance:onOpen()

	if GMFightEntityModel.instance:getList()[1] then
		slot0.viewContainer.entityListView:setSelect(slot1)
	end
end

function slot0.onClose(slot0)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

return slot0
