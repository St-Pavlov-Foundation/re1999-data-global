module("modules.logic.fight.view.preview.SkillEditorHeroSelectModel", package.seeall)

slot0 = class("SkillEditorHeroSelectModel", ListScrollModel)

function slot0.setSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.side = slot1
	slot0.selectType = slot2
	slot0.stancePosId = slot3
	slot6 = {}

	for slot10, slot11 in ipairs(slot0:_getCOList()) do
		if string.find(tostring(slot11.id), slot4) or string.find(tostring(slot11.skinId), slot4) or string.find(slot11.name or "", slot4) or string.find(FightConfig.instance:getSkinCO(slot11.skinId) and FightConfig.instance:getSkinCO(slot11.skinId).name or "", slot4) then
			table.insert(slot6, {
				id = slot10,
				co = slot11
			})
		elseif slot0.selectType == SkillEditorMgr.SelectType.Group then
			slot0:_cacheGroupNames()

			if slot0._groupId2NameDict[slot11.id] and string.find(slot12, slot4) then
				table.insert(slot6, {
					id = slot10,
					co = slot11
				})
			end
		end
	end

	slot0:setList(slot6)
end

function slot0._getCOList(slot0)
	if slot0.selectType == SkillEditorMgr.SelectType.Hero then
		return lua_character.configList
	elseif slot0.selectType == SkillEditorMgr.SelectType.SubHero then
		return lua_character.configList
	elseif slot0.selectType == SkillEditorMgr.SelectType.Monster then
		slot1 = {}
		slot2 = {}

		for slot6, slot7 in ipairs(lua_monster.configList) do
			if not slot1[slot7.skinId] then
				slot1[slot7.skinId] = {}
			end

			if not string.nilorempty(slot7.activeSkill) then
				table.insert(slot1[slot7.skinId], 1, slot7)
			else
				table.insert(slot1[slot7.skinId], slot7)
			end
		end

		for slot6, slot7 in pairs(slot1) do
			table.insert(slot2, slot7[1])
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.skinId < slot1.skinId
		end)

		return slot2
	elseif slot0.selectType == SkillEditorMgr.SelectType.Group then
		slot0:_cacheGroupNames()

		return lua_monster_group.configList
	end
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

slot0.instance = slot0.New()

return slot0
