module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5BuildModel", package.seeall)

slot0 = class("VersionActivity1_5BuildModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initBuildInfoList(slot0, slot1)
	slot0.selectBuildList = {}
	slot0.selectTypeList = {
		0,
		0,
		0
	}
	slot0.hadBuildList = {}
	slot0.buildGroupHadBuildCount = {
		0,
		0,
		0
	}

	for slot5, slot6 in ipairs(slot1.selectIds) do
		table.insert(slot0.selectBuildList, slot6)
	end

	slot0:updateSelectTypeList()

	for slot5, slot6 in ipairs(slot1.ownBuildingIds) do
		table.insert(slot0.hadBuildList, slot6)
	end

	slot0:updateGroupHadBuildCount()

	slot0.hasGainedReward = slot1.gainedReward
end

function slot0.addHadBuild(slot0, slot1)
	if tabletool.indexOf(slot0.hadBuildList, slot1) then
		return
	end

	table.insert(slot0.hadBuildList, slot1)
	slot0:updateGroupHadBuildCount()
	slot0:setSelectBuildId(VersionActivity1_5DungeonConfig.instance:getBuildCo(slot1))
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, slot1)
end

function slot0.updateSelectBuild(slot0, slot1)
	tabletool.clear(slot0.selectBuildList)

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.selectBuildList, slot6)
	end

	slot0:updateSelectTypeList()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateSelectBuild)
end

function slot0.updateGainedReward(slot0, slot1)
	slot0.hasGainedReward = slot1

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward)
end

function slot0.updateSelectTypeList(slot0)
	for slot4 = 1, #slot0.selectTypeList do
		slot0.selectTypeList[slot4] = 0
	end

	for slot4, slot5 in ipairs(slot0.selectBuildList) do
		if slot0:checkBuildIdIsSelect(slot5) then
			slot6 = VersionActivity1_5DungeonConfig.instance:getBuildCo(slot5)
			slot0.selectTypeList[slot6.group] = slot6.type
		end
	end
end

function slot0.checkBuildIdIsSelect(slot0, slot1)
	return tabletool.indexOf(slot0.selectBuildList, slot1)
end

function slot0.checkBuildIsHad(slot0, slot1)
	return tabletool.indexOf(slot0.hadBuildList, slot1)
end

function slot0.updateGroupHadBuildCount(slot0)
	for slot4 = 1, #slot0.buildGroupHadBuildCount do
		slot0.buildGroupHadBuildCount[slot4] = 0
	end

	for slot4, slot5 in ipairs(slot0.hadBuildList) do
		slot7 = VersionActivity1_5DungeonConfig.instance:getBuildCo(slot5).group
		slot0.buildGroupHadBuildCount[slot7] = slot0.buildGroupHadBuildCount[slot7] + 1
	end
end

function slot0.getCanBuildCount(slot0, slot1)
	return slot0.buildGroupHadBuildCount[slot1]
end

function slot0.getSelectBuildIdList(slot0)
	return slot0.selectBuildList
end

function slot0.getSelectType(slot0, slot1)
	return slot0.selectTypeList[slot1]
end

function slot0.getSelectTypeList(slot0)
	return slot0.selectTypeList
end

function slot0.setSelectBuildId(slot0, slot1)
	slot0.selectTypeList[slot1.group] = slot1.type

	tabletool.clear(slot0.selectBuildList)

	for slot5, slot6 in pairs(slot0.selectTypeList) do
		if slot6 ~= VersionActivity1_5DungeonEnum.BuildType.None then
			table.insert(slot0.selectBuildList, VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot5, slot6).id)
		end
	end
end

function slot0.getHadBuildCount(slot0)
	return #slot0.hadBuildList
end

function slot0.getBuildCoByGroupIndex(slot0, slot1)
	if slot0:getSelectType(slot1) == VersionActivity1_5DungeonEnum.BuildType.None then
		return nil
	end

	return VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot1, slot2)
end

function slot0.getTextByType(slot0, slot1)
	return string.format("<color=%s>%s</color>", VersionActivity1_5DungeonEnum.BuildType2TextColor[slot0] or VersionActivity1_5DungeonEnum.BuildType2TextColor[VersionActivity1_5DungeonEnum.BuildType.None], slot1)
end

slot0.instance = slot0.New()

return slot0
