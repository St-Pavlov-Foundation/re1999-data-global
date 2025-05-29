module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroStatHelper", package.seeall)

local var_0_0 = class("DiceHeroStatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0._useCardsRecords = {}
	arg_1_0._gameBeginDt = 0
	arg_1_0._talkBeginDt = 0
end

function var_0_0.resetGameDt(arg_2_0)
	arg_2_0._gameBeginDt = UnityEngine.Time.realtimeSinceStartup

	arg_2_0:clearUseCard()
end

function var_0_0.resetTalkDt(arg_3_0)
	arg_3_0._talkBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.clearUseCard(arg_4_0)
	arg_4_0._useCardsRecords = {}
end

function var_0_0.addUseCard(arg_5_0, arg_5_1)
	local var_5_0 = DiceHeroFightModel.instance:getGameData()

	if not var_5_0 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._useCardsRecords) do
		if iter_5_1.round == var_5_0.round then
			table.insert(iter_5_1.skills, arg_5_1)

			return
		end
	end

	table.insert(arg_5_0._useCardsRecords, {
		round = var_5_0.round,
		skills = {
			arg_5_1
		}
	})
end

function var_0_0.sendFightEnd(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = DiceHeroFightModel.instance:getGameData()
	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0.enemyHeros) do
		table.insert(var_6_1, iter_6_1.hp)
		table.insert(var_6_2, iter_6_1.shield)
	end

	StatController.instance:track(StatEnum.EventName.DiceHero_FightEnd, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(DiceHeroModel.instance.guideLevel),
		[StatEnum.EventProperties.DiceHero_OperTpye] = arg_6_1 and "settle" or "giveup",
		[StatEnum.EventProperties.DiceHero_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_6_0._gameBeginDt,
		[StatEnum.EventProperties.DiceHero_RoundNum] = var_6_0 and var_6_0.round or 0,
		[StatEnum.EventProperties.DiceHero_Result] = tostring(arg_6_1 or DiceHeroEnum.GameStatu.None),
		[StatEnum.EventProperties.DiceHero_IsFirst] = arg_6_2 or false,
		[StatEnum.EventProperties.DiceHero_FightObj] = {
			hero = var_6_0.allyHero.id,
			relics = arg_6_0:getClone(var_6_0.allyHero.relicIds),
			hp_init = var_6_0.initHp,
			hp = var_6_0.allyHero.hp,
			shield = var_6_0.allyHero.shield,
			enemy_hp = var_6_1,
			ememy_shield = var_6_2
		},
		[StatEnum.EventProperties.DiceHero_SkillInfo] = arg_6_0._useCardsRecords
	})
end

function var_0_0.sendStoryEnd(arg_7_0, arg_7_1, arg_7_2)
	StatController.instance:track(StatEnum.EventName.DiceHero_StoryEnd, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(DiceHeroModel.instance.guideLevel),
		[StatEnum.EventProperties.DiceHero_OperTpye] = arg_7_1 and "settle" or "giveup",
		[StatEnum.EventProperties.DiceHero_TalkId] = DiceHeroModel.instance.talkId,
		[StatEnum.EventProperties.DiceHero_StepId] = DiceHeroModel.instance.stepId,
		[StatEnum.EventProperties.DiceHero_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_7_0._talkBeginDt,
		[StatEnum.EventProperties.DiceHero_IsFirst] = arg_7_2 or false
	})
end

function var_0_0.sendReset(arg_8_0)
	local var_8_0 = DiceHeroModel.instance:getGameInfo(5)

	if not var_8_0 then
		return
	end

	StatController.instance:track(StatEnum.EventName.DiceHero_Reset, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(var_8_0.currLevel),
		[StatEnum.EventProperties.DiceHero_FightObj] = {
			hero = var_8_0.heroBaseInfo.id,
			hp = var_8_0.heroBaseInfo.hp,
			shield = var_8_0.heroBaseInfo.shield,
			relics = arg_8_0:getClone(var_8_0.heroBaseInfo.relicIds)
		}
	})
end

function var_0_0.getClone(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		var_9_0[iter_9_0] = iter_9_1
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
