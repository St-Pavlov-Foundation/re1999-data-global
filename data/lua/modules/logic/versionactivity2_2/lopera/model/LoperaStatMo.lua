module("modules.logic.versionactivity2_2.lopera.model.LoperaStatMo", package.seeall)

slot0 = pureTable("LoperaStatMo")

function slot0.ctor(slot0)
	slot0.beginTime = Time.realtimeSinceStartup
end

function slot0.setEpisodeId(slot0, slot1)
	slot0.episdoeId = slot1
end

function slot0.fillInfo(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.roundNum = slot3 and slot3 or slot0.roundNum
	slot0.episdoeId = slot1 and slot1 or slot0.episdoeId
	slot0.result = slot2 and slot2 or slot0.result
	slot0.eventNum = slot4 and slot4 or slot0.eventNum
	slot0.remainPower = slot5 and slot5 or slot0.remainPower
	slot0.exploreNum = slot6 and slot6 or slot0.exploreNum
	slot0.gainMaterial = slot7 and slot7 or slot0.gainMaterial
	slot0.product = slot8 and slot8 or slot0.product
end

function slot0.sendStatData(slot0)
	slot1 = nil

	StatController.instance:track(StatEnum.EventName.Exit_Lopera_activity, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - slot0.beginTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.episdoeId),
		[StatEnum.EventProperties.Result] = LoperaEnum.resultStatUse[slot0.result],
		[StatEnum.EventProperties.RoundNum] = slot0.roundNum,
		[StatEnum.EventProperties.CompletedEventNum] = slot0.eventNum,
		[StatEnum.EventProperties.RemainingMobility] = slot0.remainPower,
		[StatEnum.EventProperties.ExploreSceneNum] = slot0.exploreNum,
		[StatEnum.EventProperties.GainAlchemyStuff] = slot0.gainMaterial,
		[StatEnum.EventProperties.GainAlchemyProp] = slot0.product
	})
end

return slot0
