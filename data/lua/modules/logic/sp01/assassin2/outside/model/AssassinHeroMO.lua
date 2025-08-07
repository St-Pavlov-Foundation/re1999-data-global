module("modules.logic.sp01.assassin2.outside.model.AssassinHeroMO", package.seeall)

local var_0_0 = class("AssassinHeroMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.careerId = nil
	arg_1_0.carryItemDict = {}
	arg_1_0.hasServerInfo = false

	local var_1_0 = AssassinConfig.instance:getAssassinHeroTrialId(arg_1_0.id)

	arg_1_0.heroMo = HeroMo.New()

	arg_1_0.heroMo:initFromTrial(var_1_0)

	local var_1_1 = 0
	local var_1_2 = HeroModel.instance:getByHeroId(arg_1_0.heroMo.heroId)

	if var_1_2 then
		var_1_1 = var_1_2.exSkillLevel
	end

	local var_1_3 = arg_1_0.heroMo.exSkillLevel

	arg_1_0.heroMo.exSkillLevel = math.max(var_1_1, var_1_3)
end

function var_0_0.updateServerInfo(arg_2_0, arg_2_1)
	if not arg_2_1 or arg_2_1.heroId ~= arg_2_0.id then
		return
	end

	arg_2_0.careerId = arg_2_1.careerId

	arg_2_0:updateCarryItemList(arg_2_1.itemList)

	arg_2_0.hasServerInfo = true
end

function var_0_0.updateCarryItemList(arg_3_0, arg_3_1)
	arg_3_0.carryItemDict = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.carryItemDict[iter_3_1.index] = iter_3_1.itemType
	end
end

function var_0_0.getAssassinHeroId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.getHeroMo(arg_5_0)
	return arg_5_0.heroMo
end

function var_0_0.getHeroId(arg_6_0)
	return arg_6_0.heroMo.heroId
end

function var_0_0.getAssassinHeroName(arg_7_0)
	local var_7_0 = arg_7_0.heroMo:getHeroName() or ""
	local var_7_1 = arg_7_0.heroMo.config.nameEng or ""

	return var_7_0, var_7_1
end

function var_0_0.getAssassinHeroSkin(arg_8_0)
	local var_8_0 = arg_8_0.heroMo.skin
	local var_8_1 = HeroModel.instance:getByHeroId(arg_8_0.heroMo.heroId)

	if var_8_1 then
		var_8_0 = var_8_1.skin
	end

	return var_8_0
end

function var_0_0.getAssassinHeroShowLevel(arg_9_0)
	local var_9_0 = arg_9_0.heroMo.level or 0
	local var_9_1, var_9_2 = HeroConfig.instance:getShowLevel(var_9_0)

	return var_9_1, var_9_2
end

function var_0_0.getAssassinHeroSkillLevel(arg_10_0)
	return arg_10_0.heroMo.exSkillLevel
end

function var_0_0.getAssassinHeroEquipMo(arg_11_0)
	return arg_11_0.heroMo:getTrialEquipMo()
end

function var_0_0.getAssassinHeroCommonCareer(arg_12_0)
	return arg_12_0.heroMo.config.career
end

function var_0_0.getAssassinHeroAttributeList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = arg_13_0.heroMo:getTrialEquipMo()
	local var_13_3 = var_13_2.uid

	if HeroGroupTrialModel.instance:getEquipMo(var_13_3) then
		var_13_1 = arg_13_0.heroMo:getTotalBaseAttrDict({
			var_13_3
		})
	else
		var_13_1 = arg_13_0.heroMo:getTotalBaseAttrDict({
			var_13_3
		}, nil, nil, nil, var_13_2)
	end

	for iter_13_0, iter_13_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		local var_13_4 = {
			id = iter_13_1,
			value = var_13_1[iter_13_1] or 0
		}

		var_13_0[#var_13_0 + 1] = var_13_4
	end

	return var_13_0
end

function var_0_0.getAssassinCareerId(arg_14_0)
	return arg_14_0.careerId
end

function var_0_0.getCarryItemId(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.carryItemDict[arg_15_1]

	return (AssassinItemModel.instance:getItemIdByItemType(var_15_0))
end

function var_0_0.getItemCarryIndex(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.carryItemDict) do
		if arg_16_1 == AssassinItemModel.instance:getItemIdByItemType(iter_16_1) then
			return iter_16_0
		end
	end
end

function var_0_0.isCarryItemFull(arg_17_0)
	local var_17_0 = arg_17_0:getAssassinCareerId()
	local var_17_1 = AssassinConfig.instance:getAssassinCareerCapacity(var_17_0)
	local var_17_2 = 0

	for iter_17_0, iter_17_1 in pairs(arg_17_0.carryItemDict) do
		var_17_2 = var_17_2 + 1
	end

	return var_17_1 <= var_17_2
end

function var_0_0.findEmptyItemGridIndex(arg_18_0)
	local var_18_0
	local var_18_1 = arg_18_0:getAssassinCareerId()
	local var_18_2 = AssassinConfig.instance:getAssassinCareerCapacity(var_18_1)

	for iter_18_0 = 1, var_18_2 do
		if not arg_18_0.carryItemDict[iter_18_0] then
			var_18_0 = iter_18_0

			break
		end
	end

	return var_18_0
end

function var_0_0.isUnlocked(arg_19_0)
	return arg_19_0.hasServerInfo
end

return var_0_0
