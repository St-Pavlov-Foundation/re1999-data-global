module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEyeViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_8BossStoryEyeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity2_8BossStoryEyeView.New())

	return var_1_0
end

return var_0_0
