module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaStatMo", package.seeall)

slot0 = pureTable("TianShiNaNaStatMo")

function slot0.ctor(slot0)
	slot0.beginTime = Time.realtimeSinceStartup
	slot0.backNum = 0
end

function slot0.reset(slot0)
	slot0.beginTime = Time.realtimeSinceStartup
	slot0.backNum = 0
end

function slot0.addBackNum(slot0)
	slot0.backNum = slot0.backNum + 1
end

function slot0.sendStatData(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.Exit_Anjo_Nala_activity, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - slot0.beginTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(TianShiNaNaModel.instance.episodeCo.id),
		[StatEnum.EventProperties.Result] = slot1,
		[StatEnum.EventProperties.RoundNum] = TianShiNaNaModel.instance.nowRound,
		[StatEnum.EventProperties.BackNum] = slot0.backNum
	})
end

return slot0
