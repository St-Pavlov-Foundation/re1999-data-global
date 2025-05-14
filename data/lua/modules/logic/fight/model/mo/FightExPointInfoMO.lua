module("modules.logic.fight.model.mo.FightExPointInfoMO", package.seeall)

local var_0_0 = pureTable("FightExPointInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.exPoint = arg_1_1.exPoint
	arg_1_0.powerInfos = arg_1_1.powerInfos

	if arg_1_1.HasField then
		if arg_1_1:HasField("currentHp") then
			arg_1_0.currentHp = arg_1_1.currentHp
		end
	else
		arg_1_0.currentHp = arg_1_1.currentHp
	end
end

return var_0_0
