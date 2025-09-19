module("modules.logic.fight.model.data.FightDataMgrBase", package.seeall)

local var_0_0 = FightDataClass("FightDataMgrBase")

function var_0_0.updateData(arg_1_0, arg_1_1)
	return
end

function var_0_0.onCancelOperation(arg_2_0)
	return
end

function var_0_0.onEnterStage(arg_3_0, arg_3_1)
	return
end

function var_0_0.onExitStage(arg_4_0, arg_4_1)
	return
end

function var_0_0.onStageChanged(arg_5_0, arg_5_1, arg_5_2)
	return
end

function var_0_0.com_sendFightEvent(arg_6_0, arg_6_1, ...)
	if arg_6_0.dataMgr.isLocalDataMgr then
		return
	end

	FightController.instance:dispatchEvent(arg_6_1, ...)
end

return var_0_0
