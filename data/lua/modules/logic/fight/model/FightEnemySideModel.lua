module("modules.logic.fight.model.FightEnemySideModel", package.seeall)

local var_0_0 = class("FightEnemySideModel", BaseModel)

function var_0_0.getList(arg_1_0)
	table.sort(arg_1_0._list, FightHelper.sortAssembledMonsterFunc)

	return arg_1_0._list
end

return var_0_0
