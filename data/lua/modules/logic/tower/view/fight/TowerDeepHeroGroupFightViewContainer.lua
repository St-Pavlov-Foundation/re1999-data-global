module("modules.logic.tower.view.fight.TowerDeepHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("TowerDeepHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.addLastViews(arg_1_0, arg_1_1)
	table.insert(arg_1_1, TowerHeroGroupBossView.New())
	table.insert(arg_1_1, TowerDeepHeroGroupInfoView.New())
end

function var_0_0.defineFightView(arg_2_0)
	arg_2_0._heroGroupFightView = TowerDeepHeroGroupFightView.New()
	arg_2_0._heroGroupFightListView = TowerHeroGroupListView.New()
end

function var_0_0.getFightLevelView(arg_3_0)
	return TowerDeepHeroGroupFightViewLevel.New()
end

function var_0_0.getHelpId(arg_4_0)
	return HelpEnum.HelpId.TowerDeep
end

function var_0_0._closeCallback(arg_5_0)
	arg_5_0:closeThis()
	MainController.instance:enterMainScene(true, false)
end

function var_0_0.defaultOverrideCloseCheck(arg_6_0, arg_6_1, arg_6_2)
	return true
end

return var_0_0
