module("modules.logic.fight.model.data.FightTeamDataMgr", package.seeall)

slot0 = FightDataClass("FightTeamDataMgr")

function slot0.onConstructor(slot0)
	slot0.myData = {}
	slot0.enemyData = {}
	slot0[FightEnum.TeamType.MySide] = slot0.myData
	slot0[FightEnum.TeamType.EnemySide] = slot0.enemyData
	slot0.myCardHeatOffset = {}
end

function slot0.clearClientSimulationData(slot0)
	slot0.myCardHeatOffset = {}
end

function slot0.onCancelOperation(slot0)
	slot0:clearClientSimulationData()
end

function slot0.onStageChanged(slot0)
	slot0:clearClientSimulationData()
end

function slot0.updateData(slot0, slot1)
	slot0:refreshTeamDataByProto(slot1.attacker, slot0.myData)
	slot0:refreshTeamDataByProto(slot1.defender, slot0.enemyData)
end

function slot0.refreshTeamDataByProto(slot0, slot1, slot2)
	slot2.cardHeat = FightDataHelper.coverData(FightDataCardHeatInfo.New(slot1.cardHeat), slot2.cardHeat)
end

return slot0
