module("modules.logic.tower.view.fight.TowerDeepHeroGroupFightViewLevel", package.seeall)

local var_0_0 = class("TowerDeepHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function var_0_0.addEvents(arg_1_0)
	var_0_0.super.addEvents(arg_1_0)
	arg_1_0:addEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_1_0._showEnemyList, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	var_0_0.super.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_2_0._showEnemyList, arg_2_0)
end

function var_0_0._btnenemyOnClick(arg_3_0)
	if arg_3_0._battleId then
		EnemyInfoController.instance:openTowerDeepEnemyInfoView(arg_3_0._battleId)
	end
end

function var_0_0._showEnemyList(arg_4_0)
	local var_4_0 = FightModel.instance:getFightParam()
	local var_4_1 = {}
	local var_4_2 = {}
	local var_4_3 = {}
	local var_4_4 = {}
	local var_4_5 = TowerPermanentDeepModel.instance:getCurDeepMonsterId()
	local var_4_6 = lua_monster.configDict[var_4_5].career

	var_4_1[var_4_6] = (var_4_1[var_4_6] or 0) + 1

	table.insert(var_4_4, var_4_5)

	local var_4_7 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		table.insert(var_4_7, {
			career = iter_4_0,
			count = iter_4_1
		})
	end

	arg_4_0._enemy_boss_end_index = #var_4_7

	for iter_4_2, iter_4_3 in pairs(var_4_2) do
		table.insert(var_4_7, {
			career = iter_4_2,
			count = iter_4_3
		})
	end

	gohelper.CreateObjList(arg_4_0, arg_4_0._onEnemyItemShow, var_4_7, gohelper.findChild(arg_4_0._goenemyteam, "enemyList"), gohelper.findChild(arg_4_0._goenemyteam, "enemyList/go_enemyitem"))

	local var_4_8 = FightHelper.getBattleRecommendLevel(var_4_0.battleId, arg_4_0._isSimple)

	if var_4_8 >= 0 then
		arg_4_0._txtrecommendlevel.text = HeroConfig.instance:getLevelDisplayVariant(var_4_8)
	else
		arg_4_0._txtrecommendlevel.text = ""
	end
end

return var_0_0
