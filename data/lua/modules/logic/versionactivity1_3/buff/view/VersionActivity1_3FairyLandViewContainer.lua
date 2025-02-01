module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandViewContainer", package.seeall)

slot0 = class("VersionActivity1_3FairyLandViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.buffView = VersionActivity1_3FairyLandView.New()

	return {
		slot0.buffView
	}
end

return slot0
