module("modules.logic.fight.view.FightViewBossHpMgr", package.seeall)

local var_0_0 = class("FightViewBossHpMgr", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._bossHpRoot = gohelper.findChild(arg_1_0.viewGO, "root/bossHpRoot").transform

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, arg_2_0._onBeforeEnterStepBehaviour, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, arg_2_0._onRestartStage, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._hpItem = gohelper.findChild(arg_4_0.viewGO, "root/bossHpRoot/bossHp")

	SLFramework.AnimatorPlayer.Get(arg_4_0._hpItem):Play("idle", nil, nil)
	gohelper.setActive(gohelper.findChild(arg_4_0.viewGO, "root/bossHpRoot/bossHp/Alpha/bossHp"), false)
end

function var_0_0._onRestartStage(arg_5_0)
	arg_5_0:killAllChildView()
end

function var_0_0._onBeforeEnterStepBehaviour(arg_6_0)
	if not GMFightShowState.bossHp then
		return
	end

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		arg_6_0:openSubView(BossRushFightViewBossHp, arg_6_0._hpItem)

		return
	end

	local var_6_0 = 3

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		var_6_0 = var_6_0 + 1
	end

	if FightView.canShowSpecialBtn() then
		var_6_0 = var_6_0 + 1
	end

	local var_6_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_6_1 and var_6_1.type == DungeonEnum.EpisodeType.Rouge then
		var_6_0 = var_6_0 + 1
	end

	if var_6_0 >= 6 then
		recthelper.setAnchorX(arg_6_0._bossHpRoot, -70)
	end

	local var_6_2 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	local var_6_3 = 0
	local var_6_4 = FightHelper.getCurBossId()
	local var_6_5 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		local var_6_6 = iter_6_1:getMO()

		if var_6_6 and FightHelper.isBossId(var_6_4, var_6_6.modelId) then
			var_6_3 = var_6_3 + 1

			table.insert(var_6_5, iter_6_1.id)
		end
	end

	if var_6_3 == 2 then
		for iter_6_2, iter_6_3 in ipairs(var_6_5) do
			local var_6_7 = gohelper.cloneInPlace(arg_6_0._hpItem, "bossHp" .. iter_6_2)

			gohelper.setActive(var_6_7, true)

			local var_6_8 = var_6_0 >= 5 and 400 or 450

			recthelper.setWidth(var_6_7.transform, var_6_8)

			local var_6_9 = var_6_0 >= 5 and 240 or 295

			if var_6_9 == 295 and iter_6_2 == 1 then
				var_6_9 = 255
			end

			recthelper.setAnchorX(var_6_7.transform, iter_6_2 == 1 and -var_6_9 or var_6_9)
			arg_6_0:openSubView(FightViewMultiBossHp, var_6_7, nil, iter_6_3)
		end

		gohelper.setActive(arg_6_0._hpItem, false)
	else
		arg_6_0:openSubView(FightViewBossHp, arg_6_0._hpItem)
	end
end

function var_0_0.onRefreshViewParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
