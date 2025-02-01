module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeViewContainer", package.seeall)

slot0 = class("Season123_2_0DecomposeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CommonViewFrame.New(),
		Season123_2_0DecomposeView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
