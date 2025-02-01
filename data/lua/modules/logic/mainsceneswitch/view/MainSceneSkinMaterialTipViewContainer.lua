module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipViewContainer", package.seeall)

slot0 = class("MainSceneSkinMaterialTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MainSceneSkinMaterialTipView.New())
	table.insert(slot1, MainSceneSkinMaterialTipViewBanner.New())

	return slot1
end

return slot0
