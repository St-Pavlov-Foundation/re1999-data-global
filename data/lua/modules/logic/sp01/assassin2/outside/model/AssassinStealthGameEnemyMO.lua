module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameEnemyMO", package.seeall)

local var_0_0 = class("AssassinStealthGameEnemyMO")

function var_0_0.updateData(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.monsterId = arg_1_1.monsterId
	arg_1_0.isDead = arg_1_1.isDead
	arg_1_0.scan = arg_1_1.scan

	arg_1_0:updateBuffList(arg_1_1.buffs)
	arg_1_0:updatePos(arg_1_1.gridId, arg_1_1.pos)
end

function var_0_0.updateBuffList(arg_2_0, arg_2_1)
	arg_2_0._buffDict = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0._buffDict[iter_2_1.id] = iter_2_1.duration
	end
end

function var_0_0.updatePos(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.gridId = arg_3_1
	arg_3_0.pos = arg_3_2
end

function var_0_0.hasBuff(arg_4_0, arg_4_1)
	local var_4_0 = false

	if arg_4_0._buffDict then
		var_4_0 = arg_4_0._buffDict[arg_4_1] and true or false
	end

	return var_4_0
end

function var_0_0.hasBuffType(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_0._buffDict then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._buffDict) do
			if AssassinConfig.instance:getAssassinBuffType(iter_5_0) == arg_5_1 then
				var_5_0 = true

				break
			end
		end
	end

	return var_5_0
end

function var_0_0.getUid(arg_6_0)
	return arg_6_0.uid
end

function var_0_0.getMonsterId(arg_7_0)
	return arg_7_0.monsterId
end

function var_0_0.getIsDead(arg_8_0)
	return arg_8_0.isDead ~= 0
end

function var_0_0.getPos(arg_9_0)
	return arg_9_0.gridId, arg_9_0.pos
end

function var_0_0.getExposeRate(arg_10_0)
	local var_10_0 = AssassinEnum.StealthConst.MinExposeRate
	local var_10_1 = arg_10_0:getIsDead()
	local var_10_2 = arg_10_0:hasBuffType(AssassinEnum.StealGameBuffType.Petrifaction)

	if not var_10_1 and not var_10_2 then
		local var_10_3 = arg_10_0:getMonsterId()
		local var_10_4 = 0

		var_10_4 = arg_10_0.scan == 1 and AssassinConfig.instance:getEnemyScanRate(var_10_3) or var_10_4
		var_10_0 = var_10_4 / AssassinEnum.StealthConst.ConfigExposeRatePoint
	end

	return var_10_0
end

return var_0_0
