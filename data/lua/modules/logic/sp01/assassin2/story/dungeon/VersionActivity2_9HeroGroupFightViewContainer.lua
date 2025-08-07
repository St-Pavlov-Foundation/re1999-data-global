module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_9HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.addCommonViews(arg_1_0, arg_1_1)
	table.insert(arg_1_1, arg_1_0._heroGroupFightView)
	table.insert(arg_1_1, HeroGroupAnimView.New())
	table.insert(arg_1_1, arg_1_0._heroGroupFightListView.New())
	table.insert(arg_1_1, VersionActivity2_9HeroGroupFightViewLevel.New())
	table.insert(arg_1_1, HeroGroupFightViewRule.New())
	table.insert(arg_1_1, HeroGroupInfoScrollView.New())
	table.insert(arg_1_1, CheckActivityEndView.New())
	table.insert(arg_1_1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(arg_1_1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

return var_0_0
