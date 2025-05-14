module("modules.logic.versionactivity1_8.dungeon.model.VersionActivity1_8DungeonModel", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonModel", BaseModel)

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

function var_0_0.setShowInteractView(arg_5_0, arg_5_1)
	arg_5_0.isShowInteractView = arg_5_1
end

function var_0_0.setIsNotShowNewElement(arg_6_0, arg_6_1)
	arg_6_0.notShowNewElement = arg_6_1
end

function var_0_0.isNotShowNewElement(arg_7_0)
	return arg_7_0.notShowNewElement
end

function var_0_0.getLastEpisodeId(arg_8_0)
	return arg_8_0.lastEpisodeId
end

function var_0_0.checkIsShowInteractView(arg_9_0)
	return arg_9_0.isShowInteractView
end

function var_0_0.getElementCoList(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = DungeonMapModel.instance:getAllElements()

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		local var_10_2 = DungeonConfig.instance:getChapterMapElement(iter_10_1)
		local var_10_3 = lua_chapter_map.configDict[var_10_2.mapId]

		if var_10_3 and var_10_3.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Story and arg_10_1 == var_10_2.mapId then
			table.insert(var_10_0, var_10_2)
		end
	end

	return var_10_0
end

function var_0_0.getElementCoListWithFinish(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = DungeonConfig.instance:getMapElements(arg_11_1)

	if not var_11_1 or #var_11_1 < 0 then
		return var_11_0
	end

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		local var_11_2 = iter_11_1.id
		local var_11_3 = lua_chapter_map.configDict[iter_11_1.mapId]

		if var_11_3 and var_11_3.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Story then
			local var_11_4 = DungeonMapModel.instance:elementIsFinished(var_11_2)
			local var_11_5 = DungeonMapModel.instance:getElementById(var_11_2)
			local var_11_6 = true
			local var_11_7 = Activity157Model.instance:getActId()
			local var_11_8 = Activity157Config.instance:getMissionIdByElementId(var_11_7, var_11_2)
			local var_11_9 = false

			if var_11_8 then
				var_11_9 = Activity157Config.instance:isSideMission(var_11_7, var_11_8)
			end

			if var_11_9 and arg_11_2 then
				var_11_6 = not Activity157Model.instance:isInProgressOtherMissionGroupByElementId(var_11_2)
			end

			if arg_11_1 == iter_11_1.mapId and var_11_6 and (var_11_4 or var_11_5) then
				table.insert(var_11_0, iter_11_1)
			end
		end
	end

	return var_11_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
