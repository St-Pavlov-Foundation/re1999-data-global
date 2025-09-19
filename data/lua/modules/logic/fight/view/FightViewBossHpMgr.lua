module("modules.logic.fight.view.FightViewBossHpMgr", package.seeall)

local var_0_0 = class("FightViewBossHpMgr", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.viewRoot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0.hpRootObj = gohelper.findChild(arg_1_0.viewGO, "root/bossHpRoot")
	arg_1_0._bossHpRoot = arg_1_0.hpRootObj.transform

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, arg_2_0._onBeforeEnterStepBehaviour)
	arg_2_0:com_registFightEvent(FightEvent.OnRestartStageBefore, arg_2_0._onRestartStage)
	arg_2_0:com_registFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, arg_2_0.onSetBossHpVisibleWhenHidingFightView)
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

	if FightDataHelper.fieldMgr:isShelter() then
		arg_6_0:com_openSubView(FightViewSurvivalBossHp, arg_6_0._hpItem)

		return
	end

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		arg_6_0:com_openSubView(BossRushFightViewBossHp, arg_6_0._hpItem)

		return
	end

	local var_6_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	if var_6_0 and var_6_0.bloodReward then
		gohelper.setActive(arg_6_0._hpItem, false)
		arg_6_0:com_openSubView(FightViewBossHpBloodReward, "ui/viewres/fight/fight_act191bosshpview.prefab", arg_6_0._bossHpRoot.gameObject, var_6_0)

		return
	end

	local var_6_1 = 3

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		var_6_1 = var_6_1 + 1
	end

	if FightView.canShowSpecialBtn() then
		var_6_1 = var_6_1 + 1
	end

	local var_6_2 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_6_2 and var_6_2.type == DungeonEnum.EpisodeType.Rouge then
		var_6_1 = var_6_1 + 1
	end

	if var_6_1 >= 6 then
		recthelper.setAnchorX(arg_6_0._bossHpRoot, -70)
	end

	local var_6_3 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	local var_6_4 = 0
	local var_6_5 = FightHelper.getCurBossId()
	local var_6_6 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_3) do
		local var_6_7 = iter_6_1:getMO()

		if var_6_7 and FightHelper.isBossId(var_6_5, var_6_7.modelId) then
			var_6_4 = var_6_4 + 1

			table.insert(var_6_6, iter_6_1.id)
		end
	end

	if var_6_4 == 2 then
		for iter_6_2, iter_6_3 in ipairs(var_6_6) do
			local var_6_8 = gohelper.cloneInPlace(arg_6_0._hpItem, "bossHp" .. iter_6_2)

			gohelper.setActive(var_6_8, true)

			local var_6_9 = var_6_1 >= 5 and 400 or 450

			recthelper.setWidth(var_6_8.transform, var_6_9)

			local var_6_10 = var_6_1 >= 5 and 240 or 295

			if var_6_10 == 295 and iter_6_2 == 1 then
				var_6_10 = 255
			end

			recthelper.setAnchorX(var_6_8.transform, iter_6_2 == 1 and -var_6_10 or var_6_10)
			arg_6_0:com_openSubView(FightViewMultiBossHp, var_6_8, nil, iter_6_3)
		end

		gohelper.setActive(arg_6_0._hpItem, false)
	else
		arg_6_0:com_openSubView(FightViewBossHp, arg_6_0._hpItem)
	end
end

function var_0_0.onSetBossHpVisibleWhenHidingFightView(arg_7_0, arg_7_1)
	if not arg_7_0.originRootPosX then
		arg_7_0.originRootPosX = recthelper.getAnchorX(arg_7_0._bossHpRoot)
		arg_7_0.siblingIndex = gohelper.getSibling(arg_7_0.hpRootObj) - 1
	end

	gohelper.addChild(arg_7_1 and arg_7_0.viewGO or arg_7_0.viewRoot, arg_7_0.hpRootObj)
	recthelper.setAnchorX(arg_7_0._bossHpRoot, arg_7_0.originRootPosX)
	gohelper.setSibling(arg_7_0.hpRootObj, arg_7_0.siblingIndex)
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
