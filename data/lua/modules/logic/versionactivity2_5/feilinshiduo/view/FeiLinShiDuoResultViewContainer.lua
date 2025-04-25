module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoResultViewContainer", package.seeall)

slot0 = class("FeiLinShiDuoResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FeiLinShiDuoResultView.New())

	return slot1
end

return slot0
