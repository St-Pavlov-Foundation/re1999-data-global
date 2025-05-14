module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_6SkillViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_6SkillView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function var_0_0.onContainerInit(arg_3_0)
	return
end

return var_0_0
