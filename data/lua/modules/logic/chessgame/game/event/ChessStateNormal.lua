module("modules.logic.chessgame.game.event.ChessStateNormal", package.seeall)

slot0 = class("ChessStateNormal", ChessStateBase)

function slot0.start(slot0)
	logNormal("ChessStateNormal start")
	ChessGameController.instance:dispatchEvent(ChessGameEvent.EventStart, slot0:getStateType())
end

function slot0.onClickPos(slot0, slot1, slot2, slot3)
	slot4, slot5 = ChessGameController.instance:searchInteractByPos(slot1, slot2, ChessGameController.filterSelectable)

	if ChessGameController.instance:getClickStatus() == ChessGameEnum.SelectPosStatus.None then
		slot0:onClickInNoneStatus(slot4, slot5, slot3)
	elseif slot6 == ChessGameEnum.SelectPosStatus.SelectObjWaitPos then
		slot0:onClickInSelectObjWaitPosStatus(slot1, slot2, slot4, slot5, slot3)
	elseif slot6 == ChessGameEnum.SelectPosStatus.CatchObj then
		slot0:onClickCatchObjWaitPosStatus(slot1, slot2, slot4, slot5, slot3)
	elseif slot6 == ChessGameEnum.SelectPosStatus.ShowTalk then
		slot0:onClickShowTalkWaitPosStatus()
	end
end

function slot0.onClickInNoneStatus(slot0, slot1, slot2, slot3)
	if slot1 >= 1 then
		if (slot1 > 1 and slot2[1] or slot2).objType ~= ChessGameEnum.InteractType.Role then
			GameFacade.showToast(ToastEnum.ChessCanNotSelect)
		else
			ChessGameController.instance:setSelectObj(slot4)

			slot0._lastSelectObj = ChessGameController.instance:getSelectObj()
		end
	end
end

function slot0.onClickInSelectObjWaitPosStatus(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = ChessGameController.instance:getSelectObj()
	slot0._lastSelectObj = slot6

	if slot6 and slot6:getHandler() then
		if slot6:getHandler():onSelectPos(slot1, slot2) then
			if ChessGameController.instance.eventMgr:isPlayingFlow() then
				return
			end

			slot0:onClickPos(slot1, slot2, slot5)
		end
	else
		logError("select obj missing!")
	end
end

function slot0.onClickCatchObjWaitPosStatus(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = ChessGameController.instance:getSelectObj()
	slot0._lastSelectObj = slot6

	if slot6 and slot6:getHandler() then
		if slot6:getHandler():onSetPosWithCatchObj(slot1, slot2) then
			slot0:onClickPos(slot1, slot2, slot5)
		end
	else
		logError("select obj missing!")
	end
end

function slot0.onClickShowTalkWaitPosStatus(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.ClickOnTalking)
end

return slot0
