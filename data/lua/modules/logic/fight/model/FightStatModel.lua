module("modules.logic.fight.model.FightStatModel", package.seeall)

local var_0_0 = class("FightStatModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._totalHarm = 0
	arg_1_0._totalHurt = 0
	arg_1_0._totalHeal = 0
end

function var_0_0.setAtkStatInfo(arg_2_0, arg_2_1)
	arg_2_0._totalHarm = 0
	arg_2_0._totalHurt = 0
	arg_2_0._totalHeal = 0

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if not arg_2_0:checkShield(iter_2_1) then
			local var_2_1 = iter_2_1.entityMO or FightDataHelper.entityMgr:getById(iter_2_1.heroUid)

			if iter_2_1.heroUid == FightASFDDataMgr.EmitterId then
				var_2_1 = FightDataHelper.ASFDDataMgr:getEmitterEmitterMo()
			end

			if var_2_1 then
				local var_2_2 = FightStatMO.New()

				var_2_2:init(iter_2_1)

				var_2_2.entityMO = iter_2_1.entityMO
				var_2_2.fromOtherFight = iter_2_1.entityMO and true or false

				table.insert(var_2_0, var_2_2)

				arg_2_0._totalHarm = arg_2_0._totalHarm + var_2_2.harm
				arg_2_0._totalHurt = arg_2_0._totalHurt + var_2_2.hurt
				arg_2_0._totalHeal = arg_2_0._totalHeal + var_2_2.heal
			end
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		if arg_3_0.harm ~= arg_3_1.harm then
			return arg_3_0.harm > arg_3_1.harm
		else
			return arg_3_0.entityId < arg_3_1.entityId
		end
	end)
	arg_2_0:setList(var_2_0)
end

function var_0_0.checkShield(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return true
	end

	if arg_4_1.heroUid == FightEntityScene.MySideId or arg_4_1.heroUid == FightEntityScene.EnemySideId then
		return true
	end

	return false
end

function var_0_0.getTotalHarm(arg_5_0)
	return arg_5_0._totalHarm
end

function var_0_0.getTotalHurt(arg_6_0)
	return arg_6_0._totalHurt
end

function var_0_0.getTotalHeal(arg_7_0)
	return arg_7_0._totalHeal
end

var_0_0.instance = var_0_0.New()

return var_0_0
