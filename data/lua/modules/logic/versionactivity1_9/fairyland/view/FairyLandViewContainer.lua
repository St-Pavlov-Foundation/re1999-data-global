module("modules.logic.versionactivity1_9.fairyland.view.FairyLandViewContainer", package.seeall)

slot0 = class("FairyLandViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FairyLandPuzzles.New())
	table.insert(slot1, FairyLandView.New())

	slot0.elements = FairyLandElements.New()

	table.insert(slot1, slot0.elements)
	table.insert(slot1, FairyLandStairs.New())

	slot0.scene = FairyLandScene.New()

	table.insert(slot1, slot0.scene)
	table.insert(slot1, FairyLandDialogView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_LeftTop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.getElement(slot0, slot1)
	if slot0.elements then
		return slot0.elements:getElementByType(slot1)
	end
end

function slot0._setVisible(slot0, slot1)
	uv0.super._setVisible(slot0, slot1)

	if slot0.scene then
		slot0.scene:setSceneVisible(slot1)
	end
end

return slot0
