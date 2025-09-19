module("modules.logic.activity.config.ActivityConfig", package.seeall)

local var_0_0 = class("ActivityConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._activityConfig = nil
	arg_1_0._activityCenterConfig = nil
	arg_1_0._norSignConfig = nil
	arg_1_0._activityDungeonConfig = nil
	arg_1_0._activityShowConfig = nil
	arg_1_0.chapterId2ActId = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity",
		"activity_center",
		"activity101",
		"activity_dungeon",
		"activity_show",
		"main_act_extra_display",
		"main_act_atmosphere"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity" then
		arg_3_0:__init_activity(arg_3_2)
	elseif arg_3_1 == "activity_center" then
		arg_3_0._activityCenterConfig = arg_3_2
	elseif arg_3_1 == "activity101" then
		arg_3_0._norSignConfig = arg_3_2
	elseif arg_3_1 == "activity_dungeon" then
		arg_3_0._activityDungeonConfig = arg_3_2

		arg_3_0:initActivityDungeon()
	elseif arg_3_1 == "activity_show" then
		arg_3_0._activityShowConfig = arg_3_2
	elseif arg_3_1 == "main_act_extra_display" then
		arg_3_0:_initMainActExtraDisplay()
	elseif arg_3_1 == "main_act_atmosphere" then
		arg_3_0:_initMainActAtmosphere()
	end
end

function var_0_0._initMainActAtmosphere(arg_4_0)
	local var_4_0 = #lua_main_act_atmosphere.configList

	arg_4_0._mainActAtmosphereConfig = lua_main_act_atmosphere.configList[var_4_0]
end

function var_0_0.getMainActAtmosphereConfig(arg_5_0)
	return arg_5_0._mainActAtmosphereConfig
end

function var_0_0._initMainActExtraDisplay(arg_6_0)
	arg_6_0._mainActExtraDisplayList = {}

	for iter_6_0, iter_6_1 in ipairs(lua_main_act_extra_display.configList) do
		if iter_6_1.show == 1 then
			table.insert(arg_6_0._mainActExtraDisplayList, iter_6_1)
		end
	end

	table.sort(arg_6_0._mainActExtraDisplayList, function(arg_7_0, arg_7_1)
		if arg_7_0.sortId == arg_7_1.sortId then
			return arg_7_0.id < arg_7_1.id
		end

		return arg_7_0.sortId < arg_7_1.sortId
	end)

	if not arg_6_0._activityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay activityConfig is nil")

		return
	end

	arg_6_0._seasonActivityConfig = nil
	arg_6_0._rougeActivityConfig = nil
	arg_6_0._displayBindActivityList = {}

	local var_6_0 = 100
	local var_6_1 = #lua_activity.configList

	for iter_6_2 = var_6_1, 1, -1 do
		local var_6_2 = lua_activity.configList[iter_6_2]

		if var_6_2.extraDisplayId > 0 and not arg_6_0._displayBindActivityList[var_6_2.extraDisplayId] then
			arg_6_0._displayBindActivityList[var_6_2.extraDisplayId] = var_6_2
		end

		if var_6_0 < var_6_1 - iter_6_2 then
			break
		end
	end

	arg_6_0._seasonActivityConfig = arg_6_0._displayBindActivityList[ActivityEnum.MainViewActivityState.SeasonActivity]
	arg_6_0._rougeActivityConfig = arg_6_0._displayBindActivityList[ActivityEnum.MainViewActivityState.Rouge]

	if not arg_6_0._seasonActivityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay seasonActivityConfig is nil")

		return
	end

	if not arg_6_0._rougeActivityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay rougeActivityConfig is nil")

		return
	end
end

function var_0_0.getActivityByExtraDisplayId(arg_8_0, arg_8_1)
	return arg_8_1 and arg_8_0._displayBindActivityList[arg_8_1]
end

function var_0_0.getSesonActivityConfig(arg_9_0)
	return arg_9_0._seasonActivityConfig
end

function var_0_0.getRougeActivityConfig(arg_10_0)
	return arg_10_0._rougeActivityConfig
end

function var_0_0.getMainActExtraDisplayList(arg_11_0)
	return arg_11_0._mainActExtraDisplayList
end

function var_0_0.getActivityCo(arg_12_0, arg_12_1)
	if not arg_12_0._activityConfig.configDict[arg_12_1] then
		logError("前端活动配置表不存在活动:" .. tostring(arg_12_1))
	end

	return arg_12_0._activityConfig.configDict[arg_12_1]
end

function var_0_0.getActivityCenterCo(arg_13_0, arg_13_1)
	if not arg_13_0._activityCenterConfig.configDict[arg_13_1] then
		logError("前端活动配置表不存在活动中心:" .. tostring(arg_13_1))
	end

	return arg_13_0._activityCenterConfig.configDict[arg_13_1]
end

function var_0_0.getNorSignActivityCo(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0._norSignConfig.configDict[arg_14_1][arg_14_2]
end

function var_0_0.getNorSignActivityCos(arg_15_0, arg_15_1)
	return arg_15_0._norSignConfig.configDict[arg_15_1]
end

function var_0_0.initActivityDungeon(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._activityDungeonConfig.configList) do
		arg_16_0:addChapterId2ActId(iter_16_1.story1ChapterId, iter_16_1.id)
		arg_16_0:addChapterId2ActId(iter_16_1.story2ChapterId, iter_16_1.id)
		arg_16_0:addChapterId2ActId(iter_16_1.story3ChapterId, iter_16_1.id)
		arg_16_0:addChapterId2ActId(iter_16_1.hardChapterId, iter_16_1.id)
	end
end

function var_0_0.addChapterId2ActId(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		return
	end

	if arg_17_0.chapterId2ActId[arg_17_1] then
		logError(string.format("chapterId : %s multiple, exist actId : %s, current actId : %s", arg_17_1, arg_17_0.chapterId2ActId[arg_17_1], arg_17_2))

		return
	end

	arg_17_0.chapterId2ActId[arg_17_1] = arg_17_2
end

function var_0_0.getActIdByChapterId(arg_18_0, arg_18_1)
	return arg_18_0.chapterId2ActId[arg_18_1]
end

function var_0_0.getActivityDungeonConfig(arg_19_0, arg_19_1)
	return arg_19_0._activityDungeonConfig.configDict[arg_19_1]
end

function var_0_0.getChapterIdMode(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getActIdByChapterId(arg_20_1)

	if not var_20_0 then
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end

	local var_20_1 = arg_20_0:getActivityDungeonConfig(var_20_0)

	if arg_20_1 == var_20_1.story1ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif arg_20_1 == var_20_1.story2ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif arg_20_1 == var_20_1.story3ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif arg_20_1 == var_20_1.hardChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Hard
	else
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end
end

function var_0_0.getActivityShowTaskList(arg_21_0, arg_21_1, arg_21_2)
	return arg_21_0._activityShowConfig.configDict[arg_21_1][arg_21_2]
end

function var_0_0.getActivityShowTaskCount(arg_22_0, arg_22_1)
	return arg_22_0._activityShowConfig.configDict[arg_22_1]
end

function var_0_0.getActivityTabBgPathes(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getActivityCo(arg_23_1).tabBgPath

	return (string.split(var_23_0, "#"))
end

function var_0_0.getActivityTabButtonState(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getActivityCo(arg_24_1).tabButton
	local var_24_1 = string.splitToNumber(var_24_0, "#")
	local var_24_2 = var_24_1 and var_24_1[1] == 1
	local var_24_3 = var_24_1 and var_24_1[2] == 1
	local var_24_4 = var_24_1 and var_24_1[3] == 1

	return var_24_2, var_24_3, var_24_4
end

function var_0_0.getActivityEnterViewBgm(arg_25_0, arg_25_1)
	return arg_25_0:getActivityCo(arg_25_1).tabBgmId
end

function var_0_0.isPermanent(arg_26_0, arg_26_1)
	return arg_26_0:getActivityCo(arg_26_1).isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function var_0_0.getPermanentChildActList(arg_27_0, arg_27_1)
	local var_27_0 = {}

	if not arg_27_0._belongPermanentActDict then
		arg_27_0:_initBelongPermanentActDict()
	end

	var_27_0 = arg_27_0._belongPermanentActDict[arg_27_1] or var_27_0

	return var_27_0
end

function var_0_0._initBelongPermanentActDict(arg_28_0)
	arg_28_0._belongPermanentActDict = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0._activityConfig.configDict) do
		if arg_28_0:isPermanent(iter_28_0) then
			local var_28_0 = iter_28_1.permanentParentAcitivityId

			if var_28_0 ~= 0 then
				local var_28_1 = arg_28_0._belongPermanentActDict[var_28_0]

				if not var_28_1 then
					var_28_1 = {}
					arg_28_0._belongPermanentActDict[var_28_0] = var_28_1
				end

				table.insert(var_28_1, iter_28_0)
			end
		end
	end
end

function var_0_0.getActivityRedDotId(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getActivityCo(arg_29_1)

	return var_29_0 and var_29_0.redDotId or 0
end

function var_0_0.getActivityCenterRedDotId(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getActivityCenterCo(arg_30_1)

	return var_30_0 and var_30_0.reddotid or 0
end

function var_0_0.__init_activity(arg_31_0, arg_31_1)
	arg_31_0._activityConfig = arg_31_1
	arg_31_0._typeId2ActivityCOList = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_1.configList) do
		local var_31_0 = iter_31_1.typeId

		arg_31_0._typeId2ActivityCOList[var_31_0] = arg_31_0._typeId2ActivityCOList[var_31_0] or {}

		table.insert(arg_31_0._typeId2ActivityCOList[var_31_0], iter_31_1)
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0._typeId2ActivityCOList) do
		table.sort(iter_31_3, function(arg_32_0, arg_32_1)
			return arg_32_0.id > arg_32_1.id
		end)
	end
end

function var_0_0.typeId2ActivityCOList(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return {}
	end

	return arg_33_0._typeId2ActivityCOList[arg_33_1] or {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
