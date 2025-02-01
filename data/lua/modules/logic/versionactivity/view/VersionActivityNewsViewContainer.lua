module("modules.logic.versionactivity.view.VersionActivityNewsViewContainer", package.seeall)

slot0 = class("VersionActivityNewsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityNewsView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
