module("modules.logic.survival.view.shelter.ShelterHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("ShelterHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.defineFightView(arg_1_0)
	var_0_0.super.defineFightView(arg_1_0)

	arg_1_0._heroGroupFightView = ShelterHeroGroupFightView.New()
	arg_1_0._heroGroupFightListView = ShelterHeroGroupListView.New()
end

function var_0_0.getFightLevelView(arg_2_0)
	return ShelterHeroGroupFightView_Level.New()
end

function var_0_0.addLastViews(arg_3_0, arg_3_1)
	table.insert(arg_3_1, SurvivalHeroGroupEquipView.New())
end

return var_0_0
