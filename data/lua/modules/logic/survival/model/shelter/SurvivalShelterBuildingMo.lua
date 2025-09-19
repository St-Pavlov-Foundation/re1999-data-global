module("modules.logic.survival.model.shelter.SurvivalShelterBuildingMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterBuildingMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.buildingId = arg_1_1.buildingId
	arg_1_0.level = arg_1_1.level
	arg_1_0.status = arg_1_1.status
	arg_1_0.attrs = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.attrContainer.values) do
		arg_1_0.attrs[iter_1_1.attrId] = iter_1_1.finalVal
	end

	arg_1_0:updateHeros(arg_1_1.heroPos)

	arg_1_0.npcs = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.npcPos) do
		arg_1_0:addNpc(iter_1_3.npcId, iter_1_3.pos)
	end

	arg_1_0.baseCo = SurvivalConfig.instance:getBuildingConfig(arg_1_0.buildingId, 1)
	arg_1_0.isSingleLevel = SurvivalConfig.instance:getBuildingConfig(arg_1_0.buildingId, 2, true) == nil
	arg_1_0.shop = SurvivalShopMo.New()

	arg_1_0.shop:init(arg_1_1.shop)

	if arg_1_2 then
		arg_1_0._lockLevel = nil
	end
end

function var_0_0.updateHeros(arg_2_0, arg_2_1)
	arg_2_0.heros = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.heros[iter_2_1.heroId] = iter_2_1.pos
	end
end

function var_0_0.batchHeros(arg_3_0, arg_3_1)
	arg_3_0.heros = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1 ~= 0 then
			arg_3_0.heros[iter_3_1] = iter_3_0 - 1
		end
	end
end

function var_0_0.isDestoryed(arg_4_0)
	return arg_4_0.status == SurvivalEnum.BuildingStatus.Destroy
end

function var_0_0.sort(arg_5_0, arg_5_1)
	return arg_5_0.buildingId < arg_5_1.buildingId
end

function var_0_0.isEqualType(arg_6_0, arg_6_1)
	return arg_6_0.baseCo.type == arg_6_1
end

function var_0_0.getBuildingType(arg_7_0)
	return arg_7_0.baseCo.type
end

function var_0_0.isBuild(arg_8_0)
	return arg_8_0.level > 0
end

function var_0_0.getNpcByPosition(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.npcs) do
		if iter_9_1 == arg_9_1 then
			return iter_9_0
		end
	end
end

function var_0_0.isNpcInBuilding(arg_10_0, arg_10_1)
	return arg_10_0:getNpcPos(arg_10_1) ~= nil
end

function var_0_0.getNpcPos(arg_11_0, arg_11_1)
	return arg_11_0.npcs[arg_11_1]
end

function var_0_0.removeNpc(arg_12_0, arg_12_1)
	arg_12_0.npcs[arg_12_1] = nil
end

function var_0_0.addNpc(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 < 0 then
		return
	end

	arg_13_0.npcs[arg_13_1] = arg_13_2
end

function var_0_0.isHeroInBuilding(arg_14_0, arg_14_1)
	return arg_14_0:getHeroPos(arg_14_1) ~= nil
end

function var_0_0.getHeroPos(arg_15_0, arg_15_1)
	return arg_15_0.heros[arg_15_1]
end

function var_0_0.removeHero(arg_16_0, arg_16_1)
	arg_16_0.heros[arg_16_1] = nil
end

function var_0_0.addHero(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.heros[arg_17_1] = arg_17_2
end

function var_0_0.getAttr(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.attrs[arg_18_1] or 0

	if SurvivalEnum.AttrTypePer[arg_18_1] then
		arg_18_2 = arg_18_2 or 0
		var_18_0 = math.floor(arg_18_2 * math.max(0, 1 + var_18_0 / 1000))
	end

	return var_18_0
end

function var_0_0.refreshLocalStatus(arg_19_0)
	arg_19_0._localStatus = arg_19_0:getRealLocalStatus()
end

function var_0_0.getLocalStatus(arg_20_0)
	if arg_20_0._localStatus == nil then
		arg_20_0:refreshLocalStatus()

		return arg_20_0._localStatus
	end

	local var_20_0 = arg_20_0:getRealLocalStatus()

	if arg_20_0._localStatus == var_20_0 then
		return arg_20_0._localStatus
	end

	if arg_20_0._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.UnBuild and var_20_0 == SurvivalEnum.ShelterBuildingLocalStatus.Normal then
		return SurvivalEnum.ShelterBuildingLocalStatus.UnBuildToNormal
	end

	if arg_20_0._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.Destroy and var_20_0 == SurvivalEnum.ShelterBuildingLocalStatus.Normal then
		return SurvivalEnum.ShelterBuildingLocalStatus.DestroyToNormal
	end

	if arg_20_0._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.Normal and var_20_0 == SurvivalEnum.ShelterBuildingLocalStatus.Destroy then
		return SurvivalEnum.ShelterBuildingLocalStatus.NormalToDestroy
	end

	return SurvivalEnum.ShelterBuildingLocalStatus.Normal
end

function var_0_0.getRealLocalStatus(arg_21_0)
	if arg_21_0:isDestoryed() then
		return SurvivalEnum.ShelterBuildingLocalStatus.Destroy
	end

	if arg_21_0:isBuild() then
		return SurvivalEnum.ShelterBuildingLocalStatus.Normal
	end

	return SurvivalEnum.ShelterBuildingLocalStatus.UnBuild
end

function var_0_0.lockLevel(arg_22_0)
	arg_22_0._lockLevel = arg_22_0.level
end

function var_0_0.getLevel(arg_23_0)
	return arg_23_0._lockLevel or arg_23_0.level
end

return var_0_0
