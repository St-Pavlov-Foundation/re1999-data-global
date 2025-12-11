module("modules.logic.fight.model.data.FightDataMgrBase", package.seeall)

local var_0_0 = FightDataClass("FightDataMgrBase")

function var_0_0.updateData(arg_1_0, arg_1_1)
	return
end

function var_0_0.onCancelOperation(arg_2_0)
	return
end

function var_0_0.onStageChanged(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.com_sendFightEvent(arg_4_0, arg_4_1, ...)
	if arg_4_0.dataMgr.isLocalDataMgr then
		return
	end

	FightController.instance:dispatchEvent(arg_4_1, ...)
end

function var_0_0.com_sendMsg(arg_5_0, arg_5_1, ...)
	if arg_5_0.dataMgr.isLocalDataMgr then
		return
	end

	FightMsgMgr.sendMsg(arg_5_1, ...)
end

return var_0_0
