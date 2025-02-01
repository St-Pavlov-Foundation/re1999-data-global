module("modules.logic.chessgame.game.step.ChessCheckIsCatch", package.seeall)

slot0 = class("ChessCheckIsCatch", BaseWork)

function slot0.init(slot0)
end

function slot0.onStart(slot0, slot1)
	slot0:checkIsCatchObj(slot1)
end

function slot0.checkIsCatchObj(slot0, slot1)
	if slot1 then
		if not ChessGameInteractModel.instance:getInteractById(slot1.mo.id) then
			slot2 = ChessGameController.instance.interactsMgr:getMainPlayer()
			slot3, slot4 = slot2.mo:getXY()

			slot2:getHandler():moveTo(slot3, slot4, slot0.afterReturnBack, slot0)
		else
			ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
				visible = false
			})
			ChessGameController.instance:autoSelectPlayer()

			if ChessGameController.instance.interactsMgr:getMainPlayer() then
				slot2:getHandler():_refreshNodeArea()
				slot1:getHandler():withCatch()
				ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.CatchObj)
				slot0:onDone(true)
			else
				slot0:onDone(true)
			end
		end
	else
		slot0:onDone(true)
	end
end

function slot0.afterReturnBack(slot0)
	slot1 = ChessGameController.instance.interactsMgr:getMainPlayer()

	slot1:getHandler():calCanWalkArea()
	slot1:getHandler():faceTo(slot1.mo:getDirection())
	slot0:onDone(true)
end

return slot0
