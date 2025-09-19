module("modules.logic.survival.model.SurvivalTalentGroupMo", package.seeall)

local var_0_0 = pureTable("SurvivalTalentGroupMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.groupId = 1
	arg_1_0.talents = {}
	arg_1_0.parent = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.groupId = arg_2_1.groupId
	arg_2_0.talents = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.talentIds) do
		arg_2_0.talents[iter_2_1] = true
	end
end

function var_0_0.getTalentCos(arg_3_0)
	if not arg_3_0._talents then
		arg_3_0._talents = {}

		local var_3_0 = SurvivalConfig.instance:getAllTalentCos(arg_3_0.groupId)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if SurvivalHelper.instance:isInSeasonAndVersion(iter_3_1) then
				table.insert(arg_3_0._talents, iter_3_1)
			end
		end

		table.sort(arg_3_0._talents, var_0_0.sortCo)

		if #arg_3_0._talents ~= 8 then
			logError("天赋配置不是8个？？？？" .. arg_3_0.groupId .. " >>> " .. #arg_3_0._talents)
		end
	end

	return arg_3_0._talents
end

function var_0_0.isTalentUnlock(arg_4_0, arg_4_1)
	return arg_4_0.parent.allUnlockIds[arg_4_1]
end

function var_0_0.getEquipTalents(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0:getTalentCos()) do
		if arg_5_0.talents[iter_5_1.id] then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function var_0_0.isEquipAll(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0:getTalentCos()) do
		if not arg_6_0.talents[iter_6_1.id] and arg_6_0:isTalentUnlock(iter_6_1.id) then
			return false
		end
	end

	return true
end

function var_0_0.sortCo(arg_7_0, arg_7_1)
	if arg_7_0.pos ~= arg_7_1.pos then
		return arg_7_0.pos < arg_7_1.pos
	end

	return arg_7_0.id < arg_7_1.id
end

return var_0_0
