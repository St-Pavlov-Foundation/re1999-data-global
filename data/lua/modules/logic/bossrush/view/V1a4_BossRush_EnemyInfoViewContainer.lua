module("modules.logic.bossrush.view.V1a4_BossRush_EnemyInfoViewContainer", package.seeall)

slot0 = class("V1a4_BossRush_EnemyInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a4_BossRush_EnemyInfoView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.getBossRushViewRule(slot0)
	return slot0._bossRushViewRule
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, slot0._closeCallback, nil, , slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.diffRootChild(slot0, slot1)
	return false
end

return slot0
