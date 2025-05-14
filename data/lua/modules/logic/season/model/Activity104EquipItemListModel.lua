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
	arg_11_0.equipUid2Pos[arg_11_1] = arg_11_2
	arg_11_0.equipUid2Slot[arg_11_1] = arg_11_3

	if arg_11_2 == arg_11_0.curPos then
		arg_11_0.curEquipMap[arg_11_3] = arg_11_1
	end
end

function var_0_0.initList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0._itemMap) do
		arg_12_0:setListData(iter_12_1.itemId, iter_12_0, iter_12_1, var_12_0)
	end

	local var_12_1 = arg_12_0:getGroupMO()

	if var_12_1 then
		local var_12_2 = var_12_1.trialDict

		if var_12_2 then
			for iter_12_2, iter_12_3 in pairs(var_12_2) do
				for iter_12_4 = 1, var_0_0.MaxPos do
					local var_12_3 = HeroConfig.instance:getTrial104Equip(iter_12_4, iter_12_3[1], iter_12_3[2])

					if var_12_3 and var_12_3 > 0 then
						local var_12_4 = var_0_0.getTrialEquipUID(var_12_3, iter_12_4, iter_12_3[1])

						arg_12_0:setListData(var_12_3, var_12_4, nil, var_12_0)
					end
				end
			end
		end
	end

	local var_12_5 = HeroGroupModel.instance.battleConfig

	if var_12_5 and var_12_5.trialMainAct104EuqipId > 0 then
		local var_12_6 = 1
		local var_12_7 = var_0_0.getTrialEquipUID(var_12_5.trialMainAct104EuqipId, var_12_6)

		arg_12_0:setListData(var_12_5.trialMainAct104EuqipId, var_12_7, nil, var_12_0)
	end

	table.sort(var_12_0, var_0_0.sortItemMOList)

	arg_12_0._originList = var_12_0

	arg_12_0:refreshMergeList()
end

function var_0_0.setListData(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if not SeasonConfig.instance:getEquipIsOptional(arg_13_1) then
		local var_13_0 = SeasonConfig.instance:getSeasonEquipCo(arg_13_1)

		if var_13_0 and arg_13_0:isCardFitRole(var_13_0) and arg_13_0:isCardCanShowByTag(arg_13_2, var_13_0.tag) then
			arg_13_0.equipUid2Group[arg_13_2] = var_13_0.group

			if not arg_13_3 then
				arg_13_3 = Activity104ItemMo.New()

				arg_13_3:init({
					quantity = 1,
					itemId = arg_13_1,
					uid = arg_13_2
				})
			end

			local var_13_1 = Activity104EquipListMo.New()

			var_13_1:init(arg_13_3)
			table.insert(arg_13_4, var_13_1)
		end
	end
end

function var_0_0.isCardFitRole(arg_14_0, arg_14_1)
	if arg_14_0.curPos == var_0_0.MainCharPos then
		return SeasonEquipMetaUtils.isMainRoleCard(arg_14_1.rare)
	else
		return not SeasonEquipMetaUtils.isMainRoleCard(arg_14_1.rare)
	end
end

function var_0_0.isCardCanShowByTag(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.tagModel then
		return arg_15_0.tagModel:isCardNeedShow(arg_15_2)
	end

	return true
end

function var_0_0.refreshMergeList(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = {}
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.curEquipMap) do
		if iter_16_1 ~= var_0_0.EmptyUid then
			var_16_1[iter_16_1] = true
		end
	end

	for iter_16_2 = 1, #arg_16_0._originList do
		local var_16_4 = arg_16_0._originList[iter_16_2].id
		local var_16_5 = arg_16_0._originList[iter_16_2].itemId

		if var_16_1[var_16_4] or arg_16_0.equipUid2Pos[var_16_4] then
			table.insert(var_16_0, arg_16_0._originList[iter_16_2])
		else
			local var_16_6 = var_16_2[var_16_5]

			if var_16_6 == nil then
				table.insert(var_16_0, arg_16_0._originList[iter_16_2])

				var_16_2[var_16_5] = 1
				var_16_3[var_16_4] = var_16_5
			else
				var_16_2[var_16_5] = var_16_6 + 1
			end
		end
	end

	arg_16_0._deckUidMap = var_16_3
	arg_16_0._itemIdDeckCountMap = var_16_2

	arg_16_0:setList(var_16_0)
end

function var_0_0.changeSelectSlot(arg_17_0, arg_17_1)
	if arg_17_1 <= arg_17_0:getEquipMaxCount(arg_17_0.curPos) and arg_17_1 > 0 then
		arg_17_0.curSelectSlot = arg_17_1
	end
end

function var_0_0.getEquipMO(arg_18_0, arg_18_1)
	return arg_18_0._itemMap[arg_18_1]
end

function var_0_0.equipShowItem(arg_19_0, arg_19_1)
	arg_19_0.curEquipMap[arg_19_0.curSelectSlot] = arg_19_1
end

function var_0_0.equipItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.curEquipMap[arg_20_2] = arg_20_1
	arg_20_0.equipUid2Pos[arg_20_1] = arg_20_0.curPos
	arg_20_0.equipUid2Slot[arg_20_1] = arg_20_2
end

function var_0_0.unloadShowSlot(arg_21_0, arg_21_1)
	arg_21_0.curEquipMap[arg_21_1] = var_0_0.EmptyUid
end

function var_0_0.unloadItem(arg_22_0, arg_22_1)
	arg_22_0.equipUid2Pos[arg_22_1] = nil
	arg_22_0.equipUid2Slot[arg_22_1] = nil

	local var_22_0 = arg_22_0:getEquipMaxCount(arg_22_0.curPos)

	for iter_22_0 = 1, var_22_0 do
		if arg_22_0.curEquipMap[iter_22_0] == arg_22_1 then
			arg_22_0.curEquipMap[iter_22_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.unloadItemByPos(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.equipUid2Pos) do
		if iter_23_1 == arg_23_1 and arg_23_0.equipUid2Slot[iter_23_0] == arg_23_2 then
			arg_23_0:unloadItem(iter_23_0)

			return
		end
	end
end

function var_0_0.getItemUidByPos(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.equipUid2Pos) do
		if iter_24_1 == arg_24_1 and arg_24_0.equipUid2Slot[iter_24_0] == arg_24_2 then
			return iter_24_0
		end
	end

	return var_0_0.EmptyUid
end

function var_0_0.getItemEquipedPos(arg_25_0, arg_25_1)
	return arg_25_0.equipUid2Pos[arg_25_1], arg_25_0.equipUid2Slot[arg_25_1]
end

function var_0_0.getCurItemEquip(arg_26_0)
	local var_26_0 = arg_26_0:getGroupMO()

	if not var_26_0 then
		return nil
	end

	local var_26_1 = var_26_0.activity104Equips

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		if iter_26_1.index == arg_26_0.curPos then
			return iter_26_1
		end
	end
end

function var_0_0.getEquipMaxCount(arg_27_0, arg_27_1)
	return arg_27_1 == var_0_0.MainCharPos and var_0_0.HeroMaxPos or var_0_0.MaxPos
end

function var_0_0.getPosHeroUid(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getGroupMO(arg_28_2)

	if not var_28_0 then
		return nil
	end

	return var_28_0:getHeroByIndex(arg_28_1 + 1)
end

function var_0_0.slotIsLock(arg_29_0, arg_29_1)
	return not Activity104Model.instance:isSeasonPosUnlock(arg_29_0.activityId, arg_29_0.groupIndex, arg_29_1, arg_29_0.curPos)
end

function var_0_0.disableBecauseCareerNotFit(arg_30_0, arg_30_1)
	return arg_30_0:isEquipCareerNoFit(arg_30_1, arg_30_0.curPos, arg_30_0:getGroupMO())
end

function var_0_0.disableBecauseSameCard(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.equipUid2Group[arg_31_1]

	if var_31_0 then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.curEquipMap) do
			local var_31_1 = arg_31_0.equipUid2Group[iter_31_1]

			if var_31_1 and iter_31_0 ~= arg_31_0.curSelectSlot and var_31_1 == var_31_0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.disableBecauseRole(arg_32_0, arg_32_1)
	local var_32_0 = SeasonConfig.instance:getSeasonEquipCo(arg_32_1)

	if not var_32_0 then
		return false
	end

	local var_32_1 = SeasonEquipMetaUtils.isMainRoleCard(var_32_0.rare)

	if arg_32_0.curPos == var_0_0.MainCharPos then
		if var_32_1 then
			return false
		end
	elseif not var_32_1 then
		return false
	end

	return true
end

function var_0_0.isEquipCareerNoFit(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 == var_0_0.MainCharPos or not arg_33_3 then
		return false
	end

	local var_33_0 = SeasonConfig.instance:getSeasonEquipCo(arg_33_1)

	if not var_33_0 then
		return false
	end

	local var_33_1 = arg_33_3:getHeroByIndex(arg_33_2 + 1)
	local var_33_2

	if not string.nilorempty(var_33_1) then
		var_33_2 = HeroModel.instance:getById(var_33_1)
	end

	if not var_33_2 then
		return false
	end

	local var_33_3 = var_33_2.config.career

	if not string.nilorempty(var_33_0.career) then
		if CharacterEnum.CareerType.Ling == var_33_3 or CharacterEnum.CareerType.Zhi == var_33_3 then
			return var_33_0.career ~= Activity104Enum.CareerType.Ling_Or_Zhi
		else
			return tonumber(var_33_0.career) ~= var_33_3
		end
	end

	return false
end

function var_0_0.isItemUidInShowSlot(arg_34_0, arg_34_1)
	return arg_34_0.curEquipMap[arg_34_0.curSelectSlot] == arg_34_1
end

function var_0_0.isAllSlotEmpty(arg_35_0)
	local var_35_0 = arg_35_0:getEquipMaxCount(arg_35_0.curPos)

	for iter_35_0 = 1, var_35_0 do
		if arg_35_0.curEquipMap[iter_35_0] ~= var_0_0.EmptyUid then
			return false
		end
	end

	return true
end

function var_0_0.sortItemMOList(arg_36_0, arg_36_1)
	local var_36_0 = SeasonConfig.instance:getSeasonEquipCo(arg_36_0.itemId)
	local var_36_1 = SeasonConfig.instance:getSeasonEquipCo(arg_36_1.itemId)

	if var_36_0 ~= nil and var_36_1 ~= nil then
		local var_36_2 = var_0_0.instance:disableBecauseRole(arg_36_0.itemId)
		local var_36_3 = var_0_0.instance:disableBecauseRole(arg_36_1.itemId)

		if var_36_3 ~= var_36_2 then
			return var_36_3
		end

		if var_36_0.rare ~= var_36_1.rare then
			return var_36_0.rare > var_36_1.rare
		else
			return var_36_0.equipId > var_36_1.equipId
		end
	else
		return arg_36_0.itemUid < arg_36_1.itemUid
	end
end

function var_0_0.getGroupMO(arg_37_0, arg_37_1)
	return HeroGroupModel.instance:getCurGroupMO()
end

function var_0_0.flushSlot(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.curEquipMap[arg_38_1]

	arg_38_0:unloadItemByPos(arg_38_0.curPos, arg_38_1)

	if var_38_0 ~= var_0_0.EmptyUid then
		arg_38_0:unloadItem(var_38_0)
		arg_38_0:equipItem(var_38_0, arg_38_1)
	end
end

function var_0_0.resumeSlotData(arg_39_0)
	local var_39_0 = arg_39_0:getEquipMaxCount(arg_39_0.curPos)

	for iter_39_0 = 1, var_39_0 do
		local var_39_1 = arg_39_0:getItemUidByPos(arg_39_0.curPos, iter_39_0)

		arg_39_0.curEquipMap[iter_39_0] = var_39_1
	end
end

function var_0_0.flushGroup(arg_40_0)
	return (arg_40_0:packUpdateEquips())
end

function var_0_0.packUpdateEquips(arg_41_0)
	local var_41_0 = {}

	for iter_41_0 = 1, var_0_0.TotalEquipPos do
		local var_41_1 = arg_41_0:getPosHeroUid(iter_41_0 - 1) or var_0_0.EmptyUid
		local var_41_2 = {
			index = iter_41_0 - 1,
			heroUid = var_41_1,
			equipUid = {}
		}
		local var_41_3 = arg_41_0:getEquipMaxCount(iter_41_0 - 1)

		for iter_41_1 = 1, var_41_3 do
			var_41_2.equipUid[iter_41_1] = var_0_0.EmptyUid
		end

		var_41_0[iter_41_0] = var_41_2
	end

	for iter_41_2, iter_41_3 in pairs(arg_41_0.equipUid2Pos) do
		if not var_0_0.isTrialEquip(iter_41_2) then
			local var_41_4 = arg_41_0.equipUid2Slot[iter_41_2]

			if var_41_4 then
				var_41_0[iter_41_3 + 1].equipUid[var_41_4] = iter_41_2
			end
		end
	end

	return var_41_0
end

function var_0_0.checkResetCurSelected(arg_42_0)
	local var_42_0 = arg_42_0:getEquipMaxCount(arg_42_0.curPos)

	for iter_42_0 = 1, var_42_0 do
		if arg_42_0.curEquipMap[iter_42_0] ~= var_0_0.EmptyUid and not arg_42_0._itemMap[arg_42_0.curEquipMap[iter_42_0]] then
			arg_42_0.curEquipMap[iter_42_0] = var_0_0.EmptyUid
		end
	end
end

function var_0_0.getShowUnlockSlotCount(arg_43_0)
	local var_43_0 = 0

	for iter_43_0 = 0, var_0_0.TotalEquipPos - 1 do
		for iter_43_1 = arg_43_0:getEquipMaxCount(iter_43_0), 1, -1 do
			if Activity104Model.instance:isSeasonPosUnlock(arg_43_0.activityId, arg_43_0.groupIndex, iter_43_1, iter_43_0) then
				var_43_0 = math.max(var_43_0, iter_43_1)
			end
		end
	end

	return var_43_0
end

function var_0_0.getNeedShowDeckCount(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0._deckUidMap[arg_44_1]

	if var_44_0 == nil then
		return false
	end

	local var_44_1 = arg_44_0._itemIdDeckCountMap[var_44_0]

	return var_44_1 > 1, var_44_1
end

function var_0_0.getDelayPlayTime(arg_45_0, arg_45_1)
	if arg_45_1 == nil then
		return -1
	end

	local var_45_0 = arg_45_0.curPos == var_0_0.MainCharPos and SeasonEquipHeroViewContainer.ColumnCount or SeasonEquipItem.ColumnCount
	local var_45_1 = Time.time

	if arg_45_0._itemStartAnimTime == nil then
		arg_45_0._itemStartAnimTime = var_45_1 + SeasonEquipItem.OpenAnimStartTime
	end

	local var_45_2 = arg_45_0:getIndex(arg_45_1)

	if not var_45_2 or var_45_2 > SeasonEquipItem.AnimRowCount * var_45_0 then
		return -1
	end

	local var_45_3 = math.floor((var_45_2 - 1) / var_45_0) * SeasonEquipItem.OpenAnimTime + SeasonEquipItem.OpenAnimStartTime
	local var_45_4 = var_45_1 - arg_45_0._itemStartAnimTime

	if var_45_3 < var_45_4 then
		return -1
	else
		return var_45_3 - var_45_4
	end
end

function var_0_0.flushRecord(arg_46_0)
	if arg_46_0.recordNew then
		arg_46_0.recordNew:recordAllItem()
	end
end

function var_0_0.fiterFightCardDataList(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = {}
	local var_47_1 = {}

	if arg_47_2 then
		local var_47_2 = FightModel.instance:getBattleId()
		local var_47_3 = var_47_2 and lua_battle.configDict[var_47_2]
		local var_47_4 = var_47_3 and var_47_3.playerMax or ModuleEnum.HeroCountInGroup

		for iter_47_0, iter_47_1 in ipairs(arg_47_2) do
			local var_47_5 = iter_47_1.pos

			if var_47_5 < 0 then
				var_47_5 = var_47_4 - var_47_5
			end

			var_47_1[var_47_5] = iter_47_1.trialId
		end
	end

	arg_47_0:_fiterFightCardData(var_0_0.TotalEquipPos, var_47_0, arg_47_1)

	for iter_47_2 = 1, var_0_0.TotalEquipPos - 1 do
		arg_47_0:_fiterFightCardData(iter_47_2, var_47_0, arg_47_1, var_47_1)
	end

	return var_47_0
end

function var_0_0._fiterFightCardData(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = arg_48_1 - 1
	local var_48_1 = arg_48_4 and arg_48_4[arg_48_1]
	local var_48_2 = arg_48_3 and arg_48_3[arg_48_1] and arg_48_3[arg_48_1].heroUid

	if var_48_0 == var_0_0.MainCharPos then
		var_48_2 = nil
	end

	if (not var_48_2 or var_48_2 == var_0_0.EmptyUid) and var_48_0 ~= var_0_0.MainCharPos then
		return
	end

	local var_48_3 = arg_48_0:getEquipMaxCount(var_48_0)
	local var_48_4 = 1

	for iter_48_0 = 1, var_48_3 do
		local var_48_5 = arg_48_3 and arg_48_3[arg_48_1] and arg_48_3[arg_48_1].equipUid and arg_48_3[arg_48_1].equipUid[iter_48_0]
		local var_48_6

		if var_48_5 then
			var_48_6 = Activity104Model.instance:getItemIdByUid(var_48_5)
		end

		if not var_48_6 or var_48_6 == 0 then
			if var_48_1 then
				var_48_6 = HeroConfig.instance:getTrial104Equip(iter_48_0, var_48_1)
			elseif var_48_0 == var_0_0.MainCharPos then
				local var_48_7 = FightModel.instance:getBattleId()
				local var_48_8 = var_48_7 and lua_battle.configDict[var_48_7]

				var_48_6 = var_48_8 and var_48_8.trialMainAct104EuqipId
			end
		end

		if var_48_6 and var_48_6 > 0 then
			local var_48_9 = {
				equipId = var_48_6,
				heroUid = var_48_2,
				trialId = var_48_1,
				count = var_48_4
			}

			var_48_4 = var_48_4 + 1

			table.insert(arg_48_2, var_48_9)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
