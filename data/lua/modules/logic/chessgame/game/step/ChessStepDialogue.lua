module("modules.logic.chessgame.game.step.ChessStepDialogue", package.seeall)

local var_0_0 = class("ChessStepDialogue", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.originData.interactId
	local var_2_1 = arg_2_0.originData.dialogueId
	local var_2_2 = ChessModel.instance:getActId()
	local var_2_3 = ChessConfig.instance:getBubbleCoByGroup(var_2_2, var_2_1)

	if not var_2_3 then
		arg_2_0:onDone(true)

		return
	end

	if ChessGameModel.instance:isTalking() then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.ClickOnTalking)

		return
	end

	ChessGameController.instance:registerCallback(ChessGameEvent.DialogEnd, arg_2_0._onDialogEnd, arg_2_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.PlayDialogue, {
		txtco = var_2_3,
		id = var_2_0
	})
	ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.ShowTalk)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function var_0_0._onDialogEnd(arg_3_0)
	ChessGameController.instance:setSelectObj(nil)
	ChessGameController.instance:autoSelectPlayer()
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	ChessGameController.instance:unregisterCallback(ChessGameEvent.DialogEnd, arg_4_0._onDialogEnd, arg_4_0)
end

return var_0_0
