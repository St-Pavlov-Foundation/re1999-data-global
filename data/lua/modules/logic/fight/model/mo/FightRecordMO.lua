module("modules.logic.fight.model.mo.FightRecordMO", package.seeall)

local var_0_0 = pureTable("FightRecordMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.fightId = arg_1_1.fightId
	arg_1_0.fightName = arg_1_1.fightName
	arg_1_0.fightTime = arg_1_1.fightTime
	arg_1_0.fightResult = arg_1_1.fightResult

	FightStatModel.instance:setAtkStatInfo(arg_1_1.attackStatistics)
end

return var_0_0
