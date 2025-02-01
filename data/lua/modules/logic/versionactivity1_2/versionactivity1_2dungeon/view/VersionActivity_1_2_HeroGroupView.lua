module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupView", package.seeall)

slot0 = class("VersionActivity_1_2_HeroGroupView", HeroGroupFightView)

function slot0.openHeroGroupEditView(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity_1_2_HeroGroupEditView, slot0._param)
end

return slot0
