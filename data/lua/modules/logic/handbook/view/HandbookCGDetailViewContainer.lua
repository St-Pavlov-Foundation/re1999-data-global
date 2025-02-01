module("modules.logic.handbook.view.HandbookCGDetailViewContainer", package.seeall)

slot0 = class("HandbookCGDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, HandbookCGDetailView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_ui/#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return slot0
