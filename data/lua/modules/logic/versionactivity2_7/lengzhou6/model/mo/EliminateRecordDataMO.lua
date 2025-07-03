module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateRecordDataMO", package.seeall)

local var_0_0 = class("EliminateRecordDataMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0._eliminateTypeMap = {}
end

function var_0_0.setEliminateType(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_0._eliminateTypeMap[arg_2_1] == nil then
		arg_2_0._eliminateTypeMap[arg_2_1] = {}
	end

	local var_2_0 = {
		eliminateType = arg_2_2,
		eliminateCount = arg_2_3,
		spEliminateCount = arg_2_4
	}

	table.insert(arg_2_0._eliminateTypeMap[arg_2_1], var_2_0)
end

function var_0_0.getEliminateTypeMap(arg_3_0)
	return arg_3_0._eliminateTypeMap
end

function var_0_0.clearRecord(arg_4_0)
	tabletool.clear(arg_4_0._eliminateTypeMap)
end

return var_0_0
