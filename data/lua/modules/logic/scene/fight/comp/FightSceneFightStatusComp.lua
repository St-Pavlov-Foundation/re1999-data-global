module("modules.logic.scene.fight.comp.FightSceneFightStatusComp", package.seeall)

local var_0_0 = class("FightSceneFightStatusComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, arg_2_0._onRoundSequenceStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_2_0._onRestartStageBefore, arg_2_0)
	FightController.instance:registerCallback(FightEvent.FightDialogEnd, arg_2_0._onFightDialogEnd, arg_2_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_2_0._pushEndFight, arg_2_0)
	FightController.instance:registerCallback(FightEvent.CoverPerformanceEntityData, arg_2_0.onCoverPerformanceEntityData, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0._onLevelLoaded(arg_3_0)
	arg_3_0._fightScene = GameSceneMgr.instance:getCurScene()
	arg_3_0._sceneObj = arg_3_0._fightScene.level:getSceneGo()
end

function var_0_0._onFightDialogEnd(arg_4_0)
	arg_4_0:_clearTab()
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.StoryView then
		arg_5_0:_clearTab()
	end
end

function var_0_0._checkFunc(arg_6_0)
	if FightViewDialog.playingDialog then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	local var_6_0 = true

	arg_6_0._hpDic = arg_6_0._hpDic or {}
	arg_6_0._expointDic = arg_6_0._expointDic or {}
	arg_6_0._buffCount = arg_6_0._buffCount or {}

	local var_6_1 = FightHelper.getAllEntitys()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = iter_6_1.id
		local var_6_3 = iter_6_1:getMO()

		if var_6_3 then
			local var_6_4 = var_6_3.currentHp

			if arg_6_0._hpDic[var_6_2] ~= var_6_4 then
				var_6_0 = false
				arg_6_0._hpDic[var_6_2] = var_6_4
			end

			local var_6_5 = var_6_3:getExPoint()

			if arg_6_0._expointDic[var_6_2] ~= var_6_5 then
				var_6_0 = false
				arg_6_0._expointDic[var_6_2] = var_6_5
			end

			local var_6_6 = var_6_3:getBuffList()
			local var_6_7 = var_6_6 and #var_6_6 or 0

			if arg_6_0._buffCount[var_6_2] ~= var_6_7 then
				var_6_0 = false
				arg_6_0._buffCount[var_6_2] = var_6_7
			end
		end
	end

	if var_6_0 then
		logError("场上角色数据一分钟没有变化了,可能卡住了")
		FightMsgMgr.sendMsg(FightMsgId.MaybeCrashed)
		arg_6_0:_releaseTimer()
	end
end

function var_0_0._onRoundSequenceStart(arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0._checkFunc, arg_7_0, 60)
end

function var_0_0._onRoundSequenceFinish(arg_8_0)
	arg_8_0:_releaseTimer()
end

function var_0_0._onRestartStageBefore(arg_9_0)
	arg_9_0:_releaseTimer()
end

function var_0_0._releaseTimer(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._checkFunc, arg_10_0)
	arg_10_0:_clearTab()
end

function var_0_0._pushEndFight(arg_11_0)
	arg_11_0:_releaseTimer()
end

function var_0_0._clearTab(arg_12_0)
	arg_12_0._hpDic = nil
	arg_12_0._expointDic = nil
	arg_12_0._buffCount = nil
end

function var_0_0.onCoverPerformanceEntityData(arg_13_0, arg_13_1)
	local var_13_0 = FightHelper.getEntity(arg_13_1)

	if var_13_0 and var_13_0.buff then
		var_13_0.buff:releaseAllBuff()
		var_13_0.buff:dealStartBuff()
	end
end

function var_0_0.onSceneClose(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:_releaseTimer()
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, arg_14_0._onRoundSequenceStart, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_14_0._onRoundSequenceFinish, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_14_0._onRestartStageBefore, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_14_0._onFightDialogEnd, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_14_0._pushEndFight, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.CoverPerformanceEntityData, arg_14_0.onCoverPerformanceEntityData, arg_14_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_14_0._onCloseView, arg_14_0)
end

return var_0_0
