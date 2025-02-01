module("modules.logic.rouge.dlc.101.view.RougeDangerousViewContainer", package.seeall)

slot0 = class("RougeDangerousViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeDangerousView.New())

	return slot1
end

function slot0.playOpenTransition(slot0)
	uv0.super.playOpenTransition(slot0, {
		noBlock = true,
		duration = RougeDangerousView.OpenViewDuration
	})
end

return slot0
