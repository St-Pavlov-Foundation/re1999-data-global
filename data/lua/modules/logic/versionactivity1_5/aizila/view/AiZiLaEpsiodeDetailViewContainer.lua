module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEpsiodeDetailViewContainer", package.seeall)

slot0 = class("AiZiLaEpsiodeDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._detailView = AiZiLaEpsiodeDetailView.New()

	table.insert(slot1, slot0._detailView)
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0.playViewAnimator(slot0, slot1)
	slot0._detailView:playViewAnimator(slot1)
end

return slot0
