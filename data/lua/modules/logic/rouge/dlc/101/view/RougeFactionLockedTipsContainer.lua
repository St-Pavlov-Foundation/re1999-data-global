module("modules.logic.rouge.dlc.101.view.RougeFactionLockedTipsContainer", package.seeall)

slot0 = class("RougeFactionLockedTipsContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeFactionLockedTips.New())

	return slot1
end

return slot0
