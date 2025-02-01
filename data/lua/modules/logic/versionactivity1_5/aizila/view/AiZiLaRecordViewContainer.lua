module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordViewContainer", package.seeall)

slot0 = class("AiZiLaRecordViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._equipView = AiZiLaRecordView.New()

	table.insert(slot1, slot0._equipView)
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

return slot0
