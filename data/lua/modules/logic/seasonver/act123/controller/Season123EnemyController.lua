module("modules.logic.seasonver.act123.controller.Season123EnemyController", package.seeall)

local var_0_0 = class("Season123EnemyController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	Season123EnemyModel.instance:init(arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onCloseView(arg_2_0)
	Season123EnemyModel.instance:release()
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	if Season123EnemyModel.instance:getSelectedIndex() ~= arg_3_1 then
		Season123EnemyModel.instance:setSelectIndex(arg_3_1)
		Season123Controller.instance:dispatchEvent(Season123Event.EnemyDetailSwitchTab)
	end
end

function var_0_0.selectMonster(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Season123EnemyModel.instance:getCurrentBattleGroupIds()

	if not var_4_0 then
		return
	end

	local var_4_1 = Season123EnemyModel.instance:getMonsterIds(var_4_0[arg_4_1])

	if not var_4_1 then
		return
	end

	local var_4_2 = var_4_1[arg_4_2]

	if var_4_2 ~= Season123EnemyModel.instance.selectMonsterId then
		Season123EnemyModel.instance:setEnemySelectMonsterId(arg_4_1, arg_4_2, var_4_2)
		Season123Controller.instance:dispatchEvent(Season123Event.EnemyDetailSelectEnemy)
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
