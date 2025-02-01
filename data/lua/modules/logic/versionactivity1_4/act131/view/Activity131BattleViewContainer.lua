module("modules.logic.versionactivity1_4.act131.view.Activity131BattleViewContainer", package.seeall)

slot0 = class("Activity131BattleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity131BattleView.New())

	return slot1
end

return slot0
