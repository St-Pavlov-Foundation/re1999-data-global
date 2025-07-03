module("modules.logic.fight.entity.comp.FightNameUIExPointExtraItem", package.seeall)

local var_0_0 = class("FightNameUIExPointExtraItem", FightNameUIExPointBaseItem)

function var_0_0.getType(arg_1_0)
	return FightNameUIExPointBaseItem.ExPointType.Extra
end

function var_0_0.GetExtraExPointItem(arg_2_0)
	local var_2_0 = var_0_0.New()

	var_2_0:init(arg_2_0)

	return var_2_0
end

return var_0_0
