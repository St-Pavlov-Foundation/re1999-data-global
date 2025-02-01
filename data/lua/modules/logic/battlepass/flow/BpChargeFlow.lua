module("modules.logic.battlepass.flow.BpChargeFlow", package.seeall)

slot0 = class("BpChargeFlow", FlowSequence)

function slot0.buildFlow(slot0)
	PopupController.instance:setPause("BpChargeFlow", true)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("BpChargeFlow")
	BpController.instance:pauseShowLevelUp()
	slot0:addWork(BpWaitSecWork.New(0.06))

	if BpController.instance:needShowLevelUp() then
		slot0:addWork(BpOpenAndWaitCloseWork.New(ViewName.BpLevelupTipView))
	end

	slot0:addWork(BpCloseViewWork.New(ViewName.BpChargeView))
	slot0:addWork(BpWaitBonusAnimWork.New())
	slot0:start()
end

function slot0.clearWork(slot0)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("BpChargeFlow")
	PopupController.instance:setPause("BpChargeFlow", false)
end

return slot0
