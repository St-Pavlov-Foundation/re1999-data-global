module("modules.logic.versionactivity2_7.enter.view.VersionActivity2_7EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_7EnterViewContainer", VersionActivityFixedEnterViewContainer)

function var_0_0.getViews(arg_1_0)
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity2_7EnterBgmView.New()
	}
end

function var_0_0.getMultiViews(arg_2_0)
	return {
		VersionActivity2_7DungeonEnterView.New(),
		V2a7_Act191EnterView.New(),
		V2a6_CooperGarlandEnterView.New(),
		V2a7_LengZhou6EnterView.New(),
		V2a7_v2a0_ReactivityEnterview.New(),
		Act183VersionActivityEnterView.New(),
		RoleStoryEnterView.New()
	}
end

return var_0_0
