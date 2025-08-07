module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameHeroMO", package.seeall)

local var_0_0 = class("AssassinStealthGameHeroMO")

function var_0_0.updateData(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.careerId = arg_1_1.careerId
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.isDead = arg_1_1.isDead
	arg_1_0.actionPoint = arg_1_1.actionPoint

	arg_1_0:setItemByList(arg_1_1.items)
	arg_1_0:setBuffByList(arg_1_1.buffs)

	arg_1_0.gridId = arg_1_1.gridId
	arg_1_0.pos = arg_1_1.pos
	arg_1_0.maxActionPoint = arg_1_1.maxActionPoint
	arg_1_0.isStealth = arg_1_1.state

	arg_1_0:setSkillUseCount(arg_1_1.roundSkillCounts, arg_1_1.totalSkillCounts)
	arg_1_0:setItemUseCount(arg_1_1.roundItemCounts)
end

function var_0_0.setItemByList(arg_2_0, arg_2_1)
	arg_2_0._carryItemDict = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = AssassinItemMO.New(iter_2_1)
		local var_2_1 = var_2_0:getId()

		arg_2_0._carryItemDict[var_2_1] = var_2_0
	end
end

function var_0_0.AddItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getItemMo(arg_3_1)

	if var_3_0 then
		var_3_0:addCount(arg_3_2)
	else
		local var_3_1 = AssassinItemMO.New({
			itemId = arg_3_1,
			count = arg_3_2
		})

		arg_3_0._carryItemDict[arg_3_1] = var_3_1
	end
end

function var_0_0.setBuffByList(arg_4_0, arg_4_1)
	arg_4_0._buffDict = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0._buffDict[iter_4_1.id] = iter_4_1.duration
	end
end

function var_0_0.setSkillUseCount(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._skillRoundUseCountDict = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0._skillRoundUseCountDict[iter_5_1.key] = iter_5_1.value
	end

	arg_5_0._skillTotalUseCountDict = {}

	for iter_5_2, iter_5_3 in ipairs(arg_5_2) do
		arg_5_0._skillTotalUseCountDict[iter_5_3.key] = iter_5_3.value
	end
end

function var_0_0.setItemUseCount(arg_6_0, arg_6_1)
	arg_6_0._itemRoundUseCountDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0._itemRoundUseCountDict[iter_6_1.key] = iter_6_1.value
	end
end

function var_0_0.getUid(arg_7_0)
	return arg_7_0.uid
end

function var_0_0.getHeroId(arg_8_0)
	return arg_8_0.heroId
end

function var_0_0.getCareerId(arg_9_0)
	return arg_9_0.careerId
end

function var_0_0.getActionPoint(arg_10_0)
	return arg_10_0.actionPoint
end

function var_0_0.getMaxActionPoint(arg_11_0)
	return arg_11_0.maxActionPoint
end

function var_0_0.getStatus(arg_12_0)
	local var_12_0 = AssassinEnum.HeroStatus.Stealth

	if arg_12_0.isDead ~= 0 then
		var_12_0 = AssassinEnum.HeroStatus.Dead
	elseif arg_12_0.isStealth ~= 0 then
		var_12_0 = AssassinEnum.HeroStatus.Expose
	else
		local var_12_1 = AssassinStealthGameModel.instance:getMapId()
		local var_12_2, var_12_3 = arg_12_0:getPos()
		local var_12_4 = AssassinConfig.instance:getGridPointType(var_12_1, var_12_2, var_12_3)

		if var_12_4 == AssassinEnum.StealthGamePointType.HayStack or var_12_4 == AssassinEnum.StealthGamePointType.Garden then
			var_12_0 = AssassinEnum.HeroStatus.Hide
		end
	end

	return var_12_0
end

function var_0_0.getHp(arg_13_0)
	return arg_13_0.hp or 0
end

function var_0_0.getPos(arg_14_0)
	return arg_14_0.gridId, arg_14_0.pos
end

function var_0_0.getActiveSkillId(arg_15_0)
	local var_15_0 = arg_15_0:getHeroId()
	local var_15_1 = arg_15_0:getCareerId()
	local var_15_2 = AssassinConfig.instance:getAssassinActiveSkillIdByHeroCareer(var_15_0, var_15_1)

	if var_15_2 and AssassinConfig.instance:getIsStealthGameSkill(var_15_2) then
		return var_15_2
	end
end

function var_0_0.getItemMo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._carryItemDict[arg_16_1]

	if not var_16_0 and arg_16_2 then
		logError(string.format("AssassinStealthGameHeroMO:getItemMo error, itemMo is nil, heroUid:%s, itemId:%s", arg_16_0.uid, arg_16_1))
	end

	return var_16_0
end

function var_0_0.getItemIdList(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0._carryItemDict) do
		if iter_17_1:getCount() > 0 then
			var_17_0[#var_17_0 + 1] = iter_17_0
		end
	end

	return var_17_0
end

function var_0_0.getItemCount(arg_18_0, arg_18_1)
	local var_18_0 = 0
	local var_18_1 = arg_18_0:getItemMo(arg_18_1)

	if var_18_1 then
		var_18_0 = var_18_1:getCount()
	end

	return var_18_0
end

function var_0_0.hasSkillProp(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = false

	if arg_19_2 then
		local var_19_1 = arg_19_0:getActiveSkillId()

		var_19_0 = var_19_1 and var_19_1 == arg_19_1
	else
		var_19_0 = arg_19_0:getItemCount(arg_19_1) > 0
	end

	if not var_19_0 and arg_19_3 then
		string.format("hero not has skill prop, heroUid:%s, skillPropId:%s, isSkill:%s", arg_19_0.uid, arg_19_1, arg_19_2)
	end

	return true
end

function var_0_0.getSkillPropRoundUseCount(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = 0

	if arg_20_2 then
		var_20_0 = arg_20_0._skillRoundUseCountDict[arg_20_1] or 0
	else
		var_20_0 = arg_20_0._itemRoundUseCountDict[arg_20_1] or 0
	end

	return var_20_0
end

function var_0_0.getSkillPropTotalUseCount(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 0

	if arg_21_2 then
		var_21_0 = arg_21_0._skillTotalUseCountDict[arg_21_1] or 0
	end

	return var_21_0
end

return var_0_0
