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
	arg_1_0.shop = arg_1_0.shop or SurvivalShopMo.New()

	arg_1_0.shop:init(arg_1_1.shop)

	arg_1_0.survivalReputationPropMo = arg_1_0.survivalReputationPropMo or SurvivalReputationPropMo.New()

	arg_1_0:setReputationData(arg_1_1.reputationProp)

	if arg_1_2 then
		arg_1_0._lockLevel = nil
	end
end

function var_0_0.setReputationData(arg_2_0, arg_2_1)
	arg_2_0.survivalReputationPropMo:setData(arg_2_1)
	arg_2_0:refreshReputationRedDot()
end

function var_0_0.updateHeros(arg_3_0, arg_3_1)
	arg_3_0.heros = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.heros[iter_3_1.heroId] = iter_3_1.pos
	end
end

function var_0_0.batchHeros(arg_4_0, arg_4_1)
	arg_4_0.heros = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1 ~= 0 then
			arg_4_0.heros[iter_4_1] = iter_4_0 - 1
		end
	end
end

function var_0_0.isDestoryed(arg_5_0)
	return arg_5_0.status == SurvivalEnum.BuildingStatus.Destroy
end

function var_0_0.sort(arg_6_0, arg_6_1)
	return arg_6_0.buildingId < arg_6_1.buildingId
end

function var_0_0.isEqualType(arg_7_0, arg_7_1)
	return arg_7_0.baseCo.type == arg_7_1
end

function var_0_0.getBuildingType(arg_8_0)
	return arg_8_0.baseCo.type
end

function var_0_0.isBuild(arg_9_0)
	return arg_9_0.level > 0
end

function var_0_0.getNpcByPosition(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.npcs) do
		if iter_10_1 == arg_10_1 then
			return iter_10_0
		end
	end
end

function var_0_0.isNpcInBuilding(arg_11_0, arg_11_1)
	return arg_11_0:getNpcPos(arg_11_1) ~= nil
end

function var_0_0.getNpcPos(arg_12_0, arg_12_1)
	return arg_12_0.npcs[arg_12_1]
end

function var_0_0.removeNpc(arg_13_0, arg_13_1)
	arg_13_0.npcs[arg_13_1] = nil
end

function var_0_0.addNpc(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 < 0 then
		return
	end

	arg_14_0.npcs[arg_14_1] = arg_14_2
end

function var_0_0.isHeroInBuilding(arg_15_0, arg_15_1)
	return arg_15_0:getHeroPos(arg_15_1) ~= nil
end

function var_0_0.getHeroPos(arg_16_0, arg_16_1)
	return arg_16_0.heros[arg_16_1]
end

function var_0_0.removeHero(arg_17_0, arg_17_1)
	arg_17_0.heros[arg_17_1] = nil
end

function var_0_0.addHero(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.heros[arg_18_1] = arg_18_2
end

function var_0_0.getAttr(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.attrs[arg_19_1] or 0

	if SurvivalEnum.AttrTypePer[arg_19_1] then
		arg_19_2 = arg_19_2 or 0
		var_19_0 = math.floor(arg_19_2 * math.max(0, 1 + var_19_0 / 1000))
	end

	return var_19_0
end

function var_0_0.refreshLocalStatus(arg_20_0)
	arg_20_0._localStatus = arg_20_0:getRealLocalStatus()
end

function var_0_0.getLocalStatus(arg_21_0)
	if arg_21_0._localStatus == nil then
		arg_21_0:refreshLocalStatus()

		return arg_21_0._localStatus
	end

	local var_21_0 = arg_21_0:getRealLocalStatus()

	if arg_21_0._localStatus == var_21_0 then
		return arg_21_0._localStatus
	end

	if arg_21_0._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.UnBuild and var_21_0 == SurvivalEnum.ShelterBuildingLocalStatus.Normal then
		return SurvivalEnum.ShelterBuildingLocalStatus.UnBuildToNormal
	end

	if arg_21_0._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.Destroy and var_21_0 == SurvivalEnum.ShelterBuildingLocalStatus.Normal then
		return SurvivalEnum.ShelterBuildingLocalStatus.DestroyToNormal
	end

	if arg_21_0._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.Normal and var_21_0 == SurvivalEnum.ShelterBuildingLocalStatus.Destroy then
		return SurvivalEnum.ShelterBuildingLocalStatus.NormalToDestroy
	end

	return SurvivalEnum.ShelterBuildingLocalStatus.Normal
end

function var_0_0.getRealLocalStatus(arg_22_0)
	if arg_22_0:isDestoryed() then
		return SurvivalEnum.ShelterBuildingLocalStatus.Destroy
	end

	if arg_22_0:isBuild() then
		return SurvivalEnum.ShelterBuildingLocalStatus.Normal
	end

	return SurvivalEnum.ShelterBuildingLocalStatus.UnBuild
end

function var_0_0.lockLevel(arg_23_0)
	arg_23_0._lockLevel = arg_23_0.level
end

function var_0_0.getLevel(arg_24_0)
	return arg_24_0._lockLevel or arg_24_0.level
end

function var_0_0.getShop(arg_25_0)
	if arg_25_0:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		return arg_25_0.survivalReputationPropMo.survivalShopMo
	else
		return arg_25_0.shop
	end
end

function var_0_0.refreshReputationRedDot(arg_26_0)
	if arg_26_0:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		local var_26_0 = arg_26_0:getReputationShopRedDot()
		local var_26_1 = SurvivalConfig.instance:getReputationRedDotType(arg_26_0.buildingId)
		local var_26_2 = {}

		table.insert(var_26_2, {
			id = var_26_1,
			value = var_26_0
		})
		RedDotRpc.instance:clientAddRedDotGroupList(var_26_2, true)
	end
end

function var_0_0.getReputationShopRedDot(arg_27_0)
	return arg_27_0.survivalReputationPropMo:haveFreeReward() and 1 or 0
end

return var_0_0
