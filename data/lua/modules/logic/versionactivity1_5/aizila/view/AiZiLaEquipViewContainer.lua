module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipViewContainer", package.seeall)

slot0 = class("AiZiLaEquipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._equipView = AiZiLaEquipView.New()

	table.insert(slot1, slot0._equipView)
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = true

		if ViewMgr.instance:isOpen(ViewName.AiZiLaGameView) then
			slot2 = false
		end

		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			slot2,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

return slot0
