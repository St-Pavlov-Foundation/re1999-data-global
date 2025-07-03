module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6GameController", package.seeall)

local var_0_0 = class("LengZhou6GameController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.enterEpisodeId(arg_2_0, arg_2_1)
	local var_2_0 = 12702

	arg_2_0:enterLevel(var_2_0, arg_2_1)
end

function var_0_0.enterLevel(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = LengZhou6Config.instance:getEpisodeConfig(arg_3_1, arg_3_2)
	local var_3_1 = var_3_0.eliminateLevelId

	if var_3_1 ~= 0 then
		LengZhou6StatHelper.instance:enterGame()
		LengZhou6GameModel.instance:enterLevel(var_3_0)
		LengZhou6EliminateController.instance:enterLevel(var_3_1)
		ViewMgr.instance:openView(ViewName.LengZhou6GameView)
	end
end

function var_0_0.restartLevel(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = LengZhou6Config.instance:getEpisodeConfig(arg_4_1, arg_4_2)
	local var_4_1 = var_4_0.eliminateLevelId

	if var_4_1 ~= 0 then
		LengZhou6StatHelper.instance:enterGame()
		LengZhou6GameModel.instance:enterLevel(var_4_0)
		LengZhou6EliminateController.instance:enterLevel(var_4_1)
		arg_4_0:dispatchEvent(LengZhou6Event.GameReStart)
	end
end

function var_0_0.gameUpdateRound(arg_5_0, arg_5_1)
	arg_5_0:_damageAndHpSettle(arg_5_1)
end

function var_0_0._damageAndHpSettle(arg_6_0, arg_6_1)
	local var_6_0 = LengZhou6GameModel.instance:getEnemySettleCount()
	local var_6_1 = 0
	local var_6_2 = 0

	for iter_6_0 = 1, var_6_0 do
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackBefore)

		local var_6_3, var_6_4 = LengZhou6GameModel.instance:getTotalPlayerSettle()

		var_6_1 = var_6_1 + var_6_3
		var_6_2 = var_6_2 + var_6_4

		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackAfter)
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackComplete)
	end

	LengZhou6GameModel.instance:resetEnemySettleCount()

	local var_6_5 = {
		damage = var_6_1,
		hp = var_6_2,
		isRound = arg_6_1
	}
	local var_6_6 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateDamage, var_6_5)

	LengZhou6EliminateController.instance:buildSeqFlow(var_6_6)
end

function var_0_0._updateRoundAndCD(arg_7_0, arg_7_1)
	if arg_7_1 then
		LengZhou6GameModel.instance:changeRound(-1)
		LengZhou6GameModel.instance:getPlayer():updateActiveSkillCD()
	end

	if LengZhou6GameModel.instance:gameIsOver() then
		local var_7_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo)

		LengZhou6EliminateController.instance:buildSeqFlow(var_7_0)

		return
	end

	arg_7_0:_enemySkillRelease(arg_7_1)
end

function var_0_0._enemySkillRelease(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0, var_8_1 = LengZhou6GameModel.instance:getEnemy():getAllCanUseSkillId()

		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.enemyCheckInterval)
		arg_8_0:dispatchEvent(LengZhou6Event.EnemySkillRound, var_8_1)

		if var_8_0 == nil then
			LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.poisonSettlement)

			return
		end

		for iter_8_0 = 1, #var_8_0 do
			local var_8_2 = var_8_0[iter_8_0]
			local var_8_3 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.LengZhou6EnemyReleaseSkillStep, var_8_2)

			LengZhou6EliminateController.instance:buildSeqFlow(var_8_3)
		end

		local var_8_4 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.LengZhou6EnemyGenerateSkillStep)

		LengZhou6EliminateController.instance:buildSeqFlow(var_8_4)
	end

	local var_8_5 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo)

	LengZhou6EliminateController.instance:buildSeqFlow(var_8_5)
end

function var_0_0.playerSettle(arg_9_0)
	LengZhou6GameModel.instance:playerSettle()
end

function var_0_0.gameEnd(arg_10_0)
	local var_10_0 = LengZhou6GameModel.instance:getBattleModel()
	local var_10_1 = LengZhou6GameModel.instance:playerIsWin()

	if var_10_0 == LengZhou6Enum.BattleModel.infinite and var_10_1 then
		if LengZhou6GameModel.instance:canSelectSkill() then
			LengZhou6GameModel.instance:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectSkill)
			arg_10_0:recordProgress()
		else
			LengZhou6GameModel.instance:enterNextLayer()
		end

		return
	end

	arg_10_0:dispatchEvent(LengZhou6Event.GameEnd, var_10_1)
	ViewMgr.instance:openView(ViewName.LengZhou6GameResult)
end

function var_0_0.levelGame(arg_11_0, arg_11_1)
	arg_11_0:recordProgress()

	if arg_11_1 then
		ViewMgr.instance:closeView(ViewName.LengZhou6GameView)
		LengZhou6EliminateController.instance:clear()
	end

	LengZhou6GameModel.instance:clear()
end

function var_0_0.recordProgress(arg_12_0)
	local var_12_0 = LengZhou6GameModel.instance:playerIsWin()
	local var_12_1 = LengZhou6GameModel.instance:getBattleModel()

	if var_12_1 == LengZhou6Enum.BattleModel.infinite or var_12_0 then
		local var_12_2

		if var_12_1 == LengZhou6Enum.BattleModel.infinite then
			var_12_2 = LengZhou6GameModel.instance:getRecordServerData():getRecordData()

			local var_12_3 = LengZhou6GameModel.instance:getPlayer()

			if LengZhou6GameModel.instance:getCurRound() <= 0 or var_12_3:getHp() <= 0 then
				var_12_2 = ""
			end
		end

		local var_12_4 = LengZhou6Model.instance:getCurEpisodeId()

		if not LengZhou6Enum.enterGM then
			LengZhou6Controller.instance:finishLevel(var_12_4, var_12_2)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
