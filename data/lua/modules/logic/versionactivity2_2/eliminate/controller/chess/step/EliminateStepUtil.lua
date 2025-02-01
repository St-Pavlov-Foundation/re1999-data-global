module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateStepUtil", package.seeall)

slot0 = class("EliminateStepUtil")

function slot0.createStep(slot0, slot1)
	slot2 = nil

	if slot0 == EliminateEnum.StepWorkType.Move then
		slot2 = EliminateChessMoveStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.Die then
		slot2 = EliminateChessDieStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.Debug then
		slot2 = EliminateChessDebugStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.Arrange then
		slot2 = EliminateChessArrangeStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.HandleData then
		slot2 = EliminateChessHandleDataStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.StartShowView then
		slot2 = EliminateChessShowStartStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.EndShowView then
		slot2 = EliminateChessShowEndStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.ShowEvaluate then
		slot2 = EliminateChessShowEvaluateStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.PlayEffect then
		slot2 = EliminateChessPlayEffectStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.PlayAudio then
		slot2 = EliminateChessPlayAudioStep.New()
	end

	if slot0 == EliminateEnum.StepWorkType.RefreshEliminate then
		slot2 = EliminateChessRefreshStep.New()
	end

	if slot2 then
		slot2:initData(slot1)
	else
		logError("EliminateChessController:getSetWork stepType error!")
	end

	return slot2
end

function slot0.createCommonStepTable(slot0, slot1, slot2)
	if uv0.stepPool == nil then
		uv0.stepPool = LuaObjPool.New(10, function ()
			return {
				x = uv0,
				y = uv1,
				time = uv2
			}
		end, function (slot0)
			slot0 = nil
		end, function (slot0)
			slot0.x = 0
			slot0.y = 0
			slot0.time = 0
		end)
	end

	return uv0.stepPool:getObject()
end

function slot0.putCommonStepTable(slot0)
	uv0.stepPool:putObject(slot0)
end

function slot0.releaseCommonStepTable()
	if uv0.stepPool then
		uv0.stepPool:dispose()

		uv0.stepPool = nil
	end
end

function slot0.createOrGetMoveStepTable(slot0, slot1, slot2)
	if uv0.moveStepPool == nil then
		uv0.moveStepPool = LuaObjPool.New(10, function ()
			return {
				chessItem = uv0,
				time = uv1 and uv1 or EliminateEnum.AniTime.Move,
				animType = uv2
			}
		end, function (slot0)
			slot0.chessItem = nil
			slot0.time = nil
			slot0.animType = nil
			slot0 = nil
		end, function (slot0)
			slot0.chessItem = nil
			slot0.time = nil
			slot0.animType = nil
		end)
	end

	uv0.moveStepPool:getObject().chessItem = slot0
	slot3.time = slot1 and slot1 or EliminateEnum.AniTime.Move
	slot3.animType = slot2

	return slot3
end

function slot0.putMoveStepTable(slot0)
	if uv0.moveStepPool ~= nil then
		uv0.moveStepPool:putObject(slot0)
	end
end

function slot0.releaseMoveStepTable()
	if uv0.moveStepPool ~= nil then
		uv0.moveStepPool:dispose()

		uv0.moveStepPool = nil
	end
end

return slot0
