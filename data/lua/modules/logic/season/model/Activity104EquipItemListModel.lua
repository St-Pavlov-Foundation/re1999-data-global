module("modules.logic.season.model.Activity104EquipItemListModel", package.seeall)

local var_0_0 = class("Activity104EquipItemListModel", ListScrollModel)

var_0_0.MainCharPos = 4
var_0_0.TotalEquipPos = 5
var_0_0.MaxPos = 2
var_0_0.HeroMaxPos = 1
var_0_0.EmptyUid = "0"

function var_0_0.clear(arg_1_0)
	var_0_0.super.clear(arg_1_0)

	arg_1_0.activityId = nil
	arg_1_0.curPos = nil
	arg_1_0.equipUid2Pos = nil
	arg_1_0.equipUid2Group = nil
	arg_1_0.equipUid2Slot = nil
	arg_1_0.curEquipMap = nil
	arg_1_0.curSelectSlot = nil
	arg_1_0._itemMap = nil
	arg_1_0.recordNew = nil
	arg_1_0._itemStartAnimTime = nil
	arg_1_0._deckUidMap = nil
	arg_1_0._itemIdDeckCountMap = nil
	arg_1_0.tagModel = nil
end

function var_0_0.initDatas(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	logNormal("Activity104EquipItemListModel initDatas")
	arg_2_0:clear()

	arg_2_0.activityId = arg_2_1
	arg_2_0.curPos = arg_2_3
	arg_2_0.groupIndex = arg_2_2
	arg_2_0.equipUid2Pos = {}
	arg_2_0.equipUid2Slot = {}

	local var_2_0 = arg_2_0:getEquipMaxCount(arg_2_0.curPos)

	arg_2_0.curEquipMap = {}

	for iter_2_0 = 1, var_2_0 do
		arg_2_0.curEquipMap[iter_2_0] = var_0_0.EmptyUid
	end

	arg_2_0.curSelectSlot = arg_2_4 or 1
	arg_2_0.equipUid2Group = {}

	arg_2_0:initSubModel()
	arg_2_0:initItemMap()
	arg_2_0:initPlayerPrefs()
	arg_2_0:initPosData()
	arg_2_0:initList()
end

function var_0_0.initSubModel(arg_3_0)
	arg_3_0.tagModel = Activity104EquipTagModel.New()

	arg_3_0.tagModel:init(arg_3_0.activityId)
end

function var_0_0.initItemMap(arg_4_0)
	arg_4_0._itemMap = Activity104Model.instance:getAllItemMo(arg_4_0.activityId) or {}
end

function var_0_0.initPlayerPrefs(arg_5_0)
	arg_5_0.recordNew = SeasonEquipLocalRecord.New()

	arg_5_0.recordNew:init(arg_5_0.activityId, Activity104Enum.PlayerPrefsKeyItemUid)
end

function var_0_0.getTrialEquipUID(...)
	local var_6_0 = {
		...
	}

	return table.concat(var_6_0, "#")
end

function var_0_0.isTrialEquip(arg_7_0)
	return tonumber(arg_7_0) == nil
end

function var_0_0.curSelectIsTrialEquip(arg_8_0)
	local var_8_0 = arg_8_0.curEquipMap[arg_8_0.curSelectSlot]

	return var_8_0 and var_0_0.isTrialEquip(var_8_0)
end

function var_0_0.curMapIsTrialEquipMap(arg_9_0)
	if arg_9_0.curPos == var_0_0.MainCharPos then
		local var_9_0 = HeroGroupModel.instance.battleConfig

		return var_9_0 and var_9_0.trialMainAct104EuqipId > 0
	end

	local var_9_1 = arg_9_0:getGroupMO()

	if not var_9_1 then
		return
	end

	local var_9_2 = var_9_1.trialDict
	local var_9_3 = arg_9_0.curPos + 1
	local var_9_4 = var_9_2 and var_9_2[var_9_3]

	if var_9_4 then
		local var_9_5 = arg_9_0:getEquipMaxCount(var_9_3)

		for iter_9_0 = 1, var_9_5 do
			local var_9_6 = HeroConfig.instance:getTrial104Equip(iter_9_0, var_9_4[1], var_9_4[2])

			if var_9_6 and var_9_6 > 0 then
				return true
			end
		end
	end
end

function var_0_0.initPosData(arg_10_0)
	local var_10_0 = arg_10_0:getGroupMO()

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0.activity104Equips

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		local var_10_2 = arg_10_0:getEquipMaxCount(iter_10_0)

		for iter_10_2 = 1, var_10_2 do
			local var_10_3 = iter_10_1.equipUid[iter_10_2]

			if arg_10_0._itemMap[var_10_3] then
				arg_10_0:setCardPosData(var_10_3, iter_10_0, iter_10_2)
			end
		end
	end

	local var_10_4 = var_10_0.trialDict

	if var_10_4 then
		for iter_10_3, iter_10_4 in pairs(var_10_4) do
			local var_10_5 = iter_10_3 - 1
			local var_10_6 = arg_10_0:getEquipMaxCount(var_10_5)

			for iter_10_5 = 1, var_10_6 do
				local var_10_7 = HeroConfig.instance:getTrial104Equip(iter_10_5, iter_10_4[1], iter_10_4[2])

				if var_10_7 and var_10_7 > 0 then
					local var_10_8 = var_0_0.getTrialEquipUID(var_10_7, iter_10_5, iter_10_4[1])

					arg_10_0:setCardPosData(var_10_8, var_10_5, iter_10_5)
				end
			end
		end
	end

	local var_10_9 = HeroGroupModel.instance.battleConfig

	if var_10_9 and var_10_9.trialMainAct104EuqipId > 0 then
		local var_10_10 = 1
		local var_10_11 = var_0_0.getTrialEquipUID(var_10_9.trialMainAct104EuqipId, var_10_10)

		arg_10_0:setCardPosData(var_10_11, var_0_0.MainCharPos, var_10_10)
	end
end

function var_0_0.setCardPosData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:clearCardPosSlot(arg_11_2, arg_11_3)

	arg_11_0.equipUid2Pos[arg_11_1] = arg_11_2
	arg_11_0.equipUid2Slot[arg_11_1] = arg_11_3

	if arg_11_2 == arg_11_0.curPos then
		arg_11_0.curEquipMap[arg_11_3] = arg_11_1
	end
end

function var_0_0.clearCardPosSlot(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	for iter_12_0, iter_12_1 in pairs(arg_12_0.equipUid2Pos) do
		local var_12_1 = arg_12_0.equipUid2Slot[iter_12_0]

		if iter_12_1 == arg_12_1 and var_12_1 == arg_12_2 then
			var_12_0 = iter_12_0

			break
		end
	end

	if var_12_0 then
		arg_12_0.equipUid2Pos[var_12_0] = nil
		arg_12_0.equipUid2Slot[var_12_0] = nil
	end
end

function var_0_0.initList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._itemMap) do
		arg_13_0:setListData(iter_13_1.itemId, iter_13_0, iter_13_1, var_13_0)
	end

	local var_13_1 = arg_13_0:getGroupMO()

	if var_13_1 then
		local var_13_2 = var_13_1.trialDict

		if var_13_2 then
			for iter_13_2, iter_13_3 in pairs(var_13_2) do
				for iter_13_4 = 1, var_0_0.MaxPos do
					local var_13_3 = HeroConfig.instance:getTrial104Equip(iter_13_4, iter_13_3[1], iter_13_3[2])

					if var_13_3 and var_13_3 > 0 then
						local var_13_4 = var_0_0.getTrialEquipUID(var_13_3, iter_13_4, iter_13_3[1])

						arg_13_0:setListData(var_13_3, var_13_4, nil, var_13_0)
					end
				end
			end
		end
	end

	local var_13_5 = HeroGroupModel.instance.battleConfig

	if var_13_5 and var_13_5.trialMainAct104EuqipId > 0 then
		local var_13_6 = 1
		local var_13_7 = var_0_0.getTrialEquipUID(var_13_5.trialMainAct104EuqipId, var_13_6)

		arg_13_0:setListData(var_13_5.trialMainAct104EuqipId, var_13_7, nil, var_13_0)
	end

	table.sort(var_13_0, var_0_0.sortItemMOList)

	arg_13_0._originList = var_13_0

	arg_13_0:refreshMergeList()
end

function var_0_0.setListData(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if not SeasonConfig.instance:getEquipIsOptional(arg_14_1) then
		local var_14_0 = SeasonConfig.instance:getSeasonEquipCo(arg_14_1)

		if var_14_0 and arg_14_0:isCardFitRole(var_14_0) and arg_14_0:isCardCanShowByTag(arg_14_2, var_14_0.tag) then
			arg_14_0.equipUid2Group[arg_14_2] = var_14_0.group

			if not arg_14_3 then
				arg_14_3 = Activity104ItemMo.New()

				arg_14_3:init({
					quantity = 1,
					itemId = arg_14_1,
					uid = arg_14_2
				})
			end

			local var_14_1 = Activity104EquipListMo.New()

			var_14_1:init(arg_14_3)
			table.insert(arg_14_4, var_14_1)
		end
	end
end

function var_0_0.isCardFitRole(arg_15_0, arg_15_1)
	if arg_15_0.curPos == var_0_0.MainCharPos then
		return SeasonEquipMetaUtils.isMainRoleCard(arg_15_1.rare)
	else
		return not SeasonEquipMetaUtils.isMainRoleCard(arg_15_1.rare)
	end
end

function var_0_0.isCardCanShowByTag(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.tagModel then
		return arg_16_0.tagModel:isCardNeedShow(arg_16_2)
	end

	return true
end

function var_0_0.refreshMergeList(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = {}
	local var_17_2 = {}
	local var_17_3 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0.curEquipMap) do
		if iter_17_1 ~= var_0_0.EmptyUid then
			var_17_1[iter_17_1] = true
		end
	end

	for iter_17_2 = 1, #arg_17_0._originList do
		local var_17_4 = arg_17_0._originList[iter_17_2].id
		local var_17_5 = arg_17_0._originList[iter_17_2].itemId

		if var_17_1[var_17_4] or arg_17_0.equipUid2Pos[var_17_4] then
			table.insert(var_17_0, arg_17_0._originList[iter_17_2])
		else
			local var_17_6 = var_17_2[var_17_5]

			if var_17_6 == nil then
				table.insert(var_17_0, arg_17_0._originList[iter_17_2])

				var_17_2[var_17_5] = 1
				var_17_3[var_17_4] = var_17_5
			else
				var_17_2[var_17_5] = var_17_6 + 1
			end
		end
	end

	arg_17_0._deckUidMap = var_17_3
	arg_17_0._itemIdDeckCountMap = var_17_2

	arg_17_0:setList(var_17_0)
end

function var_0_0.changeSelectSlot(arg_18_0, arg_18_1)
	if arg_18_1 <= arg_18_0:getEquipMaxCount(arg_18_0.curPos) and arg_18_1 > 0 then
		arg_18_0.curSelectSlot = arg_18_1
	end
end

function var_0_0.getEquipMO(arg_19_0, arg_19_1)
	return arg_19_0._itemMap[arg_19_1]
end

function var_0_0.equipShowItem(arg_20_0, arg_20_1)
	arg_20_0.curEquipMap[arg_20_0.curSelectSlot] = arg_20_1
end

function var_0_0.equipItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.curEquipMap[arg_21_2] = arg_21_1
	arg_21_0.equipUid2Pos[arg_21_1] = arg_21_0.curPos
	arg_21_0.equipUid2Slot[arg_21_1] = arg_21_2
end

function var_0_0.unloadShowSlot(arg_22_0, arg_22_1)
	arg_22_0.curEquipMap[arg_22_1] = var_0_0.EmptyUid
end

function var_0_0.unloadItem(arg_23_0, arg_23_1)
	arg_23_0.equipUid2Pos[arg_23_1] = nil
	arg_23_0.equipUid2Slot[arg_23_1] = nil

	local var_23_0 = arg_23_0:getEquipMaxCount(arg_23_0.curPos)

	for iter_23_0 = 1, var_23_0 do
		if arg_23_0.curEquipMap[iter_23_0] == arg_23_1 then
			arg_23_0.curEquipMap[iter_23_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.unloadItemByPos(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.equipUid2Pos) do
		if iter_24_1 == arg_24_1 and arg_24_0.equipUid2Slot[iter_24_0] == arg_24_2 then
			arg_24_0:unloadItem(iter_24_0)

			return
		end
	end
end

function var_0_0.getItemUidByPos(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.equipUid2Pos) do
		if iter_25_1 == arg_25_1 and arg_25_0.equipUid2Slot[iter_25_0] == arg_25_2 then
			return iter_25_0
		end
	end

	return var_0_0.EmptyUid
end

function var_0_0.getItemEquipedPos(arg_26_0, arg_26_1)
	return arg_26_0.equipUid2Pos[arg_26_1], arg_26_0.equipUid2Slot[arg_26_1]
end

function var_0_0.getCurItemEquip(arg_27_0)
	local var_27_0 = arg_27_0:getGroupMO()

	if not var_27_0 then
		return nil
	end

	local var_27_1 = var_27_0.activity104Equips

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		if iter_27_1.index == arg_27_0.curPos then
			return iter_27_1
		end
	end
end

function var_0_0.getEquipMaxCount(arg_28_0, arg_28_1)
	return arg_28_1 == var_0_0.MainCharPos and var_0_0.HeroMaxPos or var_0_0.MaxPos
end

function var_0_0.getPosHeroUid(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getGroupMO(arg_29_2)

	if not var_29_0 then
		return nil
	end

	return var_29_0:getHeroByIndex(arg_29_1 + 1)
end

function var_0_0.slotIsLock(arg_30_0, arg_30_1)
	local var_30_0 = Activity104Model.instance:isSeasonPosUnlock(arg_30_0.activityId, arg_30_0.groupIndex, arg_30_1, arg_30_0.curPos)
	local var_30_1 = arg_30_1 <= arg_30_0:getTrialEquipCountByPos(arg_30_0.curPos)

	return not var_30_0 and not var_30_1
end

function var_0_0.disableBecauseCareerNotFit(arg_31_0, arg_31_1)
	return arg_31_0:isEquipCareerNoFit(arg_31_1, arg_31_0.curPos, arg_31_0:getGroupMO())
end

function var_0_0.disableBecauseSameCard(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.equipUid2Group[arg_32_1]

	if var_32_0 then
		for iter_32_0, iter_32_1 in pairs(arg_32_0.curEquipMap) do
			local var_32_1 = arg_32_0.equipUid2Group[iter_32_1]

			if var_32_1 and iter_32_0 ~= arg_32_0.curSelectSlot and var_32_1 == var_32_0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.disableBecauseRole(arg_33_0, arg_33_1)
	local var_33_0 = SeasonConfig.instance:getSeasonEquipCo(arg_33_1)

	if not var_33_0 then
		return false
	end

	local var_33_1 = SeasonEquipMetaUtils.isMainRoleCard(var_33_0.rare)

	if arg_33_0.curPos == var_0_0.MainCharPos then
		if var_33_1 then
			return false
		end
	elseif not var_33_1 then
		return false
	end

	return true
end

function var_0_0.isEquipCareerNoFit(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_2 == var_0_0.MainCharPos or not arg_34_3 then
		return false
	end

	local var_34_0 = SeasonConfig.instance:getSeasonEquipCo(arg_34_1)

	if not var_34_0 then
		return false
	end

	local var_34_1 = arg_34_3:getHeroByIndex(arg_34_2 + 1)
	local var_34_2

	if not string.nilorempty(var_34_1) then
		var_34_2 = HeroModel.instance:getById(var_34_1)
	end

	if not var_34_2 then
		return false
	end

	local var_34_3 = var_34_2.config.career

	if not string.nilorempty(var_34_0.career) then
		if CharacterEnum.CareerType.Ling == var_34_3 or CharacterEnum.CareerType.Zhi == var_34_3 then
			return var_34_0.career ~= Activity104Enum.CareerType.Ling_Or_Zhi
		else
			return tonumber(var_34_0.career) ~= var_34_3
		end
	end

	return false
end

function var_0_0.isItemUidInShowSlot(arg_35_0, arg_35_1)
	return arg_35_0.curEquipMap[arg_35_0.curSelectSlot] == arg_35_1
end

function var_0_0.isAllSlotEmpty(arg_36_0)
	local var_36_0 = arg_36_0:getEquipMaxCount(arg_36_0.curPos)

	for iter_36_0 = 1, var_36_0 do
		if arg_36_0.curEquipMap[iter_36_0] ~= var_0_0.EmptyUid then
			return false
		end
	end

	return true
end

function var_0_0.sortItemMOList(arg_37_0, arg_37_1)
	local var_37_0 = SeasonConfig.instance:getSeasonEquipCo(arg_37_0.itemId)
	local var_37_1 = SeasonConfig.instance:getSeasonEquipCo(arg_37_1.itemId)

	if var_37_0 ~= nil and var_37_1 ~= nil then
		local var_37_2 = var_0_0.instance:disableBecauseRole(arg_37_0.itemId)
		local var_37_3 = var_0_0.instance:disableBecauseRole(arg_37_1.itemId)

		if var_37_3 ~= var_37_2 then
			return var_37_3
		end

		if var_37_0.rare ~= var_37_1.rare then
			return var_37_0.rare > var_37_1.rare
		else
			return var_37_0.equipId > var_37_1.equipId
		end
	else
		return arg_37_0.itemUid < arg_37_1.itemUid
	end
end

function var_0_0.getGroupMO(arg_38_0, arg_38_1)
	return HeroGroupModel.instance:getCurGroupMO()
end

function var_0_0.flushSlot(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.curEquipMap[arg_39_1]

	arg_39_0:unloadItemByPos(arg_39_0.curPos, arg_39_1)

	if var_39_0 ~= var_0_0.EmptyUid then
		arg_39_0:unloadItem(var_39_0)
		arg_39_0:equipItem(var_39_0, arg_39_1)
	end
end

function var_0_0.resumeSlotData(arg_40_0)
	local var_40_0 = arg_40_0:getEquipMaxCount(arg_40_0.curPos)

	for iter_40_0 = 1, var_40_0 do
		local var_40_1 = arg_40_0:getItemUidByPos(arg_40_0.curPos, iter_40_0)

		arg_40_0.curEquipMap[iter_40_0] = var_40_1
	end
end

function var_0_0.flushGroup(arg_41_0)
	return (arg_41_0:packUpdateEquips())
end

function var_0_0.packUpdateEquips(arg_42_0)
	local var_42_0 = {}

	for iter_42_0 = 1, var_0_0.TotalEquipPos do
		local var_42_1 = arg_42_0:getPosHeroUid(iter_42_0 - 1) or var_0_0.EmptyUid
		local var_42_2 = {
			index = iter_42_0 - 1,
			heroUid = var_42_1,
			equipUid = {}
		}
		local var_42_3 = arg_42_0:getEquipMaxCount(iter_42_0 - 1)

		for iter_42_1 = 1, var_42_3 do
			var_42_2.equipUid[iter_42_1] = var_0_0.EmptyUid
		end

		var_42_0[iter_42_0] = var_42_2
	end

	for iter_42_2, iter_42_3 in pairs(arg_42_0.equipUid2Pos) do
		if not var_0_0.isTrialEquip(iter_42_2) then
			local var_42_4 = arg_42_0.equipUid2Slot[iter_42_2]

			if var_42_4 then
				var_42_0[iter_42_3 + 1].equipUid[var_42_4] = iter_42_2
			end
		end
	end

	return var_42_0
end

function var_0_0.checkResetCurSelected(arg_43_0)
	local var_43_0 = arg_43_0:getEquipMaxCount(arg_43_0.curPos)

	for iter_43_0 = 1, var_43_0 do
		if arg_43_0.curEquipMap[iter_43_0] ~= var_0_0.EmptyUid and not arg_43_0._itemMap[arg_43_0.curEquipMap[iter_43_0]] then
			arg_43_0.curEquipMap[iter_43_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.getShowUnlockSlotCount(arg_44_0)
	local var_44_0 = 0

	for iter_44_0 = 0, var_0_0.TotalEquipPos - 1 do
		for iter_44_1 = arg_44_0:getEquipMaxCount(iter_44_0), 1, -1 do
			if Activity104Model.instance:isSeasonPosUnlock(arg_44_0.activityId, arg_44_0.groupIndex, iter_44_1, iter_44_0) then
				var_44_0 = math.max(var_44_0, iter_44_1)
			end
		end

		local var_44_1 = arg_44_0:getTrialEquipCountByPos(iter_44_0)

		var_44_0 = math.max(var_44_0, var_44_1)
	end

	return var_44_0
end

function var_0_0.getTrialEquipCountByPos(arg_45_0, arg_45_1)
	local var_45_0 = 0
	local var_45_1 = arg_45_0:getGroupMO()

	if not var_45_1 then
		return var_45_0
	end

	local var_45_2 = var_45_1.trialDict
	local var_45_3 = var_45_2 and var_45_2[arg_45_1 + 1]

	if var_45_3 then
		local var_45_4 = arg_45_0:getEquipMaxCount(arg_45_1)

		for iter_45_0 = 1, var_45_4 do
			local var_45_5 = HeroConfig.instance:getTrial104Equip(iter_45_0, var_45_3[1], var_45_3[2])

			if var_45_5 and var_45_5 > 0 then
				var_45_0 = var_45_0 + 1
			end
		end
	end

	return var_45_0
end

function var_0_0.getNeedShowDeckCount(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._deckUidMap[arg_46_1]

	if var_46_0 == nil then
		return false
	end

	local var_46_1 = arg_46_0._itemIdDeckCountMap[var_46_0]

	return var_46_1 > 1, var_46_1
end

function var_0_0.getDelayPlayTime(arg_47_0, arg_47_1)
	if arg_47_1 == nil then
		return -1
	end

	local var_47_0 = arg_47_0.curPos == var_0_0.MainCharPos and SeasonEquipHeroViewContainer.ColumnCount or SeasonEquipItem.ColumnCount
	local var_47_1 = Time.time

	if arg_47_0._itemStartAnimTime == nil then
		arg_47_0._itemStartAnimTime = var_47_1 + SeasonEquipItem.OpenAnimStartTime
	end

	local var_47_2 = arg_47_0:getIndex(arg_47_1)

	if not var_47_2 or var_47_2 > SeasonEquipItem.AnimRowCount * var_47_0 then
		return -1
	end

	local var_47_3 = math.floor((var_47_2 - 1) / var_47_0) * SeasonEquipItem.OpenAnimTime + SeasonEquipItem.OpenAnimStartTime
	local var_47_4 = var_47_1 - arg_47_0._itemStartAnimTime

	if var_47_3 < var_47_4 then
		return -1
	else
		return var_47_3 - var_47_4
	end
end

function var_0_0.flushRecord(arg_48_0)
	if arg_48_0.recordNew then
		arg_48_0.recordNew:recordAllItem()
	end
end

function var_0_0.fiterFightCardDataList(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = {}
	local var_49_1 = {}

	if arg_49_2 then
		local var_49_2 = FightModel.instance:getBattleId()
		local var_49_3 = var_49_2 and lua_battle.configDict[var_49_2]
		local var_49_4 = var_49_3 and var_49_3.playerMax or ModuleEnum.HeroCountInGroup

		for iter_49_0, iter_49_1 in ipairs(arg_49_2) do
			local var_49_5 = iter_49_1.pos

			if var_49_5 < 0 then
				var_49_5 = var_49_4 - var_49_5
			end

			var_49_1[var_49_5] = iter_49_1.trialId
		end
	end

	arg_49_0:_fiterFightCardData(var_0_0.TotalEquipPos, var_49_0, arg_49_1)

	for iter_49_2 = 1, var_0_0.TotalEquipPos - 1 do
		arg_49_0:_fiterFightCardData(iter_49_2, var_49_0, arg_49_1, var_49_1)
	end

	return var_49_0
end

function var_0_0._fiterFightCardData(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	local var_50_0 = arg_50_1 - 1
	local var_50_1 = arg_50_4 and arg_50_4[arg_50_1]
	local var_50_2 = arg_50_3 and arg_50_3[arg_50_1] and arg_50_3[arg_50_1].heroUid

	if var_50_0 == var_0_0.MainCharPos then
		var_50_2 = nil
	end

	if (not var_50_2 or var_50_2 == var_0_0.EmptyUid) and var_50_0 ~= var_0_0.MainCharPos then
		return
	end

	local var_50_3 = arg_50_0:getEquipMaxCount(var_50_0)
	local var_50_4 = 1

	for iter_50_0 = 1, var_50_3 do
		local var_50_5 = arg_50_3 and arg_50_3[arg_50_1] and arg_50_3[arg_50_1].equipUid and arg_50_3[arg_50_1].equipUid[iter_50_0]
		local var_50_6

		if var_50_5 then
			var_50_6 = Activity104Model.instance:getItemIdByUid(var_50_5)
		end

		if not var_50_6 or var_50_6 == 0 then
			if var_50_1 then
				var_50_6 = HeroConfig.instance:getTrial104Equip(iter_50_0, var_50_1)
			elseif var_50_0 == var_0_0.MainCharPos then
				local var_50_7 = FightModel.instance:getBattleId()
				local var_50_8 = var_50_7 and lua_battle.configDict[var_50_7]

				var_50_6 = var_50_8 and var_50_8.trialMainAct104EuqipId
			end
		end

		if var_50_6 and var_50_6 > 0 then
			local var_50_9 = {
				equipId = var_50_6,
				heroUid = var_50_2,
				trialId = var_50_1,
				count = var_50_4
			}

			var_50_4 = var_50_4 + 1

			table.insert(arg_50_2, var_50_9)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
