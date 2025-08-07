module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateStepUtil", package.seeall)

local var_0_0 = class("EliminateStepUtil")

function var_0_0.createStep(arg_1_0, arg_1_1)
	local var_1_0

	if arg_1_0 == EliminateEnum.StepWorkType.Move then
		var_1_0 = EliminateChessMoveStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.Die then
		var_1_0 = EliminateChessDieStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.Debug then
		var_1_0 = EliminateChessDebugStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.Arrange then
		var_1_0 = EliminateChessArrangeStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.HandleData then
		var_1_0 = EliminateChessHandleDataStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.StartShowView then
		var_1_0 = EliminateChessShowStartStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.EndShowView then
		var_1_0 = EliminateChessShowEndStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.ShowEvaluate then
		var_1_0 = EliminateChessShowEvaluateStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.PlayEffect then
		var_1_0 = EliminateChessPlayEffectStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.PlayAudio then
		var_1_0 = EliminateChessPlayAudioStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.RefreshEliminate then
		var_1_0 = EliminateChessRefreshStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.Arrange_XY then
		var_1_0 = EliminateChessArrange_XYStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.DieEffect then
		var_1_0 = EliminateChessDieEffectStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.ChangeState then
		var_1_0 = EliminateChessChangeStateStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.CheckEliminate then
		var_1_0 = EliminateChessCheckStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.EliminateChessDebug2_7 then
		var_1_0 = EliminateChessDebug2_7Step.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.EliminateChessRevert then
		var_1_0 = EliminateChessRevertStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.EliminateChessUpdateDamage then
		var_1_0 = EliminateChessUpdateDamageStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo then
		var_1_0 = EliminateChessUpdateGameInfoStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.LengZhou6EnemyReleaseSkillStep then
		var_1_0 = LengZhou6EnemyReleaseSkillStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.ChessItemUpdateInfo then
		var_1_0 = EliminateChessItemUpdateInfoStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.LengZhou6EnemyGenerateSkillStep then
		var_1_0 = LengZhou6EnemyGenerateSkillStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.EliminateCheckAndRefresh then
		var_1_0 = EliminateCheckAndRefreshStep.New()
	end

	if arg_1_0 == EliminateEnum.StepWorkType.LengZhou6PlayAudio then
		var_1_0 = EliminatePlayAudioStep.New()
	end

	if var_1_0 then
		var_1_0:initData(arg_1_1)
	else
		logError("EliminateChessController:getSetWork stepType error!")
	end

	return var_1_0
end

function var_0_0.createCommonStepTable(arg_2_0, arg_2_1, arg_2_2)
	if var_0_0.stepPool == nil then
		var_0_0.stepPool = LuaObjPool.New(10, function()
			return {
				x = arg_2_0,
				y = arg_2_1,
				time = arg_2_2
			}
		end, function(arg_4_0)
			arg_4_0 = nil
		end, function(arg_5_0)
			arg_5_0.x = 0
			arg_5_0.y = 0
			arg_5_0.time = 0
		end)
	end

	return var_0_0.stepPool:getObject()
end

function var_0_0.putCommonStepTable(arg_6_0)
	var_0_0.stepPool:putObject(arg_6_0)
end

function var_0_0.releaseCommonStepTable()
	if var_0_0.stepPool then
		var_0_0.stepPool:dispose()

		var_0_0.stepPool = nil
	end
end

function var_0_0.createOrGetMoveStepTable(arg_8_0, arg_8_1, arg_8_2)
	if var_0_0.moveStepPool == nil then
		var_0_0.moveStepPool = LuaObjPool.New(10, function()
			return {
				chessItem = arg_8_0,
				time = arg_8_1 and arg_8_1 or EliminateEnum.AniTime.Move,
				animType = arg_8_2
			}
		end, function(arg_10_0)
			arg_10_0.chessItem = nil
			arg_10_0.time = nil
			arg_10_0.animType = nil
			arg_10_0 = nil
		end, function(arg_11_0)
			arg_11_0.chessItem = nil
			arg_11_0.time = nil
			arg_11_0.animType = nil
		end)
	end

	local var_8_0 = var_0_0.moveStepPool:getObject()

	var_8_0.chessItem = arg_8_0
	var_8_0.time = arg_8_1 and arg_8_1 or EliminateEnum.AniTime.Move
	var_8_0.animType = arg_8_2

	return var_8_0
end

function var_0_0.putMoveStepTable(arg_12_0)
	if var_0_0.moveStepPool ~= nil then
		var_0_0.moveStepPool:putObject(arg_12_0)
	end
end

function var_0_0.releaseMoveStepTable()
	if var_0_0.moveStepPool ~= nil then
		var_0_0.moveStepPool:dispose()

		var_0_0.moveStepPool = nil
	end
end

return var_0_0
