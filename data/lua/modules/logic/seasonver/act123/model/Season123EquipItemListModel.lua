module("modules.logic.seasonver.act123.model.Season123EquipItemListModel", package.seeall)

local var_0_0 = class("Season123EquipItemListModel", ListScrollModel)

var_0_0.MainCharPos = 4
var_0_0.TotalEquipPos = 5
var_0_0.MaxPos = 1
var_0_0.HeroMaxPos = 2
var_0_0.EmptyUid = "0"
var_0_0.ColumnCount = 6
var_0_0.AnimRowCount = 4
var_0_0.OpenAnimTime = 0.06
var_0_0.OpenAnimStartTime = 0.05

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
	arg_1_0.curUnlockIndexSet = nil
end

function var_0_0.initDatas(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	logNormal("Season123EquipItemListModel initDatas")
	arg_2_0:clear()

	arg_2_0.activityId = arg_2_1
	arg_2_0.curPos = arg_2_5
	arg_2_0.groupIndex = arg_2_2
	arg_2_0.stage = arg_2_3
	arg_2_0.layer = arg_2_4
	arg_2_0.equipUid2Pos = {}
	arg_2_0.equipUid2Slot = {}

	local var_2_0 = arg_2_0:getEquipMaxCount(arg_2_0.curPos)

	arg_2_0.curEquipMap = {}

	for iter_2_0 = 1, var_2_0 do
		arg_2_0.curEquipMap[iter_2_0] = var_0_0.EmptyUid
	end

	arg_2_0.curSelectSlot = arg_2_6 or 1
	arg_2_0.equipUid2Group = {}

	arg_2_0:initUnlockIndex()
	arg_2_0:initSubModel()
	arg_2_0:initItemMap()
	arg_2_0:initPlayerPrefs()
	arg_2_0:initPosData()
	arg_2_0:initList()
end

function var_0_0.initUnlockIndex(arg_3_0)
	arg_3_0.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(arg_3_0.activityId)
end

function var_0_0.initSubModel(arg_4_0)
	arg_4_0.tagModel = Season123EquipTagModel.New()

	arg_4_0.tagModel:init(arg_4_0.activityId)
end

function var_0_0.initItemMap(arg_5_0)
	arg_5_0._itemMap = Season123Model.instance:getAllItemMo(arg_5_0.activityId) or {}
end

function var_0_0.initPlayerPrefs(arg_6_0)
	arg_6_0.recordNew = Season123EquipLocalRecord.New()

	arg_6_0.recordNew:init(arg_6_0.activityId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function var_0_0.initPosData(arg_7_0)
	local var_7_0 = arg_7_0:getGroupMO()

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.activity104Equips

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		local var_7_2 = arg_7_0:getEquipMaxCount(iter_7_0)

		for iter_7_2 = 1, var_7_2 do
			local var_7_3 = iter_7_1.equipUid[iter_7_2]

			if arg_7_0._itemMap[var_7_3] then
				arg_7_0:setCardPosData(var_7_3, iter_7_0, iter_7_2)
			end
		end
	end
end

function var_0_0.setCardPosData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.equipUid2Pos[arg_8_1] = arg_8_2
	arg_8_0.equipUid2Slot[arg_8_1] = arg_8_3

	if arg_8_2 == arg_8_0.curPos then
		arg_8_0.curEquipMap[arg_8_3] = arg_8_1
	end
end

function var_0_0.initList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0._itemMap) do
		arg_9_0:setListData(iter_9_1.itemId, iter_9_0, iter_9_1, var_9_0)
	end

	table.sort(var_9_0, var_0_0.sortItemMOList)

	arg_9_0._originList = var_9_0

	arg_9_0:refreshMergeList()
end

function var_0_0.setListData(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not Season123Config.instance:getEquipIsOptional(arg_10_1) then
		local var_10_0 = Season123Config.instance:getSeasonEquipCo(arg_10_1)

		if var_10_0 and arg_10_0:isCardFitRole(var_10_0) and arg_10_0:isCardCanShowByTag(arg_10_2, var_10_0.tag) then
			arg_10_0.equipUid2Group[arg_10_2] = var_10_0.group

			if not arg_10_3 then
				arg_10_3 = Season123ItemMO.New()

				arg_10_3:init({
					quantity = 1,
					itemId = arg_10_1,
					uid = arg_10_2
				})
			end

			local var_10_1 = Season123EquipListMo.New()

			var_10_1:init(arg_10_3)
			table.insert(arg_10_4, var_10_1)
		end
	end
end

function var_0_0.getTrialEquipUID(...)
	local var_11_0 = {
		...
	}

	return table.concat(var_11_0, "#")
end

function var_0_0.isTrialEquip(arg_12_0)
	return tonumber(arg_12_0) == nil
end

function var_0_0.curSelectIsTrialEquip(arg_13_0)
	local var_13_0 = arg_13_0.curEquipMap[arg_13_0.curSelectSlot]

	return var_13_0 and var_0_0.isTrialEquip(var_13_0)
end

function var_0_0.curMapIsTrialEquipMap(arg_14_0)
	if arg_14_0.curPos == var_0_0.MainCharPos then
		local var_14_0 = HeroGroupModel.instance.battleConfig

		return var_14_0 and var_14_0.trialMainAct104EuqipId > 0
	end

	local var_14_1 = arg_14_0:getGroupMO()

	if not var_14_1 then
		return
	end

	local var_14_2 = var_14_1.trialDict
	local var_14_3 = arg_14_0.curPos + 1
	local var_14_4 = var_14_2 and var_14_2[var_14_3]

	if var_14_4 then
		local var_14_5 = arg_14_0:getEquipMaxCount(var_14_3)

		for iter_14_0 = 1, var_14_5 do
			local var_14_6 = HeroConfig.instance:getTrial104Equip(iter_14_0, var_14_4[1], var_14_4[2])

			if var_14_6 and var_14_6 > 0 then
				return true
			end
		end
	end
end

function var_0_0.isCardFitRole(arg_15_0, arg_15_1)
	if arg_15_0.curPos == var_0_0.MainCharPos then
		return Season123EquipMetaUtils.isMainRoleCard(arg_15_1)
	else
		return not Season123EquipMetaUtils.isMainRoleCard(arg_15_1)
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
	return not arg_30_0:isEquipCardPosUnlock(arg_30_1, arg_30_0.curPos)
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
	local var_33_0 = Season123Config.instance:getSeasonEquipCo(arg_33_1)

	if not var_33_0 then
		return false
	end

	local var_33_1 = Season123EquipMetaUtils.isMainRoleCard(var_33_0)

	if arg_33_0.curPos == var_0_0.MainCharPos then
		if var_33_1 then
			return false
		end
	elseif not var_33_1 then
		return false
	end

	return true
end

function var_0_0.disableBecausePos(arg_34_0, arg_34_1)
	if not Season123Config.instance:getSeasonEquipCo(arg_34_1) then
		return false
	end

	local var_34_0, var_34_1 = Season123Config.instance:getCardLimitPosDict(arg_34_1)

	if var_34_0 == nil or var_34_0[arg_34_0.curPos + 1] then
		return false
	end

	return true, var_34_1
end

function var_0_0.isEquipCareerNoFit(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if arg_35_2 == var_0_0.MainCharPos or not arg_35_3 then
		return false
	end

	local var_35_0 = Season123Config.instance:getSeasonEquipCo(arg_35_1)

	if not var_35_0 then
		return false
	end

	local var_35_1 = arg_35_3:getHeroByIndex(arg_35_2 + 1)
	local var_35_2

	if not string.nilorempty(var_35_1) then
		var_35_2 = HeroModel.instance:getById(var_35_1)
	end

	if not var_35_2 then
		return false
	end

	local var_35_3 = var_35_2.config.career

	if not string.nilorempty(var_35_0.career) then
		if CharacterEnum.CareerType.Ling == var_35_3 or CharacterEnum.CareerType.Zhi == var_35_3 then
			return var_35_0.career ~= Activity123Enum.CareerType.Ling_Or_Zhi
		else
			return tonumber(var_35_0.career) ~= var_35_3
		end
	end

	return false
end

function var_0_0.isItemUidInShowSlot(arg_36_0, arg_36_1)
	return arg_36_0.curEquipMap[arg_36_0.curSelectSlot] == arg_36_1
end

function var_0_0.isAllSlotEmpty(arg_37_0)
	local var_37_0 = arg_37_0:getEquipMaxCount(arg_37_0.curPos)

	for iter_37_0 = 1, var_37_0 do
		if arg_37_0.curEquipMap[iter_37_0] ~= var_0_0.EmptyUid then
			return false
		end
	end

	return true
end

function var_0_0.sortItemMOList(arg_38_0, arg_38_1)
	local var_38_0 = Season123Config.instance:getSeasonEquipCo(arg_38_0.itemId)
	local var_38_1 = Season123Config.instance:getSeasonEquipCo(arg_38_1.itemId)

	if var_38_0 ~= nil and var_38_1 ~= nil then
		local var_38_2 = var_0_0.instance:disableBecauseRole(arg_38_0.itemId)
		local var_38_3 = var_0_0.instance:disableBecauseRole(arg_38_1.itemId)

		if var_38_3 ~= var_38_2 then
			return var_38_3
		end

		if var_38_0.rare ~= var_38_1.rare then
			return var_38_0.rare > var_38_1.rare
		else
			return var_38_0.equipId > var_38_1.equipId
		end
	else
		return arg_38_0.id < arg_38_1.id
	end
end

function var_0_0.getGroupMO(arg_39_0, arg_39_1)
	return Season123Model.instance:getSnapshotHeroGroup(arg_39_1)
end

function var_0_0.flushSlot(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0.curEquipMap[arg_40_1]

	arg_40_0:unloadItemByPos(arg_40_0.curPos, arg_40_1)

	if var_40_0 ~= var_0_0.EmptyUid then
		arg_40_0:unloadTeamLimitCard(var_40_0)
		arg_40_0:unloadItem(var_40_0)
		arg_40_0:equipItem(var_40_0, arg_40_1)
	end
end

function var_0_0.unloadTeamLimitCard(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getById(arg_41_1)

	if not var_41_0 then
		return
	end

	local var_41_1 = arg_41_0:getList()
	local var_41_2 = Season123Config.instance:getSeasonEquipCo(var_41_0.itemId)
	local var_41_3 = false

	if var_41_2 and var_41_2.teamLimit == 0 then
		return false
	end

	for iter_41_0, iter_41_1 in pairs(arg_41_0.equipUid2Pos) do
		if iter_41_0 ~= arg_41_1 and arg_41_0._itemMap[iter_41_0] then
			local var_41_4 = Season123Config.instance:getSeasonEquipCo(arg_41_0._itemMap[iter_41_0].itemId)

			if var_41_4 and var_41_4.teamLimit ~= 0 and var_41_4.teamLimit == var_41_2.teamLimit then
				arg_41_0:unloadItem(iter_41_0)

				var_41_3 = true
			end
		end
	end

	return var_41_3
end

function var_0_0.resumeSlotData(arg_42_0)
	local var_42_0 = arg_42_0:getEquipMaxCount(arg_42_0.curPos)

	for iter_42_0 = 1, var_42_0 do
		local var_42_1 = arg_42_0:getItemUidByPos(arg_42_0.curPos, iter_42_0)

		arg_42_0.curEquipMap[iter_42_0] = var_42_1
	end
end

function var_0_0.flushGroup(arg_43_0)
	return (arg_43_0:packUpdateEquips())
end

function var_0_0.packUpdateEquips(arg_44_0)
	local var_44_0 = {}

	for iter_44_0 = 1, var_0_0.TotalEquipPos do
		local var_44_1 = arg_44_0:getPosHeroUid(iter_44_0 - 1) or var_0_0.EmptyUid
		local var_44_2 = {
			index = iter_44_0 - 1,
			heroUid = var_44_1,
			equipUid = {}
		}
		local var_44_3 = arg_44_0:getEquipMaxCount(iter_44_0 - 1)

		for iter_44_1 = 1, var_44_3 do
			var_44_2.equipUid[iter_44_1] = var_0_0.EmptyUid
		end

		var_44_0[iter_44_0] = var_44_2
	end

	for iter_44_2, iter_44_3 in pairs(arg_44_0.equipUid2Pos) do
		if not var_0_0.isTrialEquip(iter_44_2) then
			local var_44_4 = arg_44_0.equipUid2Slot[iter_44_2]

			if var_44_4 then
				var_44_0[iter_44_3 + 1].equipUid[var_44_4] = iter_44_2
			end
		end
	end

	return var_44_0
end

function var_0_0.checkResetCurSelected(arg_45_0)
	local var_45_0 = arg_45_0:getEquipMaxCount(arg_45_0.curPos)

	for iter_45_0 = 1, var_45_0 do
		if arg_45_0.curEquipMap[iter_45_0] ~= var_0_0.EmptyUid and not arg_45_0._itemMap[arg_45_0.curEquipMap[iter_45_0]] then
			arg_45_0.curEquipMap[iter_45_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.getShowUnlockSlotCount(arg_46_0)
	local var_46_0 = 0

	for iter_46_0 = 0, var_0_0.TotalEquipPos - 1 do
		for iter_46_1 = arg_46_0:getEquipMaxCount(iter_46_0), 1, -1 do
			if arg_46_0:isEquipCardPosUnlock(iter_46_1, iter_46_0) then
				var_46_0 = math.max(var_46_0, iter_46_1)
			end
		end
	end

	return var_46_0
end

function var_0_0.getNeedShowDeckCount(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0._deckUidMap[arg_47_1]

	if var_47_0 == nil then
		return false
	end

	local var_47_1 = arg_47_0._itemIdDeckCountMap[var_47_0]

	return var_47_1 > 1, var_47_1
end

function var_0_0.getDelayPlayTime(arg_48_0, arg_48_1)
	if arg_48_1 == nil then
		return -1
	end

	local var_48_0 = arg_48_0.curPos == var_0_0.MainCharPos and SeasonEquipHeroViewContainer.ColumnCount or var_0_0.ColumnCount
	local var_48_1 = Time.time

	if arg_48_0._itemStartAnimTime == nil then
		arg_48_0._itemStartAnimTime = var_48_1 + var_0_0.OpenAnimStartTime
	end

	local var_48_2 = arg_48_0:getIndex(arg_48_1)

	if not var_48_2 or var_48_2 > var_0_0.AnimRowCount * var_48_0 then
		return -1
	end

	local var_48_3 = math.floor((var_48_2 - 1) / var_48_0) * var_0_0.OpenAnimTime + var_0_0.OpenAnimStartTime
	local var_48_4 = var_48_1 - arg_48_0._itemStartAnimTime

	if var_48_3 < var_48_4 then
		return -1
	else
		return var_48_3 - var_48_4
	end
end

function var_0_0.flushRecord(arg_49_0)
	if arg_49_0.recordNew then
		arg_49_0.recordNew:recordAllItem()
	end
end

function var_0_0.isEquipCardPosUnlock(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = Season123Model.instance:getUnlockCardIndex(arg_50_2, arg_50_1)

	return arg_50_0.curUnlockIndexSet[var_50_0] == true
end

var_0_0.instance = var_0_0.New()

return var_0_0
