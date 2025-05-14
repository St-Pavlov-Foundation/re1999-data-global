module("modules.logic.enemyinfo.model.EnemyInfoLayoutMo", package.seeall)

local var_0_0 = pureTable("EnemyInfoLayoutMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.showLeftTab = false
	arg_1_0.viewWidth = 0
	arg_1_0.tabWidth = 0
	arg_1_0.leftTabWidth = 0
	arg_1_0.rightTabWidth = 0
	arg_1_0.enemyInfoWidth = 0
end

function var_0_0.updateLayout(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.showLeftTab = arg_2_2
	arg_2_0.viewWidth = arg_2_1
	arg_2_0.tabWidth = 0

	if arg_2_0.showLeftTab then
		arg_2_0.tabWidth = EnemyInfoEnum.TabWidth
		arg_2_0.viewWidth = arg_2_0.viewWidth - arg_2_0.tabWidth
	end

	local var_2_0 = EnemyInfoEnum.LeftTabRatio
	local var_2_1 = EnemyInfoEnum.RightTabRatio

	if arg_2_0.showLeftTab then
		var_2_0 = var_2_0 + EnemyInfoEnum.WithTabOffset.LeftRatio
		var_2_1 = var_2_1 + EnemyInfoEnum.WithTabOffset.RightRatio
	end

	arg_2_0.leftTabWidth = arg_2_0.viewWidth * var_2_0
	arg_2_0.rightTabWidth = arg_2_0.viewWidth * var_2_1
end

function var_0_0.setEnemyInfoWidth(arg_3_0, arg_3_1)
	arg_3_0.enemyInfoWidth = arg_3_1
end

function var_0_0.setScrollEnemyWidth(arg_4_0, arg_4_1)
	arg_4_0.scrollEnemyWidth = arg_4_1
end

function var_0_0.getScrollEnemyLeftMargin(arg_5_0)
	if arg_5_0.showLeftTab then
		return EnemyInfoEnum.ScrollEnemyMargin.Left + EnemyInfoEnum.WithTabOffset.ScrollEnemyLeftMargin
	end

	return EnemyInfoEnum.ScrollEnemyMargin.Left
end

function var_0_0.getEnemyInfoLeftMargin(arg_6_0)
	if arg_6_0.showLeftTab then
		return EnemyInfoEnum.EnemyInfoMargin.Left + EnemyInfoEnum.WithTabOffset.EnemyInfoLeftMargin
	end

	return EnemyInfoEnum.EnemyInfoMargin.Left
end

return var_0_0
