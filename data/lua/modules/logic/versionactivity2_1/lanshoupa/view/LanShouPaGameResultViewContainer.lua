module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameResultViewContainer", package.seeall)

slot0 = class("LanShouPaGameResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._resultview = LanShouPaGameResultView.New()

	table.insert(slot1, slot0._resultview)

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
