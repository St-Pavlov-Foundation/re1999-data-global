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

function var_0_0._initCGList(arg_4_0)
	arg_4_0._cgList = {}
	arg_4_0._cgDungeonList = {}
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
			table.insert(arg_4_0._cgDungeonList, iter_4_3)
		end
	end
end

function var_0_0.getCGList(arg_6_0, arg_6_1)
	if not arg_6_0._cgList then
		arg_6_0:_initCGList()
	end

	if arg_6_1 == HandbookEnum.CGType.Dungeon then
		return arg_6_0._cgDungeonList
	elseif arg_6_1 == HandbookEnum.CGType.Role then
		return arg_6_0._cgRoleList
	end

	return arg_6_0._cgList
end

function var_0_0.getDungeonCGList(arg_7_0)
	if not arg_7_0._cgList then
		arg_7_0:_initCGList()
	end

	return arg_7_0._cgDungeonList
end

function var_0_0.getRoleCGList(arg_8_0)
	if not arg_8_0._cgList then
		arg_8_0:_initCGList()
	end

	return arg_8_0._cgRoleList
end

function var_0_0.getCGCount(arg_9_0)
	if not arg_9_0._cgList then
		arg_9_0:_initCGList()
	end

	return arg_9_0._cgList and #arg_9_0._cgList or 0
end

function var_0_0.getCGConfig(arg_10_0, arg_10_1)
	return arg_10_0._cgConfig.configDict[arg_10_1]
end

function var_0_0.getCGIndex(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._cgList

	if arg_11_2 == HandbookEnum.CGType.Dungeon then
		var_11_0 = arg_11_0._cgDungeonList
	elseif arg_11_2 == HandbookEnum.CGType.Role then
		var_11_0 = arg_11_0._cgRoleList
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.id == arg_11_1 then
			return iter_11_0
		end
	end

	return 0
end

function var_0_0._initStoryGroupList(arg_12_0)
	arg_12_0._storyGroupList = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0._storyGroupConfig.configDict) do
		table.insert(arg_12_0._storyGroupList, iter_12_1)
	end

	table.sort(arg_12_0._storyGroupList, function(arg_13_0, arg_13_1)
		if arg_13_0.storyChapterId ~= arg_13_1.storyChapterId then
			return arg_12_0._sortBystoryChapterId(arg_13_0.storyChapterId, arg_13_1.storyChapterId)
		end

		if arg_13_0.order ~= arg_13_1.order then
			return arg_13_0.order < arg_13_1.order
		end

		return arg_13_0.id < arg_13_1.id
	end)
end

function var_0_0.getStoryGroupList(arg_14_0)
	if not arg_14_0._storyGroupList then
		arg_14_0:_initStoryGroupList()
	end

	return arg_14_0._storyGroupList
end

function var_0_0.getStoryGroupConfig(arg_15_0, arg_15_1)
	return arg_15_0._storyGroupConfig.configDict[arg_15_1]
end

function var_0_0._initStoryChapterList(arg_16_0)
	arg_16_0._storyChapterList = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0._storyChapterConfig.configDict) do
		table.insert(arg_16_0._storyChapterList, iter_16_1)
	end

	table.sort(arg_16_0._storyChapterList, function(arg_17_0, arg_17_1)
		if arg_17_0.order ~= arg_17_1.order then
			return arg_17_0.order < arg_17_1.order
		end

		return arg_17_0.id < arg_17_1.id
	end)
end

function var_0_0.getStoryChapterList(arg_18_0)
	if not arg_18_0._storyChapterList then
		arg_18_0:_initStoryChapterList()
	end

	return arg_18_0._storyChapterList
end

function var_0_0.getStoryChapterConfig(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._storyChapterConfig.configDict[arg_19_1]

	if not var_19_0 then
		logError("章节不存在, ID: " .. tostring(arg_19_1))
	end

	return var_19_0
end

function var_0_0._sortBystoryChapterId(arg_20_0, arg_20_1)
	local var_20_0 = var_0_0.instance:getStoryChapterConfig(arg_20_0)
	local var_20_1 = var_0_0.instance:getStoryChapterConfig(arg_20_1)

	if var_20_0.order ~= var_20_1.order then
		return var_20_0.order < var_20_1.order
	end

	return var_20_0.id < var_20_1.id
end

function var_0_0.getDialogByFragment(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(lua_chapter_map_element.configDict) do
		if iter_21_1.fragment == arg_21_1 and not string.nilorempty(iter_21_1.param) then
			return tonumber(iter_21_1.param)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
