module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaLiAnNaStatHelper", package.seeall)

local var_0_0 = class("MaLiAnNaStatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0._episodeId = "0"
	arg_1_0._result = 0
	arg_1_0._beginTime = 0
	arg_1_0._soliderHero = {}
	arg_1_0._skill_usages = {}
end

function var_0_0.enterEpisode(arg_2_0, arg_2_1)
	arg_2_0._episodeId = tostring(arg_2_1)
	arg_2_0._beginTime = os.time()

	tabletool.clear(arg_2_0._soliderHero)
	tabletool.clear(arg_2_0._skill_usages)
end

function var_0_0.addUseSkillInfo(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	local var_3_0 = true

	for iter_3_0 = 1, #arg_3_0._skill_usages do
		local var_3_1 = arg_3_0._skill_usages[iter_3_0]

		if var_3_1.skill_id == arg_3_1 then
			var_3_1.skill_num = var_3_1.skill_num + 1
			var_3_0 = false

			break
		end
	end

	if var_3_0 then
		table.insert(arg_3_0._skill_usages, {
			skill_num = 1,
			skill_id = arg_3_1
		})
	end
end

function var_0_0.sendGameExit(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = MaLiAnNaLaSoliderMoUtil.instance:getAllHeroSolider(Activity201MaLiAnNaEnum.CampType.Player)

	if var_4_0 then
		for iter_4_0 = 1, #var_4_0 do
			local var_4_1 = var_4_0[iter_4_0]

			table.insert(arg_4_0._soliderHero, {
				soldierid = var_4_1:getConfigId(),
				hp = var_4_1:getHp()
			})
		end
	end

	local var_4_2 = Activity201MaLiAnNaGameModel.instance:getGameTime()

	StatController.instance:track(StatEnum.EventName.ExitMaLiAnNaActivity, {
		[StatEnum.EventProperties.MaLiAnNa_EpisodeId] = arg_4_0._episodeId,
		[StatEnum.EventProperties.MaLiAnNa_Result] = tostring(arg_4_1),
		[StatEnum.EventProperties.MaLiAnNa_UseTime] = os.time() - arg_4_0._beginTime,
		[StatEnum.EventProperties.MaLiAnNa_TotalRound] = var_4_2,
		[StatEnum.EventProperties.MaLiAnNa_FailureCondition] = tostring(arg_4_2),
		[StatEnum.EventProperties.MaLiAnNa_OurRemainingHpArray] = arg_4_0._soliderHero,
		[StatEnum.EventProperties.MaLiAnNa_SkillUsage] = arg_4_0._skill_usages
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
