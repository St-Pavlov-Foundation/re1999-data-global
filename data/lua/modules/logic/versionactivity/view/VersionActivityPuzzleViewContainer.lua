module("modules.logic.versionactivity.view.VersionActivityPuzzleViewContainer", package.seeall)

slot0 = class("VersionActivityPuzzleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityPuzzleView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
