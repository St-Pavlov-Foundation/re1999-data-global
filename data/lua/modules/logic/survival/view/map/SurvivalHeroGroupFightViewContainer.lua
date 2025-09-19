module("modules.logic.survival.view.map.SurvivalHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("SurvivalHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.defineFightView(arg_1_0)
	var_0_0.super.defineFightView(arg_1_0)

	arg_1_0._heroGroupFightView = SurvivalHeroGroupFightView.New()
	arg_1_0._heroGroupFightListView = SurvivalHeroGroupListView.New()
end

function var_0_0.getFightRuleView(arg_2_0)
	return SurvivalHeroGroupFightView_Rule.New()
end

function var_0_0.getFightLevelView(arg_3_0)
	return SurvivalHeroGroupFightView_Level.New()
end

function var_0_0.addLastViews(arg_4_0, arg_4_1)
	table.insert(arg_4_1, SurvivalHeroGroupEquipView.New())
end

return var_0_0
