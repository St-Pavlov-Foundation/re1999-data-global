module("modules.logic.versionactivity1_8.dungeon.config.Activity157Config", package.seeall)

slot0 = class("Activity157Config", BaseConfig)

function slot1(slot0, slot1)
	return slot0 < slot1
end

function slot0.reqConfigNames(slot0)
	return {
		"activity157_const",
		"activity157_factory_component",
		"activity157_mission",
		"activity157_mission_group",
		"activity157_repair_map"
	}
end

function slot0.onInit(slot0)
	slot0.actId2MissionGroupDict = {}
	slot0.actId2ElementDict = {}
	slot0.actId2missionGroupTree = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity157_mission" then
		slot0:initMissionCfg(slot2)
	end
end

function slot0.initMissionCfg(slot0, slot1)
	slot0.actId2MissionGroupDict = {}
	slot0.actId2ElementDict = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		if not slot0.actId2MissionGroupDict[slot5] then
			slot0.actId2MissionGroupDict[slot5] = {}
		end

		if not slot0.actId2ElementDict[slot5] then
			slot0.actId2ElementDict[slot5] = {}
		end

		slot9 = {}

		for slot13, slot14 in pairs(slot6) do
			if not slot7[slot14.groupId] then
				slot7[slot15] = {}
			end

			slot8[slot14.elementId] = slot13
			slot9[slot13] = slot14.order
			slot16[#slot16 + 1] = slot13
		end

		for slot13, slot14 in pairs(slot7) do
			table.sort(slot14, function (slot0, slot1)
				if (uv0[slot0] or 0) ~= (uv0[slot1] or 0) then
					return slot2 < slot3
				end

				return slot0 < slot1
			end)
		end
	end
end

function slot0.initMissionGroupTree(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.actId2missionGroupTree[slot1] = {}

	for slot7, slot8 in ipairs(slot0:getAllMissionGroupIdList(slot1)) do
		slot2[slot8] = {}

		for slot14, slot15 in ipairs(slot0:getAct157MissionList(slot1, slot8)) do
			slot16 = nil
			slot18 = slot0:getMissionElementId(slot1, slot15) and DungeonConfig.instance:getChapterMapElement(slot17)

			if not string.nilorempty(slot18 and slot18.condition) then
				slot20, slot21 = string.match(slot19, "(ChapterMapElement=)(%d+)")
				slot16 = slot0:getMissionIdByElementId(slot1, slot21 and tonumber(slot21))
			end

			slot9[slot15] = slot16
		end
	end
end

function slot2(slot0, slot1, slot2)
	slot3 = nil

	if slot0 and slot1 then
		slot3 = lua_activity157_const.configDict[slot0] and slot4[slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("Activity157Config:getAct157ConstCfg error, cfg is nil, actId:%s  id:%s", slot0, slot1))
	end

	return slot3
end

function slot0.getAct157Const(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.value
	end

	return slot3
end

function slot0.getAct157FactoryProductCapacity(slot0, slot1, slot2)
	slot3 = 0
	slot5 = slot0:getAct157Const(slot1, slot2) and string.splitToNumber(slot4, "#")
	slot7 = slot5 and slot5[2]

	if slot5 and slot5[1] and slot7 then
		slot3 = slot6 * slot7
	end

	return slot3
end

function slot0.getAct157CompositeFormula(slot0, slot1)
	slot2 = {}

	return ItemModel.instance:getItemDataListByConfigStr(slot0:getAct157Const(slot1, Activity157Enum.ConstId.FactoryCompositeFormula))
end

function slot3(slot0, slot1, slot2)
	slot3 = nil
	slot1 = tonumber(slot1)

	if slot0 and slot1 then
		slot3 = lua_activity157_factory_component.configDict[slot0] and slot4[slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("Activity157Config:getAct157FactoryComponentCfg error, cfg is nil, actId:%s  id:%s", slot0, slot1))
	end

	return slot3
end

function slot0.getComponentUnlockCondition(slot0, slot1, slot2)
	slot3, slot4, slot5 = nil

	if uv0(slot1, slot2, true) then
		slot8 = string.splitToNumber(slot6.unlockCondition, "#")
		slot3 = slot8[1]
		slot4 = slot8[2]
		slot5 = slot8[3]
	end

	return slot3, slot4, slot5
end

function slot0.getPreComponentId(slot0, slot1, slot2)
	slot3 = 0

	if uv0(slot1, slot2, true) then
		slot3 = slot4.preComponentId
	end

	return slot3
end

function slot0.getComponentReward(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.bonusForShow
	end

	return slot3
end

function slot0.getComponentBonusBuildingLevel(slot0, slot1, slot2)
	slot3 = 1

	if uv0(slot1, slot2, true) then
		slot3 = tonumber(slot4.bonusBuildingLevel)
	end

	return slot3
end

function slot0.getComponentIdList(slot0, slot1)
	slot2 = {}

	if lua_activity157_factory_component then
		for slot7, slot8 in pairs(lua_activity157_factory_component.configDict[slot1]) do
			slot2[#slot2 + 1] = slot7
		end
	end

	table.sort(slot2, uv0)

	return slot2
end

function slot4(slot0, slot1, slot2)
	slot3 = nil

	if slot0 and slot1 then
		slot3 = lua_activity157_repair_map.configDict[slot0] and slot4[slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("Activity157Config:getAct157RepairMapCfg error, cfg is nil, actId:%s  id:%s", slot0, slot1))
	end

	return slot3
end

function slot0.getAct157RepairMapTitleTip(slot0, slot1, slot2)
	slot3 = ""

	if uv0(slot1, slot2, true) then
		slot3 = slot4.titleTip
	end

	return slot3
end

function slot0.getAct157RepairMapTilebase(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.tilebase
	end

	return slot3
end

function slot0.getAct157RepairMapObjects(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.objects
	end

	return slot3
end

function slot5(slot0, slot1, slot2)
	slot3 = nil

	if slot0 and slot1 then
		slot3 = lua_activity157_mission_group.configDict[slot0] and slot4[slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("Activity157Config:getAct157MissionGroupCfg error, cfg is nil, actId:%s  id:%s", slot0, slot1))
	end

	return slot3
end

function slot0.getMissionGroupType(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.type
	end

	return slot3
end

function slot0.getAllMissionGroupIdList(slot0, slot1)
	slot2 = {}
	slot3 = nil

	if slot1 then
		slot3 = lua_activity157_mission_group.configDict[slot1]
	end

	if slot3 then
		for slot7, slot8 in pairs(slot3) do
			slot2[#slot2 + 1] = slot7
		end
	else
		logError(string.format("Activity157Config:getAllMissionGroupIdList error, cfg is nil, actId:%s ", slot1))
	end

	table.sort(slot2, uv0)

	return slot2
end

function slot0.getRootMissionId(slot0, slot1, slot2)
	slot3 = nil

	if slot0.actId2MissionGroupDict[slot1] and slot2 and slot4[slot2] then
		slot3 = slot5[1]
	end

	return slot3
end

function slot0.getAct157MissionList(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return {}
	end

	if slot0.actId2MissionGroupDict[slot1] then
		for slot9, slot10 in ipairs(slot4[slot2] or {}) do
			slot3[#slot3 + 1] = slot10
		end
	end

	return slot3
end

function slot0.isSideMissionGroup(slot0, slot1, slot2)
	slot3 = true

	if slot0:getMissionGroupType(slot1, slot2) then
		slot3 = slot4 == Activity157Enum.MissionType.SideMission
	end

	return slot3
end

function slot0.getLeafMission(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return {}
	end

	if slot0.actId2MissionGroupDict[slot1] and slot2 then
		for slot9, slot10 in ipairs(slot4[slot2] or {}) do
			if not slot0:getAct157ChildMissionList(slot1, slot10) or #slot11 <= 0 then
				slot3[#slot3] = slot10
			end
		end
	end

	return slot3
end

function slot0.getMapName(slot0, slot1, slot2)
	slot3 = ""

	if uv0(slot1, slot2, true) then
		slot3 = slot4.mapName
	end

	return slot3
end

function slot6(slot0, slot1, slot2)
	slot3 = nil

	if slot0 and slot1 then
		slot3 = lua_activity157_mission.configDict[slot0] and slot4[slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("Activity157Config:getAct157MissionCfg error, cfg is nil, actId:%s  id:%s", slot0, slot1))
	end

	return slot3
end

function slot0.getAct157MissionPos(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = string.splitToNumber(slot4.pos, "#")
	end

	return slot3
end

function slot0.getAct157MissionOrder(slot0, slot1, slot2)
	slot3 = 0

	if uv0(slot1, slot2, true) then
		slot3 = slot4.order
	end

	return slot3
end

function slot0.getMissionElementId(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.elementId
	end

	return slot3
end

function slot0.getAct157MissionStoryId(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.storyId
	end

	return slot3
end

function slot0.getMissionGroup(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.groupId
	end

	return slot3
end

function slot0.isRootMission(slot0, slot1, slot2)
	slot3 = false

	if slot2 then
		slot3 = slot2 == slot0:getRootMissionId(slot1, slot0:getMissionGroup(slot1, slot2))
	end

	return slot3
end

function slot0.isSideMission(slot0, slot1, slot2)
	return slot0:isSideMissionGroup(slot1, slot0:getMissionGroup(slot1, slot2))
end

function slot0.getLineResPath(slot0, slot1, slot2)
	slot3 = ""

	if uv0(slot1, slot2, true) and not string.nilorempty(slot4.linePrefab) then
		slot3 = string.format("%s_mapline", slot5)
	end

	return slot3
end

function slot0.getMissionIdByElementId(slot0, slot1, slot2)
	slot3 = nil

	if slot1 and slot2 then
		slot3 = (slot0.actId2ElementDict[slot1] or {})[slot2]
	end

	return slot3
end

function slot0.getAct157ParentMissionId(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return nil
	end

	if not slot0.actId2missionGroupTree or not slot0.actId2missionGroupTree[slot1] then
		slot0:initMissionGroupTree(slot1)
	end

	if slot0:getMissionGroup(slot1, slot2) then
		slot3 = (slot0.actId2missionGroupTree[slot1][slot5] or {})[slot2]
	end

	return slot3
end

function slot0.getAct157ChildMissionList(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return {}
	end

	if not slot0.actId2missionGroupTree or not slot0.actId2missionGroupTree[slot1] then
		slot0:initMissionGroupTree(slot1)
	end

	if slot0:getMissionGroup(slot1, slot2) then
		for slot10, slot11 in pairs(slot0.actId2missionGroupTree[slot1][slot5] or {}) do
			if slot11 == slot2 then
				slot3[#slot3 + 1] = slot10
			end
		end
	end

	return slot3
end

function slot0.getMissionArea(slot0, slot1, slot2)
	slot3 = ""

	if uv0(slot1, slot2, true) then
		slot3 = slot4.area
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
