module("modules.logic.fight.controller.FightStressHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getStressUiType(arg_1_0)
	local var_1_0 = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

	if var_1_0 then
		local var_1_1 = var_1_0.stressIdentity[arg_1_0]

		if var_1_1 then
			table.sort(var_1_1, var_0_0.sortIdentity)

			return var_0_0.getIdentityUiType(var_1_1[1])
		end
	end

	local var_1_2
	local var_1_3 = FightDataHelper.entityMgr:getById(arg_1_0)

	if not var_1_3 then
		return FightNameUIStressMgr.UiType.Normal
	end

	if var_1_3.side == FightEnum.EntitySide.MySide then
		var_1_2 = FightNameUIStressMgr.HeroDefaultIdentityId
	else
		local var_1_4 = var_1_3:getCO()
		local var_1_5 = var_1_4 and lua_monster_skill_template.configDict[var_1_4.skillTemplate]

		var_1_2 = var_1_5 and var_1_5.identity or FightNameUIStressMgr.HeroDefaultIdentityId
		var_1_2 = tonumber(var_1_2)
	end

	return var_0_0.getIdentityUiType(var_1_2)
end

function var_0_0.sortIdentity(arg_2_0, arg_2_1)
	return arg_2_0 < arg_2_1
end

function var_0_0.getIdentityUiType(arg_3_0)
	local var_3_0 = lua_stress_identity.configDict[arg_3_0]

	if not var_3_0 then
		logError(string.format("身份类型表，identityId : %s, 不存在", arg_3_0))

		return FightNameUIStressMgr.UiType.Normal
	end

	return var_3_0.uiType
end

return var_0_0
