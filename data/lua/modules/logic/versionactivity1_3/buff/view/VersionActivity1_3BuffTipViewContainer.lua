module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffTipViewContainer", package.seeall)

slot0 = class("VersionActivity1_3BuffTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.buffTipView = VersionActivity1_3BuffTipView.New()

	return {
		slot0.buffTipView
	}
end

return slot0
