module("modules.logic.herogroup.view.HeroGroupFightFiveHeroViewContainer", package.seeall)

local var_0_0 = class("HeroGroupFightFiveHeroViewContainer", HeroGroupFightViewContainer)

function var_0_0.defineFightView(arg_1_0)
	arg_1_0._heroGroupFightView = HeroGroupFightFiveHeroView.New()
	arg_1_0._heroGroupFightListView = HeroGroupListFiveHeroView.New()
end

return var_0_0
