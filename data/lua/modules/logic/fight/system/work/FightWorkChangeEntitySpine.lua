module("modules.logic.fight.system.work.FightWorkChangeEntitySpine", package.seeall)

local var_0_0 = class("FightWorkChangeEntitySpine", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entity = arg_1_1
	arg_1_0._url = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 10)

	arg_2_0._lastSpineObj = arg_2_0._entity.spine:getSpineGO()

	arg_2_0._entity:loadSpine(arg_2_0._onLoaded, arg_2_0, arg_2_0._url)
end

function var_0_0._onLoaded(arg_3_0)
	if arg_3_0._entity then
		arg_3_0._entity:initHangPointDict()
		FightRenderOrderMgr.instance:_resetRenderOrder(arg_3_0._entity.id)

		local var_3_0 = arg_3_0._entity.effect:getHangEffect()

		if var_3_0 then
			for iter_3_0, iter_3_1 in pairs(var_3_0) do
				local var_3_1 = iter_3_1.effectWrap
				local var_3_2 = iter_3_1.hangPoint
				local var_3_3, var_3_4, var_3_5 = transformhelper.getLocalPos(var_3_1.containerTr)
				local var_3_6 = arg_3_0._entity:getHangPoint(var_3_2)

				gohelper.addChild(var_3_6, var_3_1.containerGO)
				transformhelper.setLocalPos(var_3_1.containerTr, var_3_3, var_3_4, var_3_5)
			end
		end

		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, arg_3_0._entity.spine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, arg_3_0._entity.spine)
	end

	gohelper.destroy(arg_3_0._lastSpineObj)
	arg_3_0:onDone(true)
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
end

return var_0_0
