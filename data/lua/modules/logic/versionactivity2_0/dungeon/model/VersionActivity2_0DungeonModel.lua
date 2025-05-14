module("modules.logic.versionactivity2_0.dungeon.model.VersionActivity2_0DungeonModel", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:init()
end

function var_0_0.init(arg_3_0)
	arg_3_0:setLastEpisodeId()
	arg_3_0:setShowInteractView()
end

function var_0_0.setLastEpisodeId(arg_4_0, arg_4_1)
	arg_4_0.lastEpisodeId = arg_4_1
end

function var_0_0.getLastEpisodeId(arg_5_0)
	return arg_5_0.lastEpisodeId
end

function var_0_0.setShowInteractView(arg_6_0, arg_6_1)
	arg_6_0.isShowInteractView = arg_6_1
end

function var_0_0.checkIsShowInteractView(arg_7_0)
	return arg_7_0.isShowInteractView
end

function var_0_0.setIsNotShowNewElement(arg_8_0, arg_8_1)
	arg_8_0.notShowNewElement = arg_8_1
end

function var_0_0.isNotShowNewElement(arg_9_0)
	return arg_9_0.notShowNewElement
end

function var_0_0.setOpenGraffitiEntrance(arg_10_0, arg_10_1)
	arg_10_0.isOpenGraffitiEntrance = arg_10_1
end

function var_0_0.getOpenGraffitiEntranceState(arg_11_0)
	return arg_11_0.isOpenGraffitiEntrance
end

function var_0_0.setMapNeedTweenState(arg_12_0, arg_12_1)
	arg_12_0.isMapNeedTween = arg_12_1
end

function var_0_0.getMapNeedTweenState(arg_13_0)
	return arg_13_0.isMapNeedTween
end

function var_0_0.setOpeningGraffitiEntrance(arg_14_0, arg_14_1)
	arg_14_0.isOpeningGraffitiEntrance = arg_14_1
end

function var_0_0.getOpeningGraffitiEntranceState(arg_15_0)
	return arg_15_0.isOpeningGraffitiEntrance
end

function var_0_0.setDraggingMapState(arg_16_0, arg_16_1)
	arg_16_0.isDragginMap = arg_16_1
end

function var_0_0.isDraggingMapState(arg_17_0)
	return arg_17_0.isDragginMap
end

function var_0_0.getGraffitiEntranceUnlockState(arg_18_0)
	local var_18_0 = Activity161Model.instance:getActId()
	local var_18_1 = ActivityConfig.instance:getActivityCo(var_18_0)

	if var_18_1 then
		if OpenConfig.instance:getOpenCo(var_18_1.openId) then
			return OpenModel.instance:isFunctionUnlock(var_18_1.openId)
		else
			logError("openConfig is not exit: " .. var_18_1.openId)
		end
	end

	return false
end

function var_0_0.getElementCoList(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = DungeonMapModel.instance:getAllElements()

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		local var_19_2 = DungeonConfig.instance:getChapterMapElement(iter_19_1)
		local var_19_3 = lua_chapter_map.configDict[var_19_2.mapId]

		if var_19_3 and var_19_3.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Story and arg_19_1 == var_19_2.mapId then
			table.insert(var_19_0, var_19_2)
		end
	end

	return var_19_0
end

function var_0_0.getElementCoListWithFinish(arg_20_0, arg_20_1)
	local var_20_0 = {}
	local var_20_1 = arg_20_0:getAllNormalElementCoList(arg_20_1)

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		local var_20_2 = iter_20_1.id
		local var_20_3 = lua_chapter_map.configDict[iter_20_1.mapId]

		if var_20_3 and var_20_3.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Story then
			local var_20_4 = DungeonMapModel.instance:elementIsFinished(var_20_2)
			local var_20_5 = DungeonMapModel.instance:getElementById(var_20_2)

			if arg_20_1 == iter_20_1.mapId and var_20_4 and not var_20_5 then
				table.insert(var_20_0, iter_20_1)
			end
		end
	end

	return var_20_0, var_20_1
end

function var_0_0.getAllNormalElementCoList(arg_21_0, arg_21_1)
	local var_21_0 = {}
	local var_21_1 = DungeonConfig.instance:getMapElements(arg_21_1)

	if not var_21_1 or #var_21_1 < 0 then
		return var_21_0
	end

	local var_21_2 = Activity161Model.instance:getActId()

	for iter_21_0, iter_21_1 in pairs(var_21_1) do
		local var_21_3 = Activity161Config.instance:getGraffitiCo(var_21_2, iter_21_1.id)
		local var_21_4, var_21_5 = Activity161Config.instance:getGraffitiRelevantElementMap(var_21_2)

		if not var_21_3 and iter_21_1.type ~= DungeonEnum.ElementType.Graffiti and not var_21_4[iter_21_1.id] and not var_21_5[iter_21_1.id] then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.setDungeonBaseMo(arg_22_0, arg_22_1)
	arg_22_0.actDungeonBaseMo = arg_22_1
end

function var_0_0.getDungeonBaseMo(arg_23_0)
	return arg_23_0.actDungeonBaseMo
end

function var_0_0.getCurNeedUnlockGraffitiElement(arg_24_0)
	local var_24_0 = Activity161Model.instance:getActId()
	local var_24_1 = Activity161Config.instance:getAllGraffitiCo(var_24_0)

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		local var_24_2 = DungeonMapModel.instance:elementIsFinished(iter_24_1.mainElementId)
		local var_24_3 = Activity161Config.instance:isPreMainElementFinish(iter_24_1)
		local var_24_4 = Activity161Config.instance:getGraffitiRelevantElement(var_24_0, iter_24_1.elementId)
		local var_24_5 = DungeonMapModel.instance:getElementById(iter_24_1.mainElementId)

		if var_24_3 and var_24_5 and not var_24_2 then
			return iter_24_1.mainElementId
		elseif var_24_2 and #var_24_4 > 0 then
			for iter_24_2, iter_24_3 in pairs(var_24_4) do
				local var_24_6 = DungeonMapModel.instance:elementIsFinished(iter_24_3)
				local var_24_7 = DungeonMapModel.instance:getElementById(iter_24_3)

				if not var_24_6 and var_24_7 then
					return iter_24_3
				end
			end
		end
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
