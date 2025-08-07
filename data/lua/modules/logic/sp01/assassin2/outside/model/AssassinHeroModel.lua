module("modules.logic.sp01.assassin2.outside.model.AssassinHeroModel", package.seeall)

local var_0_0 = class("AssassinHeroModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearAll()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearAll(arg_3_0)
	arg_3_0:clear()
	arg_3_0:clearData()
end

function var_0_0.clearData(arg_4_0)
	return
end

function var_0_0.updateAllInfo(arg_5_0, arg_5_1)
	arg_5_0:clearAll()

	local var_5_0 = AssassinConfig.instance:getAssassinHeroIdList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = AssassinHeroMO.New(iter_5_1)

		arg_5_0:addAtLast(var_5_1)
	end

	arg_5_0:updateAssassinHeroInfoByList(arg_5_1.heros)
end

function var_0_0.updateAssassinHeroInfoByList(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0:updateAssassinHeroInfo(iter_6_1)
	end
end

function var_0_0.updateAssassinHeroInfo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getAssassinHeroMo(arg_7_1.heroId, true)

	if var_7_0 then
		var_7_0:updateServerInfo(arg_7_1)
	end
end

local function var_0_1(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.instance:getAssassinHeroMo(arg_8_0, true)
	local var_8_1 = var_0_0.instance:getAssassinHeroMo(arg_8_1, true)
	local var_8_2 = var_8_0 and var_8_0:isUnlocked()

	if var_8_2 ~= (var_8_1 and var_8_1:isUnlocked()) then
		return var_8_2
	end

	return arg_8_1 < arg_8_0
end

function var_0_0.getAssassinHeroIdList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = arg_9_0:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		var_9_0[#var_9_0 + 1] = iter_9_1:getAssassinHeroId()
	end

	table.sort(var_9_0, var_0_1)

	return var_9_0
end

function var_0_0.getAssassinHeroMo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getById(arg_10_1)

	if not var_10_0 and arg_10_2 then
		logError(string.format("AssassinHeroModel:getAssassinHeroMo error, not find assassinHeroMo, assassinHeroId:%s", arg_10_1))
	end

	return var_10_0
end

function var_0_0.getHeroMo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getAssassinHeroMo(arg_11_1, true)

	return var_11_0 and var_11_0:getHeroMo()
end

function var_0_0.isUnlockAssassinHero(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getAssassinHeroMo(arg_12_1, true)

	return var_12_0 and var_12_0:isUnlocked()
end

function var_0_0.getHeroId(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getAssassinHeroMo(arg_13_1, true)

	return var_13_0 and var_13_0:getHeroId()
end

function var_0_0.getAssassinHeroName(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getAssassinHeroMo(arg_14_1, true)
	local var_14_1 = ""
	local var_14_2 = ""

	if var_14_0 then
		var_14_1, var_14_2 = var_14_0:getAssassinHeroName()
	end

	return var_14_1, var_14_2
end

function var_0_0.getAssassinHeroSkin(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getAssassinHeroMo(arg_15_1, true)

	return var_15_0 and var_15_0:getAssassinHeroSkin()
end

function var_0_0.getAssassinHeroShowLevel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getAssassinHeroMo(arg_16_1, true)
	local var_16_1
	local var_16_2

	if var_16_0 then
		var_16_1, var_16_2 = var_16_0:getAssassinHeroShowLevel()
	end

	return var_16_1, var_16_2
end

function var_0_0.getAssassinHeroSkillLevel(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getAssassinHeroMo(arg_17_1, true)

	return var_17_0 and var_17_0:getAssassinHeroSkillLevel() or 0
end

function var_0_0.getAssassinHeroEquipMo(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getAssassinHeroMo(arg_18_1, true)

	return var_18_0 and var_18_0:getAssassinHeroEquipMo()
end

function var_0_0.getAssassinHeroAttributeList(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getAssassinHeroMo(arg_19_1, true)

	return var_19_0 and var_19_0:getAssassinHeroAttributeList()
end

function var_0_0.getAssassinHeroCommonCareer(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getAssassinHeroMo(arg_20_1, true)

	return var_20_0 and var_20_0:getAssassinHeroCommonCareer()
end

function var_0_0.getAssassinCareerId(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getAssassinHeroMo(arg_21_1, true)

	return var_21_0 and var_21_0:getAssassinCareerId()
end

function var_0_0.getCarryItemId(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getAssassinHeroMo(arg_22_1, true)

	return var_22_0 and var_22_0:getCarryItemId(arg_22_2)
end

function var_0_0.getItemCarryIndex(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getAssassinHeroMo(arg_23_1, true)

	return var_23_0 and var_23_0:getItemCarryIndex(arg_23_2)
end

function var_0_0.isCarryItemFull(arg_24_0, arg_24_1)
	local var_24_0 = true
	local var_24_1 = arg_24_0:getAssassinHeroMo(arg_24_1, true)

	if var_24_1 then
		var_24_0 = var_24_1:isCarryItemFull()
	end

	return var_24_0
end

function var_0_0.findEmptyItemGridIndex(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getAssassinHeroMo(arg_25_1, true)

	return var_25_0 and var_25_0:findEmptyItemGridIndex()
end

function var_0_0.isUnlockCareer(arg_26_0, arg_26_1)
	local var_26_0 = AssassinConfig.instance:getAssassinCareerUnlockNeedHeroList(arg_26_1)

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if arg_26_0:isUnlockAssassinHero(iter_26_1) then
			return true
		end
	end
end

function var_0_0.isRequiredAssassin(arg_27_0, arg_27_1)
	return arg_27_1 == AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.RequireAssassinHeroId, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
