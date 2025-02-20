module("modules.logic.versionactivity2_3.act174.view.Act174FightResultViewContainer", package.seeall)

slot0 = class("Act174FightResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act174FightResultView.New())

	return slot1
end

return slot0
