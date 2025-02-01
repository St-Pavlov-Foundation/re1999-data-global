module("modules.logic.battlepass.config.BpConfig", package.seeall)

slot0 = class("BpConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._taskBpId2List = {}
	slot0._taskBpId2Dict = {}
	slot0._bonusBpId2List = {}
	slot0._desDict = {}
	slot0._skinDict = {}
	slot0._headDict = {}
	slot0.taskPreposeIds = {}
	slot0._newItems = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"bp",
		"bp_lv_bonus",
		"bp_task",
		"bp_des"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "bp_task" then
		for slot6, slot7 in ipairs(slot2.configList) do
			slot9 = slot7.loopType
			slot0._taskBpId2List[slot8] = slot0._taskBpId2List[slot7.bpId] or {}
			slot0._taskBpId2Dict[slot8] = slot0._taskBpId2Dict[slot8] or {}

			table.insert(slot0._taskBpId2List[slot8], slot7)

			slot0._taskBpId2Dict[slot8][slot9] = slot0._taskBpId2Dict[slot8][slot9] or {}

			table.insert(slot0._taskBpId2Dict[slot8][slot9], slot7)

			if not string.nilorempty(slot7.prepose) then
				for slot15, slot16 in pairs(string.splitToNumber(slot7.prepose, "#")) do
					-- Nothing
				end

				slot0.taskPreposeIds[slot7.id] = {
					[slot16] = true
				}
			end
		end

		slot3 = nil

		function slot3(slot0, slot1, slot2)
			if slot0 == slot2 then
				return
			end

			slot1[slot2] = true

			if not uv0.taskPreposeIds[slot2] then
				return
			end

			for slot7 in pairs(slot3) do
				if not slot1[slot7] then
					uv1(slot0, slot1, slot7)
				end
			end
		end

		for slot7, slot8 in pairs(slot0.taskPreposeIds) do
			for slot12 in pairs(slot8) do
				slot3(slot7, slot8, slot12)
			end
		end

		return
	end

	if slot1 == "bp_lv_bonus" then
		for slot6, slot7 in ipairs(slot2.configList) do
			slot0._bonusBpId2List[slot8] = slot0._bonusBpId2List[slot7.bpId] or {}

			table.insert(slot0._bonusBpId2List[slot8], slot7)
			slot0:_processBonus(slot8, slot7.freeBonus)
			slot0:_processBonus(slot8, slot7.payBonus)
		end
	elseif slot1 == "bp_des" then
		for slot6, slot7 in ipairs(slot2.configList) do
			slot9 = slot7.type
			slot0._desDict[slot8] = slot0._desDict[slot7.bpId] or {}
			slot0._desDict[slot8][slot9] = slot0._desDict[slot8][slot9] or {}

			table.insert(slot0._desDict[slot8][slot9], slot7)
			slot0:_processBonus(slot8, slot7.items)
		end
	end
end

function slot0._processBonus(slot0, slot1, slot2)
	if string.nilorempty(slot2) then
		return
	end

	slot0._newItems[slot1] = slot0._newItems[slot1] or {}

	for slot7, slot8 in pairs(GameUtil.splitString2(slot2, true)) do
		if slot8[1] == MaterialEnum.MaterialType.HeroSkin then
			slot0._skinDict[slot1] = slot8[2]
		elseif slot8[1] == MaterialEnum.MaterialType.Item and lua_item.configDict[slot8[2]].subType == ItemEnum.SubType.Portrait then
			slot0._headDict[slot1] = slot8[2]
		end

		if slot8[5] == 1 then
			table.insert(slot0._newItems[slot1], slot8)
		end
	end
end

function slot0.getNewItems(slot0, slot1)
	return slot0._newItems[slot1] or {}
end

function slot0.getBpCO(slot0, slot1)
	return lua_bp.configDict[slot1]
end

function slot0.getTaskCO(slot0, slot1)
	return lua_bp_task.configDict[slot1]
end

function slot0.getTaskCOList(slot0, slot1)
	return slot0._taskBpId2List[slot1]
end

function slot0.getDesConfig(slot0, slot1, slot2)
	if not slot0._desDict[slot1] then
		return {}
	end

	return slot0._desDict[slot1][slot2]
end

function slot0.getCurSkinId(slot0, slot1)
	if not slot0._skinDict[slot1] then
		return 301703
	end

	return slot0._skinDict[slot1]
end

function slot0.getBpSkinBonusId(slot0, slot1)
	return slot0._skinDict[slot1]
end

function slot0.getCurHeadItemName(slot0, slot1)
	if not slot0._headDict[slot1] then
		return ""
	end

	slot2 = slot0._headDict[slot1]

	return lua_item.configDict[slot2].name, slot2
end

function slot0.getTaskCOListByLoopType(slot0, slot1, slot2)
	if slot0._taskBpId2Dict[slot1] then
		return slot3[slot2]
	end
end

function slot0.getBonusCO(slot0, slot1, slot2)
	if lua_bp_lv_bonus.configDict[slot1] then
		return slot3[slot2]
	end
end

function slot0.getBonusCOList(slot0, slot1)
	return slot0._bonusBpId2List[slot1]
end

function slot0.getLevelScore(slot0, slot1)
	if not slot0:getBpCO(slot1) then
		return 1000
	end

	return slot2.expLevelUp
end

function slot0.getItemShowSize(slot0, slot1, slot2)
	if not slot0._itemSizeCo then
		slot0._itemSizeCo = {}

		if not string.nilorempty(lua_const.configDict[ConstEnum.BpItemSize] and slot3.value) then
			for slot9, slot10 in pairs(GameUtil.splitString2(slot4, true)) do
				if not slot0._itemSizeCo[slot10[1]] then
					slot0._itemSizeCo[slot10[1]] = {}
				end

				slot0._itemSizeCo[slot10[1]][slot10[2]] = {
					itemSize = slot10[3],
					x = slot10[4],
					y = slot10[5]
				}
			end
		end
	end

	if slot0._itemSizeCo[slot1] and slot0._itemSizeCo[slot1][slot2] then
		return slot3.itemSize, slot3.x, slot3.y
	end

	return 1.2
end

slot0.instance = slot0.New()

return slot0
