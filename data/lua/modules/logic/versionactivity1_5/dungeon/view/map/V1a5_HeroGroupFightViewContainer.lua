module("modules.logic.versionactivity1_5.dungeon.view.map.V1a5_HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("V1a5_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.addFirstViews(arg_1_0, arg_1_1)
	var_0_0.super.addFirstViews(arg_1_0, arg_1_1)
	table.insert(arg_1_1, V1a5_HeroGroupFightLayoutView.New())
end

function var_0_0.addLastViews(arg_2_0, arg_2_1)
	var_0_0.super.addLastViews(arg_2_0, arg_2_1)
	table.insert(arg_2_1, V1a5HeroGroupBuildingView.New())
end

return var_0_0
