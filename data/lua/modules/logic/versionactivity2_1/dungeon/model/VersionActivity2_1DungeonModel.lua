module("modules.logic.versionactivity2_1.dungeon.model.VersionActivity2_1DungeonModel", package.seeall)

local var_0_0 = class("VersionActivity2_1DungeonModel", BaseModel)

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

function var_0_0.isUnlockAct165Btn(arg_12_0)
	local var_12_0 = Activity165Model.instance:getActivityId()
	local var_12_1 = ActivityConfig.instance:getActivityCo(var_12_0)

	if var_12_1 then
		if OpenConfig.instance:getOpenCo(var_12_1.openId) then
			local var_12_2 = OpenModel.instance:isFunctionUnlock(var_12_1.openId)
			local var_12_3 = Activity165Model.instance:hasUnlockStory()

			return var_12_2 and var_12_3
		else
			logError("openConfig is not exit: " .. var_12_1.openId)
		end
	end

	return false
end

function var_0_0.getElementCoList(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = DungeonMapModel.instance:getAllElements()

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		local var_13_2 = DungeonConfig.instance:getChapterMapElement(iter_13_1)
		local var_13_3 = lua_chapter_map.configDict[var_13_2.mapId]

		if var_13_3 and var_13_3.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story and arg_13_1 == var_13_2.mapId then
			table.insert(var_13_0, var_13_2)
		end
	end

	return var_13_0
end

function var_0_0.getElementCoListWithFinish(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:getAllNormalElementCoList(arg_14_1)

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		local var_14_2 = iter_14_1.id
		local var_14_3 = lua_chapter_map.configDict[iter_14_1.mapId]

		if var_14_3 and var_14_3.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story then
			local var_14_4 = DungeonMapModel.instance:elementIsFinished(var_14_2)
			local var_14_5 = DungeonMapModel.instance:getElementById(var_14_2)

			if arg_14_1 == iter_14_1.mapId and var_14_4 and not var_14_5 then
				table.insert(var_14_0, iter_14_1)
			end
		end
	end

	return var_14_0, var_14_1
end

function var_0_0.getAllNormalElementCoList(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = DungeonConfig.instance:getMapElements(arg_15_1)
	local var_15_2 = Activity165Model.instance:getAllElements()

	if var_15_2 and var_15_1 then
		for iter_15_0, iter_15_1 in pairs(var_15_1) do
			if not LuaUtil.tableContains(var_15_2, iter_15_1.id) then
				table.insert(var_15_0, iter_15_1)
			end
		end
	end

	return var_15_0
end

function var_0_0.setDungeonBaseMo(arg_16_0, arg_16_1)
	arg_16_0.actDungeonBaseMo = arg_16_1
end

function var_0_0.getDungeonBaseMo(arg_17_0)
	return arg_17_0.actDungeonBaseMo
end

function var_0_0.getUnFinishElementEpisodeId(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = DungeonMapModel.instance:getAllElements()

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		local var_18_2 = DungeonConfig.instance:getChapterMapElement(iter_18_1)
		local var_18_3 = lua_chapter_map.configDict[var_18_2.mapId]

		if var_18_3 and var_18_3.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story then
			local var_18_4 = DungeonConfig.instance:getEpisodeIdByMapCo(var_18_3)

			if var_18_4 < var_18_0 or var_18_0 == 0 then
				var_18_0 = var_18_4
			end
		end
	end

	return var_18_0
end

function var_0_0.getFinishWithFragmentElementList(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = DungeonConfig.instance:getMapElements(arg_19_1.id) or {}

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if DungeonMapModel.instance:elementIsFinished(iter_19_1.id) and iter_19_1.fragment > 0 then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.checkStoryCanUnlock(arg_20_0, arg_20_1)
	local var_20_0
	local var_20_1 = Activity165Model.instance:getActivityId()
	local var_20_2 = Activity165Config.instance:getAllStoryCoList(var_20_1)

	for iter_20_0, iter_20_1 in ipairs(var_20_2) do
		local var_20_3 = Activity165Config.instance:getStoryElements(var_20_1, iter_20_1.storyId)

		if var_20_3[#var_20_3] == arg_20_1 then
			var_20_0 = iter_20_1

			break
		end
	end

	return var_20_0
end

function var_0_0.getUnFinishStoryElements(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = DungeonMapModel.instance:getAllElements()
	local var_21_2 = Activity165Model.instance:getAllElements()

	for iter_21_0, iter_21_1 in pairs(var_21_1) do
		if LuaUtil.tableContains(var_21_2, iter_21_1) then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.checkAndGetUnfinishStoryElementCo(arg_22_0, arg_22_1)
	local var_22_0
	local var_22_1 = DungeonConfig.instance:getMapElements(arg_22_1) or {}
	local var_22_2 = arg_22_0:getUnFinishStoryElements()

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		if LuaUtil.tableContains(var_22_2, iter_22_1.id) then
			var_22_0 = iter_22_1

			break
		end
	end

	return var_22_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
