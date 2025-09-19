module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8HeroGroupBossViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_8HeroGroupBossViewContainer", HeroGroupFightViewContainer)

function var_0_0.defineFightView(arg_1_0)
	arg_1_0._heroGroupFightView = VersionActivity2_8HeroGroupBossFightView.New()
	arg_1_0._heroGroupFightListView = HeroGroupListView.New()
end

return var_0_0
