module("modules.logic.act189.config.ShortenActConfig", package.seeall)

local var_0_0 = string.format
local var_0_1 = table.insert
local var_0_2 = class("ShortenActConfig", BaseConfig)

function var_0_2.reqConfigNames(arg_1_0)
	return {
		"activity189_shortenact",
		"activity189_shortenact_style"
	}
end

function var_0_2.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "activity189_shortenact" then
		arg_2_0:__init_activity189_shortenact(arg_2_2)
	end
end

function var_0_2.__init_activity189_shortenact(arg_3_0, arg_3_1)
	local var_3_0

	if isDebugBuild then
		local var_3_1 = var_0_0("[logError] 189_运营改版活动.xlsx.xlsx - export_版本缩期活动_设置")

		var_3_0 = ConfigsCheckerMgr.instance:createStrBuf(var_3_1)
	end

	local var_3_2 = GameBranchMgr.instance:VHyphenA()
	local var_3_3 = arg_3_1.configList or {}

	for iter_3_0 = #var_3_3, 1, -1 do
		local var_3_4 = var_3_3[iter_3_0]

		if var_3_4.version == var_3_2 then
			arg_3_0._setting = var_3_4

			return
		end
	end

	if isDebugBuild then
		var_3_0:appendLine(var_0_0("%s版本未上线版本缩期运营活动", var_3_2))
		var_3_0:logWarnIfGot()
	end

	arg_3_0._setting = {
		activityId = 12607,
		style = 1
	}
end

function var_0_2.getSettingId(arg_4_0)
	return arg_4_0._setting.settingId
end

function var_0_2.getSettingCO(arg_5_0)
	return Activity189Config.instance:getSettingCO(arg_5_0:getSettingId())
end

function var_0_2.getActivityId(arg_6_0)
	local var_6_0 = arg_6_0._setting.activityId

	if var_6_0 then
		return var_6_0
	end

	return arg_6_0:getSettingCO().activityId
end

function var_0_2.getStyleCO(arg_7_0)
	return lua_activity189_shortenact_style.configDict[arg_7_0._setting.style]
end

function var_0_2.getBonusList(arg_8_0)
	return Activity189Config.instance:getBonusList(arg_8_0:getSettingId())
end

function var_0_2.getTaskCO_ReadTask(arg_9_0)
	return Activity189Config.instance:getTaskCO_ReadTask(arg_9_0:getActivityId())
end

function var_0_2.getTaskCO_ReadTask_Tag(arg_10_0, arg_10_1)
	return Activity189Config.instance:getTaskCO_ReadTask_Tag(arg_10_0:getActivityId(), arg_10_1)
end

function var_0_2.getTaskCO_ReadTask_Tag_TaskId(arg_11_0, arg_11_1, arg_11_2)
	return Activity189Config.instance:getTaskCO_ReadTask_Tag(arg_11_0:getActivityId(), arg_11_1, arg_11_2)
end

var_0_2.instance = var_0_2.New()

return var_0_2
