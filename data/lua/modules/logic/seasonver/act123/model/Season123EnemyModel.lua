module("modules.logic.seasonver.act123.model.Season123EnemyModel", package.seeall)

slot0 = class("Season123EnemyModel", BaseModel)

function slot0.release(slot0)
	slot0.selectIndex = nil
	slot0.battleIdList = nil
	slot0.stage = nil
	slot0._groupMap = nil
	slot0._monsterGroupMap = nil
	slot0._group2Monsters = nil
	slot0.selectMonsterGroupIndex = nil
	slot0.selectMonsterIndex = nil
	slot0.selectMonsterId = nil
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.activityId = slot1
	slot0.stage = slot2
	slot0.selectIndex = 1
	slot0.battleIdList = uv0.getStageBattleIds(slot1, slot2)

	slot0:initDatas()
	slot0:initSelect(slot3)
end

function slot0.initDatas(slot0)
	slot0._groupMap = {}
	slot0._monsterGroupMap = {}
	slot0._group2Monsters = {}
end

function slot0.initSelect(slot0, slot1)
	if not Season123Config.instance:getSeasonEpisodeStageCos(slot0.activityId, slot0.stage) then
		return nil
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7.layer == slot1 then
			slot0.selectIndex = slot6

			return
		end
	end
end

function slot0.getCurrentBattleGroupIds(slot0)
	if not slot0:getSelectBattleId() then
		return
	end

	if not slot0._groupMap[slot1] then
		if string.nilorempty(lua_battle.configDict[slot1].monsterGroupIds) then
			slot2 = {}
		else
			for slot7, slot8 in ipairs(string.splitToNumber(slot3.monsterGroupIds, "#")) do
				slot9 = lua_monster_group.configDict[slot8]
				slot0._monsterGroupMap[slot8] = slot9

				slot0:initGroup2Monster(slot8, slot9)
			end
		end

		slot0._groupMap[slot1] = slot2
	end

	return slot2
end

function slot0.initGroup2Monster(slot0, slot1, slot2)
	slot3 = {}
	slot5 = string.nilorempty(slot2.spMonster)

	if string.nilorempty(slot2.monster) and slot5 then
		return
	end

	slot3 = slot4 and {} or string.splitToNumber(slot2.monster, "#")

	for slot10, slot11 in ipairs(slot5 and {} or string.splitToNumber(slot2.spMonster, "#")) do
		table.insert(slot3, slot11)
	end

	slot0._group2Monsters[slot1] = slot3
end

function slot0.getMonsterIds(slot0, slot1)
	return slot0._group2Monsters[slot1]
end

function slot0.setSelectIndex(slot0, slot1)
	slot0.selectIndex = slot1

	slot0:getCurrentBattleGroupIds()
end

function slot0.getSelectedIndex(slot0)
	return slot0.selectIndex
end

function slot0.getBattleIds(slot0)
	return slot0.battleIdList
end

function slot0.getSelectBattleId(slot0)
	return slot0.battleIdList[slot0.selectIndex]
end

function slot0.setEnemySelectMonsterId(slot0, slot1, slot2, slot3)
	slot0.selectMonsterGroupIndex = slot1
	slot0.selectMonsterIndex = slot2
	slot0.selectMonsterId = slot3
end

function slot0.getBossId(slot0, slot1)
	if not slot0:getSelectBattleId() then
		return
	end

	slot4 = FightModel.instance:getSelectMonsterGroupId(slot1, slot2) and lua_monster_group.configDict[slot3]

	return slot4 and not string.nilorempty(slot4.bossId) and slot4.bossId or nil
end

function slot0.getStageBattleIds(slot0, slot1)
	if not Season123Config.instance:getSeasonEpisodeStageCos(slot0, slot1) then
		return {}
	end

	for slot7, slot8 in ipairs(slot3) do
		if DungeonConfig.instance:getEpisodeCO(slot8.episodeId) then
			table.insert(slot2, slot9.battleId)
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
