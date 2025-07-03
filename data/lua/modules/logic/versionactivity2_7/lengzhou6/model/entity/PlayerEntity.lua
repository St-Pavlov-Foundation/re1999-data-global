module("modules.logic.versionactivity2_7.lengzhou6.model.entity.PlayerEntity", package.seeall)

local var_0_0 = class("PlayerEntity", EntityBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._camp = LengZhou6Enum.entityCamp.player
	arg_1_0._activeSkill = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0._damageComp = EliminateDamageComp.New()
	arg_2_0._treatmentComp = EliminateTreatmentComp.New()
end

function var_0_0.initByConfig(arg_3_0)
	arg_3_0._config = LengZhou6Config.instance:getEliminateBattleCharacter(arg_3_0._configId)
	arg_3_0._icon = arg_3_0._config.icon
	arg_3_0._name = arg_3_0._config.name

	arg_3_0:setHp(arg_3_0:getRealConfigHp())
	arg_3_0:_initDefaultSkill()
	LocalEliminateChessModel.instance:resetCreateWeight()

	local var_3_0 = arg_3_0._config.skill

	arg_3_0:createAndInitPlayerSkill(var_3_0)
end

function var_0_0.getRealConfigHp(arg_4_0)
	return LengZhou6Enum.enterGM and LengZhou6Enum.DebugPlayerHp or arg_4_0._config.hp
end

function var_0_0.changeHp(arg_5_0, arg_5_1)
	arg_5_0._hpDiff = arg_5_1

	local var_5_0 = arg_5_0:getRealConfigHp()

	arg_5_0._hp = math.max(0, math.min(arg_5_0._hp + arg_5_1, var_5_0))
end

function var_0_0.resetData(arg_6_0, arg_6_1)
	if arg_6_0._damageComp ~= nil then
		arg_6_0._damageComp:reset()
	end

	if arg_6_0._treatmentComp ~= nil then
		arg_6_0._treatmentComp:reset()
	end

	if arg_6_0._skills ~= nil then
		tabletool.clear(arg_6_0._skills)
	end

	if arg_6_0._buffs ~= nil then
		tabletool.clear(arg_6_0._buffs)
	end

	arg_6_0:_initDefaultSkill()
	LocalEliminateChessModel.instance:resetCreateWeight()

	for iter_6_0 = 1, #arg_6_1 do
		local var_6_0 = arg_6_1[iter_6_0]

		arg_6_0:createAndInitPlayerSkill(var_6_0)
	end

	tabletool.clear(arg_6_0._activeSkill)
end

function var_0_0.createAndInitPlayerSkill(arg_7_0, arg_7_1)
	if arg_7_1 == nil or arg_7_1 == 0 then
		return
	end

	arg_7_0:_addSkill(arg_7_1)
	arg_7_0:initSpecialAttrBySkillId(arg_7_1)
	LengZhou6StatHelper.instance:addUseSkillId(arg_7_1)
end

function var_0_0._initDefaultSkill(arg_8_0)
	for iter_8_0 = 1, 4 do
		local var_8_0 = LengZhou6Config.instance:getEliminateBattleCost(iter_8_0)

		arg_8_0:_addSkill(var_8_0)
	end
end

function var_0_0._addSkill(arg_9_0, arg_9_1)
	local var_9_0 = LengZhou6SkillUtils.instance.createSkill(arg_9_1)

	table.insert(arg_9_0._skills, var_9_0)
end

function var_0_0.initSpecialAttrBySkillId(arg_10_0, arg_10_1)
	local var_10_0 = LengZhou6Config.instance:getAllSpecialAttr()

	if var_10_0 == nil then
		return
	end

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_0 == arg_10_1 then
			local var_10_1 = iter_10_1.effect
			local var_10_2 = iter_10_1.chessType
			local var_10_3 = iter_10_1.value

			if var_10_1 == "fixColorWeight" then
				LocalEliminateChessModel.instance:changeCreateWeight(var_10_2, var_10_3)
			end
		end
	end
end

function var_0_0.getActiveSkills(arg_11_0)
	if arg_11_0._activeSkill == nil then
		arg_11_0._activeSkill = {}
	end

	if #arg_11_0._activeSkill == 0 then
		for iter_11_0 = 1, #arg_11_0._skills do
			local var_11_0 = arg_11_0._skills[iter_11_0]

			if var_11_0:getSkillType() == LengZhou6Enum.SkillType.active or var_11_0:getSkillType() == LengZhou6Enum.SkillType.passive and not LengZhou6Config.instance:isPlayerChessPassive(var_11_0:getConfig().id) then
				table.insert(arg_11_0._activeSkill, var_11_0)
			end
		end
	end

	return arg_11_0._activeSkill
end

function var_0_0.updateActiveSkillCD(arg_12_0)
	if arg_12_0._activeSkill == nil then
		return
	end

	for iter_12_0 = 1, #arg_12_0._activeSkill do
		arg_12_0._activeSkill[iter_12_0]:updateCD()
	end
end

function var_0_0.calDamage(arg_13_0, arg_13_1)
	return arg_13_0._damageComp:damage(arg_13_1)
end

function var_0_0.calTreatment(arg_14_0, arg_14_1)
	return arg_14_0._treatmentComp:treatment(arg_14_1)
end

function var_0_0.clearActiveSkillAndSkill(arg_15_0)
	if arg_15_0._activeSkill ~= nil then
		tabletool.clear(arg_15_0._activeSkill)

		arg_15_0._activeSkill = nil
	end

	if arg_15_0._skills ~= nil then
		tabletool.clear(arg_15_0._skills)
	end
end

function var_0_0.clear(arg_16_0)
	var_0_0.super.clear(arg_16_0)
	arg_16_0:clearActiveSkill()
end

return var_0_0
