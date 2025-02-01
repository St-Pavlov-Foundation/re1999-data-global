module("modules.logic.seasonver.act123.view.Season123EnemyViewContainer", package.seeall)

slot0 = class("Season123EnemyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123EnemyView.New(),
		Season123EnemyTabList.New(),
		Season123EnemyRule.New(),
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
end

return slot0
