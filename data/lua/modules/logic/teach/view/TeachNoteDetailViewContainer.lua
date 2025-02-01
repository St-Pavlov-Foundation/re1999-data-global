module("modules.logic.teach.view.TeachNoteDetailViewContainer", package.seeall)

slot0 = class("TeachNoteDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, TeachNoteDetailView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigationView
		}
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mission_close)
end

return slot0
