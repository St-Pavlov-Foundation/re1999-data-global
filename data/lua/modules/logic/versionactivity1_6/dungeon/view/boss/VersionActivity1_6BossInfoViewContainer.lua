module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossInfoViewContainer", package.seeall)

slot0 = class("VersionActivity1_6BossInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._bossRushViewRule = VersionActivity1_6_BossInfoRuleView.New()

	return {
		VersionActivity1_6BossInfoView.New(),
		TabViewGroup.New(1, "#go_btns"),
		slot0._bossRushViewRule
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
