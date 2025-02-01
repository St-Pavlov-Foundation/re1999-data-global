module("modules.logic.fight.view.preview.SkillEditorToolAutoPlaySkillModel", package.seeall)

slot0 = class("SkillEditorToolAutoPlaySkillModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._selectList = {}
end

function slot0.setSelect(slot0, slot1)
	slot0:_buildCOList()

	slot2 = {}

	for slot6, slot7 in pairs(slot0._dataList) do
		if slot6 ~= SkillEditorMgr.SelectType.Group then
			for slot11, slot12 in ipairs(slot7) do
				if string.find(tostring(slot12.id), slot1) or string.find(tostring(slot12.skinId), slot1) or string.find(slot12.name or "", slot1) or string.find(FightConfig.instance:getSkinCO(slot12.skinId) and FightConfig.instance:getSkinCO(slot12.skinId).name or "", slot1) then
					table.insert(slot2, {
						co = slot12,
						type = slot6,
						skinId = slot12.skinId
					})
				end
			end
		else
			for slot11, slot12 in ipairs(slot7) do
				slot0:_cacheGroupNames()

				if slot0._groupId2NameDict[slot12.id] and string.find(slot13, slot1) then
					table.insert(slot2, {
						co = slot12,
						type = slot6,
						skinId = slot12.skinId
					})
				end
			end
		end
	end

	slot0:setList(slot2)
end

function slot0._buildCOList(slot0)
	slot0._dataList = {}
	slot0._dataList[SkillEditorMgr.SelectType.Hero] = slot0._dataList[SkillEditorMgr.SelectType.Hero] or {}

	tabletool.addValues(slot0._dataList[SkillEditorMgr.SelectType.Hero], lua_character.configList)

	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(lua_monster.configList) do
		if not slot1[slot7.skinId] then
			slot1[slot7.skinId] = true

			table.insert(slot2, slot7)
		end
	end

	slot0._dataList[SkillEditorMgr.SelectType.Monster] = slot0._dataList[SkillEditorMgr.SelectType.Monster] or {}
	slot0._dataList[SkillEditorMgr.SelectType.Group] = slot0._dataList[SkillEditorMgr.SelectType.Group] or {}

	tabletool.addValues(slot0._dataList[SkillEditorMgr.SelectType.Monster], slot2)
	tabletool.addValues(slot0._dataList[SkillEditorMgr.SelectType.Group], lua_monster_group.configList)
	slot0:_cacheGroupNames()
end

function slot0._cacheGroupNames(slot0)
	if slot0._groupId2NameDict then
		return
	end

	slot0._groupId2NameDict = {}

	for slot4, slot5 in ipairs(lua_monster_group.configList) do
		slot6 = string.splitToNumber(slot5.monster, "#")
		slot7 = lua_monster.configDict[slot6[1]]

		for slot11 = 2, #slot6 do
			if tabletool.indexOf(string.splitToNumber(slot5.bossId, "#"), slot6[slot11]) then
				slot7 = lua_monster.configDict[slot6[slot11]]

				break
			end
		end

		slot0._groupId2NameDict[slot5.id] = slot7 and slot7.name
	end
end

function slot0.addSelect(slot0, slot1)
	if tabletool.indexOf(slot0._selectList, slot1) then
		slot0._list[slot2] = slot1
	else
		table.insert(slot0._selectList, slot1)
	end
end

function slot0.removeSelect(slot0, slot1)
	tabletool.removeValue(slot0._selectList, slot1)
end

function slot0.getSelectList(slot0)
	return slot0._selectList
end

slot0.instance = slot0.New()

return slot0
