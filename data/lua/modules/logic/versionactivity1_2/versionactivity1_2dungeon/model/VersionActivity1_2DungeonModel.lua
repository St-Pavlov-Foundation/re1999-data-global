module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.model.VersionActivity1_2DungeonModel", package.seeall)

slot0 = class("VersionActivity1_2DungeonModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getTrapPutting(slot0)
	return slot0.putTrap ~= 0 and slot0.putTrap
end

function slot0.onReceiveGet116InfosReply(slot0, slot1)
	slot0._activity_id = slot1.activityId
	slot0.element_data = {}

	for slot5, slot6 in ipairs(slot1.infos) do
		slot0.element_data[slot6.elementId] = {
			elementId = slot6.elementId,
			level = slot6.level
		}
	end

	slot0.trapIds = {}

	for slot5, slot6 in ipairs(slot1.trapIds) do
		slot0.trapIds[slot6] = slot6
	end

	slot0.putTrap = slot1.putTrap
	slot0.spStatus = {}

	for slot5, slot6 in ipairs(slot1.spStatus) do
		slot0.spStatus[slot6.episodeId] = {
			episodeId = slot6.episodeId,
			chapterId = slot6.chapterId,
			status = slot6.status,
			refreshTime = slot6.refreshTime
		}
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet116InfosReply)
end

function slot0.getSpStatus(slot0, slot1)
	return slot0.spStatus and slot0.spStatus[slot1]
end

function slot0.onReceiveAct116InfoUpdatePush(slot0, slot1)
	slot0.newSp = {}

	for slot5, slot6 in ipairs(slot1.spStatus) do
		if slot0.spStatus then
			if slot6.status == 1 and slot0.spStatus[slot6.episodeId].status ~= 1 then
				slot0.newSp[slot6.episodeId] = true
			end
		else
			slot0.newSp[slot6.episodeId] = true
		end
	end

	slot0:onReceiveGet116InfosReply(slot1)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveAct116InfoUpdatePush)
end

function slot0.onReceiveUpgradeElementReply(slot0, slot1)
	slot0.element_data = slot0.element_data or {}
	slot0.element_data[slot1.elementId] = {
		elementId = slot1.elementId,
		level = slot1.level
	}

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, slot1.elementId)
end

function slot0.getElementData(slot0, slot1)
	return slot0.element_data and slot0.element_data[slot1]
end

function slot0.onReceiveBuildTrapReply(slot0, slot1)
	slot0.trapIds = slot0.trapIds or {}
	slot0.trapIds[slot1.trapId] = slot1.trapId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveBuildTrapReply, slot1.trapId)
end

function slot0.onReceivePutTrapReply(slot0, slot1)
	slot0.putTrap = slot1.trapId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceivePutTrapReply)
end

function slot0.getCurActivityID(slot0)
	return slot0._activity_id or VersionActivity1_2Enum.ActivityId.Dungeon
end

function slot0.getAttrUpDic(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.element_data) do
		if slot6.level > 0 then
			for slot11, slot12 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot6.elementId)) do
				if slot12.level == slot6.level then
					table.insert(slot1, slot12)

					break
				end
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot7.buildingType == 2 then
			for slot12, slot13 in ipairs(string.split(slot7.configType, "|")) do
				slot14 = string.splitToNumber(slot13, "#")
				slot2[slot15] = (slot2[slot14[1]] or 0) + slot14[2]
			end
		end
	end

	return slot2
end

function slot0.getBuildingGainList(slot0)
	slot1 = {}

	if slot0.element_data then
		for slot5, slot6 in pairs(slot0.element_data) do
			if slot6.level > 0 then
				for slot11, slot12 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot6.elementId)) do
					if (slot12.buildingType == 2 or slot12.buildingType == 3) and slot12.level == slot6.level then
						table.insert(slot1, slot12)

						break
					end
				end
			end
		end
	end

	if slot0.putTrap ~= 0 then
		table.insert(slot1, lua_activity116_building.configDict[slot0.putTrap])
	end

	return slot1
end

function slot0.haveNextLevel(slot0, slot1)
	if not slot0:getElementData(slot1) then
		return true
	end

	slot3 = {}
	slot7 = slot1

	for slot7, slot8 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot7)) do
		table.insert(slot3, slot8)
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.level < slot1.level
	end)

	return slot3[slot2.level + 2]
end

function slot0.getDailyEpisodeConfigByElementId(slot0, slot1)
	if lua_chapter_map_element.configDict[slot1].type == DungeonEnum.ElementType.DailyEpisode then
		slot4 = nil

		if VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot2.id) then
			for slot8, slot9 in pairs(slot3) do
				slot4 = slot9

				break
			end
		end

		if slot4 then
			for slot9, slot10 in ipairs(string.splitToNumber(slot4.configType, "#")) do
				if uv0.instance:getSpStatus(slot10) and slot11.status == 1 then
					return DungeonConfig.instance:getEpisodeCO(slot10)
				end
			end
		end
	end
end

function slot0.jump2DailyEpisode(slot0, slot1)
	if string.splitToNumber(JumpConfig.instance:getJumpConfig(slot1).param, "#")[1] == 100 and slot3[2] == JumpEnum.ActIdEnum.Act1_2Dungeon and slot3[3] == JumpEnum.Activity1_2DungeonJump.Jump2Daily then
		if VersionActivity1_2DungeonConfig.instance:getConfigByEpisodeId(slot3[4]) then
			if not DungeonMapModel.instance:getElementById(slot5.elementId) then
				slot9 = string.splitToNumber(lua_chapter_map_element.configDict[slot6].condition, "=")[2]

				GameFacade.showToastString(string.format(luaLang("dungeon_unlock_episode_mode"), luaLang("dungeon_story_mode") .. DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot9).chapterId).chapterIndex .. "-" .. VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(slot9)))
			elseif slot0:getDailyEpisodeConfigByElementId(slot6) then
				if slot8.id == slot4 then
					ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
					VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, slot6)
				else
					GameFacade.showMessageBox(MessageBoxIdDefine.Dungeon1_2Jump2Daily, MsgBoxEnum.BoxType.Yes_No, function ()
						ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
						VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, uv0)
					end)
				end
			else
				for slot12, slot13 in ipairs(VersionActivity1_2DungeonConfig.instance:getType4List()) do
					if slot0:getDailyEpisodeConfigByElementId(slot13.elementId) then
						GameFacade.showMessageBox(MessageBoxIdDefine.Dungeon1_2Jump2Daily, MsgBoxEnum.BoxType.Yes_No, function ()
							ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
							VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, uv0.elementId)
						end)

						return true
					end
				end

				GameFacade.showToast(ToastEnum.Dungeon1_2CanNotJump2Daily)
			end
		end

		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
