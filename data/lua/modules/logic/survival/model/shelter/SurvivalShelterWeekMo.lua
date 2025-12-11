module("modules.logic.survival.model.shelter.SurvivalShelterWeekMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterWeekMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.shelterMapId = arg_1_1.shelterMapId
	arg_1_0.day = arg_1_1.day
	arg_1_0.extendScore = arg_1_2
	arg_1_0.difficulty = arg_1_1.difficulty
	arg_1_0.inSurvival = arg_1_1.inSurvival
	arg_1_0.bags = arg_1_0.bags or {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.bag) do
		local var_1_0 = iter_1_1.bagType

		arg_1_0.bags[var_1_0] = arg_1_0.bags[var_1_0] or SurvivalBagMo.New()

		arg_1_0.bags[var_1_0]:init(iter_1_1)
	end

	arg_1_0.reputationBuilds = {}

	arg_1_0:updateBuildingInfos(arg_1_1.buildingBox.building)
	arg_1_0:updateNpcInfos(arg_1_1.npcBox.npcs)

	arg_1_0.mapInfos = GameUtil.rpcInfosToList(arg_1_1.mapInfo, SurvivalMapInfoMo)
	arg_1_0.heros = {}
	arg_1_0.herosByHeroId = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.heroBox.heros) do
		local var_1_1 = SurvivalShelterHeroMo.New()

		var_1_1:init(iter_1_3)
		table.insert(arg_1_0.heros, var_1_1)

		arg_1_0.herosByHeroId[var_1_1.heroId] = var_1_1
	end

	arg_1_0.equipBox = arg_1_0.equipBox or SurvivalEquipBoxMo.New()

	arg_1_0.equipBox:init(arg_1_1.equipBox)

	arg_1_0.attrs = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.attrContainer.values) do
		arg_1_0.attrs[iter_1_5.attrId] = iter_1_5.finalVal
	end

	arg_1_0.taskPanel = SurvivalTaskPanelMo.New()

	arg_1_0.taskPanel:init(arg_1_1.taskPanel)

	arg_1_0.intrudeBox = arg_1_0.intrudeBox or SurvivalIntrudeBoxMo.New()

	arg_1_0.intrudeBox:init(arg_1_1.intrudeBox)

	arg_1_0.panel = nil

	if arg_1_1.panel.type ~= SurvivalEnum.PanelType.None then
		arg_1_0.panel = SurvivalPanelMo.New()

		arg_1_0.panel:init(arg_1_1.panel)
	end

	arg_1_0:updateRecruitInfo(arg_1_1.recruitInfo)

	arg_1_0.preExploreShop = arg_1_0.preExploreShop or SurvivalShopMo.New()

	arg_1_0.preExploreShop:init(arg_1_1.preExploreShop)

	arg_1_0.clientData = arg_1_0.clientData or SurvivalWeekClientDataMo.New()

	arg_1_0.clientData:init(arg_1_1.clientData, arg_1_0)

	arg_1_0.rainType = arg_1_1.rainType
	arg_1_0.talents = arg_1_1.talentBox.talentIds
end

function var_0_0.getBag(arg_2_0, arg_2_1)
	return arg_2_0.bags[arg_2_1]
end

function var_0_0.updateRecruitInfo(arg_3_0, arg_3_1)
	if not arg_3_0.recruitInfo then
		arg_3_0.recruitInfo = SurvivalShelterRecruitMo.New()
	end

	arg_3_0.recruitInfo:init(arg_3_1)
end

function var_0_0.getMonsterFight(arg_4_0)
	return arg_4_0.intrudeBox and arg_4_0.intrudeBox.fight
end

function var_0_0.isInFight(arg_5_0)
	local var_5_0 = arg_5_0.intrudeBox.fight

	return var_5_0:canAbandon() and var_5_0.endTime == arg_5_0.day and not arg_5_0.inSurvival
end

function var_0_0.updateAttrs(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if arg_6_0.attrs[iter_6_1.attrId] ~= iter_6_1.finalVal then
			arg_6_0.attrs[iter_6_1.attrId] = iter_6_1.finalVal

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnAttrUpdate, iter_6_1.attrId)
		end
	end
end

function var_0_0.getAttr(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getAttrRaw(arg_7_1)

	if SurvivalEnum.AttrTypePer[arg_7_1] then
		arg_7_2 = arg_7_2 or 0
		arg_7_3 = arg_7_3 or 0
		var_7_0 = math.floor(arg_7_2 * math.max(0, 1 + (var_7_0 + arg_7_3) / 1000))
	end

	return var_7_0
end

function var_0_0.getAttrRaw(arg_8_0, arg_8_1)
	return arg_8_0.attrs[arg_8_1] or 0
end

function var_0_0.getHeroMo(arg_9_0, arg_9_1)
	if not arg_9_0.herosByHeroId[arg_9_1] then
		local var_9_0 = SurvivalShelterHeroMo.New()

		var_9_0:setDefault(arg_9_1)
		table.insert(arg_9_0.heros, var_9_0)

		arg_9_0.herosByHeroId[var_9_0.heroId] = var_9_0
	end

	return arg_9_0.herosByHeroId[arg_9_1]
end

function var_0_0.updateHeroHealth(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = arg_10_0.herosByHeroId[iter_10_1.heroId]

		if not var_10_0 then
			var_10_0 = SurvivalShelterHeroMo.New()

			table.insert(arg_10_0.heros, var_10_0)
		end

		var_10_0:init(iter_10_1)

		arg_10_0.herosByHeroId[var_10_0.heroId] = var_10_0
	end
end

function var_0_0.isAllHeroHealth(arg_11_0)
	local var_11_0 = true

	if arg_11_0.herosByHeroId then
		local var_11_1 = arg_11_0:getAttr(SurvivalEnum.AttrType.HeroHealthMax)

		for iter_11_0, iter_11_1 in pairs(arg_11_0.herosByHeroId) do
			if var_11_1 > iter_11_1.health then
				var_11_0 = false

				break
			end
		end
	end

	return var_11_0
end

function var_0_0.updateBuildingInfos(arg_12_0, arg_12_1)
	if arg_12_0.buildingDict == nil then
		arg_12_0.buildingDict = {}
	end

	local var_12_0 = {}

	if arg_12_1 then
		for iter_12_0 = 1, #arg_12_1 do
			local var_12_1 = arg_12_0:updateBuildingInfo(arg_12_1[iter_12_0])

			var_12_0[arg_12_1[iter_12_0].id] = true

			local var_12_2, var_12_3 = arg_12_0:haveReputationShop(var_12_1)

			if var_12_1:isEqualType(SurvivalEnum.BuildingType.ReputationShop) and not var_12_2 then
				table.insert(arg_12_0.reputationBuilds, var_12_1)
			end
		end
	end

	for iter_12_1, iter_12_2 in pairs(arg_12_0.buildingDict) do
		if not var_12_0[iter_12_1] then
			arg_12_0.buildingDict[iter_12_1] = nil

			if iter_12_2:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
				local var_12_4, var_12_5 = arg_12_0:haveReputationShop(iter_12_2)

				if var_12_4 then
					table.remove(arg_12_0.reputationBuilds, var_12_5)
				end
			end
		end
	end
end

function var_0_0.updateBuildingInfo(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getBuildingInfo(arg_13_1.id)

	if not var_13_0 then
		var_13_0 = SurvivalShelterBuildingMo.New()
		arg_13_0.buildingDict[arg_13_1.id] = var_13_0
	end

	var_13_0:init(arg_13_1, arg_13_2)

	return var_13_0
end

function var_0_0.haveReputationShop(arg_14_0, arg_14_1)
	local var_14_0 = tabletool.indexOf(arg_14_0.reputationBuilds, arg_14_1)

	return var_14_0 ~= nil, var_14_0
end

function var_0_0.getBuildingInfo(arg_15_0, arg_15_1)
	return arg_15_0.buildingDict[arg_15_1]
end

function var_0_0.lockBuildingLevel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getBuildingInfo(arg_16_1)

	if var_16_0 then
		var_16_0:lockLevel()
	end
end

function var_0_0.getBuildingInfoByBuildType(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.buildingDict) do
		if iter_17_1:isEqualType(arg_17_1) then
			return iter_17_1
		end
	end
end

function var_0_0.getBuildingInfoByBuildingId(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.buildingDict) do
		if iter_18_1.buildingId == arg_18_1 then
			return iter_18_1
		end
	end
end

function var_0_0.getBuildingList(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0.buildingDict) do
		table.insert(var_19_0, iter_19_1)
	end

	return var_19_0
end

function var_0_0.updateNpcInfos(arg_20_0, arg_20_1)
	if arg_20_0.npcDict == nil then
		arg_20_0.npcDict = {}
	end

	local var_20_0 = {}

	if arg_20_1 then
		for iter_20_0 = 1, #arg_20_1 do
			arg_20_0:updateNpcInfo(arg_20_1[iter_20_0])

			var_20_0[arg_20_1[iter_20_0].id] = true
		end
	end

	for iter_20_1, iter_20_2 in pairs(arg_20_0.npcDict) do
		if not var_20_0[iter_20_1] then
			arg_20_0.npcDict[iter_20_1] = nil
		end
	end
end

function var_0_0.updateNpcInfo(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getNpcInfo(arg_21_1.id)

	if not var_21_0 then
		var_21_0 = SurvivalShelterNpcMo.New()
		arg_21_0.npcDict[arg_21_1.id] = var_21_0
	end

	var_21_0:init(arg_21_1)
end

function var_0_0.getNpcInfo(arg_22_0, arg_22_1)
	return arg_22_0.npcDict[arg_22_1]
end

function var_0_0.hasNpc(arg_23_0, arg_23_1)
	return arg_23_0:getNpcInfo(arg_23_1) ~= nil
end

function var_0_0.getNpcPostion(arg_24_0, arg_24_1)
	if not arg_24_0:hasNpc(arg_24_1) then
		return
	end

	for iter_24_0, iter_24_1 in pairs(arg_24_0.buildingDict) do
		if iter_24_1:isNpcInBuilding(arg_24_1) then
			return iter_24_0, iter_24_1:getNpcPos(arg_24_1)
		end
	end
end

function var_0_0.getNpcByBuildingPosition(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:getBuildingInfo(arg_25_1)

	if not var_25_0 then
		return
	end

	return var_25_0:getNpcByPosition(arg_25_2)
end

function var_0_0.changeNpcPostion(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if not arg_26_0:hasNpc(arg_26_1) then
		return
	end

	local var_26_0 = arg_26_0:getNpcPostion(arg_26_1)

	if var_26_0 then
		arg_26_0:getBuildingInfo(var_26_0):removeNpc(arg_26_1)
	end

	arg_26_0:getBuildingInfo(arg_26_2):addNpc(arg_26_1, arg_26_3)
end

function var_0_0.exchangeNpcPosition(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = arg_27_0:getNpcPostion(arg_27_1)
	local var_27_2, var_27_3 = arg_27_0:getNpcPostion(arg_27_2)

	if var_27_0 and var_27_2 then
		arg_27_0:changeNpcPostion(arg_27_1, var_27_2, var_27_3)
		arg_27_0:changeNpcPostion(arg_27_2, var_27_0, var_27_1)
	end
end

function var_0_0.hasHero(arg_28_0, arg_28_1)
	return arg_28_0.herosByHeroId[arg_28_1] ~= nil
end

function var_0_0.getHeroPostion(arg_29_0, arg_29_1)
	if not arg_29_0:hasHero(arg_29_1) then
		return
	end

	for iter_29_0, iter_29_1 in pairs(arg_29_0.buildingDict) do
		if iter_29_1:isHeroInBuilding(arg_29_1) then
			return iter_29_0, iter_29_1:getHeroPos(arg_29_1)
		end
	end
end

function var_0_0.batchHeroPostion(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:getBuildingInfo(arg_30_2)

	if not var_30_0 then
		return
	end

	var_30_0:batchHeros(arg_30_1)
end

function var_0_0.changeHeroPostion(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if not arg_31_0:hasHero(arg_31_1) then
		return
	end

	local var_31_0 = arg_31_0:getHeroPostion(arg_31_1)

	if var_31_0 then
		arg_31_0:getBuildingInfo(var_31_0):removeHero(arg_31_1)
	end

	arg_31_0:getBuildingInfo(arg_31_2):addHero(arg_31_1, arg_31_3)
end

function var_0_0.exchangeHeroPosition(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0, var_32_1 = arg_32_0:getHeroPostion(arg_32_1)
	local var_32_2, var_32_3 = arg_32_0:getHeroPostion(arg_32_2)

	if var_32_0 and var_32_2 then
		arg_32_0:changeHeroPostion(arg_32_1, var_32_2, var_32_3)
		arg_32_0:changeHeroPostion(arg_32_2, var_32_0, var_32_1)
	end
end

function var_0_0.checkBuildingLev(arg_33_0, arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.buildingDict) do
		if iter_33_1.buildingId == arg_33_1 and arg_33_2 <= iter_33_1.level then
			return true
		end
	end

	return false
end

function var_0_0.checkBuildingTypeLev(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.buildingDict) do
		if iter_34_1:isEqualType(arg_34_1) and arg_34_2 <= iter_34_1.level then
			return true
		end
	end

	return false
end

function var_0_0.isBuildingUnlock(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = SurvivalConfig.instance:getBuildingConfig(arg_35_1, arg_35_2, true)

	if not var_35_0 then
		return true
	end

	local var_35_1 = var_35_0.unlockCondition

	if string.nilorempty(var_35_1) then
		return true
	end

	local var_35_2 = GameUtil.splitString2(var_35_1, false)
	local var_35_3 = false
	local var_35_4

	for iter_35_0, iter_35_1 in ipairs(var_35_2) do
		var_35_3, var_35_4 = arg_35_0:_checkBuildUnLockCondition(iter_35_1, arg_35_3)

		if not var_35_3 then
			break
		end
	end

	return var_35_3, var_35_4
end

function var_0_0._checkBuildUnLockCondition(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_1 then
		return true
	end

	local var_36_0 = false
	local var_36_1

	if arg_36_1[1] == "npcNum" then
		local var_36_2 = tonumber(arg_36_1[2]) or 0

		var_36_0 = var_36_2 <= tabletool.len(arg_36_0.npcDict)

		if not var_36_0 and arg_36_2 then
			var_36_1 = formatLuaLang("survivalbuildingmanageview_buildinglock_reason1", var_36_2)
		end
	elseif arg_36_1[1] == "building" then
		local var_36_3 = tonumber(arg_36_1[2]) or 0
		local var_36_4 = tonumber(arg_36_1[3]) or 0

		var_36_0 = arg_36_0:checkBuildingLev(var_36_3, var_36_4)

		if not var_36_0 and arg_36_2 then
			local var_36_5 = SurvivalConfig.instance:getBuildingConfig(var_36_3, 1, true)

			var_36_1 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalbuildingmanageview_buildinglock_reason2"), var_36_5 and var_36_5.name or "", var_36_4)
		end
	end

	return var_36_0, var_36_1
end

function var_0_0.isBuildingCanLevup(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if not arg_37_1 then
		return false
	end

	local var_37_0 = arg_37_1.buildingId
	local var_37_1 = SurvivalConfig.instance:getBuildingConfig(var_37_0, arg_37_2, true)

	if not var_37_1 then
		return false
	end

	if not arg_37_0:isBuildingUnlock(var_37_0, arg_37_2) then
		return false
	end

	if arg_37_3 then
		return true
	end

	local var_37_2 = var_37_1.lvUpCost

	return (arg_37_0:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_37_2, arg_37_1, SurvivalEnum.AttrType.BuildCost))
end

function var_0_0.canShowNpcInShelter(arg_38_0, arg_38_1)
	return true
end

function var_0_0.getBuildingBtnStatus(arg_39_0)
	local var_39_0 = false
	local var_39_1 = false
	local var_39_2 = false

	for iter_39_0, iter_39_1 in pairs(arg_39_0.buildingDict) do
		if iter_39_1:isDestoryed() then
			var_39_0 = true

			break
		end

		if arg_39_0:isBuildingCanLevup(iter_39_1, iter_39_1.level + 1, false) then
			if iter_39_1:isBuild() then
				var_39_2 = true
			else
				var_39_1 = true
			end
		end
	end

	if var_39_0 then
		return SurvivalEnum.ShelterBuildingBtnStatus.Destroy
	end

	if var_39_1 then
		return SurvivalEnum.ShelterBuildingBtnStatus.New
	end

	if var_39_2 then
		return SurvivalEnum.ShelterBuildingBtnStatus.Levelup
	end

	return SurvivalEnum.ShelterBuildingBtnStatus.Normal
end

function var_0_0.getRecruitInfo(arg_40_0)
	return arg_40_0.recruitInfo
end

function var_0_0.getNpcCost(arg_41_0)
	return 0
end

function var_0_0.getBuildShop(arg_42_0, arg_42_1)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.buildingDict) do
		local var_42_0 = iter_42_1:getShop(arg_42_1)

		if var_42_0.id == arg_42_1 then
			return var_42_0
		end
	end
end

function var_0_0.getReputationBuilds(arg_43_0)
	return arg_43_0.reputationBuilds
end

function var_0_0.getBuildingMoByReputationId(arg_44_0, arg_44_1)
	for iter_44_0, iter_44_1 in ipairs(arg_44_0.reputationBuilds) do
		if arg_44_1 == iter_44_1.survivalReputationPropMo.prop.reputationId then
			return iter_44_1
		end
	end
end

function var_0_0.isAllReputationShopMaxLevel(arg_45_0)
	for iter_45_0, iter_45_1 in ipairs(arg_45_0.reputationBuilds) do
		if not iter_45_1.survivalReputationPropMo:isMaxLevel() then
			return false
		end
	end

	return true
end

function var_0_0.getSurvivalMapInfoMo(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in ipairs(arg_46_0.mapInfos) do
		if arg_46_1 == iter_46_1.mapId then
			return iter_46_1
		end
	end
end

return var_0_0
