module("modules.logic.seasonver.act123.model.Season123EquipHeroItemListModel", package.seeall)

local var_0_0 = class("Season123EquipHeroItemListModel", ListScrollModel)

var_0_0.MainCharPos = ModuleEnum.MaxHeroCountInGroup
var_0_0.TotalEquipPos = 5
var_0_0.MaxPos = 1
var_0_0.HeroMaxPos = 2
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
	logNormal("Season123EquipHeroItemListModel initDatas")
	arg_2_0:clear()

	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2
	arg_2_0.curPos = var_0_0.MainCharPos
	arg_2_0.equipUid2Pos = {}
	arg_2_0.equipUid2Slot = {}

	local var_2_0 = arg_2_0:getEquipMaxCount(arg_2_0.curPos)

	arg_2_0.curEquipMap = {}

	for iter_2_0 = 1, var_2_0 do
		arg_2_0.curEquipMap[iter_2_0] = var_0_0.EmptyUid
	end

	arg_2_0.curSelectSlot = arg_2_3 or 1
	arg_2_0.equipUid2Group = {}

	arg_2_0:initSubModel()
	arg_2_0:initUnlockIndex()
	arg_2_0:initItemMap()
	arg_2_0:initPlayerPrefs()
	arg_2_0:initPosData(arg_2_4)
	arg_2_0:initList()
end

function var_0_0.initSubModel(arg_3_0)
	arg_3_0.tagModel = Season123EquipTagModel.New()

	arg_3_0.tagModel:init(arg_3_0.activityId)
end

function var_0_0.initUnlockIndex(arg_4_0)
	arg_4_0.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(arg_4_0.activityId)
end

function var_0_0.initItemMap(arg_5_0)
	arg_5_0._itemMap = Season123Model.instance:getAllItemMo(arg_5_0.activityId) or {}
end

function var_0_0.initPlayerPrefs(arg_6_0)
	arg_6_0.recordNew = Season123EquipLocalRecord.New()

	arg_6_0.recordNew:init(arg_6_0.activityId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function var_0_0.initPosData(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		arg_7_0:setCardPosData(iter_7_1, arg_7_0.curPos, iter_7_0)
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

	local var_9_1 = HeroGroupModel.instance.battleConfig

	if var_9_1 and var_9_1.trialMainAct104EuqipId > 0 then
		local var_9_2 = 1
		local var_9_3 = var_0_0.getTrialEquipUID(var_9_1.trialMainAct104EuqipId, var_9_2)

		arg_9_0:setListData(var_9_1.trialMainAct104EuqipId, var_9_3, nil, var_9_0)
	end

	table.sort(var_9_0, var_0_0.sortItemMOList)

	arg_9_0._originList = var_9_0

	arg_9_0:refreshMergeList()
end

function var_0_0.setListData(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not SeasonConfig.instance:getEquipIsOptional(arg_10_1) then
		local var_10_0 = Season123Config.instance:getSeasonEquipCo(arg_10_1)

		if var_10_0 and arg_10_0:isCardFitRole(var_10_0) and arg_10_0:isCardCanShowByTag(arg_10_2, var_10_0.tag) and var_10_0.isCardBag ~= "1" then
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

function var_0_0.isCardFitRole(arg_11_0, arg_11_1)
	if arg_11_0.curPos == var_0_0.MainCharPos then
		return Season123EquipMetaUtils.isMainRoleCard(arg_11_1)
	else
		return not Season123EquipMetaUtils.isMainRoleCard(arg_11_1)
	end
end

function var_0_0.isCardCanShowByTag(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.tagModel then
		return arg_12_0.tagModel:isCardNeedShow(arg_12_2)
	end

	return true
end

function var_0_0.refreshMergeList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0.curEquipMap) do
		if iter_13_1 ~= var_0_0.EmptyUid then
			var_13_1[iter_13_1] = true
		end
	end

	for iter_13_2 = 1, #arg_13_0._originList do
		local var_13_4 = arg_13_0._originList[iter_13_2].id
		local var_13_5 = arg_13_0._originList[iter_13_2].itemId

		if var_13_1[var_13_4] or arg_13_0.equipUid2Pos[var_13_4] then
			table.insert(var_13_0, arg_13_0._originList[iter_13_2])
		else
			local var_13_6 = var_13_2[var_13_5]

			if var_13_6 == nil then
				table.insert(var_13_0, arg_13_0._originList[iter_13_2])

				var_13_2[var_13_5] = 1
				var_13_3[var_13_4] = var_13_5
			else
				var_13_2[var_13_5] = var_13_6 + 1
			end
		end
	end

	arg_13_0._deckUidMap = var_13_3
	arg_13_0._itemIdDeckCountMap = var_13_2

	arg_13_0:setList(var_13_0)
end

function var_0_0.changeSelectSlot(arg_14_0, arg_14_1)
	if arg_14_1 <= arg_14_0:getEquipMaxCount(arg_14_0.curPos) and arg_14_1 > 0 then
		arg_14_0.curSelectSlot = arg_14_1
	end
end

function var_0_0.getEquipMO(arg_15_0, arg_15_1)
	return arg_15_0._itemMap[arg_15_1]
end

function var_0_0.equipShowItem(arg_16_0, arg_16_1)
	arg_16_0.curEquipMap[arg_16_0.curSelectSlot] = arg_16_1
end

function var_0_0.equipItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.curEquipMap[arg_17_2] = arg_17_1
	arg_17_0.equipUid2Pos[arg_17_1] = arg_17_0.curPos
	arg_17_0.equipUid2Slot[arg_17_1] = arg_17_2
end

function var_0_0.unloadShowSlot(arg_18_0, arg_18_1)
	arg_18_0.curEquipMap[arg_18_1] = var_0_0.EmptyUid
end

function var_0_0.unloadItem(arg_19_0, arg_19_1)
	arg_19_0.equipUid2Pos[arg_19_1] = nil
	arg_19_0.equipUid2Slot[arg_19_1] = nil

	local var_19_0 = arg_19_0:getEquipMaxCount(arg_19_0.curPos)

	for iter_19_0 = 1, var_19_0 do
		if arg_19_0.curEquipMap[iter_19_0] == arg_19_1 then
			arg_19_0.curEquipMap[iter_19_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.unloadItemByPos(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.equipUid2Pos) do
		if iter_20_1 == arg_20_1 and arg_20_0.equipUid2Slot[iter_20_0] == arg_20_2 then
			arg_20_0:unloadItem(iter_20_0)

			return
		end
	end
end

function var_0_0.getItemUidByPos(arg_21_0, arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.equipUid2Pos) do
		if iter_21_1 == arg_21_1 and arg_21_0.equipUid2Slot[iter_21_0] == arg_21_2 then
			return iter_21_0
		end
	end

	return var_0_0.EmptyUid
end

function var_0_0.getItemEquipedPos(arg_22_0, arg_22_1)
	return arg_22_0.equipUid2Pos[arg_22_1], arg_22_0.equipUid2Slot[arg_22_1]
end

function var_0_0.getEquipMaxCount(arg_23_0, arg_23_1)
	return arg_23_1 == var_0_0.MainCharPos and var_0_0.HeroMaxPos or var_0_0.MaxPos
end

function var_0_0.getPosHeroUid(arg_24_0, arg_24_1)
	return nil
end

function var_0_0.slotIsLock(arg_25_0, arg_25_1)
	return not Season123Model.instance:isSeasonStagePosUnlock(arg_25_0.activityId, arg_25_0.stage, arg_25_1, arg_25_0.curPos)
end

function var_0_0.disableBecauseSameCard(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.equipUid2Group[arg_26_1]

	if var_26_0 then
		for iter_26_0, iter_26_1 in pairs(arg_26_0.curEquipMap) do
			local var_26_1 = arg_26_0.equipUid2Group[iter_26_1]

			if var_26_1 and iter_26_0 ~= arg_26_0.curSelectSlot and var_26_1 == var_26_0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.disableBecauseRole(arg_27_0, arg_27_1)
	local var_27_0 = SeasonConfig.instance:getSeasonEquipCo(arg_27_1)

	if not var_27_0 then
		return false
	end

	local var_27_1 = Season123EquipMetaUtils.isMainRoleCard(var_27_0)

	if arg_27_0.curPos == var_0_0.MainCharPos then
		if var_27_1 then
			return false
		end
	elseif not var_27_1 then
		return false
	end

	return true
end

function var_0_0.isItemUidInShowSlot(arg_28_0, arg_28_1)
	return arg_28_0.curEquipMap[arg_28_0.curSelectSlot] == arg_28_1
end

function var_0_0.isAllSlotEmpty(arg_29_0)
	local var_29_0 = arg_29_0:getEquipMaxCount(arg_29_0.curPos)

	for iter_29_0 = 1, var_29_0 do
		if arg_29_0.curEquipMap[iter_29_0] ~= var_0_0.EmptyUid then
			return false
		end
	end

	return true
end

function var_0_0.sortItemMOList(arg_30_0, arg_30_1)
	local var_30_0 = Season123Config.instance:getSeasonEquipCo(arg_30_0.itemId)
	local var_30_1 = Season123Config.instance:getSeasonEquipCo(arg_30_1.itemId)

	if var_30_0 ~= nil and var_30_1 ~= nil then
		local var_30_2 = var_0_0.instance:disableBecauseRole(arg_30_0.itemId)
		local var_30_3 = var_0_0.instance:disableBecauseRole(arg_30_1.itemId)

		if var_30_3 ~= var_30_2 then
			return var_30_3
		end

		if var_30_0.rare ~= var_30_1.rare then
			return var_30_0.rare > var_30_1.rare
		else
			return var_30_0.equipId > var_30_1.equipId
		end
	else
		return arg_30_0.id < arg_30_1.id
	end
end

function var_0_0.flushSlot(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.curEquipMap[arg_31_1]

	arg_31_0:unloadItemByPos(arg_31_0.curPos, arg_31_1)

	if var_31_0 ~= var_0_0.EmptyUid then
		arg_31_0:unloadTeamLimitCard(var_31_0)
		arg_31_0:unloadItem(var_31_0)
		arg_31_0:equipItem(var_31_0, arg_31_1)
	end
end

function var_0_0.unloadTeamLimitCard(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getById(arg_32_1)

	if not var_32_0 then
		return
	end

	local var_32_1 = arg_32_0:getList()
	local var_32_2 = Season123Config.instance:getSeasonEquipCo(var_32_0.itemId)
	local var_32_3 = false

	if var_32_2 and var_32_2.teamLimit == 0 then
		return false
	end

	for iter_32_0, iter_32_1 in pairs(arg_32_0.equipUid2Pos) do
		if iter_32_0 ~= arg_32_1 and arg_32_0._itemMap[iter_32_0] then
			local var_32_4 = Season123Config.instance:getSeasonEquipCo(arg_32_0._itemMap[iter_32_0].itemId)

			if var_32_4 and var_32_4.teamLimit ~= 0 and var_32_4.teamLimit == var_32_2.teamLimit then
				arg_32_0:unloadItem(iter_32_0)

				var_32_3 = true
			end
		end
	end

	return var_32_3
end

function var_0_0.resumeSlotData(arg_33_0)
	local var_33_0 = arg_33_0:getEquipMaxCount(arg_33_0.curPos)

	for iter_33_0 = 1, var_33_0 do
		local var_33_1 = arg_33_0:getItemUidByPos(arg_33_0.curPos, iter_33_0)

		arg_33_0.curEquipMap[iter_33_0] = var_33_1
	end
end

function var_0_0.getEquipedCards(arg_34_0)
	return (arg_34_0:packUpdateEquips())
end

function var_0_0.packUpdateEquips(arg_35_0)
	local var_35_0 = {}

	for iter_35_0 = 1, var_0_0.HeroMaxPos do
		var_35_0[iter_35_0] = arg_35_0.curEquipMap[iter_35_0] or var_0_0.EmptyUid
	end

	return var_35_0
end

function var_0_0.checkResetCurSelected(arg_36_0)
	local var_36_0 = arg_36_0:getEquipMaxCount(arg_36_0.curPos)

	for iter_36_0 = 1, var_36_0 do
		if arg_36_0.curEquipMap[iter_36_0] ~= var_0_0.EmptyUid and not arg_36_0._itemMap[arg_36_0.curEquipMap[iter_36_0]] then
			arg_36_0.curEquipMap[iter_36_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.getShowUnlockSlotCount(arg_37_0)
	local var_37_0 = 0
	local var_37_1 = arg_37_0.curPos

	for iter_37_0 = arg_37_0:getEquipMaxCount(var_37_1), 1, -1 do
		if arg_37_0:isEquipCardPosUnlock(iter_37_0, var_37_1) then
			var_37_0 = math.max(var_37_0, iter_37_0)

			return var_37_0
		end
	end

	return var_37_0
end

function var_0_0.isEquipCardPosUnlock(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = Season123Model.instance:getUnlockCardIndex(arg_38_2, arg_38_1)

	return arg_38_0.curUnlockIndexSet[var_38_0] == true
end

function var_0_0.getNeedShowDeckCount(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0._deckUidMap[arg_39_1]

	if var_39_0 == nil then
		return false
	end

	local var_39_1 = arg_39_0._itemIdDeckCountMap[var_39_0]

	return var_39_1 > 1, var_39_1
end

function var_0_0.getDelayPlayTime(arg_40_0, arg_40_1)
	if arg_40_1 == nil then
		return -1
	end

	local var_40_0 = arg_40_0.curPos == var_0_0.MainCharPos and SeasonEquipHeroViewContainer.ColumnCount or SeasonEquipItem.ColumnCount
	local var_40_1 = Time.time

	if arg_40_0._itemStartAnimTime == nil then
		arg_40_0._itemStartAnimTime = var_40_1 + SeasonEquipItem.OpenAnimStartTime
	end

	local var_40_2 = arg_40_0:getIndex(arg_40_1)

	if not var_40_2 or var_40_2 > SeasonEquipItem.AnimRowCount * var_40_0 then
		return -1
	end

	local var_40_3 = math.floor((var_40_2 - 1) / var_40_0) * SeasonEquipItem.OpenAnimTime + SeasonEquipItem.OpenAnimStartTime
	local var_40_4 = var_40_1 - arg_40_0._itemStartAnimTime

	if var_40_3 < var_40_4 then
		return -1
	else
		return var_40_3 - var_40_4
	end
end

function var_0_0.flushRecord(arg_41_0)
	if arg_41_0.recordNew then
		arg_41_0.recordNew:recordAllItem()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
