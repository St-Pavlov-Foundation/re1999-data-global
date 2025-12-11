module("modules.logic.fight.mgr.FightCheckCrashMgr", package.seeall)

local var_0_0 = class("FightCheckCrashMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0:com_registFightEvent(FightEvent.OnRoundSequenceStart, arg_1_0._onRoundSequenceStart)
	arg_1_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundSequenceFinish)
	arg_1_0:com_registFightEvent(FightEvent.OnRestartStageBefore, arg_1_0._onRestartStageBefore)
	arg_1_0:com_registFightEvent(FightEvent.FightDialogEnd, arg_1_0._onFightDialogEnd)
	arg_1_0:com_registFightEvent(FightEvent.StartFightEnd, arg_1_0.onStartFightEnd)
	arg_1_0:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, arg_1_0._onCloseView)
end

function var_0_0._onFightDialogEnd(arg_2_0)
	arg_2_0:clearTab()
end

function var_0_0._onCloseView(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.StoryView then
		arg_3_0:clearTab()
	end
end

function var_0_0.checkFunc(arg_4_0)
	if FightViewDialog.playingDialog then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	local var_4_0 = true

	arg_4_0.hpDic = arg_4_0.hpDic or {}
	arg_4_0.exPointDic = arg_4_0.exPointDic or {}
	arg_4_0.buffCount = arg_4_0.buffCount or {}

	local var_4_1 = FightDataHelper.entityMgr.entityDataDic

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		local var_4_2 = iter_4_1.currentHp

		if arg_4_0.hpDic[iter_4_0] ~= var_4_2 then
			var_4_0 = false
			arg_4_0.hpDic[iter_4_0] = var_4_2
		end

		local var_4_3 = iter_4_1:getExPoint()

		if arg_4_0.exPointDic[iter_4_0] ~= var_4_3 then
			var_4_0 = false
			arg_4_0.exPointDic[iter_4_0] = var_4_3
		end

		local var_4_4 = iter_4_1:getBuffList()
		local var_4_5 = var_4_4 and #var_4_4 or 0

		if arg_4_0.buffCount[iter_4_0] ~= var_4_5 then
			var_4_0 = false
			arg_4_0.buffCount[iter_4_0] = var_4_5
		end
	end

	if var_4_0 then
		logError("场上角色数据一分钟没有变化了,可能卡住了")
		FightMsgMgr.sendMsg(FightMsgId.MaybeCrashed)
		arg_4_0:releaseTimer()
	end
end

function var_0_0._onRoundSequenceStart(arg_5_0)
	arg_5_0:com_registSingleRepeatTimer(arg_5_0.checkFunc, 60, -1)
end

function var_0_0._onRoundSequenceFinish(arg_6_0)
	arg_6_0:com_releaseSingleTimer(arg_6_0.checkFunc)
end

function var_0_0._onRestartStageBefore(arg_7_0)
	arg_7_0:com_releaseSingleTimer(arg_7_0.checkFunc)
end

function var_0_0.releaseTimer(arg_8_0)
	arg_8_0:com_releaseSingleTimer(arg_8_0.checkFunc)
	arg_8_0:clearTab()
end

function var_0_0.onStartFightEnd(arg_9_0)
	arg_9_0:releaseTimer()
end

function var_0_0.clearTab(arg_10_0)
	arg_10_0.hpDic = nil
	arg_10_0.exPointDic = nil
	arg_10_0.buffCount = nil
end

function var_0_0.onDestructor(arg_11_0)
	return
end

return var_0_0
