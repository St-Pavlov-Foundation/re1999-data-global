module("modules.logic.enemyinfo.controller.EnemyInfoController", package.seeall)

slot0 = class("EnemyInfoController")

function slot0.openRougeEnemyInfoView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = slot1,
		hpFixRate = slot2,
		tabEnum = EnemyInfoEnum.TabEnum.Rouge
	})
end

function slot0.openEnemyInfoViewByBattleId(slot0, slot1)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = slot1,
		tabEnum = EnemyInfoEnum.TabEnum.Normal
	})
end

function slot0.openWeekWalkEnemyInfoView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		mapId = slot1,
		selectBattleId = slot2,
		tabEnum = EnemyInfoEnum.TabEnum.WeekWalk
	})
end

function slot0.openSeason123EnemyInfoView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		showLeftTab = true,
		activityId = slot1,
		stage = slot2,
		layer = slot3,
		tabEnum = EnemyInfoEnum.TabEnum.Season123
	})
end

function slot0.openSeason123EnemyInfoViewWithNoTab(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		showLeftTab = false,
		activityId = slot1,
		battleId = slot2,
		tabEnum = EnemyInfoEnum.TabEnum.Season123
	})
end

function slot0.openBossRushEnemyInfoView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		activityId = slot1,
		stage = slot2,
		layer = slot3,
		tabEnum = EnemyInfoEnum.TabEnum.BossRush
	})
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
