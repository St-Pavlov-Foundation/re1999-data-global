module("modules.logic.rouge.map.view.levelup.RougeLevelUpViewContainer", package.seeall)

slot0 = class("RougeLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeLevelUpView.New())

	return slot1
end

return slot0
