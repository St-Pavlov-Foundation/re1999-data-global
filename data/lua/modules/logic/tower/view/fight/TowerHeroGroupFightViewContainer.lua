module("modules.logic.tower.view.fight.TowerHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("TowerHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.addLastViews(arg_1_0, arg_1_1)
	table.insert(arg_1_1, TowerHeroGroupBossView.New())
end

function var_0_0.defineFightView(arg_2_0)
	arg_2_0._heroGroupFightView = TowerHeroGroupFightView.New()
	arg_2_0._heroGroupFightListView = TowerHeroGroupListView.New()
end

function var_0_0._closeCallback(arg_3_0)
	arg_3_0:closeThis()
	MainController.instance:enterMainScene(true, false)
end

function var_0_0.defaultOverrideCloseCheck(arg_4_0, arg_4_1, arg_4_2)
	return true
end

return var_0_0
