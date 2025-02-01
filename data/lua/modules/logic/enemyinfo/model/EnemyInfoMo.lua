module("modules.logic.enemyinfo.model.EnemyInfoMo", package.seeall)

slot0 = pureTable("EnemyInfoMo")

function slot0.ctor(slot0)
	slot0.showLeftTab = false
	slot0.battleId = 0
	slot0.tabEnum = EnemyInfoEnum.TabEnum.Normal
end

function slot0.updateBattleId(slot0, slot1)
	if slot0.battleId == slot1 then
		return
	end

	slot0.battleId = slot1

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.UpdateBattleInfo, slot0.battleId)
end

function slot0.setTabEnum(slot0, slot1)
	slot0.tabEnum = slot1
end

function slot0.setShowLeftTab(slot0, slot1)
	slot0.showLeftTab = slot1
end

return slot0
