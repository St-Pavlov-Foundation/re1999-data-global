module("modules.logic.fight.model.datahelper.FightEntityDataHelper", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	class = true
}

function var_0_0.isPlayerUid(arg_1_0)
	return arg_1_0 == FightEntityScene.MySideId or arg_1_0 == FightEntityScene.EnemySideId
end

function var_0_0.isNotPlayerUid(arg_2_0)
	return arg_2_0 ~= FightEntityScene.MySideId and arg_2_0 ~= FightEntityScene.EnemySideId
end

function var_0_0.copyEntityMO(arg_3_0, arg_3_1)
	FightDataUtil.coverData(arg_3_0, arg_3_1, var_0_1)
end

function var_0_0.sortSubEntityList(arg_4_0, arg_4_1)
	return arg_4_0.position > arg_4_1.position
end

return var_0_0
