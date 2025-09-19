module("modules.logic.survival.model.shelter.SurvivalShelterWeekMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterWeekMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.shelterMapId = arg_1_1.shelterMapId
	arg_1_0.day = arg_1_1.day
	arg_1_0.difficulty = arg_1_1.difficulty
	arg_1_0.inSurvival = arg_1_1.inSurvival
	arg_1_0.bag = arg_1_0.bag or SurvivalBagMo.New()

	arg_1_0.bag:init(arg_1_1.bag)
	arg_1_0:updateBuildingInfos(arg_1_1.buildingBox.building)
	arg_1_0:updateNpcInfos(arg_1_1.npcBox.npcs)
	arg_1_0:updateDecreeInfos(arg_1_1.decreeBox.decrees)

	arg_1_0.copyIds = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.copyIds) do
		arg_1_0.copyIds[iter_1_1] = true
	end

	arg_1_0.heros = {}
	arg_1_0.herosByHeroId = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.heroBox.heros) do
		local var_1_0 = SurvivalShelterHeroMo.New()

		var_1_0:init(iter_1_3)
		table.insert(arg_1_0.heros, var_1_0)

		arg_1_0.herosByHeroId[var_1_0.heroId] = var_1_0
	end

	arg_1_0.equipBox = arg_1_0.equipBox or SurvivalEquipBoxMo.New()

	arg_1_0.equipBox:init(arg_1_1.equipBox)

	arg_1_0.attrs = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.attrContainer.values) do
		arg_1_0.attrs[iter_1_5.attrId] = iter_1_5.finalVal
	end

	arg_1_0.taskPanel = SurvivalTaskPanelMo.New()

	arg_1_0.taskPanel:init(arg_1_1.taskPanel)

	arg_1_0.talentBox = SurvivalTalentBoxMo.New()

	arg_1_0.talentBox:init(arg_1_1.talentBox)

	arg_1_0.intrudeBox = SurvivalIntrudeBoxMo.New()

	arg_1_0.intrudeBox:init(arg_1_1.intrudeBox)

	arg_1_0.panel = nil

	if arg_1_1.panel.type ~= SurvivalEnum.PanelType.None then
		arg_1_0.panel = SurvivalPanelMo.New()

		arg_1_0.panel:init(arg_1_1.panel)
	end

	arg_1_0:updateRecruitInfo(arg_1_1.recruitInfo)

	arg_1_0.clientData = arg_1_0.clientData or SurvivalWeekClientDataMo.New()

	arg_1_0.clientData:init(arg_1_1.clientData, arg_1_0)
end

function var_0_0.updateRecruitInfo(arg_2_0, arg_2_1)
	if not arg_2_0.recruitInfo then
		arg_2_0.recruitInfo = SurvivalShelterRecruitMo.New()
	end

	arg_2_0.recruitInfo:init(arg_2_1)
end

function var_0_0.getMonsterFight(arg_3_0)
	return arg_3_0.intrudeBox and arg_3_0.intrudeBox.fight
end

function var_0_0.isInFight(arg_4_0)
	local var_4_0 = arg_4_0.intrudeBox.fight

	return var_4_0:canAbandon() and var_4_0.endTime == arg_4_0.day and not arg_4_0.inSurvival
end

function var_0_0.updateAttrs(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if arg_5_0.attrs[iter_5_1.attrId] ~= iter_5_1.finalVal then
			arg_5_0.attrs[iter_5_1.attrId] = iter_5_1.finalVal

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnAttrUpdate, iter_5_1.attrId)
		end
	end
end

function var_0_0.getAttr(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.attrs[arg_6_1] or 0

	if SurvivalEnum.AttrTypePer[arg_6_1] then
		arg_6_2 = arg_6_2 or 0
		arg_6_3 = arg_6_3 or 0
		var_6_0 = math.floor(arg_6_2 * math.max(0, 1 + (var_6_0 + arg_6_3) / 1000))
	end

	return var_6_0
end

function var_0_0.getHeroMo(arg_7_0, arg_7_1)
	if not arg_7_0.herosByHeroId[arg_7_1] then
		local var_7_0 = SurvivalShelterHeroMo.New()

		var_7_0:setDefault(arg_7_1)
		table.insert(arg_7_0.heros, var_7_0)

		arg_7_0.herosByHeroId[var_7_0.heroId] = var_7_0
	end

	return arg_7_0.herosByHeroId[arg_7_1]
end

function var_0_0.updateHeroHealth(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = arg_8_0.herosByHeroId[iter_8_1.heroId]

		if not var_8_0 then
			var_8_0 = SurvivalShelterHeroMo.New()

			table.insert(arg_8_0.heros, var_8_0)
		end

		var_8_0:init(iter_8_1)

		arg_8_0.herosByHeroId[var_8_0.heroId] = var_8_0
	end
end

function var_0_0.isAllHeroHealth(arg_9_0)
	local var_9_0 = true

	if arg_9_0.herosByHeroId then
		local var_9_1 = arg_9_0:getAttr(SurvivalEnum.AttrType.HeroHealthMax)

		for iter_9_0, iter_9_1 in pairs(arg_9_0.herosByHeroId) do
			if var_9_1 > iter_9_1.health then
				var_9_0 = false

				break
			end
		end
	end

	return var_9_0
end

function var_0_0.updateBuildingInfos(arg_10_0, arg_10_1)
	if arg_10_0.buildingDict == nil then
		arg_10_0.buildingDict = {}
	end

	local var_10_0 = {}

	if arg_10_1 then
		for iter_10_0 = 1, #arg_10_1 do
			arg_10_0:updateBuildingInfo(arg_10_1[iter_10_0])

			var_10_0[arg_10_1[iter_10_0].id] = true
		end
	end

	for iter_10_1, iter_10_2 in pairs(arg_10_0.buildingDict) do
		if not var_10_0[iter_10_1] then
			arg_10_0.buildingDict[iter_10_1] = nil
		end
	end
end

function var_0_0.updateBuildingInfo(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getBuildingInfo(arg_11_1.id)

	if not var_11_0 then
		var_11_0 = SurvivalShelterBuildingMo.New()
		arg_11_0.buildingDict[arg_11_1.id] = var_11_0
	end

	var_11_0:init(arg_11_1, arg_11_2)
end

function var_0_0.getBuildingInfo(arg_12_0, arg_12_1)
	return arg_12_0.buildingDict[arg_12_1]
end

function var_0_0.lockBuildingLevel(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getBuildingInfo(arg_13_1)

	if var_13_0 then
		var_13_0:lockLevel()
	end
end

function var_0_0.getBuildingInfoByBuildType(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.buildingDict) do
		if iter_14_1:isEqualType(arg_14_1) then
			return iter_14_1
		end
	end
end

function var_0_0.getBuildingInfoByBuildingId(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.buildingDict) do
		if iter_15_1.buildingId == arg_15_1 then
			return iter_15_1
		end
	end
end

function var_0_0.getBuildingList(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.buildingDict) do
		table.insert(var_16_0, iter_16_1)
	end

	return var_16_0
end

function var_0_0.updateNpcInfos(arg_17_0, arg_17_1)
	if arg_17_0.npcDict == nil then
		arg_17_0.npcDict = {}
	end

	local var_17_0 = {}

	if arg_17_1 then
		for iter_17_0 = 1, #arg_17_1 do
			arg_17_0:updateNpcInfo(arg_17_1[iter_17_0])

			var_17_0[arg_17_1[iter_17_0].id] = true
		end
	end

	for iter_17_1, iter_17_2 in pairs(arg_17_0.npcDict) do
		if not var_17_0[iter_17_1] then
			arg_17_0.npcDict[iter_17_1] = nil
		end
	end
end

function var_0_0.updateNpcInfo(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getNpcInfo(arg_18_1.id)

	if not var_18_0 then
		var_18_0 = SurvivalShelterNpcMo.New()
		arg_18_0.npcDict[arg_18_1.id] = var_18_0
	end

	var_18_0:init(arg_18_1)
end

function var_0_0.getNpcInfo(arg_19_0, arg_19_1)
	return arg_19_0.npcDict[arg_19_1]
end

function var_0_0.updateDecreeInfos(arg_20_0, arg_20_1)
	arg_20_0:getDecreeBox():updateDecreeInfos(arg_20_1)
end

function var_0_0.updateDecreeInfo(arg_21_0, arg_21_1)
	arg_21_0:getDecreeBox():updateDecreeInfo(arg_21_1)
end

function var_0_0.getDecreeBox(arg_22_0)
	if not arg_22_0.decreesBox then
		arg_22_0.decreesBox = SurvivalShelterDecreeBoxMo.New()

		arg_22_0.decreesBox:init()
	end

	return arg_22_0.decreesBox
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

	return (arg_37_0.bag:costIsEnough(var_37_2, arg_37_1, SurvivalEnum.AttrType.BuildCost))
end

function var_0_0.canShowNpcInShelter(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getNpcPostion(arg_38_1)

	if not var_38_0 then
		return false
	end

	return not arg_38_0:getBuildingInfo(var_38_0):isDestoryed()
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
	local var_41_0 = 0
	local var_41_1 = arg_41_0:getNormalNpcList()

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		local var_41_2 = SurvivalConfig.instance:getNpcConfig(iter_41_1)

		if var_41_2 and not string.nilorempty(var_41_2.cost) then
			local var_41_3 = string.split(var_41_2.cost, "#")

			var_41_0 = var_41_0 + (string.splitToNumber(var_41_3[2], ":")[2] or 0)
		end
	end

	return (arg_41_0:getAttr(SurvivalEnum.AttrType.NpcFoodCost, var_41_0))
end

function var_0_0.getNormalNpcList(arg_42_0)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in pairs(arg_42_0.buildingDict) do
		if not iter_42_1:isDestoryed() then
			for iter_42_2, iter_42_3 in pairs(iter_42_1.npcs) do
				table.insert(var_42_0, iter_42_2)
			end
		end
	end

	return var_42_0
end

function var_0_0.hasNewDecree(arg_43_0)
	local var_43_0 = arg_43_0:getAttr(SurvivalEnum.AttrType.DecreeNum)
	local var_43_1 = 2

	for iter_43_0 = 1, var_43_1 do
		local var_43_2 = var_43_0 < iter_43_0
		local var_43_3 = arg_43_0:getDecreeBox():getDecreeInfo(iter_43_0)

		if not var_43_2 and (not var_43_3 or var_43_3:isCurPolicyEmpty()) then
			return true
		end
	end

	return false
end

function var_0_0.isNpcWillLeave(arg_44_0)
	if arg_44_0:getNpcCost() > arg_44_0.bag:getItemCountPlus(SurvivalEnum.CurrencyType.Food) then
		return true
	end

	local var_44_0 = false

	if arg_44_0.npcDict then
		for iter_44_0, iter_44_1 in pairs(arg_44_0.npcDict) do
			if not arg_44_0:getNpcPostion(iter_44_0) then
				var_44_0 = true

				break
			end
		end
	end

	return var_44_0
end

return var_0_0
