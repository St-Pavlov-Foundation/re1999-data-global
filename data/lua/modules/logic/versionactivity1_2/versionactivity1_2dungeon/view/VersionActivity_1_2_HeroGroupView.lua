module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupView", package.seeall)

local var_0_0 = class("VersionActivity_1_2_HeroGroupView", HeroGroupFightView)

function var_0_0.openHeroGroupEditView(arg_1_0)
	ViewMgr.instance:openView(ViewName.VersionActivity_1_2_HeroGroupEditView, arg_1_0._param)
end

return var_0_0
