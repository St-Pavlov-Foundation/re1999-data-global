module("modules.logic.rouge.view.RougePickAssistView", package.seeall)

slot0 = class("RougePickAssistView", PickAssistView)

function slot0.onOpen(slot0)
	slot0._capacityParams = RougeController.instance.pickAssistViewParams

	slot0:_initCapacity()
	uv0.super.onOpen(slot0)
end

function slot0._initCapacity(slot0)
	slot0._capacityComp = RougeCapacityComp.Add(gohelper.findChild(slot0.viewGO, "bg/volume"), slot0._capacityParams.curCapacity, slot0._capacityParams.totalCapacity, true)

	slot0._capacityComp:showChangeEffect(true)
end

function slot0.refreshBtnDetail(slot0)
	uv0.super.refreshBtnDetail(slot0)
	slot0._capacityComp:updateCurNum((PickAssistListModel.instance:getSelectedMO() and RougeConfig1.instance:getRoleCapacity(slot1.heroMO.config.rare) or 0) + slot0._capacityParams.curCapacity)
end

return slot0
