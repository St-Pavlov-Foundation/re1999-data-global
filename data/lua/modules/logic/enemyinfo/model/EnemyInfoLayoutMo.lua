module("modules.logic.enemyinfo.model.EnemyInfoLayoutMo", package.seeall)

slot0 = pureTable("EnemyInfoLayoutMo")

function slot0.ctor(slot0)
	slot0.showLeftTab = false
	slot0.viewWidth = 0
	slot0.tabWidth = 0
	slot0.leftTabWidth = 0
	slot0.rightTabWidth = 0
	slot0.enemyInfoWidth = 0
end

function slot0.updateLayout(slot0, slot1, slot2)
	slot0.showLeftTab = slot2
	slot0.viewWidth = slot1
	slot0.tabWidth = 0

	if slot0.showLeftTab then
		slot0.tabWidth = EnemyInfoEnum.TabWidth
		slot0.viewWidth = slot0.viewWidth - slot0.tabWidth
	end

	if slot0.showLeftTab then
		slot3 = EnemyInfoEnum.LeftTabRatio + EnemyInfoEnum.WithTabOffset.LeftRatio
		slot4 = EnemyInfoEnum.RightTabRatio + EnemyInfoEnum.WithTabOffset.RightRatio
	end

	slot0.leftTabWidth = slot0.viewWidth * slot3
	slot0.rightTabWidth = slot0.viewWidth * slot4
end

function slot0.setEnemyInfoWidth(slot0, slot1)
	slot0.enemyInfoWidth = slot1
end

function slot0.setScrollEnemyWidth(slot0, slot1)
	slot0.scrollEnemyWidth = slot1
end

function slot0.getScrollEnemyLeftMargin(slot0)
	if slot0.showLeftTab then
		return EnemyInfoEnum.ScrollEnemyMargin.Left + EnemyInfoEnum.WithTabOffset.ScrollEnemyLeftMargin
	end

	return EnemyInfoEnum.ScrollEnemyMargin.Left
end

function slot0.getEnemyInfoLeftMargin(slot0)
	if slot0.showLeftTab then
		return EnemyInfoEnum.EnemyInfoMargin.Left + EnemyInfoEnum.WithTabOffset.EnemyInfoLeftMargin
	end

	return EnemyInfoEnum.EnemyInfoMargin.Left
end

return slot0
