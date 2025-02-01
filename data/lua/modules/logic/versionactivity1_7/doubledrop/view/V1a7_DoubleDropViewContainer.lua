module("modules.logic.versionactivity1_7.doubledrop.view.V1a7_DoubleDropViewContainer", package.seeall)

slot0 = class("V1a7_DoubleDropViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, V1a7_DoubleDropView.New())

	return slot1
end

return slot0
