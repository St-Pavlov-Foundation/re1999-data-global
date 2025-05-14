module("modules.logic.weekwalk.view.HeroGroupFightWeekwalkViewContainer", package.seeall)

local var_0_0 = class("HeroGroupFightWeekwalkViewContainer", HeroGroupFightViewContainer)

function var_0_0.defineFightView(arg_1_0)
	var_0_0.super.defineFightView(arg_1_0)

	arg_1_0._heroGroupFightListView = WeekWalkHeroGroupListView.New()
end

function var_0_0.addLastViews(arg_2_0, arg_2_1)
	table.insert(arg_2_1, HeroGroupFightWeekWalkView.New())
end

return var_0_0
