module("modules.logic.versionactivity3_1.enter.controller.VersionActivity3_1EnterController", package.seeall)

local var_0_0 = class("VersionActivity3_1EnterController", VersionActivityFixedEnterController)

function var_0_0.openVersionActivityEnterView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.openEnterViewCb = arg_1_1
	arg_1_0.openEnterViewCbObj = arg_1_2

	local var_1_0 = VersionActivity3_1Enum.ActivityId.EnterView
	local var_1_1 = VersionActivityEnterHelper.getActIdList(VersionActivity3_1Enum.EnterViewActSetting)
	local var_1_2 = {
		actId = var_1_0,
		jumpActId = arg_1_3,
		activityIdList = var_1_1,
		activitySettingList = VersionActivity3_1Enum.EnterViewActSetting,
		isExitFight = arg_1_5
	}
	local var_1_3

	if arg_1_4 then
		var_1_2.isDirectOpen = true
	else
		var_1_3 = arg_1_0._internalOpenEnterView

		if TimeUtil.getDayFirstLoginRed(VersionActivity3_1Enum.EnterVideoDayKey) and (not arg_1_3 or arg_1_3 == VersionActivity3_1Enum.ActivityId.Dungeon) then
			var_1_2.playVideo = true
		end
	end

	local var_1_4 = ViewName.VersionActivity3_1EnterView

	arg_1_0:_internalOpenView(var_1_4, var_1_0, var_1_3, arg_1_0, var_1_2, arg_1_0.openEnterViewCb, arg_1_0.openEnterViewCbObj)
end

var_0_0.instance = var_0_0.New()

return var_0_0
