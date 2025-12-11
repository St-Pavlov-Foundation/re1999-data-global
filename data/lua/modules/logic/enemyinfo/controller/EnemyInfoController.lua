module("modules.logic.enemyinfo.controller.EnemyInfoController", package.seeall)

local var_0_0 = class("EnemyInfoController")

function var_0_0.openRougeEnemyInfoView(arg_1_0, arg_1_1, arg_1_2)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = arg_1_1,
		hpFixRate = arg_1_2,
		tabEnum = EnemyInfoEnum.TabEnum.Rouge
	})
end

function var_0_0.openSurvivalEnemyInfoView(arg_2_0, arg_2_1, arg_2_2)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = arg_2_1,
		hpFixRate = arg_2_2,
		tabEnum = EnemyInfoEnum.TabEnum.Survival
	})
end

function var_0_0.openEnemyInfoViewByBattleId(arg_3_0, arg_3_1)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = arg_3_1,
		tabEnum = EnemyInfoEnum.TabEnum.Normal
	})
end

function var_0_0.openWeekWalkEnemyInfoView(arg_4_0, arg_4_1, arg_4_2)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		mapId = arg_4_1,
		selectBattleId = arg_4_2,
		tabEnum = EnemyInfoEnum.TabEnum.WeekWalk
	})
end

function var_0_0.openWeekWalk_2EnemyInfoView(arg_5_0, arg_5_1, arg_5_2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2EnemyInfoView, {
		mapId = arg_5_1,
		selectBattleId = arg_5_2,
		tabEnum = EnemyInfoEnum.TabEnum.WeekWalk_2
	})
end

function var_0_0.openSeason123EnemyInfoView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		showLeftTab = true,
		activityId = arg_6_1,
		stage = arg_6_2,
		layer = arg_6_3,
		tabEnum = EnemyInfoEnum.TabEnum.Season123
	})
end

function var_0_0.openSeason123EnemyInfoViewWithNoTab(arg_7_0, arg_7_1, arg_7_2)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		showLeftTab = false,
		activityId = arg_7_1,
		battleId = arg_7_2,
		tabEnum = EnemyInfoEnum.TabEnum.Season123
	})
end

function var_0_0.openBossRushEnemyInfoView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		activityId = arg_8_1,
		stage = arg_8_2,
		layer = arg_8_3,
		tabEnum = EnemyInfoEnum.TabEnum.BossRush
	})
end

function var_0_0.openAct191EnemyInfoView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = arg_9_1,
		tabEnum = EnemyInfoEnum.TabEnum.Act191
	})
end

function var_0_0.openTowerDeepEnemyInfoView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = arg_10_1,
		tabEnum = EnemyInfoEnum.TabEnum.TowerDeep
	})
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
