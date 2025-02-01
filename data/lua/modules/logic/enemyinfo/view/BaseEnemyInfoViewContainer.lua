module("modules.logic.enemyinfo.view.BaseEnemyInfoViewContainer", package.seeall)

slot0 = class("BaseEnemyInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	for slot7, slot8 in ipairs({
		EnemyInfoEnterView.New(),
		EnemyInfoLayoutView.New(),
		EnemyInfoLeftView.New(),
		EnemyInfoRightView.New(),
		EnemyInfoTipView.New(),
		TabViewGroup.New(1, "#go_btns")
	}) do
		slot8.layoutMo = EnemyInfoLayoutMo.New()
		slot8.enemyInfoMo = EnemyInfoMo.New()
	end

	return slot3
end

function slot0.onContainerInit(slot0)
	uv0.super.onContainerInit(slot0)

	if slot0._views then
		for slot4, slot5 in ipairs(slot0._views) do
			slot5.viewParam = slot0.viewParam
		end
	end
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return slot0
