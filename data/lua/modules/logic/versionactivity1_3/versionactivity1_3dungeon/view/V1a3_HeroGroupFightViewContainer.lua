module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.V1a3_HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("V1a3_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.addFirstViews(arg_1_0, arg_1_1)
	var_0_0.super.addFirstViews(arg_1_0, arg_1_1)
	table.insert(arg_1_1, HeroGroupFairyLandView.New())
end

return var_0_0
