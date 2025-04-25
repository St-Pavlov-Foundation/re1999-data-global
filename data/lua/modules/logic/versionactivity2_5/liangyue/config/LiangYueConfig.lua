module("modules.logic.versionactivity2_5.liangyue.config.LiangYueConfig", package.seeall)

slot0 = class("LiangYueConfig", BaseConfig)
slot0.EPISODE_CONFIG_NAME = "activity184_episode"
slot0.PUZZLE_CONFIG_NAME = "activity184_puzzle_episode"
slot0.ILLUSTRATION_CONFIG_NAME = "activity184_illustration"
slot0.TASK_CONFIG_NAME = "activity184_task"

function slot0.reqConfigNames(slot0)
	return {
		slot0.EPISODE_CONFIG_NAME,
		slot0.ILLUSTRATION_CONFIG_NAME,
		slot0.PUZZLE_CONFIG_NAME,
		slot0.TASK_CONFIG_NAME
	}
end

function slot0.onInit(slot0)
	slot0._noGameEpisodeDic = {}
	slot0._afterGameEpisodeDic = {}
	slot0._taskDict = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == slot0.EPISODE_CONFIG_NAME then
		slot0._episodeConfig = slot2
	elseif slot1 == slot0.TASK_CONFIG_NAME then
		slot0._taskConfig = slot2
	elseif slot1 == slot0.ILLUSTRATION_CONFIG_NAME then
		slot0._illustrationConfig = slot2

		slot0:initIllustrationConfig()
	elseif slot1 == slot0.PUZZLE_CONFIG_NAME then
		slot0._episodePuzzleConfig = slot2

		slot0:initPuzzleEpisodeConfig()
	end
end

function slot0.getTaskByActId(slot0, slot1)
	if not slot0._taskDict[slot1] then
		slot2 = {}

		for slot6, slot7 in ipairs(slot0._taskConfig.configList) do
			if slot7.activityId == slot1 then
				table.insert(slot2, slot7)
			end
		end

		slot0._taskDict[slot1] = slot2
	end

	return slot2
end

function slot0.initPuzzleEpisodeConfig(slot0)
	slot0._episodeStaticIllustrationDic = {}

	for slot4, slot5 in ipairs(slot0._episodePuzzleConfig.configList) do
		if slot0._episodeStaticIllustrationDic[slot5.activityId] == nil then
			slot0._episodeStaticIllustrationDic[slot6] = {}
		end

		if not string.nilorempty(slot5.staticShape) then
			slot8 = {}

			for slot12, slot13 in ipairs(string.split(slot5.staticShape, "|")) do
				slot15 = string.splitToNumber(string.split(slot13, "#")[1], ",")
				slot17 = slot15[2]

				if slot8[slot15[1]] and slot8[slot16][slot17] then
					logError("固定格子位置重复 位置: x:" .. slot16 .. "y:" .. slot17)
				else
					if not slot8[slot16] then
						slot8[slot16] = {}
					end

					slot8[slot16][slot17] = tonumber(slot14[2])
				end
			end

			slot0._episodeStaticIllustrationDic[slot6][slot5.id] = slot8
		end
	end
end

function slot0.getFirstEpisodeId(slot0)
	return slot0._episodeConfig.configList[1]
end

function slot0.initIllustrationConfig(slot0)
	slot0._illustrationShapeDic = {}
	slot0._illustrationShapeBoxCountDic = {}

	for slot4, slot5 in ipairs(slot0._illustrationConfig.configList) do
		slot7 = slot5.id

		if not slot0._illustrationShapeDic[slot5.activityId] then
			slot0._illustrationShapeDic[slot6] = {}
			slot0._illustrationShapeBoxCountDic[slot6] = {}
		end

		if not slot0._illustrationShapeDic[slot6][slot7] then
			slot8 = {}
			slot9 = 0

			for slot14 = 1, #string.split(slot5.shape, "#") do
				for slot21 = 1, #string.splitToNumber(slot10[slot14], ",") do
					if slot17[slot21] == 1 then
						slot9 = slot9 + 1
					end
				end

				slot8[slot14] = {
					[slot21] = slot17[slot21]
				}
			end

			slot0._illustrationShapeDic[slot6][slot7] = slot8
			slot0._illustrationShapeBoxCountDic[slot6][slot7] = slot9
		else
			logError(string.format("梁月角色活动 插图表id重复 actId:%s id:%s", slot6, slot7))
		end
	end
end

function slot0.getEpisodeStaticIllustrationDic(slot0, slot1, slot2)
	if slot0._episodeStaticIllustrationDic[slot1] then
		return slot0._episodeStaticIllustrationDic[slot1][slot2]
	end

	return nil
end

function slot0.getIllustrationShape(slot0, slot1, slot2)
	if not slot0._illustrationShapeDic[slot1] then
		return nil
	end

	return slot0._illustrationShapeDic[slot1][slot2]
end

function slot0.getIllustrationShapeCount(slot0, slot1, slot2)
	if not slot0._illustrationShapeBoxCountDic[slot1] then
		return nil
	end

	return slot0._illustrationShapeBoxCountDic[slot1][slot2]
end

function slot0.getIllustrationAttribute(slot0, slot1, slot2)
	if slot0:getIllustrationConfigById(slot1, slot2) == nil then
		return
	end

	if not slot0._illustrationAttributeConfig then
		slot0._illustrationAttributeConfig = {}
	end

	if not slot0._illustrationAttributeConfig[slot1] then
		slot0._illustrationAttributeConfig[slot1] = {}
	end

	if not slot0._illustrationAttributeConfig[slot1][slot2] then
		slot4 = {
			[slot12] = {
				slot12,
				slot11[2],
				slot11[3]
			}
		}

		for slot9, slot10 in ipairs(string.split(slot3.attribute, "|")) do
			slot12 = string.splitToNumber(slot10, "#")[1]
		end

		slot0._illustrationAttributeConfig[slot1][slot2] = slot4

		return slot4
	end

	return slot0._illustrationAttributeConfig[slot1][slot2]
end

function slot0.getEpisodeConfigByActAndId(slot0, slot1, slot2)
	if not slot0._episodeConfig.configDict[slot1] then
		return nil
	end

	return slot0._episodeConfig.configDict[slot1][slot2]
end

function slot0.getEpisodePuzzleConfigByActAndId(slot0, slot1, slot2)
	if not slot0._episodePuzzleConfig.configDict[slot1] then
		return nil
	end

	return slot0._episodePuzzleConfig.configDict[slot1][slot2]
end

function slot0.getIllustrationConfigById(slot0, slot1, slot2)
	if not slot0._illustrationConfig.configDict[slot1] then
		return nil
	end

	return slot0._illustrationConfig.configDict[slot1][slot2]
end

function slot0.getNoGameEpisodeList(slot0, slot1)
	if not slot0._episodeConfig.configDict[slot1] then
		return nil
	end

	if not slot0._noGameEpisodeDic[slot1] then
		slot2 = {}

		for slot7, slot8 in pairs(slot0._episodeConfig.configDict[slot1]) do
			if slot8.puzzleId == 0 then
				table.insert(slot2, slot8)
			end
		end

		table.sort(slot2, slot0._sortEpisode)

		slot0._noGameEpisodeDic[slot1] = slot2
	end

	return slot0._noGameEpisodeDic[slot1]
end

function slot0._sortEpisode(slot0, slot1)
	return slot0.episodeId <= slot1.episodeId
end

function slot0.getAfterGameEpisodeId(slot0, slot1, slot2)
	if not slot0._episodeConfig.configDict[slot1] then
		return nil
	end

	if not slot0._afterGameEpisodeDic[slot1] then
		for slot8, slot9 in pairs(slot0._episodeConfig.configDict[slot1]) do
			if slot9.puzzleId ~= 0 then
				-- Nothing
			end
		end

		slot0._afterGameEpisodeDic[slot1] = {
			[slot9.preEpisodeId] = slot9.episodeId
		}
	end

	return slot0._afterGameEpisodeDic[slot1][slot2]
end

slot0.instance = slot0.New()

return slot0
