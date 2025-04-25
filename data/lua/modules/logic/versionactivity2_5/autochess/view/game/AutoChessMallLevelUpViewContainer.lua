module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallLevelUpViewContainer", package.seeall)

slot0 = class("AutoChessMallLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AutoChessMallLevelUpView.New())

	return slot1
end

return slot0
