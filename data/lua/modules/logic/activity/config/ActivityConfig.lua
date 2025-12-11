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
		"main_act_atmosphere",
		"activity_const"
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

local function var_0_1(arg_4_0)
	return lua_activity_const.configDict[arg_4_0]
end

function var_0_0._initMainActAtmosphere(arg_5_0)
	local var_5_0 = #lua_main_act_atmosphere.configList

	arg_5_0._mainActAtmosphereConfig = lua_main_act_atmosphere.configList[var_5_0]
end

function var_0_0.getMainActAtmosphereConfig(arg_6_0)
	return arg_6_0._mainActAtmosphereConfig
end

function var_0_0._initMainActExtraDisplay(arg_7_0)
	arg_7_0._mainActExtraDisplayList = {}

	for iter_7_0, iter_7_1 in ipairs(lua_main_act_extra_display.configList) do
		if iter_7_1.show == 1 then
			table.insert(arg_7_0._mainActExtraDisplayList, iter_7_1)
		end
	end

	table.sort(arg_7_0._mainActExtraDisplayList, function(arg_8_0, arg_8_1)
		if arg_8_0.sortId == arg_8_1.sortId then
			return arg_8_0.id < arg_8_1.id
		end

		return arg_8_0.sortId < arg_8_1.sortId
	end)

	if not arg_7_0._activityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay activityConfig is nil")

		return
	end

	arg_7_0._seasonActivityConfig = nil
	arg_7_0._rougeActivityConfig = nil
	arg_7_0._displayBindActivityList = {}

	local var_7_0 = 100
	local var_7_1 = #lua_activity.configList

	for iter_7_2 = var_7_1, 1, -1 do
		local var_7_2 = lua_activity.configList[iter_7_2]

		if var_7_2.extraDisplayId > 0 and not arg_7_0._displayBindActivityList[var_7_2.extraDisplayId] then
			arg_7_0._displayBindActivityList[var_7_2.extraDisplayId] = var_7_2
		end

		if var_7_0 < var_7_1 - iter_7_2 then
			break
		end
	end

	arg_7_0._seasonActivityConfig = arg_7_0._displayBindActivityList[ActivityEnum.MainViewActivityState.SeasonActivity]
	arg_7_0._rougeActivityConfig = arg_7_0._displayBindActivityList[ActivityEnum.MainViewActivityState.Rouge]

	if not arg_7_0._seasonActivityConfig then
		logWarn("ActivityConfig:_initMainActExtraDisplay seasonActivityConfig is nil")

		return
	end

	if not arg_7_0._rougeActivityConfig then
		logWarn("ActivityConfig:_initMainActExtraDisplay rougeActivityConfig is nil")

		return
	end
end

function var_0_0.getActivityByExtraDisplayId(arg_9_0, arg_9_1)
	return arg_9_1 and arg_9_0._displayBindActivityList[arg_9_1]
end

function var_0_0.getSesonActivityConfig(arg_10_0)
	return arg_10_0._seasonActivityConfig
end

function var_0_0.getRougeActivityConfig(arg_11_0)
	return arg_11_0._rougeActivityConfig
end

function var_0_0.getMainActExtraDisplayList(arg_12_0)
	return arg_12_0._mainActExtraDisplayList
end

function var_0_0.getActivityCo(arg_13_0, arg_13_1)
	if not arg_13_0._activityConfig.configDict[arg_13_1] then
		logError("前端活动配置表不存在活动:" .. tostring(arg_13_1))
	end

	return arg_13_0._activityConfig.configDict[arg_13_1]
end

function var_0_0.getActivityCenterCo(arg_14_0, arg_14_1)
	if not arg_14_0._activityCenterConfig.configDict[arg_14_1] then
		logError("前端活动配置表不存在活动中心:" .. tostring(arg_14_1))
	end

	return arg_14_0._activityCenterConfig.configDict[arg_14_1]
end

function var_0_0.getNorSignActivityCo(arg_15_0, arg_15_1, arg_15_2)
	return arg_15_0._norSignConfig.configDict[arg_15_1][arg_15_2]
end

function var_0_0.getNorSignActivityCos(arg_16_0, arg_16_1)
	return arg_16_0._norSignConfig.configDict[arg_16_1]
end

function var_0_0.initActivityDungeon(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._activityDungeonConfig.configList) do
		arg_17_0:addChapterId2ActId(iter_17_1.story1ChapterId, iter_17_1.id)
		arg_17_0:addChapterId2ActId(iter_17_1.story2ChapterId, iter_17_1.id)
		arg_17_0:addChapterId2ActId(iter_17_1.story3ChapterId, iter_17_1.id)
		arg_17_0:addChapterId2ActId(iter_17_1.hardChapterId, iter_17_1.id)
	end
end

function var_0_0.addChapterId2ActId(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		return
	end

	if arg_18_0.chapterId2ActId[arg_18_1] then
		logError(string.format("chapterId : %s multiple, exist actId : %s, current actId : %s", arg_18_1, arg_18_0.chapterId2ActId[arg_18_1], arg_18_2))

		return
	end

	arg_18_0.chapterId2ActId[arg_18_1] = arg_18_2
end

function var_0_0.getActIdByChapterId(arg_19_0, arg_19_1)
	return arg_19_0.chapterId2ActId[arg_19_1]
end

function var_0_0.getActivityDungeonConfig(arg_20_0, arg_20_1)
	return arg_20_0._activityDungeonConfig.configDict[arg_20_1]
end

function var_0_0.getChapterIdMode(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getActIdByChapterId(arg_21_1)

	if not var_21_0 then
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end

	local var_21_1 = arg_21_0:getActivityDungeonConfig(var_21_0)

	if arg_21_1 == var_21_1.story1ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif arg_21_1 == var_21_1.story2ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif arg_21_1 == var_21_1.story3ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif arg_21_1 == var_21_1.hardChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Hard
	else
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end
end

function var_0_0.getActivityShowTaskList(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0._activityShowConfig.configDict[arg_22_1][arg_22_2]
end

function var_0_0.getActivityShowTaskCount(arg_23_0, arg_23_1)
	return arg_23_0._activityShowConfig.configDict[arg_23_1]
end

function var_0_0.getActivityTabBgPathes(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getActivityCo(arg_24_1).tabBgPath

	return (string.split(var_24_0, "#"))
end

function var_0_0.getActivityTabButtonState(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getActivityCo(arg_25_1).tabButton
	local var_25_1 = string.splitToNumber(var_25_0, "#")
	local var_25_2 = var_25_1 and var_25_1[1] == 1
	local var_25_3 = var_25_1 and var_25_1[2] == 1
	local var_25_4 = var_25_1 and var_25_1[3] == 1

	return var_25_2, var_25_3, var_25_4
end

function var_0_0.getActivityEnterViewBgm(arg_26_0, arg_26_1)
	return arg_26_0:getActivityCo(arg_26_1).tabBgmId
end

function var_0_0.isPermanent(arg_27_0, arg_27_1)
	return arg_27_0:getActivityCo(arg_27_1).isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function var_0_0.getPermanentChildActList(arg_28_0, arg_28_1)
	local var_28_0 = {}

	if not arg_28_0._belongPermanentActDict then
		arg_28_0:_initBelongPermanentActDict()
	end

	var_28_0 = arg_28_0._belongPermanentActDict[arg_28_1] or var_28_0

	return var_28_0
end

function var_0_0._initBelongPermanentActDict(arg_29_0)
	arg_29_0._belongPermanentActDict = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0._activityConfig.configDict) do
		if arg_29_0:isPermanent(iter_29_0) then
			local var_29_0 = iter_29_1.permanentParentAcitivityId

			if var_29_0 ~= 0 then
				local var_29_1 = arg_29_0._belongPermanentActDict[var_29_0]

				if not var_29_1 then
					var_29_1 = {}
					arg_29_0._belongPermanentActDict[var_29_0] = var_29_1
				end

				table.insert(var_29_1, iter_29_0)
			end
		end
	end
end

function var_0_0.getActivityRedDotId(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getActivityCo(arg_30_1)

	return var_30_0 and var_30_0.redDotId or 0
end

function var_0_0.getActivityCenterRedDotId(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getActivityCenterCo(arg_31_1)

	return var_31_0 and var_31_0.reddotid or 0
end

function var_0_0.__init_activity(arg_32_0, arg_32_1)
	arg_32_0._activityConfig = arg_32_1
	arg_32_0._typeId2ActivityCOList = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1.configList) do
		local var_32_0 = iter_32_1.typeId

		arg_32_0._typeId2ActivityCOList[var_32_0] = arg_32_0._typeId2ActivityCOList[var_32_0] or {}

		table.insert(arg_32_0._typeId2ActivityCOList[var_32_0], iter_32_1)
	end

	for iter_32_2, iter_32_3 in pairs(arg_32_0._typeId2ActivityCOList) do
		table.sort(iter_32_3, function(arg_33_0, arg_33_1)
			return arg_33_0.id > arg_33_1.id
		end)
	end
end

function var_0_0.typeId2ActivityCOList(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return {}
	end

	return arg_34_0._typeId2ActivityCOList[arg_34_1] or {}
end

function var_0_0.getConstAsNum(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = var_0_1(arg_35_1)

	if not var_35_0 then
		return arg_35_2
	end

	return tonumber(var_35_0.strValue) or arg_35_2
end

function var_0_0.getConstAsNumList(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_2 = arg_36_2 or "#"

	local var_36_0 = var_0_1(arg_36_1)

	if not var_36_0 then
		return arg_36_3
	end

	local var_36_1 = var_36_0.strValue

	if string.nilorempty(var_36_1) then
		return arg_36_3
	end

	return string.splitToNumber(var_36_1, arg_36_2) or arg_36_3
end

var_0_0.instance = var_0_0.New()

return var_0_0
