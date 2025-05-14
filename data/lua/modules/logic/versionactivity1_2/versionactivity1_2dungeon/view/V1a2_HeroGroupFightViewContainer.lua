module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.V1a2_HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("V1a2_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.defineFightView(arg_1_0)
	var_0_0.super.defineFightView(arg_1_0)

	arg_1_0._heroGroupFightView = VersionActivity_1_2_HeroGroupView.New()
end

function var_0_0.addLastViews(arg_2_0, arg_2_1)
	var_0_0.super.addLastViews(arg_2_0)
	table.insert(arg_2_1, VersionActivity_1_2_HeroGroupBuildView.New())
end

return var_0_0
