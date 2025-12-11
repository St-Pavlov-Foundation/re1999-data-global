module("modules.logic.fight.view.FightViewEnemyCard", package.seeall)

local var_0_0 = class("FightViewEnemyCard", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._opItemContainer = gohelper.findChild(arg_1_0.viewGO, "root/enemycards")
	arg_1_0._opItemGO = gohelper.findChild(arg_1_0.viewGO, "root/enemycards/item")
	arg_1_0._enemyCardTip = gohelper.findChild(arg_1_0.viewGO, "root/enemycards/enemyCardTip")
	arg_1_0._txtActionCount = gohelper.findChildText(arg_1_0.viewGO, "root/enemycards/enemyCardTip/txtactioncount")
	arg_1_0._opItemList = arg_1_0:getUserDataTb_()

	gohelper.setActive(arg_1_0._opItemGO, false)
	gohelper.setActive(arg_1_0._opItemContainer, false)

	arg_1_0._myActBreakFlow = FlowSequence.New()

	arg_1_0._myActBreakFlow:addWork(FightMyActPointBreakEffect.New())

	arg_1_0._enemyActBreakFlow = FlowSequence.New()

	arg_1_0._enemyActBreakFlow:addWork(FightEnemyActPointBreakEffect.New())

	arg_1_0._longPressTab = arg_1_0:getUserDataTb_()
	arg_1_0._deadEntityIds = nil
	arg_1_0._enemyCurrActPoint = 0
	arg_1_0._enemyNextActPoint = 0
end

function var_0_0.onDestroyView(arg_2_0)
	arg_2_0._myActBreakFlow:destroy()
	arg_2_0._enemyActBreakFlow:destroy()

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._longPressTab) do
		iter_2_1.longPress:RemoveLongPressListener()
		iter_2_1.clickUp:RemoveClickUpListener()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_3_0._onStartSequenceFinish, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundSequenceFinish, arg_3_0, LuaEventSystem.Low)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_3_0._onRoundSequenceStart, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PushFightWave, arg_3_0._onPushFightWave, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.HaveNextWave, arg_3_0.onHaveNextWave, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, arg_3_0._onEntityDead, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSummon, arg_3_0._onSummon, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_4_0._onStartSequenceFinish, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_4_0._onRoundSequenceFinish, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_4_0._onRoundSequenceStart, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.PushFightWave, arg_4_0._onPushFightWave, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.HaveNextWave, arg_4_0.onHaveNextWave, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.BeforeDeadEffect, arg_4_0._onEntityDead, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSummon, arg_4_0._onSummon, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_4_0._onSkillFinishDoActPoint, arg_4_0)
end

function var_0_0._onStartSequenceFinish(arg_5_0)
	local var_5_0 = FightDataHelper.roundMgr:getRoundData()

	arg_5_0._myActPoint = FightDataHelper.operationDataMgr.actPoint
	arg_5_0._enemyCurrActPoint = var_5_0 and var_5_0:getEnemyActPoint() or 0
	arg_5_0._enemyNextActPoint = arg_5_0._enemyCurrActPoint

	if ViewMgr.instance:isOpen(ViewName.FightSpecialTipView) then
		arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseView, arg_5_0)
	else
		arg_5_0:_playEffect(arg_5_0._myActPoint)
	end
end

function var_0_0._onCloseView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.FightSpecialTipView then
		arg_6_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseView, arg_6_0)
		arg_6_0:_playEffect(arg_6_0._myActPoint)
	end
end

function var_0_0._onRoundSequenceFinish(arg_7_0)
	if arg_7_0._enemyActBreakFlow.status == WorkStatus.Running then
		arg_7_0._enemyActBreakFlow:stop()
		arg_7_0._enemyActBreakFlow:unregisterDoneListener(arg_7_0._onEnemyActBreakDone, arg_7_0)
	end

	local var_7_0 = FightDataHelper.roundMgr:getRoundData()
	local var_7_1 = FightDataHelper.operationDataMgr.actPoint
	local var_7_2 = var_7_0 and var_7_0:getEnemyActPoint() or 0

	arg_7_0._enemyCurrActPoint = var_7_2
	arg_7_0._enemyNextActPoint = var_7_2

	arg_7_0:_playEffect(var_7_1)

	arg_7_0._mySideDead = nil
	arg_7_0._enemySideDead = nil
	arg_7_0._myActPoint = var_7_1
	arg_7_0._enemyActPoint = var_7_2
end

function var_0_0._playEffect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._opItemContainer, false)

	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.viewGO = arg_8_0.viewGO
	var_8_0.myHasDeadEntity = arg_8_0._mySideDead
	var_8_0.myNowActPoint = arg_8_1
	var_8_0.myBreakActPoint = arg_8_1 < arg_8_0._myActPoint and arg_8_0._myActPoint - arg_8_1 or 0

	arg_8_0._myActBreakFlow:start(var_8_0)
end

function var_0_0._onRoundSequenceStart(arg_9_0)
	local var_9_0 = FightDataHelper.roundMgr:getRoundData()

	arg_9_0._enemyNextActPoint = var_9_0 and var_9_0:getEnemyActPoint() or 0

	gohelper.setActive(arg_9_0._opItemContainer, false)
end

function var_0_0.onHaveNextWave(arg_10_0)
	arg_10_0._enemyNextActPoint = 0
end

function var_0_0._onPushFightWave(arg_11_0)
	if FightDataHelper.cacheFightMgr:getNextFightData() then
		arg_11_0._enemyNextActPoint = 0
	end
end

function var_0_0._onSummon(arg_12_0, arg_12_1)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) then
		return
	end

	if not arg_12_1 or not arg_12_1:isEnemySide() then
		return
	end
end

function var_0_0._onEntityDead(arg_13_0, arg_13_1)
	arg_13_0._minusCount = arg_13_0._minusCount or 0

	local var_13_0 = FightDataHelper.entityMgr:getById(arg_13_1)

	if not var_13_0 then
		return
	end

	if var_13_0.side == FightEnum.EntitySide.MySide then
		arg_13_0._mySideDead = true
	elseif var_13_0.side == FightEnum.EntitySide.EnemySide then
		arg_13_0._enemySideDead = true

		if FightHelper.isAllEntityDead(FightEnum.EntitySide.EnemySide) then
			arg_13_0._minusCount = arg_13_0._enemyCurrActPoint
		else
			arg_13_0._minusCount = arg_13_0._minusCount + arg_13_0:_calcMinusCount(arg_13_1)
		end
	end

	if FightSkillMgr.instance:isPlayingAnyTimeline() then
		arg_13_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_13_0._onSkillFinishDoActPoint, arg_13_0)
	else
		arg_13_0:_onDeadPlayActPointEffect()
	end
end

function var_0_0._onSkillFinishDoActPoint(arg_14_0)
	arg_14_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_14_0._onSkillFinishDoActPoint, arg_14_0)
	arg_14_0:_onDeadPlayActPointEffect()
end

function var_0_0._onDeadPlayActPointEffect(arg_15_0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) then
		return
	end

	if arg_15_0._minusCount and arg_15_0._minusCount > 0 then
		local var_15_0

		if arg_15_0._enemyActBreakFlow.status == WorkStatus.Running then
			var_15_0 = arg_15_0._enemyActBreakFlow.context

			arg_15_0._enemyActBreakFlow:stop()

			var_15_0.enemyHasDeadEntity = arg_15_0._enemySideDead
			var_15_0.enemyNowActPoint = var_15_0.enemyNowActPoint - arg_15_0._minusCount
			var_15_0.enemyBreakActPoint = var_15_0.enemyBreakActPoint + arg_15_0._minusCount
		else
			var_15_0 = {
				enemyHasDeadEntity = arg_15_0._enemySideDead,
				enemyNowActPoint = arg_15_0._enemyCurrActPoint - arg_15_0._minusCount,
				enemyBreakActPoint = arg_15_0._minusCount
			}
		end

		var_15_0.viewGO = arg_15_0.viewGO

		arg_15_0._enemyActBreakFlow:registerDoneListener(arg_15_0._onEnemyActBreakDone, arg_15_0)
		arg_15_0._enemyActBreakFlow:start(var_15_0)
		gohelper.setActive(arg_15_0._opItemContainer, false)

		arg_15_0._enemyCurrActPoint = arg_15_0._enemyCurrActPoint - arg_15_0._minusCount

		if arg_15_0._enemySideDead then
			AudioMgr.instance:trigger(AudioEnum.UI.play_buff_disappear_grid)
		end
	end

	arg_15_0._minusCount = nil
end

function var_0_0._calcMinusCount(arg_16_0, arg_16_1)
	local var_16_0 = FightDataHelper.entityMgr:getById(arg_16_1)

	if not var_16_0 or var_16_0.side ~= FightEnum.EntitySide.EnemySide then
		return 0
	end

	local var_16_1 = 1
	local var_16_2 = FightHelper.buildSkills(var_16_0.modelId)
	local var_16_3 = var_16_2 and #var_16_2 or 0

	for iter_16_0 = 1, var_16_3 do
		local var_16_4 = var_16_2[iter_16_0]
		local var_16_5 = lua_skill.configDict[var_16_4]

		if var_16_5 then
			for iter_16_1 = 1, FightEnum.MaxBehavior do
				local var_16_6 = var_16_5["behavior" .. iter_16_1]

				if not string.nilorempty(var_16_6) then
					local var_16_7 = FightStrUtil.instance:getSplitToNumberCache(var_16_6, "#")

					if var_16_7[1] == 50006 then
						var_16_1 = var_16_1 + (var_16_7[2] or 0)
					end
				end
			end
		end
	end

	if arg_16_0._enemyCurrActPoint - var_16_1 >= arg_16_0._enemyNextActPoint then
		return var_16_1
	else
		return arg_16_0._enemyCurrActPoint - arg_16_0._enemyNextActPoint
	end
end

function var_0_0._onEnemyActBreakDone(arg_17_0)
	gohelper.setActive(arg_17_0._opItemContainer, false)
end

function var_0_0._showEnemyCardTip(arg_18_0)
	local var_18_0 = FightDataHelper.roundMgr:getRoundData():getAIUseCardMOList()
	local var_18_1 = var_18_0 and #var_18_0 or 0
	local var_18_2 = recthelper.getAnchorX(arg_18_0._opItemList[var_18_1].go.transform.parent)
	local var_18_3 = recthelper.getAnchorY(arg_18_0._opItemList[var_18_1].go.transform.parent)

	recthelper.setAnchor(arg_18_0._enemyCardTip.transform, var_18_2 + 31, var_18_3 + 7.5)

	arg_18_0._txtActionCount.text = var_18_1

	gohelper.setActive(arg_18_0._enemyCardTip, true)
end

function var_0_0._onEnemyCardClickUp(arg_19_0)
	gohelper.setActive(arg_19_0._enemyCardTip, false)
end

return var_0_0
