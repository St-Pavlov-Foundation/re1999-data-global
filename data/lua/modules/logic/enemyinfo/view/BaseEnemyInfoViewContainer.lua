module("modules.logic.enemyinfo.view.BaseEnemyInfoViewContainer", package.seeall)

local var_0_0 = class("BaseEnemyInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = EnemyInfoLayoutMo.New()
	local var_1_1 = EnemyInfoMo.New()
	local var_1_2 = {
		EnemyInfoEnterView.New(),
		EnemyInfoLayoutView.New(),
		EnemyInfoLeftView.New(),
		EnemyInfoRightView.New(),
		EnemyInfoTipView.New(),
		TabViewGroup.New(1, "#go_btns")
	}

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		iter_1_1.layoutMo = var_1_0
		iter_1_1.enemyInfoMo = var_1_1
	end

	return var_1_2
end

function var_0_0.onContainerInit(arg_2_0)
	var_0_0.super.onContainerInit(arg_2_0)

	if arg_2_0._views then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._views) do
			iter_2_1.viewParam = arg_2_0.viewParam
		end
	end
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return var_0_0
