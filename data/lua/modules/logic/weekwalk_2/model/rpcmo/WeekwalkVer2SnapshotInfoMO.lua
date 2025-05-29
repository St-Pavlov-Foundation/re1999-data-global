module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SnapshotInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2SnapshotInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.no = arg_1_1.no
	arg_1_0.skillIds = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.skillIds) do
		table.insert(arg_1_0.skillIds, iter_1_1)
	end
end

function var_0_0.getChooseSkillId(arg_2_0)
	return arg_2_0.skillIds[1]
end

function var_0_0.setChooseSkillId(arg_3_0, arg_3_1)
	arg_3_0.skillIds = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			table.insert(arg_3_0.skillIds, iter_3_1)
		end
	end
end

return var_0_0
