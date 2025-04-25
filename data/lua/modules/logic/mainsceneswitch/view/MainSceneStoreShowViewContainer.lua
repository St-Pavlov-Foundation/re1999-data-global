module("modules.logic.mainsceneswitch.view.MainSceneStoreShowViewContainer", package.seeall)

slot0 = class("MainSceneStoreShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MainSceneStoreShowView.New())

	return slot1
end

return slot0
