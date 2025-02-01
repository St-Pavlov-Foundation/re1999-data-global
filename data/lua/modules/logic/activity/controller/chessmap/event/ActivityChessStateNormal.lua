module("modules.logic.activity.controller.chessmap.event.ActivityChessStateNormal", package.seeall)

slot0 = class("ActivityChessStateNormal", ActivityChessStateBase)

function slot0.start(slot0)
	logNormal("ActivityChessStateNormal start")
end

function slot0.onClickPos(slot0, slot1, slot2, slot3)
	slot4, slot5 = ActivityChessGameController.instance:searchInteractByPos(slot1, slot2, ActivityChessGameController.filterSelectable)

	if ActivityChessGameController.instance:getClickStatus() == ActivityChessEnum.SelectPosStatus.None then
		slot0:onClickInNoneStatus(slot4, slot5, slot3)
	elseif slot6 == ActivityChessEnum.SelectPosStatus.SelectObjWaitPos then
		slot0:onClickInSelectObjWaitPosStatus(slot1, slot2, slot4, slot5, slot3)
	end
end

function slot0.onClickInNoneStatus(slot0, slot1, slot2, slot3)
	if slot1 >= 1 then
		if (slot1 > 1 and slot2[1] or slot2).objType ~= ActivityChessEnum.InteractType.Player then
			GameFacade.showToast(ToastEnum.ChessCanNotSelect)
		else
			if slot0._lastSelectObj ~= slot4 and slot3 then
				if slot4.config.avatar == ActivityChessEnum.RoleAvatar.Apple then
					AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectApple)
				elseif slot4.config.avatar == ActivityChessEnum.RoleAvatar.PKLS then
					AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectPKLS)
				elseif slot4.config.avatar == ActivityChessEnum.RoleAvatar.WJYS then
					AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectWJYS)
				end
			end

			ActivityChessGameController.instance:setSelectObj(slot4)

			slot0._lastSelectObj = ActivityChessGameController.instance:getSelectObj()
		end
	end
end

function slot0.onClickInSelectObjWaitPosStatus(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = ActivityChessGameController.instance:getSelectObj()
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
