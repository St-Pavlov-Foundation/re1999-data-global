module("modules.logic.fight.system.work.FightWorkCheckNaNaBindContract", package.seeall)

local var_0_0 = class("FightWorkCheckNaNaBindContract", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance.notifyEntityId

	if string.nilorempty(var_1_0) then
		arg_1_0:onDone(true)

		return
	end

	if not FightHelper.getEntity(var_1_0) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = FightModel.instance.canContractList

	if not var_1_1 or #var_1_1 < 1 then
		arg_1_0:onDone(true)

		return
	end

	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.BindContract)
	ViewMgr.instance:openView(ViewName.FightNaNaTargetView)
	arg_1_0:cancelFightWorkSafeTimer()
end

return var_0_0
