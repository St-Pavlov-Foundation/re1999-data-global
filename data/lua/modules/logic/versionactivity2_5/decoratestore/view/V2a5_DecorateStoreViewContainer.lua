module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreViewContainer", package.seeall)

slot0 = class("V2a5_DecorateStoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, V2a5_DecorateStoreView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return slot0
