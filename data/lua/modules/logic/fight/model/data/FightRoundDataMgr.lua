module("modules.logic.fight.model.data.FightRoundDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightRoundDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.dataList = {}

	if isDebugBuild then
		arg_1_0.originDataList = {}
	end

	arg_1_0.curRoundData = nil
	arg_1_0.originCurRoundData = nil
	arg_1_0.enterData = nil
end

function var_0_0.setRoundData(arg_2_0, arg_2_1)
	arg_2_0.curRoundData = arg_2_1

	table.insert(arg_2_0.dataList, arg_2_1)
end

function var_0_0.setOriginRoundData(arg_3_0, arg_3_1)
	arg_3_0.originCurRoundData = arg_3_1

	table.insert(arg_3_0.originDataList, arg_3_0.originCurRoundData)
end

function var_0_0.getRoundData(arg_4_0)
	return arg_4_0.curRoundData
end

function var_0_0.getPreRoundData(arg_5_0)
	return arg_5_0.dataList[#arg_5_0.dataList - 1]
end

function var_0_0.getOriginRoundData(arg_6_0)
	return arg_6_0.originCurRoundData
end

function var_0_0.getOriginPreRoundData(arg_7_0)
	return arg_7_0.originDataList[#arg_7_0.originDataList - 1]
end

function var_0_0.onCancelOperation(arg_8_0)
	return
end

function var_0_0.onStageChanged(arg_9_0)
	return
end

return var_0_0
