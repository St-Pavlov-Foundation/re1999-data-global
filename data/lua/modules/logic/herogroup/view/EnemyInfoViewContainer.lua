module("modules.logic.herogroup.view.EnemyInfoViewContainer", package.seeall)

slot0 = class("EnemyInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		EnemyInfoView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
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
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.HeroGroupUI.Play_UI_Action_Return)
end

return slot0
