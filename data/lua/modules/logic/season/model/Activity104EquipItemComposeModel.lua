module("modules.logic.season.model.Activity104EquipItemComposeModel", package.seeall)

slot0 = class("Activity104EquipItemComposeModel", ListScrollModel)
slot0.ComposeMaxCount = 3
slot0.EmptyUid = "0"
slot0.MainRoleHeroUid = "main_role"

function slot0.initDatas(slot0, slot1)
	slot0.activityId = slot1
	slot0.curSelectMap = {}
	slot0._curSelectUidPosSet = {}

	for slot5 = 1, uv0.ComposeMaxCount do
		slot0.curSelectMap[slot5] = uv0.EmptyUid
	end

	slot0:initSubModel()
	slot0:initItemMap()
	slot0:initPosList()
	slot0:initList()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0.curSelectMap = nil
	slot0._curSelectUidPosSet = nil
	slot0._itemUid2HeroUid = nil
	slot0._itemMap = nil
	slot0._itemStartAnimTime = nil
	slot0.tagModel = nil
end

function slot0.initSubModel(slot0)
	slot0.tagModel = Activity104EquipTagModel.New()

	slot0.tagModel:init(slot0.activityId)
end

function slot0.initItemMap(slot0)
	slot0._itemMap = Activity104Model.instance:getAllItemMo(slot0.activityId) or {}
end

function slot0.initPosList(slot0)
	slot0._itemUid2HeroUid = {}

	if not Activity104Model.instance:getSeasonAllHeroGroup(slot0.activityId) then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6.activity104Equips then
			slot0:parseHeroGroupEquips(slot6, slot7)
		end
	end
end

function slot0.parseHeroGroupEquips(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot2) do
		slot8 = slot7.index
		slot9 = slot1:getHeroByIndex(slot8 + 1)

		if slot8 == Activity104EquipItemListModel.MainCharPos then
			slot9 = uv0.MainRoleHeroUid
		end

		if slot9 then
			for slot13, slot14 in pairs(slot7.equipUid) do
				if slot14 ~= uv0.EmptyUid and (not slot0._itemUid2HeroUid[slot14] or slot0._itemUid2HeroUid[slot14] == uv0.EmptyUid) and slot0._itemMap[slot14] ~= nil then
					slot0._itemUid2HeroUid[slot14] = slot9
				end
			end
		end
	end
end

function slot0.initList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._itemMap) do
		if not SeasonConfig.instance:getEquipIsOptional(slot6.itemId) and SeasonConfig.instance:getSeasonEquipCo(slot6.itemId) and not SeasonEquipMetaUtils.isBanActivity(slot7, slot0.activityId) and slot7.rare ~= Activity104Enum.MainRoleRare and slot0:isCardCanShowByTag(slot7.tag) then
			slot8 = Activity104EquipComposeMo.New()

			slot8:init(slot6)
			table.insert(slot1, slot8)
		end
	end

	table.sort(slot1, uv0.sortItemMOList)
	slot0:setList(slot1)
end

function slot0.isCardCanShowByTag(slot0, slot1)
	if slot0.tagModel then
		return slot0.tagModel:isCardNeedShow(slot1)
	end

	return true
end

function slot0.sortItemMOList(slot0, slot1)
	if uv0.instance:getEquipedHeroUid(slot0.id) ~= nil ~= (uv0.instance:getEquipedHeroUid(slot1.id) ~= nil) then
		return slot3
	end

	slot5 = SeasonConfig.instance:getSeasonEquipCo(slot1.itemId)

	if SeasonConfig.instance:getSeasonEquipCo(slot0.itemId) ~= nil and slot5 ~= nil then
		if slot4.rare ~= slot5.rare then
			return slot5.rare < slot4.rare
		else
			return slot5.equipId < slot4.equipId
		end
	else
		return slot0.id < slot1.id
	end
end

function slot0.checkResetCurSelected(slot0)
	for slot4 = 1, uv0.ComposeMaxCount do
		if not slot0._itemMap[slot0.curSelectMap[slot4]] then
			slot0.curSelectMap[slot4] = uv0.EmptyUid
		end
	end
end

function slot0.setSelectEquip(slot0, slot1)
	for slot5 = 1, uv0.ComposeMaxCount do
		if uv0.EmptyUid == slot0.curSelectMap[slot5] then
			slot0:selectEquip(slot1, slot5)

			return true
		end
	end

	return false
end

function slot0.selectEquip(slot0, slot1, slot2)
	slot0.curSelectMap[slot2] = slot1
	slot0._curSelectUidPosSet[slot1] = slot2
end

function slot0.getEquipMO(slot0, slot1)
	return slot0._itemMap[slot1]
end

function slot0.unloadEquip(slot0, slot1)
	if slot0._curSelectUidPosSet[slot1] then
		slot0.curSelectMap[slot2] = uv0.EmptyUid
		slot0._curSelectUidPosSet[slot1] = nil
	end
end

function slot0.getEquipedHeroUid(slot0, slot1)
	return slot0._itemUid2HeroUid[slot1]
end

function slot0.isEquipSelected(slot0, slot1)
	return slot0._curSelectUidPosSet[slot1] ~= nil
end

function slot0.existSelectedMaterial(slot0)
	for slot4 = 1, uv0.ComposeMaxCount do
		if slot0.curSelectMap[slot4] ~= uv0.EmptyUid then
			return true
		end
	end

	return false
end

function slot0.getSelectedRare(slot0)
	for slot4 = 1, uv0.ComposeMaxCount do
		if slot0.curSelectMap[slot4] ~= uv0.EmptyUid and SeasonConfig.instance:getSeasonEquipCo(slot0:getEquipMO(slot5).itemId) then
			return slot7.rare
		end
	end
end

function slot0.isMaterialAllReady(slot0)
	for slot4 = 1, uv0.ComposeMaxCount do
		if slot0.curSelectMap[slot4] == uv0.EmptyUid then
			return false
		end
	end

	return true
end

function slot0.getMaterialList(slot0)
	slot1 = {}

	for slot5 = 1, uv0.ComposeMaxCount do
		table.insert(slot1, slot0.curSelectMap[slot5])
	end

	return slot1
end

function slot0.getDelayPlayTime(slot0, slot1)
	if slot1 == nil then
		return -1
	end

	if slot0._itemStartAnimTime == nil then
		slot0._itemStartAnimTime = Time.time + SeasonEquipComposeItem.OpenAnimStartTime
	end

	if not slot0:getIndex(slot1) or slot3 > SeasonEquipComposeItem.AnimRowCount * SeasonEquipComposeItem.ColumnCount then
		return -1
	end

	if math.floor((slot3 - 1) / SeasonEquipComposeItem.ColumnCount) * SeasonEquipComposeItem.OpenAnimTime + SeasonEquipComposeItem.OpenAnimStartTime < slot2 - slot0._itemStartAnimTime then
		return -1
	else
		return slot4 - slot5
	end
end

slot0.instance = slot0.New()

return slot0
