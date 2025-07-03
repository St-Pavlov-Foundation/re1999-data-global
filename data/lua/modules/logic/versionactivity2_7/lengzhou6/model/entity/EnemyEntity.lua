module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyEntity", package.seeall)

local var_0_0 = class("EnemyEntity", EntityBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._action = EnemyActionData.New()
	arg_1_0._camp = LengZhou6Enum.entityCamp.enemy
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.initByConfig(arg_3_0)
	arg_3_0._config = LengZhou6Config.instance:getEliminateBattleEnemy(arg_3_0._configId)

	if arg_3_0._config == nil then
		logError("eliminate_battle_enemy config is nil" .. arg_3_0._configId)
	end

	arg_3_0._icon = arg_3_0._config.icon
	arg_3_0._name = arg_3_0._config.name

	arg_3_0:setHp(arg_3_0._config.hp)
	arg_3_0:initAction()

	local var_3_0 = arg_3_0._config.loop

	if not string.nilorempty(var_3_0) then
		local var_3_1 = string.splitToNumber(var_3_0, "#")

		arg_3_0._action:initLoopIndex(var_3_1[1], var_3_1[2])
	end
end

function var_0_0.initAction(arg_4_0)
	arg_4_0._action:init(arg_4_0._configId)
end

function var_0_0.setActionStepIndexAndRound(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._action ~= nil and arg_5_1 ~= nil and arg_5_2 ~= nil then
		arg_5_0._action:setCurBehaviorId(arg_5_1)
		arg_5_0._action:setCurRound(arg_5_2)
	end
end

function var_0_0.getCurSkillList(arg_6_0)
	local var_6_0 = arg_6_0._action:getCurBehavior()

	return var_6_0 and var_6_0:getSkillList() or nil
end

function var_0_0.getAllCanUseSkillId(arg_7_0)
	if arg_7_0._buffs ~= nil then
		for iter_7_0 = 1, #arg_7_0._buffs do
			local var_7_0 = arg_7_0._buffs[iter_7_0]

			if var_7_0:getBuffEffect() == LengZhou6Enum.BuffEffect.petrify and var_7_0:execute(true) then
				return nil, arg_7_0._action:calCurResidueCd()
			end
		end
	end

	arg_7_0:clearInvalidBuff()

	local var_7_1 = arg_7_0._action:getSkillList()
	local var_7_2 = arg_7_0._action:calCurResidueCd()

	if var_7_1 ~= nil then
		for iter_7_1 = 1, #var_7_1 do
			local var_7_3 = var_7_1[iter_7_1]

			arg_7_0._skills[var_7_3._id] = var_7_3
		end

		var_7_2 = 0
	end

	return var_7_1, var_7_2
end

function var_0_0.clearInvalidBuff(arg_8_0)
	local var_8_0 = {}

	if arg_8_0._buffs ~= nil then
		for iter_8_0 = 1, #arg_8_0._buffs do
			if arg_8_0._buffs[iter_8_0]:getBuffEffect() == 0 then
				table.insert(var_8_0, iter_8_0)
			end
		end
	end

	for iter_8_1 = #var_8_0, 1, -1 do
		local var_8_1 = var_8_0[iter_8_1]

		if arg_8_0._buffs[var_8_1] ~= nil then
			arg_8_0._buffs[var_8_1] = nil
		end
	end
end

function var_0_0.getAction(arg_9_0)
	return arg_9_0._action
end

function var_0_0.havePoisonBuff(arg_10_0)
	if arg_10_0._buffs then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._buffs) do
			if iter_10_1._configId == 1001 then
				return true
			end
		end
	end

	return false
end

function var_0_0.useSkill(arg_11_0, arg_11_1)
	if arg_11_0._skills[arg_11_1] ~= nil then
		arg_11_0._skills[arg_11_1]:execute()
	end

	arg_11_0._skills[arg_11_1] = nil
end

return var_0_0
