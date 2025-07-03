module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6StatHelper", package.seeall)

local var_0_0 = class("LengZhou6StatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0._episodeId = nil
	arg_1_0._endless_library_round = 0
	arg_1_0._result = nil
	arg_1_0._beginTime = 0
	arg_1_0._useRound = 0
	arg_1_0._playerHp = 0
	arg_1_0._enemyHp = 0
	arg_1_0._skill_ids = {}
	arg_1_0._skill_usages = {}
	arg_1_0._isEndless = false
end

function var_0_0.enterGame(arg_2_0)
	arg_2_0._episodeId = LengZhou6Model.instance:getCurEpisodeId()

	local var_2_0 = LengZhou6Model.instance:getEpisodeInfoMo(arg_2_0._episodeId)

	if var_2_0 then
		arg_2_0._isEndless = var_2_0:isEndlessEpisode()
	end

	arg_2_0._beginTime = os.time()
	arg_2_0._useRound = 0

	tabletool.clear(arg_2_0._skill_ids)
	tabletool.clear(arg_2_0._skill_usages)
end

function var_0_0.setGameResult(arg_3_0, arg_3_1)
	arg_3_0._result = arg_3_1
end

function var_0_0.updateRound(arg_4_0)
	arg_4_0._useRound = arg_4_0._useRound + 1
end

function var_0_0.addUseSkillId(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		return
	end

	local var_5_0 = true

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._skill_ids) do
		if iter_5_1 == arg_5_1 then
			var_5_0 = false

			break
		end
	end

	if var_5_0 then
		table.insert(arg_5_0._skill_ids, arg_5_1)
	end
end

function var_0_0.addUseSkillInfo(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return
	end

	local var_6_0 = true

	for iter_6_0 = 1, #arg_6_0._skill_usages do
		local var_6_1 = arg_6_0._skill_usages[iter_6_0]

		if var_6_1.skill_id == arg_6_1 then
			var_6_1.skill_num = var_6_1.skill_num + 1
			var_6_0 = false

			break
		end
	end

	if var_6_0 then
		table.insert(arg_6_0._skill_usages, {
			skill_num = 1,
			skill_id = arg_6_1
		})
	end
end

function var_0_0.setPlayerAndEnemyHp(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._playerHp = arg_7_1
	arg_7_0._enemyHp = arg_7_2
end

function var_0_0.sendGameExit(arg_8_0)
	local var_8_0 = LengZhou6GameModel.instance:getPlayer()
	local var_8_1 = LengZhou6GameModel.instance:getEnemy()

	if var_8_0 and var_8_1 then
		arg_8_0:setPlayerAndEnemyHp(var_8_0:getHp(), var_8_1:getHp())
	end

	local var_8_2 = ""

	if arg_8_0._isEndless then
		var_8_2 = tostring(LengZhou6GameModel.instance:getEndLessModelLayer())
	end

	StatController.instance:track(StatEnum.EventName.ExitHissabethActivity, {
		[StatEnum.EventProperties.LengZhou6_EpisodeId] = tostring(arg_8_0._episodeId),
		[StatEnum.EventProperties.LengZhou6_EndlessLibraryRound] = var_8_2,
		[StatEnum.EventProperties.LengZhou6_Result] = tostring(arg_8_0._result),
		[StatEnum.EventProperties.LengZhou6_UseTime] = os.time() - arg_8_0._beginTime,
		[StatEnum.EventProperties.LengZhou6_TotalRound] = arg_8_0._useRound,
		[StatEnum.EventProperties.LengZhou6_OurRemainingHP] = arg_8_0._playerHp,
		[StatEnum.EventProperties.LengZhou6_EnemyRemainingHP] = arg_8_0._enemyHp,
		[StatEnum.EventProperties.LengZhou6_SkillId] = arg_8_0._skill_ids,
		[StatEnum.EventProperties.LengZhou6_SkillUsage] = arg_8_0._skill_usages
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
