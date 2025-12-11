module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity3_1EnterViewContainer", VersionActivityFixedEnterViewContainer)

function var_0_0.getViews(arg_1_0)
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_1EnterBgmView.New()
	}
end

function var_0_0.getMultiViews(arg_2_0)
	return {
		VersionActivity3_1DungeonEnterView.New(),
		V3a1_Act191EnterView.New(),
		SurvivalEnterView.New(),
		RoleStoryEnterView.New(),
		V3a1_YeShuMeiEnterView.New(),
		V1a6_BossRush_EnterView.New(),
		V3a1_v2a4_ReactivityEnterview.New(),
		V3a1_GaoSiNiao_EnterView.New()
	}
end

return var_0_0
