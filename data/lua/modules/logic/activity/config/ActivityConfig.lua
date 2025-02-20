module("modules.logic.activity.config.ActivityConfig", package.seeall)

slot0 = class("ActivityConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._activityConfig = nil
	slot0._activityCenterConfig = nil
	slot0._norSignConfig = nil
	slot0._activityDungeonConfig = nil
	slot0._activityShowConfig = nil
	slot0.chapterId2ActId = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity",
		"activity_center",
		"activity101",
		"activity_dungeon",
		"activity_show",
		"main_act_extra_display",
		"main_act_atmosphere"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity" then
		slot0._activityConfig = slot2
	elseif slot1 == "activity_center" then
		slot0._activityCenterConfig = slot2
	elseif slot1 == "activity101" then
		slot0._norSignConfig = slot2
	elseif slot1 == "activity_dungeon" then
		slot0._activityDungeonConfig = slot2

		slot0:initActivityDungeon()
	elseif slot1 == "activity_show" then
		slot0._activityShowConfig = slot2
	elseif slot1 == "main_act_extra_display" then
		slot0:_initMainActExtraDisplay()
	elseif slot1 == "main_act_atmosphere" then
		slot0:_initMainActAtmosphere()
	end
end

function slot0._initMainActAtmosphere(slot0)
	slot0._mainActAtmosphereConfig = lua_main_act_atmosphere.configList[#lua_main_act_atmosphere.configList]
end

function slot0.getMainActAtmosphereConfig(slot0)
	return slot0._mainActAtmosphereConfig
end

function slot0._initMainActExtraDisplay(slot0)
	slot0._mainActExtraDisplayList = {}

	for slot4, slot5 in ipairs(lua_main_act_extra_display.configList) do
		if slot5.show == 1 then
			table.insert(slot0._mainActExtraDisplayList, slot5)
		end
	end

	table.sort(slot0._mainActExtraDisplayList, function (slot0, slot1)
		if slot0.sortId == slot1.sortId then
			return slot0.id < slot1.id
		end

		return slot0.sortId < slot1.sortId
	end)

	if not slot0._activityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay activityConfig is nil")

		return
	end

	slot0._seasonActivityConfig = nil
	slot0._rougeActivityConfig = nil

	for slot4 = #lua_activity.configList, 1, -1 do
		if lua_activity.configList[slot4].extraDisplayId == ActivityEnum.MainViewActivityState.SeasonActivity and not slot0._seasonActivityConfig then
			slot0._seasonActivityConfig = slot5
		elseif slot5.extraDisplayId == ActivityEnum.MainViewActivityState.Rouge and not slot0._rougeActivityConfig then
			slot0._rougeActivityConfig = slot5
		end

		if slot0._seasonActivityConfig and slot0._rougeActivityConfig then
			break
		end
	end

	if not slot0._seasonActivityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay seasonActivityConfig is nil")

		return
	end

	if not slot0._rougeActivityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay rougeActivityConfig is nil")

		return
	end
end

function slot0.getSesonActivityConfig(slot0)
	return slot0._seasonActivityConfig
end

function slot0.getRougeActivityConfig(slot0)
	return slot0._rougeActivityConfig
end

function slot0.getMainActExtraDisplayList(slot0)
	return slot0._mainActExtraDisplayList
end

function slot0.getActivityCo(slot0, slot1)
	if not slot0._activityConfig.configDict[slot1] then
		logError("前端活动配置表不存在活动:" .. tostring(slot1))
	end

	return slot0._activityConfig.configDict[slot1]
end

function slot0.getActivityCenterCo(slot0, slot1)
	if not slot0._activityCenterConfig.configDict[slot1] then
		logError("前端活动配置表不存在活动中心:" .. tostring(slot1))
	end

	return slot0._activityCenterConfig.configDict[slot1]
end

function slot0.getNorSignActivityCo(slot0, slot1, slot2)
	return slot0._norSignConfig.configDict[slot1][slot2]
end

function slot0.getNorSignActivityCos(slot0, slot1)
	return slot0._norSignConfig.configDict[slot1]
end

function slot0.initActivityDungeon(slot0)
	for slot4, slot5 in ipairs(slot0._activityDungeonConfig.configList) do
		slot0:addChapterId2ActId(slot5.story1ChapterId, slot5.id)
		slot0:addChapterId2ActId(slot5.story2ChapterId, slot5.id)
		slot0:addChapterId2ActId(slot5.story3ChapterId, slot5.id)
		slot0:addChapterId2ActId(slot5.hardChapterId, slot5.id)
	end
end

function slot0.addChapterId2ActId(slot0, slot1, slot2)
	if slot1 == 0 then
		return
	end

	if slot0.chapterId2ActId[slot1] then
		logError(string.format("chapterId : %s multiple, exist actId : %s, current actId : %s", slot1, slot0.chapterId2ActId[slot1], slot2))

		return
	end

	slot0.chapterId2ActId[slot1] = slot2
end

function slot0.getActIdByChapterId(slot0, slot1)
	return slot0.chapterId2ActId[slot1]
end

function slot0.getActivityDungeonConfig(slot0, slot1)
	return slot0._activityDungeonConfig.configDict[slot1]
end

function slot0.getChapterIdMode(slot0, slot1)
	if not slot0:getActIdByChapterId(slot1) then
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end

	if slot1 == slot0:getActivityDungeonConfig(slot2).story1ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif slot1 == slot3.story2ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif slot1 == slot3.story3ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif slot1 == slot3.hardChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Hard
	else
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end
end

function slot0.getActivityShowTaskList(slot0, slot1, slot2)
	return slot0._activityShowConfig.configDict[slot1][slot2]
end

function slot0.getActivityShowTaskCount(slot0, slot1)
	return slot0._activityShowConfig.configDict[slot1]
end

function slot0.getActivityTabBgPathes(slot0, slot1)
	return string.split(slot0:getActivityCo(slot1).tabBgPath, "#")
end

function slot0.getActivityTabButtonState(slot0, slot1)
	return string.splitToNumber(slot0:getActivityCo(slot1).tabButton, "#") and slot4[1] == 1, slot4 and slot4[2] == 1, slot4 and slot4[3] == 1
end

function slot0.getActivityEnterViewBgm(slot0, slot1)
	return slot0:getActivityCo(slot1).tabBgmId
end

function slot0.isPermanent(slot0, slot1)
	return slot0:getActivityCo(slot1).isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function slot0.getPermanentChildActList(slot0, slot1)
	slot2 = {}

	if not slot0._belongPermanentActDict then
		slot0:_initBelongPermanentActDict()
	end

	return slot0._belongPermanentActDict[slot1] or slot2
end

function slot0._initBelongPermanentActDict(slot0)
	slot0._belongPermanentActDict = {}

	for slot4, slot5 in pairs(slot0._activityConfig.configDict) do
		if slot0:isPermanent(slot4) and slot5.permanentParentAcitivityId ~= 0 then
			if not slot0._belongPermanentActDict[slot6] then
				slot0._belongPermanentActDict[slot6] = {}
			end

			table.insert(slot7, slot4)
		end
	end
end

function slot0.getActivityRedDotId(slot0, slot1)
	return slot0:getActivityCo(slot1) and slot2.redDotId or 0
end

function slot0.getActivityCenterRedDotId(slot0, slot1)
	return slot0:getActivityCenterCo(slot1) and slot2.reddotid or 0
end

slot0.instance = slot0.New()

return slot0
