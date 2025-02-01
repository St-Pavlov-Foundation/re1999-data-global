module("modules.logic.rouge.view.RougeReviewViewContainer", package.seeall)

slot0 = class("RougeReviewViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeReviewView.New())
	table.insert(slot1, RougeScrollAudioView.New("#scroll_view"))
	table.insert(slot1, TabViewGroup.New(1, "#go_LeftTop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
