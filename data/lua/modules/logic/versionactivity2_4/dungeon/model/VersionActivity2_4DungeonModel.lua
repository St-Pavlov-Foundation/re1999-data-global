module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4DungeonModel", package.seeall)

local var_0_0 = class("VersionActivity2_4DungeonModel", BaseModel)

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

function var_0_0.setMapNeedTweenState(arg_10_0, arg_10_1)
	arg_10_0.isMapNeedTween = arg_10_1
end

function var_0_0.getMapNeedTweenState(arg_11_0)
	return arg_11_0.isMapNeedTween
end

function var_0_0.getElementCoList(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = DungeonMapModel.instance:getAllElements()

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		local var_12_2 = DungeonConfig.instance:getChapterMapElement(iter_12_1)
		local var_12_3 = lua_chapter_map.configDict[var_12_2.mapId]

		if var_12_3 and var_12_3.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Story and arg_12_1 == var_12_2.mapId then
			table.insert(var_12_0, var_12_2)
		end
	end

	return var_12_0
end

function var_0_0.getElementCoListWithFinish(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = arg_13_0:getAllNormalElementCoList(arg_13_1)

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		local var_13_2 = iter_13_1.id
		local var_13_3 = lua_chapter_map.configDict[iter_13_1.mapId]

		if var_13_3 and var_13_3.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Story then
			local var_13_4 = DungeonMapModel.instance:elementIsFinished(var_13_2)
			local var_13_5 = DungeonMapModel.instance:getElementById(var_13_2)

			if arg_13_1 == iter_13_1.mapId and var_13_4 and not var_13_5 then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.getAllNormalElementCoList(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = DungeonConfig.instance:getMapElements(arg_14_1)

	if var_14_1 then
		for iter_14_0, iter_14_1 in pairs(var_14_1) do
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.setDungeonBaseMo(arg_15_0, arg_15_1)
	arg_15_0.actDungeonBaseMo = arg_15_1
end

function var_0_0.getDungeonBaseMo(arg_16_0)
	return arg_16_0.actDungeonBaseMo
end

function var_0_0.getUnFinishElementEpisodeId(arg_17_0)
	local var_17_0 = 0
	local var_17_1 = DungeonMapModel.instance:getAllElements()

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		local var_17_2 = DungeonConfig.instance:getChapterMapElement(iter_17_1)
		local var_17_3 = lua_chapter_map.configDict[var_17_2.mapId]

		if var_17_3 and var_17_3.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Story then
			local var_17_4 = DungeonConfig.instance:getEpisodeIdByMapCo(var_17_3)

			if var_17_4 < var_17_0 or var_17_0 == 0 then
				var_17_0 = var_17_4
			end
		end
	end

	return var_17_0
end

function var_0_0.getFinishWithFragmentElementList(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = DungeonConfig.instance:getMapElements(arg_18_1.id) or {}

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if DungeonMapModel.instance:elementIsFinished(iter_18_1.id) and iter_18_1.fragment > 0 then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function var_0_0.getUnFinishStoryElements(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = DungeonMapModel.instance:getAllElements()
	local var_19_2 = Activity165Model.instance:getAllElements()

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		if LuaUtil.tableContains(var_19_2, iter_19_1) then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.checkAndGetUnfinishStoryElementCo(arg_20_0, arg_20_1)
	local var_20_0
	local var_20_1 = DungeonConfig.instance:getMapElements(arg_20_1) or {}
	local var_20_2 = arg_20_0:getUnFinishStoryElements()

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if LuaUtil.tableContains(var_20_2, iter_20_1.id) then
			var_20_0 = iter_20_1

			break
		end
	end

	return var_20_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
