module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupViewContainer", package.seeall)

local var_0_0 = class("VersionActivity_1_2_HeroGroupViewContainer", HeroGroupFightViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._heroGroupFightView = VersionActivity_1_2_HeroGroupView.New()

	return {
		arg_1_0._heroGroupFightView,
		VersionActivity_1_2_HeroGroupBuildView.New(),
		VersionActivity_1_2_HeroGroupListView.New(),
		HeroGroupFightViewLevel.New(),
		HeroGroupFightViewRule.New(),
		CheckActivityEndView.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns"),
		TabViewGroup.New(2, "#go_righttop/#go_power")
	}
end

return var_0_0
