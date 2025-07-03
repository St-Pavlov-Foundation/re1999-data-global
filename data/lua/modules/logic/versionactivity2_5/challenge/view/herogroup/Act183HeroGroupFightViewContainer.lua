module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("Act183HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.addLastViews(arg_1_0, arg_1_1)
	return
end

function var_0_0.defineFightView(arg_2_0)
	arg_2_0._heroGroupFightView = Act183HeroGroupFightView.New()
	arg_2_0._heroGroupFightListView = Act183HeroGroupListView.New()
	arg_2_0._heroGroupLevelView = Act183HeroGroupFightView_Level.New()
end

function var_0_0.addCommonViews(arg_3_0, arg_3_1)
	table.insert(arg_3_1, arg_3_0._heroGroupFightView)
	table.insert(arg_3_1, HeroGroupAnimView.New())
	table.insert(arg_3_1, arg_3_0._heroGroupFightListView.New())
	table.insert(arg_3_1, arg_3_0._heroGroupLevelView.New())
	table.insert(arg_3_1, HeroGroupFightViewRule.New())
	table.insert(arg_3_1, HeroGroupInfoScrollView.New())
	table.insert(arg_3_1, CheckActivityEndView.New())
	table.insert(arg_3_1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(arg_3_1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function var_0_0.defaultOverrideCloseCheck(arg_4_0, arg_4_1, arg_4_2)
	return true
end

return var_0_0
