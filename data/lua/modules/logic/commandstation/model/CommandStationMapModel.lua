module("modules.logic.commandstation.model.CommandStationMapModel", package.seeall)

local var_0_0 = class("CommandStationMapModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._eventCategory = nil
	arg_2_0._timeId = nil
	arg_2_0._versionId = nil
	arg_2_0._timelineIsCharacterMode = false
	arg_2_0._characterId = nil
	arg_2_0._preloadScene = nil
	arg_2_0._preloadSceneLoader = nil
	arg_2_0._preloadView = nil
end

function var_0_0.setVersionId(arg_3_0, arg_3_1)
	if arg_3_1 then
		CommandStationController.setSaveNumber(CommandStationEnum.PrefsKey.Version, arg_3_1)
	end

	arg_3_0._versionId = arg_3_1
end

function var_0_0.getVersionId(arg_4_0)
	if not arg_4_0._versionId then
		local var_4_0 = CommandStationController.getSaveNumber(CommandStationEnum.PrefsKey.Version)

		if var_4_0 and lua_copost_version.configDict[var_4_0] then
			arg_4_0._versionId = var_4_0
		end
	end

	return arg_4_0._versionId or CommandStationEnum.AllVersion
end

function var_0_0.setEventCategory(arg_5_0, arg_5_1)
	arg_5_0._eventCategory = arg_5_1
end

function var_0_0.getEventCategory(arg_6_0)
	return arg_6_0._eventCategory
end

function var_0_0.getVersionTimeline(arg_7_0, arg_7_1)
	local var_7_0 = CommandStationConfig.instance:getVersionTimeline(arg_7_1)

	return arg_7_0:checkTimeline(var_7_0)
end

function var_0_0.checkTimeline(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_2 = {}

		for iter_8_2, iter_8_3 in ipairs(iter_8_1.timeId) do
			local var_8_3 = CommandStationConfig.instance:getTimePointEpisodeId(iter_8_3)

			if DungeonModel.instance:hasPassLevelAndStory(var_8_3) then
				table.insert(var_8_2, iter_8_3)
			end

			var_8_1 = var_8_1 or iter_8_3
		end

		if #var_8_2 > 0 then
			table.insert(var_8_0, {
				id = iter_8_1.id,
				timeId = var_8_2
			})
		end
	end

	return var_8_0, var_8_1
end

function var_0_0.initTimeId(arg_9_0)
	local var_9_0, var_9_1 = pcall(arg_9_0._internalInitTimeId, arg_9_0)

	if not var_9_0 then
		arg_9_0:setVersionId(CommandStationEnum.AllVersion)
		arg_9_0:setTimeId(CommandStationEnum.FirstTimeId)
		logError(string.format("CommandStationMapModel:initTimeId error:%s", var_9_1))
	end
end

function var_0_0._internalInitTimeId(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:getVersionTimeline(arg_10_0:getVersionId())
	local var_10_2 = arg_10_0._timeId or CommandStationController.getSaveNumber(CommandStationEnum.PrefsKey.TimeId)

	arg_10_0._timeId = nil

	if var_10_2 then
		local var_10_3 = false

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if tabletool.indexOf(iter_10_1.timeId, var_10_2) then
				var_10_3 = true

				break
			end
		end

		if not var_10_3 then
			var_10_2 = nil
		end
	end

	if not var_10_2 then
		local var_10_4 = var_10_0[1]

		if var_10_4 then
			var_10_2 = var_10_4.timeId[1]
		end
	end

	var_10_2 = var_10_2 or var_10_1
	arg_10_0._timeId = var_10_2
end

function var_0_0.setTimeId(arg_11_0, arg_11_1)
	arg_11_0._timeId = arg_11_1

	if arg_11_1 then
		CommandStationController.setSaveNumber(CommandStationEnum.PrefsKey.TimeId, arg_11_1)
	end
end

function var_0_0.getTimeId(arg_12_0)
	return arg_12_0._timeId
end

function var_0_0.getCurTimeIdScene(arg_13_0)
	local var_13_0 = arg_13_0._timeId
	local var_13_1 = CommandStationConfig.instance:getTimeGroupByTimeId(var_13_0).sceneId

	return (CommandStationConfig.instance:getSceneConfig(var_13_1))
end

function var_0_0.setTimelineCharacterMode(arg_14_0, arg_14_1)
	arg_14_0._timelineCharacterMode = arg_14_1
end

function var_0_0.isTimelineCharacterMode(arg_15_0)
	return arg_15_0._timelineCharacterMode
end

function var_0_0.setCharacterId(arg_16_0, arg_16_1)
	arg_16_0._characterId = arg_16_1
end

function var_0_0.getCharacterId(arg_17_0)
	return arg_17_0._characterId
end

function var_0_0.clearSceneInfo(arg_18_0)
	arg_18_0._sceneGo = nil

	arg_18_0:clearSceneNodeList()
end

function var_0_0.clearSceneNodeList(arg_19_0)
	if arg_19_0._sceneNodeList then
		tabletool.clear(arg_19_0._sceneNodeList)
	end
end

function var_0_0.setSceneGo(arg_20_0, arg_20_1)
	arg_20_0:clearSceneInfo()

	arg_20_0._sceneGo = arg_20_1
	arg_20_0._sceneNodeList = {}
end

function var_0_0.getSceneNode(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._sceneNodeList[arg_21_1]

	if gohelper.isNil(var_21_0) then
		var_21_0 = UnityEngine.GameObject.New(tostring(arg_21_1))

		gohelper.addChild(arg_21_0._sceneGo, var_21_0)

		arg_21_0._sceneNodeList[arg_21_1] = var_21_0
	end

	return var_21_0
end

function var_0_0.setPreloadScene(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._preloadScene = arg_22_2
	arg_22_0._preloadSceneLoader = arg_22_1
end

function var_0_0.getPreloadScene(arg_23_0)
	return arg_23_0._preloadScene
end

function var_0_0.getPreloadSceneLoader(arg_24_0)
	return arg_24_0._preloadSceneLoader
end

function var_0_0.setPreloadView(arg_25_0, arg_25_1)
	arg_25_0._preloadView = arg_25_1
end

function var_0_0.getPreloadView(arg_26_0)
	return arg_26_0._preloadView
end

var_0_0.instance = var_0_0.New()

return var_0_0
