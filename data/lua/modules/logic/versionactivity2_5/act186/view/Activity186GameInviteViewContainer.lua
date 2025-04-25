module("modules.logic.versionactivity2_5.act186.view.Activity186GameInviteViewContainer", package.seeall)

slot0 = class("Activity186GameInviteViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.heroView = Activity186GameHeroView.New()

	table.insert(slot1, slot0.heroView)
	table.insert(slot1, Activity186GameInviteView.New())
	table.insert(slot1, Activity186GameDialogueView.New())

	return slot1
end

return slot0
