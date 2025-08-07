module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("V2a9_BossRushHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.defineFightView(arg_1_0)
	arg_1_0._heroGroupFightView = V2a9_BossRushHeroGroupFightView.New()
	arg_1_0._heroGroupFightListView = HeroGroupListView.New()
end

function var_0_0.addCommonViews(arg_2_0, arg_2_1)
	table.insert(arg_2_1, arg_2_0._heroGroupFightView)
	table.insert(arg_2_1, HeroGroupAnimView.New())
	table.insert(arg_2_1, arg_2_0._heroGroupFightListView.New())
	table.insert(arg_2_1, V2a9_BossRushHeroGroupFightViewLevel.New())
	table.insert(arg_2_1, HeroGroupFightViewRule.New())
	table.insert(arg_2_1, HeroGroupInfoScrollView.New())
	table.insert(arg_2_1, CheckActivityEndView.New())
	table.insert(arg_2_1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(arg_2_1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

return var_0_0
