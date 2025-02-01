module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresentViewContainer", package.seeall)

slot0 = class("DecalogPresentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DecalogPresentView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return slot0
