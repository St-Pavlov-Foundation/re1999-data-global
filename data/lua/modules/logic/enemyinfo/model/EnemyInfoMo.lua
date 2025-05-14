module("modules.logic.enemyinfo.model.EnemyInfoMo", package.seeall)

local var_0_0 = pureTable("EnemyInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.showLeftTab = false
	arg_1_0.battleId = 0
	arg_1_0.tabEnum = EnemyInfoEnum.TabEnum.Normal
end

function var_0_0.updateBattleId(arg_2_0, arg_2_1)
	if arg_2_0.battleId == arg_2_1 then
		return
	end

	arg_2_0.battleId = arg_2_1

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.UpdateBattleInfo, arg_2_0.battleId)
end

function var_0_0.setTabEnum(arg_3_0, arg_3_1)
	arg_3_0.tabEnum = arg_3_1
end

function var_0_0.setShowLeftTab(arg_4_0, arg_4_1)
	arg_4_0.showLeftTab = arg_4_1
end

return var_0_0
