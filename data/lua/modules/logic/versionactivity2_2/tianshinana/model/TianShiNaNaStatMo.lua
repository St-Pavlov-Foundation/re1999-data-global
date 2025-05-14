module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaStatMo", package.seeall)

local var_0_0 = pureTable("TianShiNaNaStatMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.beginTime = Time.realtimeSinceStartup
	arg_1_0.backNum = 0
end

function var_0_0.reset(arg_2_0)
	arg_2_0.beginTime = Time.realtimeSinceStartup
	arg_2_0.backNum = 0
end

function var_0_0.addBackNum(arg_3_0)
	arg_3_0.backNum = arg_3_0.backNum + 1
end

function var_0_0.sendStatData(arg_4_0, arg_4_1)
	StatController.instance:track(StatEnum.EventName.Exit_Anjo_Nala_activity, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_4_0.beginTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(TianShiNaNaModel.instance.episodeCo.id),
		[StatEnum.EventProperties.Result] = arg_4_1,
		[StatEnum.EventProperties.RoundNum] = TianShiNaNaModel.instance.nowRound,
		[StatEnum.EventProperties.BackNum] = arg_4_0.backNum
	})
end

return var_0_0
