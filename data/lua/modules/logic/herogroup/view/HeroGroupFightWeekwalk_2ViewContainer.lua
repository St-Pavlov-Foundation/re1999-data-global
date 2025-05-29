module("modules.logic.herogroup.view.HeroGroupFightWeekwalk_2ViewContainer", package.seeall)

local var_0_0 = class("HeroGroupFightWeekwalk_2ViewContainer", HeroGroupFightViewContainer)

function var_0_0.addFirstViews(arg_1_0, arg_1_1)
	var_0_0.super.addFirstViews(arg_1_0, arg_1_1)
	table.insert(arg_1_1, WeekWalk_2HeroGroupFightLayoutView.New())
end

function var_0_0.defineFightView(arg_2_0)
	arg_2_0._heroGroupFightView = HeroGroupWeekWalk_2FightView.New()
	arg_2_0._heroGroupFightListView = WeekWalk_2HeroGroupListView.New()
	arg_2_0._heroGroupLevelView = WeekWalk_2HeroGroupFightView_Level.New()
end

function var_0_0.addCommonViews(arg_3_0, arg_3_1)
	table.insert(arg_3_1, arg_3_0._heroGroupFightView)
	table.insert(arg_3_1, HeroGroupAnimView.New())
	table.insert(arg_3_1, arg_3_0._heroGroupFightListView.New())
	table.insert(arg_3_1, arg_3_0._heroGroupLevelView.New())
	table.insert(arg_3_1, HeroGroupFightWeekWalk_2ViewRule.New())
	table.insert(arg_3_1, HeroGroupInfoScrollView.New())
	table.insert(arg_3_1, CheckActivityEndView.New())
	table.insert(arg_3_1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(arg_3_1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function var_0_0.addLastViews(arg_4_0, arg_4_1)
	table.insert(arg_4_1, HeroGroupFightWeekWalk_2View.New())
	table.insert(arg_4_1, WeekWalk_2HeroGroupBuffView.New())

	arg_4_0.helpView = HelpShowView.New()

	arg_4_0.helpView:setHelpId(HelpEnum.HelpId.WeekWalk_2HeroGroup)
	table.insert(arg_4_1, arg_4_0.helpView)
end

function var_0_0.getHelpId(arg_5_0)
	return HelpEnum.HelpId.WeekWalk_2HeroGroup
end

return var_0_0
