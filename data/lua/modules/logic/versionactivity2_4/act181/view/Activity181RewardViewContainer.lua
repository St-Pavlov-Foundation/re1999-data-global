module("modules.logic.versionactivity2_4.act181.view.Activity181RewardViewContainer", package.seeall)

slot0 = class("Activity181RewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity181RewardView.New())

	return slot1
end

return slot0
