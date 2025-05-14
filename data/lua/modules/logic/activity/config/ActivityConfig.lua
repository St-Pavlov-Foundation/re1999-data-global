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
		arg_3_0._activityConfig = arg_3_2
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

	for iter_6_2 = #lua_activity.configList, 1, -1 do
		local var_6_0 = lua_activity.configList[iter_6_2]

		if var_6_0.extraDisplayId == ActivityEnum.MainViewActivityState.SeasonActivity and not arg_6_0._seasonActivityConfig then
			arg_6_0._seasonActivityConfig = var_6_0
		elseif var_6_0.extraDisplayId == ActivityEnum.MainViewActivityState.Rouge and not arg_6_0._rougeActivityConfig then
			arg_6_0._rougeActivityConfig = var_6_0
		end

		if arg_6_0._seasonActivityConfig and arg_6_0._rougeActivityConfig then
			break
		end
	end

	if not arg_6_0._seasonActivityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay seasonActivityConfig is nil")

		return
	end

	if not arg_6_0._rougeActivityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay rougeActivityConfig is nil")

		return
	end
end

function var_0_0.getSesonActivityConfig(arg_8_0)
	return arg_8_0._seasonActivityConfig
end

function var_0_0.getRougeActivityConfig(arg_9_0)
	return arg_9_0._rougeActivityConfig
end

function var_0_0.getMainActExtraDisplayList(arg_10_0)
	return arg_10_0._mainActExtraDisplayList
end

function var_0_0.getActivityCo(arg_11_0, arg_11_1)
	if not arg_11_0._activityConfig.configDict[arg_11_1] then
		logError("前端活动配置表不存在活动:" .. tostring(arg_11_1))
	end

	return arg_11_0._activityConfig.configDict[arg_11_1]
end

function var_0_0.getActivityCenterCo(arg_12_0, arg_12_1)
	if not arg_12_0._activityCenterConfig.configDict[arg_12_1] then
		logError("前端活动配置表不存在活动中心:" .. tostring(arg_12_1))
	end

	return arg_12_0._activityCenterConfig.configDict[arg_12_1]
end

function var_0_0.getNorSignActivityCo(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0._norSignConfig.configDict[arg_13_1][arg_13_2]
end

function var_0_0.getNorSignActivityCos(arg_14_0, arg_14_1)
	return arg_14_0._norSignConfig.configDict[arg_14_1]
end

function var_0_0.initActivityDungeon(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._activityDungeonConfig.configList) do
		arg_15_0:addChapterId2ActId(iter_15_1.story1ChapterId, iter_15_1.id)
		arg_15_0:addChapterId2ActId(iter_15_1.story2ChapterId, iter_15_1.id)
		arg_15_0:addChapterId2ActId(iter_15_1.story3ChapterId, iter_15_1.id)
		arg_15_0:addChapterId2ActId(iter_15_1.hardChapterId, iter_15_1.id)
	end
end

function var_0_0.addChapterId2ActId(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		return
	end

	if arg_16_0.chapterId2ActId[arg_16_1] then
		logError(string.format("chapterId : %s multiple, exist actId : %s, current actId : %s", arg_16_1, arg_16_0.chapterId2ActId[arg_16_1], arg_16_2))

		return
	end

	arg_16_0.chapterId2ActId[arg_16_1] = arg_16_2
end

function var_0_0.getActIdByChapterId(arg_17_0, arg_17_1)
	return arg_17_0.chapterId2ActId[arg_17_1]
end

function var_0_0.getActivityDungeonConfig(arg_18_0, arg_18_1)
	return arg_18_0._activityDungeonConfig.configDict[arg_18_1]
end

function var_0_0.getChapterIdMode(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getActIdByChapterId(arg_19_1)

	if not var_19_0 then
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end

	local var_19_1 = arg_19_0:getActivityDungeonConfig(var_19_0)

	if arg_19_1 == var_19_1.story1ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif arg_19_1 == var_19_1.story2ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif arg_19_1 == var_19_1.story3ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif arg_19_1 == var_19_1.hardChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Hard
	else
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end
end

function var_0_0.getActivityShowTaskList(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0._activityShowConfig.configDict[arg_20_1][arg_20_2]
end

function var_0_0.getActivityShowTaskCount(arg_21_0, arg_21_1)
	return arg_21_0._activityShowConfig.configDict[arg_21_1]
end

function var_0_0.getActivityTabBgPathes(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getActivityCo(arg_22_1).tabBgPath

	return (string.split(var_22_0, "#"))
end

function var_0_0.getActivityTabButtonState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getActivityCo(arg_23_1).tabButton
	local var_23_1 = string.splitToNumber(var_23_0, "#")
	local var_23_2 = var_23_1 and var_23_1[1] == 1
	local var_23_3 = var_23_1 and var_23_1[2] == 1
	local var_23_4 = var_23_1 and var_23_1[3] == 1

	return var_23_2, var_23_3, var_23_4
end

function var_0_0.getActivityEnterViewBgm(arg_24_0, arg_24_1)
	return arg_24_0:getActivityCo(arg_24_1).tabBgmId
end

function var_0_0.isPermanent(arg_25_0, arg_25_1)
	return arg_25_0:getActivityCo(arg_25_1).isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function var_0_0.getPermanentChildActList(arg_26_0, arg_26_1)
	local var_26_0 = {}

	if not arg_26_0._belongPermanentActDict then
		arg_26_0:_initBelongPermanentActDict()
	end

	var_26_0 = arg_26_0._belongPermanentActDict[arg_26_1] or var_26_0

	return var_26_0
end

function var_0_0._initBelongPermanentActDict(arg_27_0)
	arg_27_0._belongPermanentActDict = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0._activityConfig.configDict) do
		if arg_27_0:isPermanent(iter_27_0) then
			local var_27_0 = iter_27_1.permanentParentAcitivityId

			if var_27_0 ~= 0 then
				local var_27_1 = arg_27_0._belongPermanentActDict[var_27_0]

				if not var_27_1 then
					var_27_1 = {}
					arg_27_0._belongPermanentActDict[var_27_0] = var_27_1
				end

				table.insert(var_27_1, iter_27_0)
			end
		end
	end
end

function var_0_0.getActivityRedDotId(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getActivityCo(arg_28_1)

	return var_28_0 and var_28_0.redDotId or 0
end

function var_0_0.getActivityCenterRedDotId(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getActivityCenterCo(arg_29_1)

	return var_29_0 and var_29_0.reddotid or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
