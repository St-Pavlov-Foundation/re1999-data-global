module("modules.logic.dungeon.controller.DungeonHelper", package.seeall)

slot0 = _M

function slot0.getEpisodeRecommendLevel(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeBattleId(slot0) then
		return 0
	end

	return uv0.getBattleRecommendLevel(slot2, slot1)
end

function slot0.getBattleRecommendLevel(slot0, slot1)
	slot2 = slot1 and "levelEasy" or "level"

	if not lua_battle.configDict[slot0] then
		return 0
	end

	slot4 = {}
	slot5 = {}
	slot6, slot7 = nil
	slot12 = slot3.monsterGroupIds

	for slot11, slot12 in ipairs(string.splitToNumber(slot12, "#")) do
		slot16 = "#"

		for slot16, slot17 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot12].monster, slot16)) do
			if uv0.isBossId(lua_monster_group.configDict[slot12].bossId, slot17) then
				table.insert(slot5, slot17)
			else
				table.insert(slot4, slot17)
			end
		end
	end

	if #slot5 > 0 then
		return lua_monster.configDict[slot5[1]][slot2]
	elseif #slot4 > 0 then
		for slot12, slot13 in ipairs(slot4) do
			slot8 = 0 + lua_monster.configDict[slot13][slot2]
		end

		return math.ceil(slot8 / #slot4)
	else
		return 0
	end
end

function slot0.isBossId(slot0, slot1)
	for slot6, slot7 in ipairs(string.splitToNumber(slot0, "#")) do
		if slot1 == slot7 then
			return true
		end
	end
end

return slot0
