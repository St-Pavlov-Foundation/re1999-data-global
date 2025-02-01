module("modules.logic.chessgame.game.step.ChessStepDialogue", package.seeall)

slot0 = class("ChessStepDialogue", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot1 = slot0.originData.interactId

	if not ChessConfig.instance:getBubbleCoByGroup(ChessModel.instance:getActId(), slot0.originData.dialogueId) then
		slot0:onDone(true)

		return
	end

	if ChessGameModel.instance:isTalking() then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.ClickOnTalking)

		return
	end

	ChessGameController.instance:registerCallback(ChessGameEvent.DialogEnd, slot0._onDialogEnd, slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.PlayDialogue, {
		txtco = slot4,
		id = slot1
	})
	ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.ShowTalk)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function slot0._onDialogEnd(slot0)
	ChessGameController.instance:setSelectObj(nil)
	ChessGameController.instance:autoSelectPlayer()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ChessGameController.instance:unregisterCallback(ChessGameEvent.DialogEnd, slot0._onDialogEnd, slot0)
end

return slot0
