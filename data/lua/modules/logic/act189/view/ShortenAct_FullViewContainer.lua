module("modules.logic.act189.view.ShortenAct_FullViewContainer", package.seeall)

slot0 = class("ShortenAct_FullViewContainer", ShortenActViewContainer_impl)

function slot0.buildViews(slot0)
	return {
		slot0:taskScrollView(),
		ShortenAct_FullView.New()
	}
end

return slot0
