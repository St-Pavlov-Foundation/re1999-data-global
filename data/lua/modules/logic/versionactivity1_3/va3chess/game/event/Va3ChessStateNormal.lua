module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateNormal", package.seeall)

slot0 = class("Va3ChessStateNormal", Va3ChessStateBase)

function slot0.start(slot0)
	logNormal("Va3ChessStateNormal start")
	Va3ChessGameController.instance:resetObjStateOnNewRound()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventStart, slot0:getStateType())
end

function slot0.onClickPos(slot0, slot1, slot2, slot3)
	slot4, slot5 = Va3ChessGameController.instance:searchInteractByPos(slot1, slot2, Va3ChessGameController.filterSelectable)

	if Va3ChessGameController.instance:getClickStatus() == Va3ChessEnum.SelectPosStatus.None then
		slot0:onClickInNoneStatus(slot4, slot5, slot3)
	elseif slot6 == Va3ChessEnum.SelectPosStatus.SelectObjWaitPos then
		slot0:onClickInSelectObjWaitPosStatus(slot1, slot2, slot4, slot5, slot3)
	end
end

function slot0.onClickInNoneStatus(slot0, slot1, slot2, slot3)
	if slot1 >= 1 then
		if (slot1 > 1 and slot2[1] or slot2).objType ~= Va3ChessEnum.InteractType.Player and slot4.objType ~= Va3ChessEnum.InteractType.AssistPlayer then
			GameFacade.showToast(ToastEnum.ChessCanNotSelect)
		else
			Va3ChessGameController.instance:setSelectObj(slot4)

			slot0._lastSelectObj = Va3ChessGameController.instance:getSelectObj()
		end
	end
end

function slot0.onClickInSelectObjWaitPosStatus(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Va3ChessGameController.instance:getSelectObj()
	slot0._lastSelectObj = slot6

	if slot6 and slot6:getHandler() then
		if slot6:getHandler():onSelectPos(slot1, slot2) then
			slot0:onClickPos(slot1, slot2, slot5)
		end
	else
		logError("select obj missing!")
	end
end

return slot0
