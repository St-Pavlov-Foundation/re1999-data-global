module("modules.logic.fight.model.data.FightASFDDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightASFDDataMgr")

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.updateData(arg_2_0, arg_2_1)
	if arg_2_1.attacker:HasField("emitterInfo") then
		arg_2_0.attackerEmitterInfo = FightASFDEmitterInfoMO.New()

		arg_2_0.attackerEmitterInfo:init(arg_2_1.attacker.emitterInfo)
	end

	if arg_2_1.defender:HasField("emitterInfo") then
		arg_2_0.defenderEmitterInfo = FightASFDEmitterInfoMO.New()

		arg_2_0.defenderEmitterInfo:init(arg_2_1.defender.emitterInfo)
	end

	arg_2_0.mySideEnergy = arg_2_1.attacker.energy or 0
	arg_2_0.enemySideEnergy = arg_2_1.defender.energy or 0
end

function var_0_0.getEmitterInfo(arg_3_0, arg_3_1)
	if arg_3_1 == FightEnum.EntitySide.MySide then
		return arg_3_0.attackerEmitterInfo
	end

	if arg_3_1 == FightEnum.EntitySide.EnemySide then
		return arg_3_0.defenderEmitterInfo
	end
end

function var_0_0.getMySideEmitterInfo(arg_4_0)
	return arg_4_0.attackerEmitterInfo
end

function var_0_0.getEnemySideEmitterInfo(arg_5_0)
	return arg_5_0.defenderEmitterInfo
end

function var_0_0.changeEnergy(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == FightEnum.EntitySide.MySide then
		arg_6_0.mySideEnergy = arg_6_0.mySideEnergy or 0
		arg_6_0.mySideEnergy = arg_6_0.mySideEnergy + arg_6_2

		return
	end

	if arg_6_1 == FightEnum.EntitySide.EnemySide then
		arg_6_0.enemySideEnergy = arg_6_0.enemySideEnergy or 0
		arg_6_0.enemySideEnergy = arg_6_0.enemySideEnergy + arg_6_2

		return
	end
end

function var_0_0.getEnergy(arg_7_0, arg_7_1)
	if arg_7_1 == FightEnum.EntitySide.MySide then
		return arg_7_0.mySideEnergy
	else
		return arg_7_0.enemySideEnergy
	end
end

function var_0_0.getEmitterEnergy(arg_8_0, arg_8_1)
	if arg_8_1 == FightEnum.EntitySide.MySide then
		return arg_8_0.attackerEmitterInfo and arg_8_0.attackerEmitterInfo.energy or 0
	else
		return arg_8_0.defenderEmitterInfo and arg_8_0.defenderEmitterInfo.energy or 0
	end
end

function var_0_0.changeEmitterEnergy(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == FightEnum.EntitySide.MySide then
		if arg_9_0.attackerEmitterInfo then
			arg_9_0.attackerEmitterInfo:changeEnergy(arg_9_2)
		end

		return
	end

	if arg_9_1 == FightEnum.EntitySide.EnemySide then
		if arg_9_0.defenderEmitterInfo then
			arg_9_0.defenderEmitterInfo:changeEnergy(arg_9_2)
		end

		return
	end
end

function var_0_0.setEmitterInfo(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == FightEnum.EntitySide.MySide then
		arg_10_0.attackerEmitterInfo = arg_10_2

		return
	end

	if arg_10_1 == FightEnum.EntitySide.EnemySide then
		arg_10_0.defenderEmitterInfo = arg_10_2

		return
	end
end

return var_0_0
