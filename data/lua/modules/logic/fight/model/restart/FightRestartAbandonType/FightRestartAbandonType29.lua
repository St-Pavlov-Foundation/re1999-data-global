module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType29", package.seeall)

local var_0_0 = class("FightRestartAbandonType29", FightRestartAbandonTypeBase)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
end

function var_0_0.canRestart(arg_2_0)
	local var_2_0 = RougeModel.instance:getRougeRetryNum() < RougeMapConfig.instance:getFightRetryNum()

	if not var_2_0 then
		GameFacade.showToast(ToastEnum.RougeNoEnoughRetryNum)
	end

	return var_2_0
end

function var_0_0.confirmNotice(arg_3_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_3_0._onPushEndFight, arg_3_0, LuaEventSystem.High)

	local var_3_0 = RougeMapConfig.instance:getFightRetryNum()
	local var_3_1 = RougeModel.instance:getRougeRetryNum()

	GameFacade.showMessageBox(MessageBoxIdDefine.RougeFightRestartConfirm, MsgBoxEnum.BoxType.Yes_No, arg_3_0.yesCallback, arg_3_0.noCallback, nil, arg_3_0, arg_3_0, nil, var_3_0 - var_3_1)
end

function var_0_0._onPushEndFight(arg_4_0)
	FightGameMgr.restartMgr:cancelRestart()
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
end

function var_0_0.yesCallback(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_5_0._onPushEndFight, arg_5_0)

	if arg_5_0.IS_DEAD then
		ToastController.instance:showToast(-80)

		return
	end

	arg_5_0:startAbandon()
end

function var_0_0.noCallback(arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_6_0._onPushEndFight, arg_6_0)
	FightGameMgr.restartMgr:cancelRestart()
end

function var_0_0.startAbandon(arg_7_0)
	DungeonFightController.instance:registerCallback(DungeonEvent.OnEndDungeonReply, arg_7_0._startRequestFight, arg_7_0)
	DungeonFightController.instance:sendEndFightRequest(true)
end

function var_0_0._startRequestFight(arg_8_0, arg_8_1)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, arg_8_0._startRequestFight, arg_8_0)

	if arg_8_1 ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end

	arg_8_0._fight_work:onDone(true)
end

function var_0_0.releaseSelf(arg_9_0)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, arg_9_0._startRequestFight, arg_9_0)
	arg_9_0:__onDispose()
end

return var_0_0
