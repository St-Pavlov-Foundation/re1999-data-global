module("modules.logic.handbook.config.HandbookConfig", package.seeall)

local var_0_0 = class("HandbookConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._cgConfig = nil
	arg_1_0._cgList = nil
	arg_1_0._storyGroupConfig = nil
	arg_1_0._storyGroupList = nil
	arg_1_0._storyChapterConfig = nil
	arg_1_0._storyChapterList = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"cg",
		"handbook_story_group",
		"handbook_story_chapter",
		"handbook_character",
		"handbook_equip"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "cg" then
		arg_3_0._cgConfig = arg_3_2
	elseif arg_3_1 == "handbook_story_group" then
		arg_3_0._storyGroupConfig = arg_3_2
	elseif arg_3_1 == "handbook_story_chapter" then
		arg_3_0._storyChapterConfig = arg_3_2
	end
end

function var_0_0._initCGConfig(arg_4_0)
	arg_4_0._cgList = {}
	arg_4_0._cgDungeonList = {}
	arg_4_0._cgDungeonDict = {}
	arg_4_0._cgRoleList = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._cgConfig.configDict) do
		table.insert(arg_4_0._cgList, iter_4_1)
	end

	table.sort(arg_4_0._cgList, function(arg_5_0, arg_5_1)
		if arg_5_0.storyChapterId ~= arg_5_1.storyChapterId then
			return arg_4_0._sortBystoryChapterId(arg_5_0.storyChapterId, arg_5_1.storyChapterId)
		end

		if arg_5_0.order ~= arg_5_1.order then
			return arg_5_0.order < arg_5_1.order
		end

		return arg_5_0.id < arg_5_1.id
	end)

	for iter_4_2, iter_4_3 in pairs(arg_4_0._cgList) do
		local var_4_0 = tostring(iter_4_3.storyChapterId)

		if string.len(var_4_0) >= 4 then
			table.insert(arg_4_0._cgRoleList, iter_4_3)
		else
			arg_4_0._cgDungeonDict[iter_4_3.storyChapterId] = arg_4_0._cgDungeonDict[iter_4_3.storyChapterId] or {}

			table.insert(arg_4_0._cgDungeonDict[iter_4_3.storyChapterId], iter_4_3)
			table.insert(arg_4_0._cgDungeonList, iter_4_3)
		end
	end
end

function var_0_0._initDungeonChapterList(arg_6_0)
	arg_6_0._dungeonChapterList = {}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._storyChapterConfig.configDict) do
		table.insert(var_6_0, iter_6_1)
	end

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		local var_6_1 = tostring(iter_6_3.id)

		if string.len(var_6_1) < 4 then
			table.insert(arg_6_0._dungeonChapterList, iter_6_3)
		end
	end
end

function var_0_0.getCGList(arg_7_0, arg_7_1)
	if not arg_7_0._cgList then
		arg_7_0:_initCGConfig()
	end

	if arg_7_1 == HandbookEnum.CGType.Dungeon then
		return arg_7_0._cgDungeonList
	elseif arg_7_1 == HandbookEnum.CGType.Role then
		return arg_7_0._cgRoleList
	end

	return arg_7_0._cgList
end

function var_0_0.getDungeonCGList(arg_8_0)
	if not arg_8_0._cgList then
		arg_8_0:_initCGConfig()
	end

	return arg_8_0._cgDungeonList
end

function var_0_0.getRoleCGList(arg_9_0)
	if not arg_9_0._cgList then
		arg_9_0:_initCGConfig()
	end

	return arg_9_0._cgRoleList
end

function var_0_0.getCGCount(arg_10_0)
	if not arg_10_0._cgList then
		arg_10_0:_initCGConfig()
	end

	return arg_10_0._cgList and #arg_10_0._cgList or 0
end

function var_0_0.getCGConfig(arg_11_0, arg_11_1)
	return arg_11_0._cgConfig.configDict[arg_11_1]
end

function var_0_0.getCGIndex(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._cgList

	if arg_12_2 == HandbookEnum.CGType.Dungeon then
		var_12_0 = arg_12_0._cgDungeonList
	elseif arg_12_2 == HandbookEnum.CGType.Role then
		var_12_0 = arg_12_0._cgRoleList
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.id == arg_12_1 then
			return iter_12_0
		end
	end

	return 0
end

function var_0_0.getDungeonChapterList(arg_13_0)
	if not arg_13_0._dungeonChapterList then
		arg_13_0:_initDungeonChapterList()
	end

	return arg_13_0._dungeonChapterList
end

function var_0_0.getCGDictByChapter(arg_14_0, arg_14_1)
	if not arg_14_0._cgDungeonDict then
		arg_14_0:_initCGConfig()
	end

	return arg_14_0._cgDungeonDict[arg_14_1]
end

function var_0_0.getCGDict(arg_15_0)
	if not arg_15_0._cgDungeonDict then
		arg_15_0:_initCGConfig()
	end

	return arg_15_0._cgDungeonDict
end

function var_0_0._initStoryGroupList(arg_16_0)
	arg_16_0._storyGroupList = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0._storyGroupConfig.configDict) do
		table.insert(arg_16_0._storyGroupList, iter_16_1)
	end

	table.sort(arg_16_0._storyGroupList, function(arg_17_0, arg_17_1)
		if arg_17_0.storyChapterId ~= arg_17_1.storyChapterId then
			return arg_16_0._sortBystoryChapterId(arg_17_0.storyChapterId, arg_17_1.storyChapterId)
		end

		if arg_17_0.order ~= arg_17_1.order then
			return arg_17_0.order < arg_17_1.order
		end

		return arg_17_0.id < arg_17_1.id
	end)
end

function var_0_0.getStoryGroupList(arg_18_0)
	if not arg_18_0._storyGroupList then
		arg_18_0:_initStoryGroupList()
	end

	return arg_18_0._storyGroupList
end

function var_0_0.getStoryGroupConfig(arg_19_0, arg_19_1)
	return arg_19_0._storyGroupConfig.configDict[arg_19_1]
end

function var_0_0._initStoryChapterList(arg_20_0)
	arg_20_0._storyChapterList = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0._storyChapterConfig.configDict) do
		table.insert(arg_20_0._storyChapterList, iter_20_1)
	end

	table.sort(arg_20_0._storyChapterList, function(arg_21_0, arg_21_1)
		if arg_21_0.order ~= arg_21_1.order then
			return arg_21_0.order < arg_21_1.order
		end

		return arg_21_0.id < arg_21_1.id
	end)
end

function var_0_0.getStoryChapterList(arg_22_0)
	if not arg_22_0._storyChapterList then
		arg_22_0:_initStoryChapterList()
	end

	return arg_22_0._storyChapterList
end

function var_0_0.getStoryChapterConfig(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._storyChapterConfig.configDict[arg_23_1]

	if not var_23_0 then
		logError("章节不存在, ID: " .. tostring(arg_23_1))
	end

	return var_23_0
end

function var_0_0._sortBystoryChapterId(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0.instance:getStoryChapterConfig(arg_24_0)
	local var_24_1 = var_0_0.instance:getStoryChapterConfig(arg_24_1)

	if var_24_0.order ~= var_24_1.order then
		return var_24_0.order < var_24_1.order
	end

	return var_24_0.id < var_24_1.id
end

function var_0_0.getDialogByFragment(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(lua_chapter_map_element.configDict) do
		if iter_25_1.fragment == arg_25_1 and not string.nilorempty(iter_25_1.param) then
			return tonumber(iter_25_1.param)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
