module("modules.logic.battlepass.flow.BpChargeFlow", package.seeall)

local var_0_0 = class("BpChargeFlow", FlowSequence)

function var_0_0.buildFlow(arg_1_0)
	PopupController.instance:setPause("BpChargeFlow", true)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("BpChargeFlow")

	local var_1_0 = BpController.instance:needShowLevelUp()

	BpController.instance:pauseShowLevelUp()
	arg_1_0:addWork(BpWaitSecWork.New(0.06))

	if var_1_0 then
		arg_1_0:addWork(BpOpenAndWaitCloseWork.New(ViewName.BpLevelupTipView))
	end

	arg_1_0:addWork(BpCloseViewWork.New(ViewName.BpChargeView))
	arg_1_0:addWork(BpWaitBonusAnimWork.New())
	arg_1_0:start()
end

function var_0_0.clearWork(arg_2_0)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("BpChargeFlow")
	PopupController.instance:setPause("BpChargeFlow", false)
end

return var_0_0
