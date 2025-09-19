module("modules.logic.handbook.config.HandbookConfig", package.seeall)

local var_0_0 = class("HandbookConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._cgConfig = nil
	arg_1_0._cgList = nil
	arg_1_0._chaptertypeConfig = nil
	arg_1_0._chapter2Type = {}
	arg_1_0._cgDict = {}
	arg_1_0._chapterCGDict = {}
	arg_1_0._storyGroupConfig = nil
	arg_1_0._storyGroupList = nil
	arg_1_0._storyChapterConfig = nil
	arg_1_0._storyChapterList = nil
	arg_1_0._skinThemeGroupCfg = nil
	arg_1_0._skinThemeCfg = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"cg",
		"handbook_story_group",
		"handbook_story_chapter",
		"handbook_character",
		"handbook_equip",
		"handbook_skin_high",
		"handbook_skin_low",
		"chapter_type"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "cg" then
		arg_3_0._cgConfig = arg_3_2
	elseif arg_3_1 == "handbook_story_group" then
		arg_3_0._storyGroupConfig = arg_3_2
	elseif arg_3_1 == "handbook_story_chapter" then
		arg_3_0._storyChapterConfig = arg_3_2
	elseif arg_3_1 == "handbook_skin_high" then
		arg_3_0._skinThemeGroupCfg = arg_3_2
	elseif arg_3_1 == "handbook_skin_low" then
		arg_3_0._skinThemeCfg = arg_3_2
		arg_3_0._isInitSkinSuitFinish = false
	elseif arg_3_1 == "chapter_type" then
		arg_3_0._chaptertypeConfig = arg_3_2
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
	arg_4_0:_initCGDict()
end

function var_0_0._initCGDict(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._chaptertypeConfig.configList) do
		local var_6_0 = {
			type = iter_6_1.typeId,
			cgTypeList = {},
			cgTypeDict = {}
		}

		arg_6_0._cgDict[iter_6_1.typeId] = var_6_0
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._storyChapterConfig.configList) do
		arg_6_0._chapter2Type[iter_6_3.id] = iter_6_3.type
	end

	for iter_6_4, iter_6_5 in pairs(arg_6_0._cgList) do
		local var_6_1 = iter_6_5.storyChapterId
		local var_6_2 = arg_6_0._chapter2Type[var_6_1]
		local var_6_3 = arg_6_0._cgDict[var_6_2]

		var_6_3.cgTypeDict[iter_6_5.storyChapterId] = var_6_3.cgTypeDict[iter_6_5.storyChapterId] or {}

		table.insert(var_6_3.cgTypeDict[iter_6_5.storyChapterId], iter_6_5)
		table.insert(var_6_3.cgTypeList, iter_6_5)
	end
end

function var_0_0.getCGList(arg_7_0, arg_7_1)
	if not arg_7_0._cgList then
		arg_7_0:_initCGConfig()
	end

	if not arg_7_1 then
		return arg_7_0._cgList
	end

	local var_7_0 = arg_7_0._cgDict[arg_7_1]

	return var_7_0 and var_7_0.cgTypeList
end

function var_0_0.getCGCount(arg_8_0)
	if not arg_8_0._cgList then
		arg_8_0:_initCGConfig()
	end

	return arg_8_0._cgList and #arg_8_0._cgList or 0
end

function var_0_0.getCGConfig(arg_9_0, arg_9_1)
	return arg_9_0._cgConfig.configDict[arg_9_1]
end

function var_0_0.getCGIndex(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getCGList(arg_10_2)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.id == arg_10_1 then
			return iter_10_0
		end
	end

	return 0
end

function var_0_0.getCGDictByChapter(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._cgDict[arg_11_2] then
		arg_11_0:_initCGConfig()
	end

	return arg_11_0._cgDict[arg_11_2].cgTypeDict[arg_11_1]
end

function var_0_0.getCGDict(arg_12_0, arg_12_1)
	if not arg_12_0._cgDict[arg_12_1] then
		arg_12_0:_initCGConfig()
	end

	return arg_12_0._cgDict[arg_12_1].cgTypeDict
end

function var_0_0._initStoryGroupList(arg_13_0)
	arg_13_0._storyGroupList = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._storyGroupConfig.configDict) do
		table.insert(arg_13_0._storyGroupList, iter_13_1)
	end

	table.sort(arg_13_0._storyGroupList, function(arg_14_0, arg_14_1)
		if arg_14_0.storyChapterId ~= arg_14_1.storyChapterId then
			return arg_13_0._sortBystoryChapterId(arg_14_0.storyChapterId, arg_14_1.storyChapterId)
		end

		if arg_14_0.order ~= arg_14_1.order then
			return arg_14_0.order < arg_14_1.order
		end

		return arg_14_0.id < arg_14_1.id
	end)
end

function var_0_0.getStoryGroupList(arg_15_0)
	if not arg_15_0._storyGroupList then
		arg_15_0:_initStoryGroupList()
	end

	return arg_15_0._storyGroupList
end

function var_0_0.getStoryGroupConfig(arg_16_0, arg_16_1)
	return arg_16_0._storyGroupConfig.configDict[arg_16_1]
end

function var_0_0._initStoryChapterList(arg_17_0)
	arg_17_0._storyChapterList = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0._storyChapterConfig.configDict) do
		table.insert(arg_17_0._storyChapterList, iter_17_1)
	end

	table.sort(arg_17_0._storyChapterList, function(arg_18_0, arg_18_1)
		if arg_18_0.order ~= arg_18_1.order then
			return arg_18_0.order < arg_18_1.order
		end

		return arg_18_0.id < arg_18_1.id
	end)
end

function var_0_0.getStoryChapterList(arg_19_0)
	if not arg_19_0._storyChapterList then
		arg_19_0:_initStoryChapterList()
	end

	return arg_19_0._storyChapterList
end

function var_0_0.getStoryChapterConfig(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._storyChapterConfig.configDict[arg_20_1]

	if not var_20_0 then
		logError("章节不存在, ID: " .. tostring(arg_20_1))
	end

	return var_20_0
end

function var_0_0._sortBystoryChapterId(arg_21_0, arg_21_1)
	local var_21_0 = var_0_0.instance:getStoryChapterConfig(arg_21_0)
	local var_21_1 = var_0_0.instance:getStoryChapterConfig(arg_21_1)

	if var_21_0.order ~= var_21_1.order then
		return var_21_0.order < var_21_1.order
	end

	return var_21_0.id < var_21_1.id
end

function var_0_0.getDialogByFragment(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(lua_chapter_map_element.configDict) do
		if iter_22_1.fragment == arg_22_1 and not string.nilorempty(iter_22_1.param) then
			return tonumber(iter_22_1.param)
		end
	end
end

function var_0_0.getSkinThemeGroupCfgs(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}

	if arg_23_1 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._skinThemeGroupCfg.configList) do
			if iter_23_1.show then
				table.insert(var_23_0, iter_23_1)
			end
		end
	else
		var_23_0 = arg_23_0._skinThemeGroupCfg.configList
	end

	if arg_23_2 then
		table.sort(var_23_0, function(arg_24_0, arg_24_1)
			if arg_24_0.order ~= arg_24_1.order then
				return arg_24_0.order < arg_24_1.order
			end

			return arg_24_0.id < arg_24_1.id
		end)
	end

	return var_23_0
end

function var_0_0.getSkinThemeGroupCfg(arg_25_0, arg_25_1)
	return arg_25_0._skinThemeGroupCfg.configDict[arg_25_1]
end

function var_0_0.getSkinSuitCfgListInGroup(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0._skinThemeCfg.configDict) do
		if iter_26_1.highId == arg_26_1 then
			if arg_26_2 then
				if iter_26_1.show and iter_26_1.show == 1 then
					var_26_0[#var_26_0 + 1] = iter_26_1
				end
			else
				var_26_0[#var_26_0 + 1] = iter_26_1
			end
		end
	end

	return var_26_0
end

function var_0_0.getSkinSuitCfg(arg_27_0, arg_27_1)
	return arg_27_0._skinThemeCfg.configDict[arg_27_1]
end

function var_0_0.getSkinSuitIdBySkinId(arg_28_0, arg_28_1)
	arg_28_0:_initSkinSuitParam()

	return arg_28_0._skinId2suitIdDict and arg_28_0._skinId2suitIdDict[arg_28_1]
end

function var_0_0.getSkinIdListBySuitId(arg_29_0, arg_29_1)
	arg_29_0:_initSkinSuitParam()

	return arg_29_0._skinThemeIdListDict and arg_29_0._skinThemeIdListDict[arg_29_1]
end

function var_0_0._initSkinSuitParam(arg_30_0)
	if arg_30_0._isInitSkinSuitFinish or not arg_30_0._skinThemeCfg then
		return
	end

	arg_30_0._isInitSkinSuitFinish = true
	arg_30_0._skinThemeIdListDict = {}
	arg_30_0._skinId2suitIdDict = {}
	arg_30_0._highId2suitCfgListDict = {}

	local var_30_0 = arg_30_0._skinThemeCfg.configList

	for iter_30_0 = 1, #var_30_0 do
		local var_30_1 = var_30_0[iter_30_0]

		if var_30_1.show == 1 and not string.nilorempty(var_30_1.skinContain) then
			local var_30_2 = var_30_1.id
			local var_30_3 = string.splitToNumber(var_30_1.skinContain, "|") or {}

			arg_30_0._skinThemeIdListDict[var_30_2] = var_30_3

			for iter_30_1, iter_30_2 in ipairs(var_30_3) do
				arg_30_0._skinId2suitIdDict[iter_30_2] = var_30_2
			end

			if not arg_30_0._highId2suitCfgListDict[var_30_1.highId] then
				arg_30_0._highId2suitCfgListDict[var_30_1.highId] = {}
			end

			table.insert(arg_30_0._highId2suitCfgListDict[var_30_1.highId], var_30_1)
		end
	end
end

function var_0_0.getChapterTypeConfigList(arg_31_0)
	return arg_31_0._chaptertypeConfig.configList
end

var_0_0.instance = var_0_0.New()

return var_0_0
