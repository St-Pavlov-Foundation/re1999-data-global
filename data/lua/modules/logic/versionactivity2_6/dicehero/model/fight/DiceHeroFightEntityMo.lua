module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightEntityMo", package.seeall)

local var_0_0 = pureTable("DiceHeroFightEntityMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.id = arg_1_1.id
	arg_1_0.status = arg_1_1.status
	arg_1_0.hp = tonumber(arg_1_1.hp) or 0
	arg_1_0.shield = tonumber(arg_1_1.shield) or 0
	arg_1_0.power = tonumber(arg_1_1.power) or 0
	arg_1_0.maxHp = tonumber(arg_1_1.maxHp) or 0
	arg_1_0.maxShield = tonumber(arg_1_1.maxShield) or 0
	arg_1_0.maxPower = tonumber(arg_1_1.maxPower) or 0
	arg_1_0.buffs = {}
	arg_1_0.buffsByUid = {}

	if arg_1_0.hp > 0 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.buffContainer.buffs) do
			local var_1_0 = DiceHeroFightBuffMo.New()

			var_1_0:init(iter_1_1)

			if var_1_0.co.visible == 1 then
				table.insert(arg_1_0.buffs, var_1_0)
			end

			arg_1_0.buffsByUid[iter_1_1.uid] = var_1_0
		end
	end

	arg_1_0.relicIds = arg_1_1.relicIds
	arg_1_0.behaviors = {}
end

function var_0_0.setHp(arg_2_0, arg_2_1)
	arg_2_0.hp = arg_2_1

	if arg_2_0.hp <= 0 then
		arg_2_0.behaviors = {}
		arg_2_0.buffs = {}
		arg_2_0.buffsByUid = {}
	end
end

function var_0_0.setSkills(arg_3_0, arg_3_1)
	arg_3_0.skills = arg_3_1
end

function var_0_0.clearBehavior(arg_4_0)
	arg_4_0.behaviors = {}
end

function var_0_0.addBehavior(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.hp <= 0 then
		return
	end

	if not arg_5_0.behaviors.type then
		arg_5_0:setBehaviorData(arg_5_0.behaviors, arg_5_1, arg_5_2)
	else
		arg_5_0.behaviors.exList = arg_5_0.behaviors.exList or {}

		local var_5_0 = {}

		arg_5_0:setBehaviorData(var_5_0, arg_5_1, arg_5_2)
		table.insert(arg_5_0.behaviors.exList, var_5_0)
	end
end

function var_0_0.setBehaviorData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_1.type = arg_6_2.type
	arg_6_1.value = arg_6_2.value
	arg_6_1.isToSelf = arg_6_2.fromId == arg_6_2.targetIds[1]
	arg_6_1.isToHero = arg_6_3 == arg_6_2.targetIds[1]
	arg_6_1.isToAll = #arg_6_2.targetIds > 1
	arg_6_1.isToFriend = not arg_6_1.isToAll and not arg_6_1.isToSelf and not arg_6_1.isToHero
end

function var_0_0.isMixDice(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.buffsByUid) do
		if iter_7_1.co.effect == DiceHeroEnum.SkillEffectType.DiceMix then
			return true
		end
	end

	return false
end

function var_0_0.isBanSkillCard(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.buffsByUid) do
		if iter_8_1.co.effect == DiceHeroEnum.SkillEffectType.BanSkillCard then
			local var_8_0 = tonumber(iter_8_1.co.param) or 0

			return var_8_0 == arg_8_1 or var_8_0 == 0
		end
	end

	return false
end

function var_0_0.addOrUpdateBuff(arg_9_0, arg_9_1)
	if arg_9_0.hp <= 0 then
		return
	end

	if arg_9_0.buffsByUid[arg_9_1.uid] then
		arg_9_0.buffsByUid[arg_9_1.uid]:init(arg_9_1)
	else
		local var_9_0 = DiceHeroFightBuffMo.New()

		var_9_0:init(arg_9_1)

		arg_9_0.buffsByUid[arg_9_1.uid] = var_9_0

		if var_9_0.co.visible == 1 then
			table.insert(arg_9_0.buffs, var_9_0)
		end
	end
end

function var_0_0.isAddLayer(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.buffsByUid[arg_10_1.uid]

	if not var_10_0 then
		return true
	end

	return var_10_0.layer < arg_10_1.layer
end

function var_0_0.removeBuff(arg_11_0, arg_11_1)
	if arg_11_0.buffsByUid[arg_11_1] then
		tabletool.removeValue(arg_11_0.buffs, arg_11_0.buffsByUid[arg_11_1])

		arg_11_0.buffsByUid[arg_11_1] = nil
	end
end

function var_0_0.canUseHeroSkill(arg_12_0)
	if arg_12_0.power < arg_12_0.maxPower then
		return false
	end

	if arg_12_0:isBanSkillCard(DiceHeroEnum.CardType.Hero) then
		return false
	end

	if not arg_12_0.skills then
		return false
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.skills) do
		if iter_12_1.co.spiritskilltype == DiceHeroEnum.HeroCardType.ActiveSkill then
			return true
		end
	end

	return false
end

function var_0_0.canUsePassiveSkill(arg_13_0)
	if arg_13_0.power <= 0 then
		return
	end

	if arg_13_0:isBanSkillCard(DiceHeroEnum.CardType.Hero) then
		return false
	end

	if not arg_13_0.skills then
		return false
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.skills) do
		if iter_13_1.co.spiritskilltype == DiceHeroEnum.HeroCardType.PassiveSkill then
			return true
		end
	end

	return false
end

function var_0_0.haveBuff2(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.buffsByUid) do
		if iter_14_1.co.id == 2 then
			return true
		end
	end

	return false
end

return var_0_0
