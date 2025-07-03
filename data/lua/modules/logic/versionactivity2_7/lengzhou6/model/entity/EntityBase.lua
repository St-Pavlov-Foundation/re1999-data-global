module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EntityBase", package.seeall)

local var_0_0 = class("EntityBase")

function var_0_0.ctor(arg_1_0)
	arg_1_0._hp = 0
	arg_1_0._skills = {}
	arg_1_0._buffs = {}
	arg_1_0._configId = 0
	arg_1_0._damageComp = nil
	arg_1_0._treatmentComp = nil
	arg_1_0._camp = -1
	arg_1_0._icon = ""
	arg_1_0._name = ""
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._configId = arg_2_1

	arg_2_0:initByConfig()
end

function var_0_0.initByConfig(arg_3_0)
	return
end

function var_0_0.changeHp(arg_4_0, arg_4_1)
	arg_4_0._hpDiff = arg_4_1
	arg_4_0._hp = math.max(0, arg_4_0._hp + arg_4_1)
end

function var_0_0.getCurDiff(arg_5_0)
	return arg_5_0._hpDiff
end

function var_0_0.getHp(arg_6_0)
	return arg_6_0._hp
end

function var_0_0.setHp(arg_7_0, arg_7_1)
	arg_7_0._hp = arg_7_1
end

function var_0_0.getConfigId(arg_8_0)
	return arg_8_0._configId
end

function var_0_0.getDamageComp(arg_9_0)
	return arg_9_0._damageComp
end

function var_0_0.getTreatmentComp(arg_10_0)
	return arg_10_0._treatmentComp
end

function var_0_0.triggerBuffAndSkill(arg_11_0)
	if arg_11_0._skills then
		for iter_11_0 = 1, #arg_11_0._skills do
			local var_11_0 = arg_11_0._skills[iter_11_0]

			if var_11_0 ~= nil and var_11_0:getSkillType() == LengZhou6Enum.SkillType.passive then
				var_11_0:execute()
			end
		end
	end

	if arg_11_0._buffs then
		for iter_11_1 = 1, #arg_11_0._buffs do
			local var_11_1 = arg_11_0._buffs[iter_11_1]

			if var_11_1 ~= nil then
				var_11_1:execute()
			end
		end
	end
end

function var_0_0.getCamp(arg_12_0)
	return arg_12_0._camp
end

function var_0_0.calDamage(arg_13_0)
	return
end

function var_0_0.calTreatment(arg_14_0)
	return
end

function var_0_0.getIcon(arg_15_0)
	return arg_15_0._icon
end

function var_0_0.getName(arg_16_0)
	return arg_16_0._name
end

function var_0_0.addBuff(arg_17_0, arg_17_1)
	table.insert(arg_17_0._buffs, arg_17_1)
end

function var_0_0.getBuffByConfigId(arg_18_0, arg_18_1)
	for iter_18_0 = 1, #arg_18_0._buffs do
		local var_18_0 = arg_18_0._buffs[iter_18_0]

		if var_18_0._configId == arg_18_1 then
			return var_18_0
		end
	end

	return nil
end

function var_0_0.getBuffs(arg_19_0)
	return arg_19_0._buffs
end

function var_0_0.clear(arg_20_0)
	arg_20_0._hp = nil
	arg_20_0._configId = nil

	if arg_20_0._skills ~= nil then
		tabletool.clear(arg_20_0._skills)

		arg_20_0._skills = nil
	end

	if arg_20_0._buffs ~= nil then
		tabletool.clear(arg_20_0._buffs)

		arg_20_0._buffs = nil
	end

	arg_20_0._damageComp = nil
	arg_20_0._treatmentComp = nil
	arg_20_0._camp = -1
	arg_20_0._icon = nil
	arg_20_0._name = nil
	arg_20_0._config = nil
end

return var_0_0
