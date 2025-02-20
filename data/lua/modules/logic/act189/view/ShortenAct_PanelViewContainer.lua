module("modules.logic.act189.view.ShortenAct_PanelViewContainer", package.seeall)

slot0 = class("ShortenAct_PanelViewContainer", ShortenActViewContainer_impl)

function slot0.buildViews(slot0)
	return {
		slot0:taskScrollView(),
		ShortenAct_PanelView.New()
	}
end

return slot0
