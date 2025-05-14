module("modules.logic.equip.model.EquipChooseListModel", package.seeall)

local var_0_0 = class("EquipChooseListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._chooseEquipDic = {}
	arg_1_0._chooseEquipList = {}
	arg_1_0._maxCount = EquipEnum.StrengthenMaxCount
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initEquipMo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._targetMO = arg_3_1
	arg_3_0._config = arg_3_0._targetMO.config

	if arg_3_2 then
		arg_3_0:resetSortStatus()
	end
end

function var_0_0.updateStrengthenList(arg_4_0)
	arg_4_0:initEquipList()
	arg_4_0:_onChooseChange()
end

function var_0_0.updateStrengthenListAndRefresh(arg_5_0)
	arg_5_0:updateStrengthenList()
	arg_5_0:setEquipList()
end

function var_0_0.initEquipList(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.filterMo = arg_6_1
	arg_6_0._equipList = {}

	arg_6_0:getEquipList(arg_6_0._equipList, arg_6_2)
	arg_6_0:filterEquip()
	arg_6_0:filterStrengthen(arg_6_0._equipList)
end

function var_0_0.filterEquip(arg_7_0)
	if not arg_7_0.filterMo then
		return
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._equipList) do
		if iter_7_1.config and arg_7_0.filterMo:checkIsIncludeTag(iter_7_1.config) then
			table.insert(var_7_0, iter_7_1)
		end
	end

	arg_7_0._equipList = var_7_0
end

function var_0_0.getEquipList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = EquipModel.instance:getEquips()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not iter_8_1._chooseNum then
			iter_8_1._chooseNum = 0
		end

		if not arg_8_2 then
			iter_8_1._chooseNum = 0
		end

		local var_8_1 = iter_8_1.config

		if var_8_1 and iter_8_1.id ~= arg_8_0._targetMO.id and not EquipHelper.isSpRefineEquip(var_8_1) and iter_8_1.equipId ~= EquipConfig.instance:getEquipUniversalId() then
			if arg_8_3 then
				if arg_8_3 > var_8_1.rare then
					table.insert(arg_8_1, iter_8_1)
				end
			else
				table.insert(arg_8_1, iter_8_1)
			end
		end
	end
end

function var_0_0.setEquipList(arg_9_0)
	arg_9_0:setList(arg_9_0._equipList)
end

function var_0_0.resetSelectedEquip(arg_10_0)
	arg_10_0._chooseEquipDic = {}
	arg_10_0._chooseEquipList = {}

	arg_10_0:_onChooseChange()
end

function var_0_0.getChooseNum(arg_11_0)
	local var_11_0 = 0

	if not arg_11_0._chooseEquipList then
		return var_11_0
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._chooseEquipList) do
		var_11_0 = var_11_0 + iter_11_1._chooseNum
	end

	return var_11_0
end

function var_0_0.getChooseEquipsNum(arg_12_0)
	return arg_12_0._chooseEquipList and #arg_12_0._chooseEquipList or 0
end

function var_0_0._selectEquip(arg_13_0, arg_13_1)
	if arg_13_1._chooseNum >= arg_13_1.count then
		return EquipEnum.ChooseEquipStatus.BeyondEquipHadNum
	end

	if arg_13_1._chooseNum <= 0 and arg_13_0:getChooseEquipsNum() >= arg_13_0._maxCount then
		return EquipEnum.ChooseEquipStatus.BeyondMaxSelectEquip
	end

	local var_13_0 = arg_13_0:calcStrengthen() or 0

	if EquipConfig.instance:getStrengthenToLv(arg_13_0._config.rare, arg_13_0._targetMO.level, arg_13_0._targetMO.exp + var_13_0) >= EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_13_0._targetMO) then
		return EquipEnum.ChooseEquipStatus.BeyondMaxStrengthenExperience
	end

	if arg_13_1._chooseNum == 0 then
		table.insert(arg_13_0._chooseEquipList, arg_13_1)
	end

	arg_13_1._chooseNum = arg_13_1._chooseNum + 1
	arg_13_0._chooseEquipDic[arg_13_1.id] = true

	return EquipEnum.ChooseEquipStatus.Success
end

function var_0_0.selectEquip(arg_14_0, arg_14_1)
	if arg_14_0.isLock then
		return EquipEnum.ChooseEquipStatus.Lock
	end

	local var_14_0 = arg_14_0:_selectEquip(arg_14_1)

	if var_14_0 == EquipEnum.ChooseEquipStatus.Success then
		arg_14_0:_onChooseChange()
	end

	return var_14_0
end

function var_0_0.deselectEquip(arg_15_0, arg_15_1)
	if arg_15_0.isLock then
		return EquipEnum.ChooseEquipStatus.Lock
	end

	if not arg_15_1._chooseNum or arg_15_1._chooseNum <= 0 then
		return EquipEnum.ChooseEquipStatus.ReduceNotSelectedEquip
	end

	arg_15_1._chooseNum = arg_15_1._chooseNum - 1

	if arg_15_1._chooseNum == 0 then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._chooseEquipList) do
			if iter_15_1.id == arg_15_1.id then
				arg_15_1._isBreak = false
				arg_15_1._canBreak = nil

				table.remove(arg_15_0._chooseEquipList, iter_15_0)

				break
			end
		end
	end

	arg_15_0._chooseEquipDic[arg_15_1.id] = arg_15_1._chooseNum > 0

	arg_15_0:_onChooseChange()

	return EquipEnum.ChooseEquipStatus.Success
end

function var_0_0.calcStrengthen(arg_16_0)
	local var_16_0 = 0

	if not arg_16_0._targetMO then
		return var_16_0
	end

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._chooseEquipList) do
		for iter_16_2 = 1, iter_16_1._chooseNum do
			var_16_0 = var_16_0 + EquipConfig.instance:getIncrementalExp(iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0._onChooseChange(arg_17_0)
	EquipSelectedListModel.instance:updateList(arg_17_0._chooseEquipList)
	EquipController.instance:dispatchEvent(EquipEvent.onChooseChange)
end

function var_0_0.getChooseEquipList(arg_18_0)
	return arg_18_0._chooseEquipList
end

function var_0_0.isChoose(arg_19_0, arg_19_1)
	return arg_19_0._chooseEquipDic[arg_19_1.id]
end

function var_0_0.canBreak(arg_20_0, arg_20_1)
	return EquipConfig.instance:canBreak(arg_20_0._targetMO, arg_20_1)
end

function var_0_0._sortNormalEquip(arg_21_0, arg_21_1)
	if arg_21_0.config.rare ~= arg_21_1.config.rare then
		return arg_21_0.config.rare < arg_21_1.config.rare
	else
		return arg_21_0.id < arg_21_1.id
	end
end

function var_0_0.canFastAdd(arg_22_0, arg_22_1)
	if arg_22_1.isLock then
		return false
	end

	if arg_22_0.equipUidToHeroMo and arg_22_0.equipUidToHeroMo[arg_22_1.uid] then
		return false
	end

	if arg_22_1.level > 1 or arg_22_1.refineLv > 1 then
		return false
	end

	return true
end

function var_0_0.onlyAddExpEquip(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._chooseEquipDic = {}
	arg_23_0._chooseEquipList = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if iter_23_0 > EquipEnum.StrengthenMaxCount then
			break
		end

		local var_23_0 = EquipConfig.instance:getOneLevelEquipProduceExp(iter_23_1.equipId)
		local var_23_1 = iter_23_1.count * var_23_0

		if arg_23_2 <= var_23_1 then
			local var_23_2 = Mathf.Ceil(arg_23_2 / var_23_0)

			arg_23_0:addEquipMo(iter_23_1, var_23_2)

			break
		end

		arg_23_2 = arg_23_2 - var_23_1

		arg_23_0:addEquipMo(iter_23_1, iter_23_1.count)
	end
end

function var_0_0.onlyAddNormalEquip(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = 0

	arg_24_0._chooseEquipDic = {}
	arg_24_0._chooseEquipList = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		if iter_24_0 > EquipEnum.StrengthenMaxCount then
			break
		end

		var_24_0 = var_24_0 + EquipConfig.instance:getOneLevelEquipProduceExp(iter_24_1.config.rare)

		arg_24_0:addEquipMo(iter_24_1, 1)

		if arg_24_2 <= var_24_0 then
			break
		end
	end
end

function var_0_0.mixtureExpAndNormalEquip(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._chooseEquipDic = {}
	arg_25_0._chooseEquipList = {}

	local var_25_0 = arg_25_1[1]
	local var_25_1 = EquipConfig.instance:getOneLevelEquipProduceExp(var_25_0.equipId)

	if arg_25_3 <= var_25_1 then
		arg_25_0:addEquipMo(var_25_0, 1)

		return
	end

	arg_25_3 = arg_25_3 - var_25_1

	local var_25_2 = 0
	local var_25_3 = EquipEnum.StrengthenMaxCount - 1

	for iter_25_0, iter_25_1 in ipairs(arg_25_2) do
		local var_25_4 = EquipConfig.instance:getOneLevelEquipProduceExp(iter_25_1.config.rare)

		arg_25_0:addEquipMo(iter_25_1, 1)

		var_25_2 = var_25_2 + 1
		arg_25_3 = arg_25_3 - var_25_4

		if var_25_3 <= var_25_2 or arg_25_3 <= 0 then
			break
		end
	end

	local var_25_5 = 0

	if arg_25_3 > 0 then
		arg_25_3 = arg_25_3 + var_25_1

		for iter_25_2, iter_25_3 in ipairs(arg_25_1) do
			local var_25_6 = EquipConfig.instance:getOneLevelEquipProduceExp(iter_25_3.equipId)

			var_25_2 = var_25_2 + 1
			var_25_5 = var_25_5 + 1

			local var_25_7 = iter_25_3.count * var_25_6

			if arg_25_3 <= var_25_7 then
				arg_25_0:addEquipMo(iter_25_3, Mathf.Ceil(arg_25_3 / var_25_6), var_25_5)

				break
			end

			arg_25_0:addEquipMo(iter_25_3, iter_25_3.count, var_25_5)

			arg_25_3 = arg_25_3 - var_25_7

			if var_25_2 >= EquipEnum.StrengthenMaxCount then
				break
			end
		end
	else
		arg_25_0:addEquipMo(var_25_0, 1, 1)
	end
end

function var_0_0.addEquipMo(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_1._chooseNum = arg_26_2
	arg_26_0._chooseEquipDic[arg_26_1.id] = true

	if not tabletool.indexOf(arg_26_0._chooseEquipList, arg_26_1) then
		if arg_26_3 then
			table.insert(arg_26_0._chooseEquipList, arg_26_3, arg_26_1)
		else
			table.insert(arg_26_0._chooseEquipList, arg_26_1)
		end
	end
end

function var_0_0.fastAddEquip(arg_27_0)
	local var_27_0 = EquipConfig.instance:getNeedExpToMaxLevel(arg_27_0._targetMO)

	if var_27_0 <= 0 then
		GameFacade.showToast(ToastEnum.MaxLevEquips)

		return
	end

	arg_27_0._chooseEquipDic = {}
	arg_27_0._chooseEquipList = {}

	local var_27_1 = {}

	arg_27_0:getEquipList(var_27_1, false, arg_27_0:getFilterRare())

	local var_27_2 = {}
	local var_27_3 = {}
	local var_27_4 = true

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		if EquipHelper.isExpEquip(iter_27_1.config) then
			table.insert(var_27_2, iter_27_1)

			var_27_4 = false
		elseif EquipHelper.isNormalEquip(iter_27_1.config) and arg_27_0:canFastAdd(iter_27_1) then
			table.insert(var_27_3, iter_27_1)

			var_27_4 = false
		end
	end

	if var_27_4 then
		arg_27_0:refreshEquip()
		GameFacade.showToast(ToastEnum.NoFastEquips)

		return
	end

	local var_27_5 = #var_27_2
	local var_27_6 = #var_27_3

	if var_27_5 ~= 0 then
		table.sort(var_27_2, function(arg_28_0, arg_28_1)
			return arg_28_0.config.rare < arg_28_1.config.rare
		end)
	end

	if var_27_6 ~= 0 then
		table.sort(var_27_3, var_0_0._sortNormalEquip)
	end

	if var_27_6 == 0 then
		arg_27_0:onlyAddExpEquip(var_27_2, var_27_0)
	elseif var_27_5 == 0 then
		arg_27_0:onlyAddNormalEquip(var_27_3, var_27_0)
	else
		arg_27_0:mixtureExpAndNormalEquip(var_27_2, var_27_3, var_27_0)
	end

	arg_27_0:refreshEquip()
end

function var_0_0.refreshEquip(arg_29_0)
	EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
	arg_29_0:_onChooseChange()
	arg_29_0:setList(arg_29_0._equipList)

	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._chooseEquipList) do
		table.insert(var_29_0, iter_29_1.uid)
	end

	EquipController.instance:dispatchEvent(EquipEvent.onAddEquipToPlayEffect, var_29_0)
end

function var_0_0._sortNormal(arg_30_0, arg_30_1)
	local var_30_0 = var_0_0.instance
	local var_30_1 = var_30_0:sortChoose(arg_30_0, arg_30_1)

	if var_30_1 == nil then
		var_30_1 = var_30_0:sortSame(arg_30_0, arg_30_1)
	end

	if var_30_1 == nil then
		var_30_1 = var_30_0:sortQuality(arg_30_0, arg_30_1)
	end

	if var_30_1 == nil then
		var_30_1 = var_30_0:sortExp(arg_30_0, arg_30_1)
	end

	if var_30_1 == nil then
		var_30_1 = var_30_0:sortLevel(arg_30_0, arg_30_1)
	end

	if var_30_1 == nil then
		var_30_1 = var_30_0:sortId(arg_30_0, arg_30_1)
	end

	return var_30_1
end

function var_0_0._sortMaxLevel(arg_31_0, arg_31_1)
	local var_31_0 = var_0_0.instance
	local var_31_1 = var_31_0:sortChoose(arg_31_0, arg_31_1)

	if var_31_1 == nil then
		var_31_1 = var_31_0:sortLevel(arg_31_0, arg_31_1)
	end

	if var_31_1 == nil then
		var_31_1 = var_31_0:sortId(arg_31_0, arg_31_1)
	end

	return var_31_1
end

function var_0_0._sortMaxBreak(arg_32_0, arg_32_1)
	local var_32_0 = var_0_0.instance
	local var_32_1 = var_32_0:sortChoose(arg_32_0, arg_32_1)

	if var_32_1 == nil then
		var_32_1 = var_32_0:sortQuality(arg_32_0, arg_32_1)
	end

	if var_32_1 == nil then
		var_32_1 = var_32_0:sortExp(arg_32_0, arg_32_1)
	end

	if var_32_1 == nil then
		var_32_1 = var_32_0:sortLevel(arg_32_0, arg_32_1)
	end

	if var_32_1 == nil then
		var_32_1 = var_32_0:sortId(arg_32_0, arg_32_1)
	end

	return var_32_1
end

function var_0_0.filterStrengthen(arg_33_0, arg_33_1)
	if arg_33_0._btnTag == 1 then
		table.sort(arg_33_1, EquipHelper.sortByLevelFuncChooseListModel)
	else
		table.sort(arg_33_1, EquipHelper.sortByQualityFuncChooseListModel)
	end
end

function var_0_0.sortId(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_1.config.id
	local var_34_1 = arg_34_2.config.id

	if var_34_0 == var_34_1 then
		return false
	end

	return var_34_0 < var_34_1
end

function var_0_0.sortLevel(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1.level
	local var_35_1 = arg_35_2.level

	if var_35_0 == var_35_1 then
		return nil
	end

	if arg_35_0._levelAscend then
		return var_35_0 < var_35_1
	else
		return var_35_1 < var_35_0
	end
end

function var_0_0.sortExp(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1.config.isExpEquip
	local var_36_1 = arg_36_2.config.isExpEquip

	if var_36_0 == var_36_1 then
		return nil
	end

	return var_36_1 < var_36_0
end

function var_0_0.sortQuality(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_1.config.rare
	local var_37_1 = arg_37_2.config.rare

	if var_37_0 == var_37_1 then
		return nil
	end

	if arg_37_0._qualityAscend then
		return var_37_0 < var_37_1
	else
		return var_37_1 < var_37_0
	end
end

function var_0_0.sortSame(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_1.config.id == arg_38_0._config.id
	local var_38_1 = arg_38_2.config.id == arg_38_0._config.id

	if var_38_0 and var_38_1 then
		return nil
	end

	if var_38_0 then
		return true
	end

	if var_38_1 then
		return false
	end
end

function var_0_0.sortChoose(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0._chooseEquipDic[arg_39_1.id]
	local var_39_1 = arg_39_0._chooseEquipDic[arg_39_2.id]

	if var_39_0 and var_39_1 then
		return nil
	end

	if var_39_0 then
		return true
	end

	if var_39_1 then
		return false
	end
end

function var_0_0.getBtnTag(arg_40_0)
	return arg_40_0._btnTag
end

function var_0_0.getRankState(arg_41_0)
	return arg_41_0._levelAscend and 1 or -1, arg_41_0._qualityAscend and 1 or -1
end

function var_0_0.sordByLevel(arg_42_0)
	arg_42_0:resetQualitySortStatus()

	if arg_42_0._btnTag == 1 then
		arg_42_0._levelAscend = not arg_42_0._levelAscend
	else
		arg_42_0._btnTag = 1
	end

	arg_42_0:filterStrengthen(arg_42_0._equipList)
	arg_42_0:setList(arg_42_0._equipList)
end

function var_0_0.sordByQuality(arg_43_0)
	arg_43_0:resetLevelSortStatus()

	if arg_43_0._btnTag == 2 then
		arg_43_0._qualityAscend = not arg_43_0._qualityAscend
	else
		arg_43_0._btnTag = 2
	end

	arg_43_0:filterStrengthen(arg_43_0._equipList)
	arg_43_0:setList(arg_43_0._equipList)
end

function var_0_0.clearEquipList(arg_44_0)
	local var_44_0 = EquipModel.instance:getEquips()

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		iter_44_1._canBreak = nil
		iter_44_1._isBreak = nil
	end

	arg_44_0._equipList = {}
	arg_44_0._chooseEquipDic = {}
	arg_44_0._chooseEquipList = {}
	arg_44_0._targetMO = nil
end

function var_0_0.equipInTeam(arg_45_0, arg_45_1)
	if not arg_45_0._allInTeamEquips then
		arg_45_0._allInTeamEquips = {}

		local var_45_0 = HeroGroupModel.instance:getCurGroupMO()

		if var_45_0 then
			local var_45_1 = var_45_0:getAllPosEquips()

			for iter_45_0, iter_45_1 in pairs(var_45_1) do
				for iter_45_2, iter_45_3 in pairs(iter_45_1.equipUid) do
					local var_45_2 = arg_45_0._allInTeamEquips[iter_45_3]

					if not var_45_2 then
						var_45_2 = {}
						arg_45_0._allInTeamEquips[iter_45_3] = var_45_2
					end

					table.insert(var_45_2, {
						1,
						iter_45_0 + 1
					})
				end
			end
		end
	end

	return arg_45_0._allInTeamEquips[arg_45_1]
end

function var_0_0.clearTeamInfo(arg_46_0)
	arg_46_0._allInTeamEquips = nil
end

function var_0_0.openEquipView(arg_47_0)
	arg_47_0.equipUidToHeroMo = {}
	arg_47_0.equipUidToInGroup = {}

	local var_47_0 = HeroGroupModel.instance:getMainGroupMo()
	local var_47_1 = var_47_0:getAllPosEquips()
	local var_47_2 = var_47_0.heroList

	for iter_47_0, iter_47_1 in pairs(var_47_1) do
		local var_47_3 = HeroModel.instance:getById(var_47_2[iter_47_0 + 1])

		arg_47_0.equipUidToHeroMo[iter_47_1.equipUid[1]] = var_47_3
		arg_47_0.equipUidToInGroup[iter_47_1.equipUid[1]] = true
	end

	arg_47_0:resetSortStatus()
end

function var_0_0.getHeroMoByEquipUid(arg_48_0, arg_48_1)
	return arg_48_0.equipUidToHeroMo and arg_48_0.equipUidToHeroMo[arg_48_1]
end

function var_0_0.isInGroup(arg_49_0, arg_49_1)
	return arg_49_0.equipUidToInGroup and arg_49_0.equipUidToInGroup[arg_49_1]
end

function var_0_0.resetSortStatus(arg_50_0)
	arg_50_0._btnTag = 1

	arg_50_0:resetLevelSortStatus()
	arg_50_0:resetQualitySortStatus()
end

function var_0_0.resetLevelSortStatus(arg_51_0)
	arg_51_0._levelAscend = false
end

function var_0_0.resetQualitySortStatus(arg_52_0)
	arg_52_0._qualityAscend = false
end

function var_0_0.getFilterRare(arg_53_0)
	if not arg_53_0.filterRare then
		arg_53_0.filterRare = EquipConfig.instance:getMinFilterRare()
	end

	logNormal("EquipChooseListModel : get filter rare : " .. tostring(arg_53_0.filterRare))

	return arg_53_0.filterRare
end

function var_0_0.setFilterRare(arg_54_0, arg_54_1)
	logNormal("EquipChooseListModel : set filter rare : " .. tostring(arg_54_1))

	arg_54_0.filterRare = arg_54_1
end

function var_0_0.setIsLock(arg_55_0, arg_55_1)
	arg_55_0.isLock = arg_55_1
end

function var_0_0.clear(arg_56_0)
	arg_56_0.equipUidToHeroMo = {}
	arg_56_0.equipUidToInGroup = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
