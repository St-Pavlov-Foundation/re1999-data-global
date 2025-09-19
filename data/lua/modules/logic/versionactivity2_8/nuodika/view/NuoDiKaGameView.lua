module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameView", package.seeall)

local var_0_0 = class("NuoDiKaGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_BG")
	arg_1_0._btnbgclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_bgclick")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_target")
	arg_1_0._txttarget = gohelper.findChildText(arg_1_0.viewGO, "#go_target/TargetList/targetbg/#txt_target")
	arg_1_0._gotargeticon = gohelper.findChild(arg_1_0.viewGO, "#go_target/TargetList/targetbg/#txt_target/#img_Icon")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._gomaptop = gohelper.findChild(arg_1_0.viewGO, "#go_maptop")
	arg_1_0._gomainrole = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole")
	arg_1_0._gomainhead = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/Head")
	arg_1_0._headAnim = arg_1_0._gomainhead:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_mainrole/Head/#simage_Icon")
	arg_1_0._goHP = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_HP")
	arg_1_0._txtHPNum = gohelper.findChildText(arg_1_0.viewGO, "#go_mainrole/#go_HP/#txt_HPNum")
	arg_1_0._goAttack = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_Attack")
	arg_1_0._txtAttckNum = gohelper.findChildText(arg_1_0.viewGO, "#go_mainrole/#go_Attack/#txt_AttckNum")
	arg_1_0._goBuffList = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_BuffList")
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_BuffList/#go_list")
	arg_1_0._goBuffIcon = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_BuffList/#go_list/#go_BuffIcon")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_Tips")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_Tips/#go_Item")
	arg_1_0._imageBuffIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_mainrole/#go_Tips/#go_Item/#image_BuffIcon")
	arg_1_0._gohealeff = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/vx_heal")
	arg_1_0._gohpeff = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_hpeff")
	arg_1_0._gohurt = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_hpeff/#go_hurt")
	arg_1_0._txthurt = gohelper.findChildText(arg_1_0.viewGO, "#go_mainrole/#go_hpeff/#go_hurt/#txt_hurt")
	arg_1_0._goheal = gohelper.findChild(arg_1_0.viewGO, "#go_mainrole/#go_hpeff/#go_heal")
	arg_1_0._txtheal = gohelper.findChildText(arg_1_0.viewGO, "#go_mainrole/#go_hpeff/#go_heal/#txt_heal")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btnbgclick:AddClickListener(arg_2_0._btnbgclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btnbgclick:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MoLiDeErResetGameTip, MsgBoxEnum.BoxType.Yes_No, arg_4_0._onChooseReset, nil, nil, arg_4_0)
end

function var_0_0._onChooseReset(arg_5_0)
	NuoDiKaMapModel.instance:resetMap(arg_5_0._mapId)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapResetClicked)
	arg_5_0:_onMapReset()
end

function var_0_0._btnskipOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MoLiDeErSkipGameTip, MsgBoxEnum.BoxType.Yes_No, arg_6_0._onChooseSkip, nil, nil, arg_6_0)
end

function var_0_0._onChooseSkip(arg_7_0)
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(arg_7_0.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Skip",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - arg_7_0._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = arg_7_0._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = arg_7_0._hp
	})
	arg_7_0:_onCloseClick()
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._btnskip.gameObject, false)

	arg_8_0._showTipList = {}

	arg_8_0:_addEvents()
end

function var_0_0._btnbgclickOnClick(arg_9_0)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, 0)
end

function var_0_0._onCloseClick(arg_10_0)
	if arg_10_0.viewParam.callback then
		arg_10_0.viewParam.callback(arg_10_0.viewParam.callbackObj)
	end

	TaskDispatcher.runDelay(arg_10_0.closeThis, arg_10_0, 0.5)
end

function var_0_0._addEvents(arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.GameSuccess, arg_11_0._onGameSuccess, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.GameItemUnlockSuccess, arg_11_0._showItemGameSuccess, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.ItemStartSkill, arg_11_0._onItemUseSkill, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.AttackMainRole, arg_11_0._onAttackMainRole, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.StartInteract, arg_11_0._onMapInteract, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.EnemyDead, arg_11_0._onEnemyDead, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.CheckShowEnemyDetail, arg_11_0._onCheckShowEnemyDetails, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.CheckShowItemDetail, arg_11_0._onCheckShowItemDetails, arg_11_0)
	arg_11_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.OnActiveClose, arg_11_0._onActiveClose, arg_11_0)
end

function var_0_0._removeEvents(arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.GameSuccess, arg_12_0._onGameSuccess, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.GameItemUnlockSuccess, arg_12_0._showItemGameSuccess, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.ItemStartSkill, arg_12_0._onItemUseSkill, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.AttackMainRole, arg_12_0._onAttackMainRole, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.StartInteract, arg_12_0._onMapInteract, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.EnemyDead, arg_12_0._onEnemyDead, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.CheckShowEnemyDetail, arg_12_0._onCheckShowEnemyDetails, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.CheckShowItemDetail, arg_12_0._onCheckShowItemDetails, arg_12_0)
	arg_12_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.OnActiveClose, arg_12_0._onActiveClose, arg_12_0)
end

function var_0_0._onActiveClose(arg_13_0)
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(arg_13_0.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "ActiveClose",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - arg_13_0._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = arg_13_0._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = arg_13_0._hp
	})
end

function var_0_0._onCheckShowEnemyDetails(arg_14_0, arg_14_1)
	if ViewMgr.instance:isOpen(ViewName.NuoDiKaGameResultView) then
		return
	end

	if NuoDiKaModel.instance:isEpisodePass(arg_14_0.viewParam.episodeId) then
		return
	end

	if NuoDiKaModel.instance:getEpisodeStatus(arg_14_0.viewParam.episodeId) ~= NuoDiKaEnum.EpisodeStatus.MapGame then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0._showTipList) do
		if iter_14_1 == arg_14_1 then
			return
		end
	end

	local var_14_0 = {
		unitId = arg_14_1,
		unitType = NuoDiKaEnum.EventType.Enemy
	}

	PopupController.instance:addPopupView(PopupEnum.PriorityType.NuoDiKaUnitTip, ViewName.NuoDiKaGameUnitDetailView, var_14_0)
	table.insert(arg_14_0._showTipList, arg_14_1)
end

function var_0_0._onCheckShowItemDetails(arg_15_0, arg_15_1)
	if ViewMgr.instance:isOpen(ViewName.NuoDiKaGameResultView) then
		return
	end

	if NuoDiKaModel.instance:isEpisodePass(arg_15_0.viewParam.episodeId) then
		return
	end

	if NuoDiKaModel.instance:getEpisodeStatus(arg_15_0.viewParam.episodeId) ~= NuoDiKaEnum.EpisodeStatus.MapGame then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0._showTipList) do
		if iter_15_1 == arg_15_1 then
			return
		end
	end

	local var_15_0 = {
		unitId = arg_15_1,
		unitType = NuoDiKaEnum.EventType.Item
	}

	PopupController.instance:addPopupView(PopupEnum.PriorityType.NuoDiKaUnitTip, ViewName.NuoDiKaGameUnitDetailView, var_15_0)
	table.insert(arg_15_0._showTipList, arg_15_1)
end

function var_0_0._onGameSuccess(arg_16_0)
	if arg_16_0._gameSuccess then
		return
	end

	arg_16_0:_endBlock()

	arg_16_0._gameSuccess = true

	local var_16_0 = {}

	var_16_0.isSuccess = true
	var_16_0.callback = arg_16_0._onSuccessTiped
	var_16_0.callbackObj = arg_16_0

	NuoDiKaController.instance:enterGameResultView(var_16_0)
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(arg_16_0.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Success",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - arg_16_0._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = arg_16_0._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = arg_16_0._hp
	})
end

function var_0_0._onSuccessTiped(arg_17_0)
	arg_17_0:_onCloseClick()
end

function var_0_0._onGameFailed(arg_18_0)
	UIBlockMgr.instance:endBlock("gamefail")

	if arg_18_0._mapMo.passType == NuoDiKaEnum.MapPassType.ClearEnemy then
		if NuoDiKaMapModel.instance:isAllEnemyDead(arg_18_0._mapId) then
			return
		end
	elseif arg_18_0._mapMo.passType == NuoDiKaEnum.MapPassType.UnlockItem and NuoDiKaMapModel.instance:isSpEventUnlock(arg_18_0._mapId) then
		return
	end

	arg_18_0:_endBlock()

	arg_18_0._gameSuccess = false

	local var_18_0 = {}

	var_18_0.isSuccess = false
	var_18_0.callback = arg_18_0._onFailedTiped
	var_18_0.callbackObj = arg_18_0

	NuoDiKaController.instance:enterGameResultView(var_18_0)
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(arg_18_0.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Fail",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - arg_18_0._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = arg_18_0._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = arg_18_0._hp
	})
end

function var_0_0._onFailedTiped(arg_19_0, arg_19_1)
	if arg_19_1 == NuoDiKaEnum.ResultTipType.Restart then
		arg_19_0:_onGameRestart()
	elseif arg_19_1 == NuoDiKaEnum.ResultTipType.Quit then
		arg_19_0:closeThis()
	end
end

function var_0_0._onGameRestart(arg_20_0)
	NuoDiKaMapModel.instance:resetMap(arg_20_0._mapId)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.GameRestart)
	arg_20_0:_resetData()
	arg_20_0:_refreshUI()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function var_0_0._onMapReset(arg_21_0)
	StatController.instance:track(StatEnum.EventName.ExitNuoDiKaActivity, {
		[StatEnum.EventProperties.NuoDiKa_EpisodeId] = tostring(arg_21_0.viewParam.episodeId),
		[StatEnum.EventProperties.NuoDiKa_Result] = "Reset",
		[StatEnum.EventProperties.NuoDiKa_UseTime] = os.time() - arg_21_0._beginTime,
		[StatEnum.EventProperties.NuoDiKa_TotalRound] = arg_21_0._interactTimes,
		[StatEnum.EventProperties.NuoDiKa_OurRemainingHP] = arg_21_0._hp
	})
	arg_21_0:_resetData()
	arg_21_0:_refreshUI()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function var_0_0._onAttackMainRole(arg_22_0, arg_22_1)
	arg_22_0:_attackMainRole(arg_22_1)
	arg_22_0:_checkHaloEnemyEffect()
end

function var_0_0._attackMainRole(arg_23_0, arg_23_1)
	arg_23_0._hp = arg_23_0._hp - arg_23_1

	if arg_23_1 > 0 then
		arg_23_0._viewAnim:Play("damage", 0, 0)
	end

	if arg_23_0._hp <= 0 then
		UIBlockMgr.instance:startBlock("gamefail")
		TaskDispatcher.runDelay(arg_23_0._onGameFailed, arg_23_0, 1.5)

		return
	end

	if arg_23_0._gohurt.gameObject.activeSelf then
		local var_23_0 = arg_23_1 - tonumber(arg_23_0._txthurt.text)

		arg_23_0._txthurt.text = "-" .. var_23_0
	else
		gohelper.setActive(arg_23_0._gohurt.gameObject, true)

		arg_23_0._txthurt.text = "-" .. arg_23_1
	end

	UIBlockMgr.instance:startBlock("mainrolehurt")
	gohelper.setActive(arg_23_0._gohurt, true)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_mainrole_hurt)
	arg_23_0._headAnim:Play("hurt", 0, 0)
	TaskDispatcher.runDelay(arg_23_0._mainRoleHurt, arg_23_0, 1)
	arg_23_0:_refreshUI()
end

function var_0_0._mainRoleHurt(arg_24_0)
	UIBlockMgr.instance:endBlock("mainrolehurt")
	gohelper.setActive(arg_24_0._gohurt, false)
end

function var_0_0._onItemUseSkill(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2:getEvent()

	if not var_25_0 then
		return
	end

	local var_25_1 = NuoDiKaConfig.instance:getItemCo(var_25_0.eventParam).skillID

	arg_25_0._eventId = var_25_0.eventId

	arg_25_0:_startSkill(var_25_1, arg_25_1, arg_25_2)
	arg_25_0:_refreshUI()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function var_0_0._startSkill(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = NuoDiKaConfig.instance:getSkillCo(arg_26_1)

	if tonumber(var_26_0.trigger) == NuoDiKaEnum.TriggerTimingType.Interact then
		if var_26_0.effect == NuoDiKaEnum.SkillType.RestoreLife then
			arg_26_0:_restoreLife(var_26_0, arg_26_2, arg_26_3)
		elseif var_26_0.effect == NuoDiKaEnum.SkillType.AttackSelected then
			arg_26_0:_attackSelectedEnemy(var_26_0, arg_26_2, arg_26_3)
		elseif var_26_0.effect == NuoDiKaEnum.SkillType.AttackRandom then
			arg_26_0:_attackRandomEnemy(var_26_0, arg_26_2, arg_26_3)
		elseif var_26_0.effect == NuoDiKaEnum.SkillType.AttackAll then
			arg_26_0:_attackAllEnemy(var_26_0, arg_26_2, arg_26_3)
		elseif var_26_0.effect == NuoDiKaEnum.SkillType.WarnEnemyNodes then
			arg_26_0:_warnEnemyNodes(var_26_0, arg_26_2, arg_26_3)
		end
	end
end

function var_0_0._restoreLife(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0._hp = arg_27_0._hp + tonumber(arg_27_1.param)

	gohelper.setActive(arg_27_0._gohealeff, true)
	gohelper.setActive(arg_27_0._goheal, true)

	arg_27_0._txtheal.text = "+" .. arg_27_1.param

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_mainrole_recover)
	UIBlockMgr.instance:startBlock("mainroleheal")
	TaskDispatcher.runDelay(arg_27_0._showHealFinished, arg_27_0, 1)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, arg_27_3)
end

function var_0_0._showHealFinished(arg_28_0)
	UIBlockMgr.instance:endBlock("mainroleheal")
	gohelper.setActive(arg_28_0._gohealeff, false)
	gohelper.setActive(arg_28_0._goheal, false)
end

function var_0_0._attackSelectedEnemy(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if not arg_29_2:isNodeHasEnemy() then
		return
	end

	local var_29_0 = arg_29_2:getEvent().eventParam

	if var_29_0 and var_29_0 > 0 then
		arg_29_0:_attackEnemy(arg_29_2, tonumber(arg_29_1.param))
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, arg_29_3)
end

function var_0_0._attackRandomEnemy(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = string.splitToNumber(arg_30_1.param, "#")

	arg_30_0._randomAttackParams = var_30_0
	arg_30_0._randomTargetNodeMo = arg_30_2
	arg_30_0._randomFromNodeMo = arg_30_3
	arg_30_0._repeatCount = 0

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, arg_30_0._randomFromNodeMo)

	arg_30_0._randomBeforeNodeMos = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if not arg_30_0._randomBeforeNodeMos or #arg_30_0._randomBeforeNodeMos < 1 then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("randomAttack")

	arg_30_0._randomAttackDelayTimes = 1.2 * var_30_0[2]

	arg_30_0:_attackOnceEnemy()
	TaskDispatcher.runRepeat(arg_30_0._attackOnceEnemy, arg_30_0, 1.2, var_30_0[2] - 1)
end

function var_0_0._attackOnceEnemy(arg_31_0)
	arg_31_0._repeatCount = arg_31_0._repeatCount + 1

	local var_31_0 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #var_31_0 < 1 then
		if #arg_31_0._randomBeforeNodeMos > 0 then
			arg_31_0:_produceNewItem()
		end

		UIBlockMgr.instance:endBlock("randomAttack")
		TaskDispatcher.cancelTask(arg_31_0._attackOnceEnemy, arg_31_0)

		return
	end

	local var_31_1 = var_31_0[math.random(1, #var_31_0)]
	local var_31_2 = arg_31_0._randomAttackDelayTimes - 1.2 * (arg_31_0._repeatCount - 1)

	arg_31_0:_attackEnemy(var_31_1, arg_31_0._randomAttackParams[1], false, var_31_2)

	if arg_31_0._repeatCount == arg_31_0._randomAttackParams[2] then
		UIBlockMgr.instance:endBlock("randomAttack")
		TaskDispatcher.cancelTask(arg_31_0._attackOnceEnemy, arg_31_0)
		arg_31_0:_checkProduceNewItem()
	end
end

function var_0_0._checkProduceNewItem(arg_32_0)
	local var_32_0 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	for iter_32_0, iter_32_1 in pairs(arg_32_0._randomBeforeNodeMos) do
		local var_32_1 = false

		for iter_32_2, iter_32_3 in pairs(var_32_0) do
			if iter_32_3.id == iter_32_1.id then
				var_32_1 = true
			end
		end

		if not var_32_1 then
			arg_32_0:_produceNewItem()

			break
		end
	end
end

function var_0_0._produceNewItem(arg_33_0)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_unit)
	arg_33_0._randomTargetNodeMo:setNodeEvent(arg_33_0._eventId)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function var_0_0._attackAllEnemy(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #var_34_0 < 1 then
		return
	end

	local var_34_1 = string.splitToNumber(arg_34_1.scale, "#")
	local var_34_2 = var_34_1[1]

	if var_34_2 == NuoDiKaEnum.TriggerRangeType.TargetNode then
		arg_34_0:_attackEnemy(arg_34_2, tonumber(arg_34_1.param))
	elseif var_34_2 == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		local var_34_3 = var_34_1[2] or 0

		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			if var_34_3 >= math.abs(arg_34_2.y - iter_34_1.y) + math.abs(arg_34_2.x - iter_34_1.x) then
				arg_34_0:_attackEnemy(arg_34_2, tonumber(arg_34_1.param))
			end
		end
	elseif var_34_2 == NuoDiKaEnum.TriggerRangeType.SquareLength then
		local var_34_4 = var_34_1[2] or 0

		for iter_34_2, iter_34_3 in pairs(var_34_0) do
			if var_34_4 >= math.abs(arg_34_2.y - iter_34_3.y) or var_34_4 >= math.abs(arg_34_2.x - iter_34_3.x) then
				arg_34_0:_attackEnemy(arg_34_2, tonumber(arg_34_1.param))
			end
		end
	elseif var_34_2 == NuoDiKaEnum.TriggerRangeType.All then
		for iter_34_4, iter_34_5 in pairs(var_34_0) do
			arg_34_0:_attackEnemy(iter_34_5, tonumber(arg_34_1.param))
		end
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ClearNodeItem, arg_34_3)

	local var_34_5 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #var_34_0 ~= #var_34_5 then
		return
	end

	local var_34_6 = NuoDiKaMapModel.instance:getAllEmptyNodes()

	if #var_34_6 > 0 then
		var_34_6[math.random(1, #var_34_6)]:setNodeEvent(arg_34_0._eventId)
	end
end

function var_0_0._attackEnemy(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if not arg_35_3 then
		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			local var_35_1 = NuoDiKaConfig.instance:getEnemyCo(iter_35_1:getEvent().eventParam)

			if NuoDiKaConfig.instance:getSkillCo(var_35_1.skillID).effect == NuoDiKaEnum.SkillType.ReplaceHurt then
				NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackEnemy, iter_35_1, arg_35_2, true)
				arg_35_0:_checkHaloEnemyEffect()

				return
			end
		end
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackEnemy, arg_35_1, arg_35_2, true)
	arg_35_0:_checkHaloEnemyEffect()

	local var_35_2 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	if #var_35_0 ~= #var_35_2 then
		for iter_35_2, iter_35_3 in pairs(var_35_0) do
			local var_35_3 = false

			for iter_35_4, iter_35_5 in pairs(var_35_2) do
				if iter_35_5.id == iter_35_3.id then
					var_35_3 = true
				end
			end

			if not var_35_3 then
				arg_35_0:_onEnemyDead(iter_35_3, arg_35_4)

				local var_35_4 = iter_35_3:getInitEvent().eventParam
				local var_35_5 = NuoDiKaConfig.instance:getEnemyCo(var_35_4)

				if NuoDiKaConfig.instance:getSkillCo(var_35_5.skillID).effect == NuoDiKaEnum.SkillType.Halo and arg_35_0._gainHaloAtks[iter_35_3.id] then
					arg_35_0._gainHaloAtks[iter_35_3.id]:reduceAtk(var_35_5.atk)
				end
			end
		end
	end
end

function var_0_0._checkHaloEnemyEffect(arg_36_0)
	local var_36_0 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()
	local var_36_1 = NuoDiKaMapModel.instance:getMaxHpNode()

	if var_36_1 then
		for iter_36_0, iter_36_1 in pairs(var_36_0) do
			if var_36_1.id ~= iter_36_1.id then
				local var_36_2 = NuoDiKaConfig.instance:getEnemyCo(iter_36_1:getEvent().eventParam)

				if NuoDiKaConfig.instance:getSkillCo(var_36_2.skillID).effect == NuoDiKaEnum.SkillType.Halo then
					local var_36_3 = false

					if arg_36_0._gainHaloAtks[iter_36_1.id] then
						if arg_36_0._gainHaloAtks[iter_36_1.id].id == var_36_1.id then
							var_36_3 = true
						else
							arg_36_0._gainHaloAtks[iter_36_1.id]:reduceAtk(iter_36_1.atk)
						end
					end

					if not var_36_3 then
						var_36_1:gainAtk(iter_36_1.atk)

						arg_36_0._gainHaloAtks[iter_36_1.id] = var_36_1
					end
				end
			end
		end
	end
end

function var_0_0._onMapInteract(arg_37_0)
	arg_37_0._interactTimes = arg_37_0._interactTimes + 1

	local var_37_0 = NuoDiKaMapModel.instance:getAllUnlockEnemyNodes()

	arg_37_0:_checkHaloEnemyEffect()

	for iter_37_0, iter_37_1 in pairs(var_37_0) do
		iter_37_1:reduceInteract(1)

		local var_37_1 = NuoDiKaConfig.instance:getEnemyCo(iter_37_1:getEvent().eventParam)
		local var_37_2 = NuoDiKaConfig.instance:getSkillCo(var_37_1.skillID)
		local var_37_3 = string.splitToNumber(var_37_2.trigger, "#")

		if var_37_3[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes and iter_37_1.interactTimes % var_37_3[2] == 0 then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ShowInteractAttackWarn, iter_37_1)
			arg_37_0:_attackMainRole(iter_37_1.atk)
		end
	end
end

function var_0_0._onEnemyDead(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_1:getInitEvent() then
		return
	end

	local var_38_0 = arg_38_1:getInitEvent().eventParam
	local var_38_1 = NuoDiKaConfig.instance:getEnemyCo(var_38_0)

	if not var_38_1 then
		return
	end

	if var_38_1.eventID and var_38_1.eventID > 0 then
		arg_38_0:_showItemGameSuccess(arg_38_1)

		return
	end

	local var_38_2 = NuoDiKaConfig.instance:getSkillCo(var_38_1.skillID)

	if var_38_2.effect == NuoDiKaEnum.SkillType.UnlockAllNodes then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.UnlockAllNodesEnemyDead, arg_38_1.id)
		arg_38_0:_unlockNodes(var_38_2, arg_38_1, arg_38_2)
	end
end

function var_0_0._showItemGameSuccess(arg_39_0, arg_39_1)
	if arg_39_0._itemSuccessShowed then
		return
	end

	arg_39_0._itemSuccessShowed = true

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.UnlockSuccessItem, arg_39_1.id)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("successItemUnlock")
	TaskDispatcher.runDelay(arg_39_0._showSuccessItemFinished, arg_39_0, 2)
	TaskDispatcher.runDelay(arg_39_0._playFallAudio, arg_39_0, 0.67)
end

function var_0_0._playFallAudio(arg_40_0)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_item_fall_game_pass)
end

function var_0_0._showSuccessItemFinished(arg_41_0)
	UIBlockMgr.instance:endBlock("successItemUnlock")
	arg_41_0:_onGameSuccess()
end

function var_0_0._unlockNodes(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = NuoDiKaMapModel.instance:getMapNodes()
	local var_42_1 = string.splitToNumber(arg_42_1.scale, "#")
	local var_42_2 = var_42_1[1]
	local var_42_3 = {}

	if var_42_2 == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		local var_42_4 = var_42_1[2] or 0

		for iter_42_0, iter_42_1 in pairs(var_42_0) do
			if not iter_42_1:isNodeUnlock() and var_42_4 >= math.abs(arg_42_2.y - iter_42_1.y) + math.abs(arg_42_2.x - iter_42_1.x) then
				table.insert(var_42_3, iter_42_1)
			end
		end
	elseif var_42_2 == NuoDiKaEnum.TriggerRangeType.SquareLength then
		local var_42_5 = var_42_1[2] or 0

		for iter_42_2, iter_42_3 in pairs(var_42_0) do
			if not iter_42_3:isNodeUnlock() and var_42_5 >= math.abs(arg_42_2.y - iter_42_3.y) and var_42_5 >= math.abs(arg_42_2.x - iter_42_3.x) then
				table.insert(var_42_3, iter_42_3)
			end
		end
	elseif var_42_2 == NuoDiKaEnum.TriggerRangeType.All then
		for iter_42_4, iter_42_5 in pairs(var_42_0) do
			if not iter_42_5:isNodeUnlock() then
				table.insert(var_42_3, iter_42_5)
			end
		end
	end

	arg_42_0:_setNodesUnlock(var_42_3, arg_42_3)
	arg_42_0:_checkHaloEnemyEffect()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function var_0_0._setNodesUnlock(arg_43_0, arg_43_1, arg_43_2)
	if #arg_43_1 < 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_around_node)
	table.sort(arg_43_1, function(arg_44_0, arg_44_1)
		return arg_44_0.id < arg_44_1.id
	end)

	arg_43_0._unlockNodeList = arg_43_1

	local var_43_0 = false

	for iter_43_0, iter_43_1 in ipairs(arg_43_0._unlockNodeList) do
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnUnlockGuideNode, tostring(iter_43_1.id))
		iter_43_1:setNodeUnlock(true)

		local var_43_1 = iter_43_1:getEvent()

		if var_43_1 and iter_43_1:isNodeHasEnemy() then
			var_43_0 = true
		end

		if var_43_1 and iter_43_1:isNodeHasItem() then
			var_43_0 = true
		end
	end

	arg_43_2 = arg_43_2 or 0

	local var_43_2 = NuoDiKaModel.instance:getEpisodeStatus(arg_43_0.viewParam.episodeId)

	if not var_43_0 or var_43_2 ~= NuoDiKaEnum.EpisodeStatus.MapGame then
		arg_43_0:_onWaitUnlockShowDetail()
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("waitUnlockDetailShow")
		TaskDispatcher.runDelay(arg_43_0._onWaitUnlockShowDetail, arg_43_0, 1 + arg_43_2)
	end
end

function var_0_0._onWaitUnlockShowDetail(arg_45_0)
	UIBlockMgr.instance:endBlock("waitUnlockDetailShow")

	for iter_45_0, iter_45_1 in ipairs(arg_45_0._unlockNodeList) do
		local var_45_0 = iter_45_1:getEvent()

		if var_45_0 and iter_45_1:isNodeHasEnemy() then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowEnemyDetail, var_45_0.eventParam)
		end

		if var_45_0 and iter_45_1:isNodeHasItem() then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowItemDetail, var_45_0.eventParam)
		end
	end
end

function var_0_0._warnEnemyNodes(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = NuoDiKaMapModel.instance:getMapNodes()
	local var_46_1 = string.splitToNumber(arg_46_1.scale, "#")
	local var_46_2 = var_46_1[1]

	if var_46_2 == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		local var_46_3 = var_46_1[2] or 0

		for iter_46_0, iter_46_1 in pairs(var_46_0) do
			if var_46_3 >= math.abs(arg_46_2.y - iter_46_1.y) + math.abs(arg_46_2.x - iter_46_1.x) then
				NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.WarnEnemyNode, iter_46_1)
			end
		end
	elseif var_46_2 == NuoDiKaEnum.TriggerRangeType.SquareLength then
		local var_46_4 = var_46_1[2] or 0

		for iter_46_2, iter_46_3 in pairs(var_46_0) do
			if var_46_4 >= math.abs(arg_46_2.y - iter_46_3.y) and var_46_4 >= math.abs(arg_46_2.x - iter_46_3.x) then
				NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.WarnEnemyNode, iter_46_3)
			end
		end
	elseif var_46_2 == NuoDiKaEnum.TriggerRangeType.All then
		for iter_46_4, iter_46_5 in pairs(var_46_0) do
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.WarnEnemyNode, iter_46_5)
		end
	end

	arg_46_3:clearEvent()
end

function var_0_0.onOpen(arg_47_0)
	arg_47_0._actId = VersionActivity2_8Enum.ActivityId.NuoDiKa
	arg_47_0._mapId = NuoDiKaConfig.instance:getEpisodeCo(arg_47_0._actId, arg_47_0.viewParam.episodeId).mapId
	arg_47_0._mapMo = NuoDiKaMapModel.instance:getMap(arg_47_0._mapId)

	local var_47_0 = NuoDiKaEnum.MapOffset.NoOdd

	if arg_47_0._mapMo.rowCount % 2 == 1 then
		if arg_47_0._mapMo.lineCount % 2 == 1 then
			var_47_0 = NuoDiKaEnum.MapOffset.XYOdd
		else
			var_47_0 = NuoDiKaEnum.MapOffset.XOdd
		end
	elseif arg_47_0._mapMo.lineCount % 2 == 1 then
		var_47_0 = NuoDiKaEnum.MapOffset.YOdd
	end

	transformhelper.setLocalPos(arg_47_0._gomap.transform, var_47_0[1], var_47_0[2], 0)
	transformhelper.setLocalPos(arg_47_0._gomaptop.transform, var_47_0[1], var_47_0[2], 0)

	arg_47_0._txttarget.text = NuoDiKaConfig.instance:getConstCo(arg_47_0._mapMo.taskValue).value2

	NuoDiKaMapModel.instance:setCurMapId(arg_47_0._mapId)

	arg_47_0._mainHeroCo = NuoDiKaMapModel.instance:getMapMainRole(arg_47_0._mapId)

	arg_47_0:_resetData()
	arg_47_0:_initUI()
	arg_47_0:_refreshUI()
end

function var_0_0._resetData(arg_48_0)
	arg_48_0._hp = arg_48_0._mainHeroCo.hp
	arg_48_0._atk = arg_48_0._mainHeroCo.atk
	arg_48_0._gainHaloAtks = {}
	arg_48_0._buffItems = {}
	arg_48_0._beginTime = os.time()
	arg_48_0._interactTimes = 0

	arg_48_0:_checkHaloEnemyEffect()
end

function var_0_0._initUI(arg_49_0)
	gohelper.setActive(arg_49_0._goHP, true)
	gohelper.setActive(arg_49_0._goAttack, true)
	gohelper.setActive(arg_49_0._goBuffList, false)
	gohelper.setActive(arg_49_0._goTips, false)
	gohelper.setActive(arg_49_0._gohurt, false)
	gohelper.setActive(arg_49_0._goheal, false)

	local var_49_0 = NuoDiKaModel.instance:getEpisodeStatus(arg_49_0.viewParam.episodeId)

	gohelper.setActive(arg_49_0._btnskip.gameObject, var_49_0 ~= NuoDiKaEnum.EpisodeStatus.MapGame)
	arg_49_0._simageBG:LoadImage(ResUrl.getNuoDiKaSingleBg(arg_49_0._mapMo.mapBg))

	arg_49_0._viewAnim = arg_49_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._refreshUI(arg_50_0)
	arg_50_0._txtHPNum.text = arg_50_0._hp
	arg_50_0._txtAttckNum.text = arg_50_0._atk

	local var_50_0 = NuoDiKaMapModel.instance:getMapMainRole(arg_50_0._mapId)
	local var_50_1 = NuoDiKaMapModel.instance:getMainRoleBuffCos(var_50_0.enemyId, arg_50_0._mapId)

	gohelper.setActive(arg_50_0._goBuffList, #var_50_1 > 0)

	for iter_50_0, iter_50_1 in pairs(arg_50_0._buffItems) do
		gohelper.setActive(iter_50_1.go, false)
	end

	for iter_50_2, iter_50_3 in ipairs(var_50_1) do
		if arg_50_0._buffItems[iter_50_3.id] then
			arg_50_0._buffItems[iter_50_3.id] = {}
			arg_50_0._buffItems[iter_50_3.id].go = gohelper.cloneInPlace(arg_50_0._goBuffIcon)
			arg_50_0._buffItems[iter_50_3.id].image = arg_50_0._buffItems[iter_50_3.id]:GetComponent(typeof(UnityEngine.UI.Image))
		end

		gohelper.setActive(arg_50_0._buffItems[iter_50_3.id].go, true)
	end

	gohelper.setActive(arg_50_0._gotargeticon, true)
end

function var_0_0.onClose(arg_51_0)
	NuoDiKaMapModel.instance:resetMap(arg_51_0._mapId)
end

function var_0_0._endBlock(arg_52_0)
	UIBlockMgr.instance:endBlock("randomAttack")
	UIBlockMgr.instance:endBlock("successItemUnlock")
	UIBlockMgr.instance:endBlock("waitUnlockDetailShow")
	UIBlockMgr.instance:endBlock("mainroleheal")
	UIBlockMgr.instance:endBlock("mainrolehurt")
	UIBlockMgr.instance:endBlock("gamefail")
end

function var_0_0.onDestroyView(arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0._attackOnceEnemy, arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0._onWaitUnlockShowDetail, arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0._showSuccessItemFinished, arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0._showHealFinished, arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0._mainRoleHurt, arg_53_0)
	arg_53_0:_endBlock()
	arg_53_0:_removeEvents()
end

return var_0_0
