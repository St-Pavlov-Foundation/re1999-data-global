module("modules.logic.fight.model.data.FightDouQuQuDataMgr", package.seeall)

slot0 = FightDataClass("FightDouQuQuDataMgr")

function slot0.onConstructor(slot0)
end

function slot0.cachePlayIndex(slot0, slot1)
	slot0.playIndexTab = slot1
	slot0.maxIndex = 0

	for slot5, slot6 in pairs(slot0.playIndexTab) do
		if slot0.maxIndex < slot6 then
			slot0.maxIndex = slot6
		end
	end
end

function slot0.cacheFightProto(slot0, slot1)
	slot0.proto = slot1
	slot0.index = slot1.index
	slot0.round = slot1.round
	slot0.isFinish = slot1.round == 0 and slot1.startRound.isFinish or slot1.fightRound.isFinish
end

function slot0.cacheGMProto(slot0, slot1)
	slot0.gmProto = slot1
end

return slot0
