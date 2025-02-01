module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType29", package.seeall)

slot0 = class("FightRestartAbandonType29", FightRestartAbandonTypeBase)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fight_work = slot1
end

function slot0.canRestart(slot0)
	if not (RougeModel.instance:getRougeRetryNum() < RougeMapConfig.instance:getFightRetryNum()) then
		GameFacade.showToast(ToastEnum.RougeNoEnoughRetryNum)
	end

	return slot3
end

function slot0.confirmNotice(slot0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._onPushEndFight, slot0, LuaEventSystem.High)
	GameFacade.showMessageBox(MessageBoxIdDefine.RougeFightRestartConfirm, MsgBoxEnum.BoxType.Yes_No, slot0.yesCallback, slot0.noCallback, nil, slot0, slot0, nil, RougeMapConfig.instance:getFightRetryNum() - RougeModel.instance:getRougeRetryNum())
end

function slot0._onPushEndFight(slot0)
	FightSystem.instance:cancelRestart()
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
end

function slot0.yesCallback(slot0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._onPushEndFight, slot0)

	if slot0.IS_DEAD then
		ToastController.instance:showToast(-80)

		return
	end

	slot0:startAbandon()
end

function slot0.noCallback(slot0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._onPushEndFight, slot0)
	FightSystem.instance:cancelRestart()
end

function slot0.startAbandon(slot0)
	DungeonFightController.instance:registerCallback(DungeonEvent.OnEndDungeonReply, slot0._startRequestFight, slot0)
	DungeonFightController.instance:sendEndFightRequest(true)
end

function slot0._startRequestFight(slot0, slot1)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, slot0._startRequestFight, slot0)

	if slot1 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end

	slot0._fight_work:onDone(true)
end

function slot0.releaseSelf(slot0)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, slot0._startRequestFight, slot0)
	slot0:__onDispose()
end

return slot0
