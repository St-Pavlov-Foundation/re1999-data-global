module("modules.logic.weekwalk.view.WeekWalkEnemyInfoViewContainer", package.seeall)

slot0 = class("WeekWalkEnemyInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.weekWalkOriginalEnemyInfoView = WeekWalkOriginalEnemyInfoView.New()
	slot0.weekWalkEnemyInfoViewRule = WeekWalkEnemyInfoViewRule.New()

	return {
		WeekWalkEnemyInfoView.New(),
		slot0.weekWalkOriginalEnemyInfoView,
		slot0.weekWalkEnemyInfoViewRule,
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.getEnemyInfoView(slot0)
	return slot0.weekWalkOriginalEnemyInfoView
end

function slot0.getWeekWalkEnemyInfoViewRule(slot0)
	return slot0.weekWalkEnemyInfoViewRule
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
