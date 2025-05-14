module("modules.logic.versionactivity2_2.lopera.model.LoperaStatMo", package.seeall)

local var_0_0 = pureTable("LoperaStatMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.beginTime = Time.realtimeSinceStartup
end

function var_0_0.setEpisodeId(arg_2_0, arg_2_1)
	arg_2_0.episdoeId = arg_2_1
end

function var_0_0.fillInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
	arg_3_0.roundNum = arg_3_3 and arg_3_3 or arg_3_0.roundNum
	arg_3_0.episdoeId = arg_3_1 and arg_3_1 or arg_3_0.episdoeId
	arg_3_0.result = arg_3_2 and arg_3_2 or arg_3_0.result
	arg_3_0.eventNum = arg_3_4 and arg_3_4 or arg_3_0.eventNum
	arg_3_0.remainPower = arg_3_5 and arg_3_5 or arg_3_0.remainPower
	arg_3_0.exploreNum = arg_3_6 and arg_3_6 or arg_3_0.exploreNum
	arg_3_0.gainMaterial = arg_3_7 and arg_3_7 or arg_3_0.gainMaterial
	arg_3_0.product = arg_3_8 and arg_3_8 or arg_3_0.product
end

function var_0_0.sendStatData(arg_4_0)
	local var_4_0

	StatController.instance:track(StatEnum.EventName.Exit_Lopera_activity, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_4_0.beginTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_4_0.episdoeId),
		[StatEnum.EventProperties.Result] = LoperaEnum.resultStatUse[arg_4_0.result],
		[StatEnum.EventProperties.RoundNum] = arg_4_0.roundNum,
		[StatEnum.EventProperties.CompletedEventNum] = arg_4_0.eventNum,
		[StatEnum.EventProperties.RemainingMobility] = arg_4_0.remainPower,
		[StatEnum.EventProperties.ExploreSceneNum] = arg_4_0.exploreNum,
		[StatEnum.EventProperties.GainAlchemyStuff] = arg_4_0.gainMaterial,
		[StatEnum.EventProperties.GainAlchemyProp] = arg_4_0.product
	})
end

return var_0_0
