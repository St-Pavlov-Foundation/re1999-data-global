module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameMapNodeItem", package.seeall)

local var_0_0 = class("NuoDiKaGameMapNodeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.topGo = arg_1_2
	arg_1_0._goroot = gohelper.findChild(arg_1_1, "goroot")
	arg_1_0._btnnode = gohelper.findChildButtonWithAudio(arg_1_1, "goroot/btn_node")
	arg_1_0._golocked = gohelper.findChild(arg_1_1, "goroot/go_locked")
	arg_1_0._gounlocked = gohelper.findChild(arg_1_1, "goroot/go_unlocked")
	arg_1_0._gointeractable = gohelper.findChild(arg_1_1, "goroot/go_interactable")
	arg_1_0._goplaceable = gohelper.findChild(arg_1_1, "goroot/go_placeable")
	arg_1_0._godamage = gohelper.findChild(arg_1_1, "goroot/go_damage")
	arg_1_0._goselected = gohelper.findChild(arg_1_1, "goroot/go_selected")
	arg_1_0._gocloud = gohelper.findChild(arg_1_1, "goroot/go_cloud")
	arg_1_0._gouninteractable = gohelper.findChild(arg_1_1, "goroot/go_uninteractable")
	arg_1_0._gouninteractableenemy = gohelper.findChild(arg_1_1, "goroot/go_uninteractableenemy")
	arg_1_0._goenemyicon = gohelper.findChild(arg_1_1, "goroot/go_enemyicon")
	arg_1_0._goenemy = gohelper.findChild(arg_1_1, "goroot/go_enemy")
	arg_1_0._simageenemy = gohelper.findChildSingleImage(arg_1_1, "goroot/go_enemy/image_enemy")
	arg_1_0._goitem = gohelper.findChild(arg_1_1, "goroot/go_item")
	arg_1_0._simageitem = gohelper.findChildSingleImage(arg_1_1, "goroot/go_item/image_item")
	arg_1_0._topgoroot = gohelper.findChild(arg_1_2, "goroot")
	arg_1_0._gostate1 = gohelper.findChild(arg_1_2, "goroot/go_state1")
	arg_1_0._gohp1 = gohelper.findChild(arg_1_2, "goroot/go_state1/gohp1")
	arg_1_0._txthpnum1 = gohelper.findChildText(arg_1_2, "goroot/go_state1/gohp1/txt_hpnum1")
	arg_1_0._goattack1 = gohelper.findChild(arg_1_2, "goroot/go_state1/goattack1")
	arg_1_0._txtattacknum1 = gohelper.findChildText(arg_1_2, "goroot/go_state1/goattack1/txt_attcknum1")
	arg_1_0._gostate2 = gohelper.findChild(arg_1_2, "goroot/go_state2")
	arg_1_0._gohp2 = gohelper.findChild(arg_1_2, "goroot/go_state2/gohp2")
	arg_1_0._txthpnum2 = gohelper.findChildText(arg_1_2, "goroot/go_state2/gohp2/txt_hpnum2")
	arg_1_0._goattack2 = gohelper.findChild(arg_1_2, "goroot/go_state2/goattack2")
	arg_1_0._txtattacknum2 = gohelper.findChildText(arg_1_2, "goroot/go_state2/goattack2/txt_attcknum2")
	arg_1_0._goturns = gohelper.findChild(arg_1_2, "goroot/go_turns")
	arg_1_0._txtturns = gohelper.findChildText(arg_1_2, "goroot/go_turns/txt_turns")
	arg_1_0._gowarn = gohelper.findChild(arg_1_2, "goroot/vx_warn")
	arg_1_0._goheal = gohelper.findChild(arg_1_2, "goroot/vx_heal")
	arg_1_0._godead = gohelper.findChild(arg_1_2, "goroot/vx_dead")
	arg_1_0._txtaffected = gohelper.findChildText(arg_1_2, "goroot/txt_affected")
	arg_1_0._goattack = gohelper.findChild(arg_1_2, "goroot/vx_attack")
	arg_1_0._goscan = gohelper.findChild(arg_1_2, "goroot/vx_scan")
	arg_1_0._godeadbuff = gohelper.findChild(arg_1_2, "goroot/vx_deadbuff")
	arg_1_0._goendless = gohelper.findChild(arg_1_2, "goroot/vx_endless")
	arg_1_0._goitemtip = gohelper.findChild(arg_1_2, "goroot/go_itemtip")
	arg_1_0._txtitemdesc = gohelper.findChildText(arg_1_2, "goroot/go_itemtip/txt_itemdesc")
	arg_1_0._txtitemname = gohelper.findChildText(arg_1_2, "goroot/go_itemtip/txt_itemdesc/txt_itemname")
	arg_1_0._btnitemuse = gohelper.findChildButtonWithAudio(arg_1_2, "goroot/go_itemtip/txt_itemdesc/btn_itemuse")
	arg_1_0._goenemytip = gohelper.findChild(arg_1_2, "goroot/go_enemytip")
	arg_1_0._txtenemydesc = gohelper.findChildText(arg_1_2, "goroot/go_enemytip/txt_enemydesc")
	arg_1_0._txtenemyname = gohelper.findChildText(arg_1_2, "goroot/go_enemytip/txt_enemydesc/txt_enemyname")
	arg_1_0._btnenemyattack = gohelper.findChildButtonWithAudio(arg_1_2, "goroot/go_enemytip/txt_enemydesc/btn_enemyattack")

	arg_1_0:_initNode()
	arg_1_0:_addEvents()
end

function var_0_0._addEvents(arg_2_0)
	arg_2_0._btnnode:AddClickListener(arg_2_0._btnnodeOnClick, arg_2_0)
	arg_2_0._btnenemyattack:AddClickListener(arg_2_0._btnenemyattackOnClick, arg_2_0)
	arg_2_0._btnitemuse:AddClickListener(arg_2_0._btnitemuseOnClick, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.NodeClicked, arg_2_0._onNodeClick, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.AttackEnemy, arg_2_0._onStartAttack, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.WarnEnemyNode, arg_2_0._onWarnEnemyNode, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.UnlockAllNodesEnemyDead, arg_2_0._onUnlockAllNodesEnemyDead, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.UnlockSuccessItem, arg_2_0._onUnlockSuccessItem, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ItemWarnAttackEnemy, arg_2_0._onItemWarnAttackEnemy, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ClearNodeItem, arg_2_0._onClearNodeItem, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.HideOtherNodeTips, arg_2_0._onHideOtherNodeTips, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ShowInteractAttackWarn, arg_2_0._onShowInteractAttackWarn, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ShowItemScan, arg_2_0._onCheckShowScan, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.MapResetClicked, arg_2_0._onResetNode, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.GameRestart, arg_2_0._onResetNode, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.GameFailed, arg_2_0._onGameFailed, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.GameSuccess, arg_2_0._onGameSuccess, arg_2_0)
end

function var_0_0._removeEvents(arg_3_0)
	arg_3_0._btnnode:RemoveClickListener()
	arg_3_0._btnenemyattack:RemoveClickListener()
	arg_3_0._btnitemuse:RemoveClickListener()
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.NodeClicked, arg_3_0._onNodeClick, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.AttackEnemy, arg_3_0._onStartAttack, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.WarnEnemyNode, arg_3_0._onWarnEnemyNode, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.UnlockAllNodesEnemyDead, arg_3_0._onUnlockAllNodesEnemyDead, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.UnlockSuccessItem, arg_3_0._onUnlockSuccessItem, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ItemWarnAttackEnemy, arg_3_0._onItemWarnAttackEnemy, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ClearNodeItem, arg_3_0._onClearNodeItem, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.HideOtherNodeTips, arg_3_0._onHideOtherNodeTips, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ShowInteractAttackWarn, arg_3_0._onShowInteractAttackWarn, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ShowItemScan, arg_3_0._onCheckShowScan, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.MapResetClicked, arg_3_0._onResetNode, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.GameRestart, arg_3_0._onResetNode, arg_3_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.GameSuccess, arg_3_0._onGameSuccess, arg_3_0)
end

function var_0_0._onGameFailed(arg_4_0)
	arg_4_0:_endBlock()
end

function var_0_0._onGameSuccess(arg_5_0)
	arg_5_0:_endBlock()
end

function var_0_0._onResetNode(arg_6_0)
	arg_6_0:hideItemTip()
	arg_6_0:hideEnemyTip()
	arg_6_0._enemyAnim:Play("open", 0, 1)
	arg_6_0._enemyTopAni:Play("open", 0, 1)
end

function var_0_0._onCheckShowScan(arg_7_0, arg_7_1)
	if arg_7_0._nodeMo.id ~= arg_7_1.id then
		return
	end

	arg_7_0:_onShowScan()
end

function var_0_0._onShowInteractAttackWarn(arg_8_0, arg_8_1)
	if arg_8_0._nodeMo.id ~= arg_8_1.id then
		return
	end

	gohelper.setActive(arg_8_0._gowarn, true)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_interact_attack)
	UIBlockMgr.instance:startBlock("interactAttack")
	TaskDispatcher.runDelay(arg_8_0._showInteractWarnFinished, arg_8_0, 1)
end

function var_0_0._showInteractWarnFinished(arg_9_0)
	gohelper.setActive(arg_9_0._gowarn, false)
	UIBlockMgr.instance:endBlock("interactAttack")
end

function var_0_0._onHideOtherNodeTips(arg_10_0, arg_10_1)
	if arg_10_0._nodeMo.id == arg_10_1 then
		return
	end

	arg_10_0:hideItemTip()
	arg_10_0:hideEnemyTip()
end

function var_0_0._onClearNodeItem(arg_11_0, arg_11_1)
	if arg_11_0._nodeMo.id ~= arg_11_1.id then
		return
	end

	arg_11_1:clearEvent()
	arg_11_0:hideItemTip()
end

function var_0_0._onItemWarnAttackEnemy(arg_12_0, arg_12_1)
	if not arg_12_0._nodeMo:isNodeUnlock() then
		return
	end

	if not (arg_12_0._nodeMo:getEvent() and arg_12_0._nodeMo:isNodeHasEnemy()) then
		return
	end

	arg_12_0._warnAttackNode = arg_12_1

	gohelper.setActive(arg_12_0._goplaceable, true)
end

function var_0_0._onUnlockAllNodesEnemyDead(arg_13_0, arg_13_1)
	if arg_13_0._nodeMo.id ~= arg_13_1 then
		return
	end

	gohelper.setActive(arg_13_0._godeadbuff, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("enemyDeadUnlock")
	TaskDispatcher.runDelay(arg_13_0._enemyDeadUnlockFinished, arg_13_0, 1.5)
end

function var_0_0._onUnlockSuccessItem(arg_14_0, arg_14_1)
	if arg_14_0._nodeMo.id ~= arg_14_1 then
		return
	end

	gohelper.setActive(arg_14_0._goendless, true)
end

function var_0_0._enemyDeadUnlockFinished(arg_15_0)
	UIBlockMgr.instance:endBlock("enemyDeadUnlock")
	gohelper.setActive(arg_15_0._godeadbuff, false)
end

function var_0_0._btnnodeOnClick(arg_16_0)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.HideOtherNodeTips, arg_16_0._nodeMo.id)

	if NuoDiKaMapModel.instance:isNodeEnemyLock(arg_16_0._nodeMo.id) then
		GameFacade.showToast(ToastEnum.NuoDiKaGameNodeLocked)

		return
	end

	if not arg_16_0._nodeMo:isNodeUnlock() then
		if not NuoDiKaMapModel.instance:isNodeCouldUnlock(arg_16_0._nodeMo.id, arg_16_0._mapId) then
			return
		end

		gohelper.setActive(arg_16_0._gounlocked, true)
		arg_16_0._cloudAnim:Play("close", 0, 0)
		arg_16_0._interactAnim:Play("close", 0, 0)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("cloudUnlock")
		TaskDispatcher.runDelay(arg_16_0._unlockFinished, arg_16_0, 0.4)
		NuoDiKaMapModel.instance:setCurSelectNode(arg_16_0._nodeMo.id)
		NuoDiKaMapModel.instance:setNodeUnlock(arg_16_0._nodeMo.id, arg_16_0._mapId)

		local var_16_0 = arg_16_0._nodeMo:getEvent()
		local var_16_1 = var_16_0 and arg_16_0._nodeMo:isNodeHasEnemy()
		local var_16_2 = var_16_0 and arg_16_0._nodeMo:isNodeHasItem()

		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_node)

		if var_16_1 or var_16_2 then
			AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_unit)
		end

		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnUnlockGuideNode, tostring(arg_16_0._nodeMo.id))
	else
		if arg_16_0._warnAttackNode then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemStartSkill, arg_16_0._nodeMo, arg_16_0._warnAttackNode)

			arg_16_0._warnAttackNode = nil

			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, arg_16_0._nodeMo.id)

			return
		end

		NuoDiKaMapModel.instance:setCurSelectNode(arg_16_0._nodeMo.id)

		local var_16_3 = arg_16_0._nodeMo:getEvent()

		arg_16_0:_refreshNodeState()

		if var_16_3 and arg_16_0._nodeMo:isNodeHasEnemy() then
			arg_16_0:showEnemyTip()
		end

		if var_16_3 and arg_16_0._nodeMo:isNodeHasItem() then
			arg_16_0:showItemTip()
		end

		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, arg_16_0._nodeMo.id)
	end
end

function var_0_0._unlockFinished(arg_17_0)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, arg_17_0._nodeMo.id)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
	TaskDispatcher.runDelay(arg_17_0._unlockAnimFinished, arg_17_0, 0.6)
end

function var_0_0._unlockAnimFinished(arg_18_0)
	UIBlockMgr.instance:endBlock("cloudUnlock")

	local var_18_0 = arg_18_0._nodeMo:getEvent()

	if var_18_0 and arg_18_0._nodeMo:isNodeHasEnemy() then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowEnemyDetail, var_18_0.eventParam)
	end

	if var_18_0 and arg_18_0._nodeMo:isNodeHasItem() then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowItemDetail, var_18_0.eventParam)
	end
end

function var_0_0._btnenemyattackOnClick(arg_19_0)
	if not arg_19_0._nodeMo:getEvent() then
		return
	end

	local var_19_0 = NuoDiKaMapModel.instance:getMapMainRole().enemyId
	local var_19_1 = NuoDiKaConfig.instance:getEnemyCo(var_19_0).atk

	if var_19_1 <= 0 then
		return
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)

	if var_19_1 >= arg_19_0._nodeMo.hp then
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_enemy_dead)
		arg_19_0._enemyAnim:Play("dead", 0, 0)
		arg_19_0._enemyTopAni:Play("dead", 0, 0)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("enemyDead")
		arg_19_0:hideEnemyTip()
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackMainRole, arg_19_0._nodeMo.atk)
		arg_19_0._nodeMo:clearEvent()
		TaskDispatcher.runDelay(arg_19_0._deadFinished, arg_19_0, 1.5)

		return
	end

	local var_19_2 = NuoDiKaMapModel.instance:getMapMainRole().enemyId
	local var_19_3 = NuoDiKaConfig.instance:getEnemyCo(var_19_2).atk

	if var_19_3 <= 0 then
		return
	end

	arg_19_0:_onStartAttack(arg_19_0._nodeMo, var_19_3, false)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackMainRole, arg_19_0._nodeMo.atk)
end

function var_0_0._deadFinished(arg_20_0)
	gohelper.setActive(arg_20_0._goattack, false)
	UIBlockMgr.instance:endBlock("enemyDead")
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.EnemyDead, arg_20_0._nodeMo)

	local var_20_0 = arg_20_0._nodeMo:getInitEvent().eventParam
	local var_20_1 = NuoDiKaConfig.instance:getEnemyCo(var_20_0)

	if var_20_1 and var_20_1.eventID and var_20_1.eventID > 0 then
		return
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function var_0_0._btnitemuseOnClick(arg_21_0)
	local var_21_0 = arg_21_0._nodeMo:getEvent()

	if not var_21_0 then
		return
	end

	if var_21_0.eventParam == 2002 then
		arg_21_0:hideItemTip()
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemWarnAttackEnemy, arg_21_0._nodeMo)

		return
	end

	if var_21_0.eventParam == 2005 then
		arg_21_0:_onShowScan()
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemStartSkill, arg_21_0._nodeMo, arg_21_0._nodeMo)
end

function var_0_0._onShowScan(arg_22_0)
	arg_22_0:hideItemTip()
	gohelper.setActive(arg_22_0._goscan, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_item_detection)
	UIBlockMgr.instance:startBlock("itemScan")
	TaskDispatcher.runDelay(arg_22_0._scanFinished, arg_22_0, 2)
end

function var_0_0._scanFinished(arg_23_0)
	gohelper.setActive(arg_23_0._goscan, false)
	UIBlockMgr.instance:endBlock("itemScan")
end

function var_0_0._onNodeClick(arg_24_0, arg_24_1)
	arg_24_0._warnAttackNode = nil

	gohelper.setActive(arg_24_0._goplaceable, false)

	if arg_24_0._nodeMo.id ~= arg_24_1 then
		arg_24_0:hideItemTip()
		arg_24_0:hideEnemyTip()
		arg_24_0:refreshNode()
	end
end

function var_0_0._onStartAttack(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_0._nodeMo:getEvent() then
		return
	end

	if arg_25_0._nodeMo.id ~= arg_25_1.id then
		return
	end

	if arg_25_3 then
		gohelper.setActive(arg_25_0._goattack, true)
	end

	arg_25_0._hurtValue = arg_25_2

	arg_25_0._nodeMo:reduceHp(arg_25_0._hurtValue)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_enemy_hurt)

	if arg_25_0._nodeMo.hp <= 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_enemy_dead)
		arg_25_0._enemyAnim:Play("dead", 0, 0)
		arg_25_0._enemyTopAni:Play("dead", 0, 0)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("enemyDead")
		arg_25_0:hideEnemyTip()
		TaskDispatcher.runDelay(arg_25_0._deadFinished, arg_25_0, 1.5)

		return
	end

	arg_25_0._enemyAnim:Play("hurt", 0, 0)
	arg_25_0._enemyTopAni:Play("hurt", 0, 0)

	if arg_25_0._txtaffected.gameObject.activeSelf then
		local var_25_0 = arg_25_2 - tonumber(arg_25_0._txtaffected.text)

		arg_25_0._txtaffected.text = "-" .. var_25_0
	else
		gohelper.setActive(arg_25_0._txtaffected.gameObject, true)

		arg_25_0._txtaffected.text = "-" .. arg_25_2
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("enemyHurt")
	TaskDispatcher.runDelay(arg_25_0._hurtFinished, arg_25_0, 1)
end

function var_0_0._hurtFinished(arg_26_0)
	gohelper.setActive(arg_26_0._goattack, false)
	gohelper.setActive(arg_26_0._txtaffected.gameObject, false)
	UIBlockMgr.instance:endBlock("enemyHurt")
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function var_0_0._onWarnEnemyNode(arg_27_0, arg_27_1)
	if arg_27_0._nodeMo.id ~= arg_27_1.id then
		return
	end

	if not arg_27_0._nodeMo:isNodeHasEnemy() then
		return
	end

	arg_27_0._nodeMo:setWarn(true)
	arg_27_0:_refreshNodeState()
end

function var_0_0._initNode(arg_28_0)
	gohelper.setActive(arg_28_0.go, true)
	gohelper.setActive(arg_28_0.topGo, true)
	gohelper.setActive(arg_28_0._golocked, false)
	gohelper.setActive(arg_28_0._gounlocked, false)
	gohelper.setActive(arg_28_0._gointeractable, false)
	gohelper.setActive(arg_28_0._goplaceable, false)
	gohelper.setActive(arg_28_0._godamage, false)
	gohelper.setActive(arg_28_0._goselected, false)
	gohelper.setActive(arg_28_0._gouninteractable, false)
	gohelper.setActive(arg_28_0._gocloud, false)
	gohelper.setActive(arg_28_0._gouninteractableenemy, false)
	gohelper.setActive(arg_28_0._goenemyicon, false)
	gohelper.setActive(arg_28_0._goenemy, false)
	gohelper.setActive(arg_28_0._gostate1, false)
	gohelper.setActive(arg_28_0._gostate2, false)
	gohelper.setActive(arg_28_0._goenemytip, false)
	gohelper.setActive(arg_28_0._txtaffected.gameObject, false)
	gohelper.setActive(arg_28_0._goitem, false)
	gohelper.setActive(arg_28_0._goitemtip, false)

	arg_28_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_28_0._btnnode.gameObject)

	arg_28_0._drag:AddDragBeginListener(arg_28_0._onBeginDrag, arg_28_0, arg_28_0._goitem.transform)
	arg_28_0._drag:AddDragListener(arg_28_0._onDrag, arg_28_0)
	arg_28_0._drag:AddDragEndListener(arg_28_0._onEndDrag, arg_28_0, arg_28_0._goitem.transform)

	arg_28_0._enemyAnim = arg_28_0._goenemy:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._enemyTopAni = arg_28_0._topgoroot:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._cloudAnim = arg_28_0._gocloud:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._lockAnim = arg_28_0._golocked:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._unlockAnim = arg_28_0._gounlocked:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._interactAnim = arg_28_0._gointeractable:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._onBeginDrag(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:hideItemTip()
	arg_29_0:hideEnemyTip()

	if not arg_29_0._nodeMo then
		return
	end

	if not arg_29_0._nodeMo:isNodeHasEnemy() and not arg_29_0._nodeMo:isNodeHasItem() then
		return
	end

	local var_29_0 = NuoDiKaConfig.instance:getItemCo(arg_29_0._nodeMo:getEvent().eventParam)

	if var_29_0 and var_29_0.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	arg_29_0._goDrag = gohelper.clone(arg_29_0._goitem)

	arg_29_0._goDrag.transform:SetParent(arg_29_0.go.transform.parent.parent)
	transformhelper.setLocalScale(arg_29_0._goDrag.transform, 1, 1, 1)

	local var_29_1 = arg_29_2.position
	local var_29_2 = recthelper.screenPosToAnchorPos(var_29_1, arg_29_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_29_0._goDrag.transform, var_29_2.x, var_29_2.y)
end

function var_0_0._onDrag(arg_30_0, arg_30_1, arg_30_2)
	if not arg_30_0._nodeMo then
		return
	end

	if not arg_30_0._nodeMo:isNodeHasEnemy() and not arg_30_0._nodeMo:isNodeHasItem() then
		return
	end

	local var_30_0 = NuoDiKaConfig.instance:getItemCo(arg_30_0._nodeMo:getEvent().eventParam)

	if var_30_0 and var_30_0.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local var_30_1 = arg_30_2.position
	local var_30_2 = recthelper.screenPosToAnchorPos(var_30_1, arg_30_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_30_0._goDrag.transform, var_30_2.x, var_30_2.y)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeUnitDraging, var_30_1, arg_30_0._nodeMo)
end

function var_0_0._onEndDrag(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0._nodeMo then
		return
	end

	if not arg_31_0._nodeMo:isNodeHasEnemy() and not arg_31_0._nodeMo:isNodeHasItem() then
		return
	end

	local var_31_0 = NuoDiKaConfig.instance:getItemCo(arg_31_0._nodeMo:getEvent().eventParam)

	if var_31_0 and var_31_0.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local var_31_1 = arg_31_2.position
	local var_31_2 = recthelper.screenPosToAnchorPos(var_31_1, arg_31_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_31_0._goDrag.transform, var_31_2.x, var_31_2.y)

	if arg_31_0._goDrag then
		gohelper.destroy(arg_31_0._goDrag)

		arg_31_0._goDrag = nil
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeUnitDragEnd, var_31_1, arg_31_0._nodeMo)
end

function var_0_0.setItem(arg_32_0, arg_32_1)
	arg_32_0._nodeMo = arg_32_1
	arg_32_0.go.name = arg_32_1.x .. "_" .. arg_32_1.y
	arg_32_0.topGo.name = arg_32_1.x .. "_" .. arg_32_1.y

	arg_32_0:refreshNode()
end

function var_0_0.refreshNode(arg_33_0)
	arg_33_0:_refreshNodeState()
	arg_33_0:_refreshEnemy()
	arg_33_0:_refreshItem()
end

function var_0_0._refreshNodeState(arg_34_0)
	local var_34_0 = arg_34_0._nodeMo:isNodeUnlock()
	local var_34_1 = NuoDiKaMapModel.instance:isNodeCouldUnlock(arg_34_0._nodeMo.id)
	local var_34_2 = NuoDiKaMapModel.instance:isNodeEnemyLock(arg_34_0._nodeMo.id)
	local var_34_3 = NuoDiKaMapModel.instance:isNodeSelected(arg_34_0._nodeMo.id)
	local var_34_4 = arg_34_0._nodeMo:isNodeHasItem() or arg_34_0._nodeMo:isNodeHasEnemy()

	if not var_34_0 and var_34_1 and not arg_34_0._gointeractable.activeSelf then
		gohelper.setActive(arg_34_0._gointeractable, true)
		arg_34_0._interactAnim:Play("open", 0, 0)
		arg_34_0._lockAnim:Play("close", 0, 0)
	end

	gohelper.setActive(arg_34_0._gounlocked, var_34_0)
	gohelper.setActive(arg_34_0._golocked, not var_34_0 and not var_34_1)
	gohelper.setActive(arg_34_0._gointeractable, not var_34_0 and var_34_1)
	gohelper.setActive(arg_34_0._gocloud, not var_34_0 and var_34_1)
	gohelper.setActive(arg_34_0._gouninteractable, not var_34_0 and var_34_2 and not arg_34_0._nodeMo.isWarn)
	gohelper.setActive(arg_34_0._gouninteractableenemy, not var_34_0 and var_34_2 and arg_34_0._nodeMo.isWarn)
	gohelper.setActive(arg_34_0._goenemyicon, not var_34_0 and not var_34_2 and arg_34_0._nodeMo.isWarn)
	gohelper.setActive(arg_34_0._goselected, var_34_3 and var_34_4)
end

function var_0_0._refreshEnemy(arg_35_0)
	local var_35_0 = arg_35_0._nodeMo:isNodeUnlock()
	local var_35_1 = arg_35_0._nodeMo:getEvent() and arg_35_0._nodeMo:isNodeHasEnemy()

	gohelper.setActive(arg_35_0._goenemy, var_35_0 and var_35_1)

	local var_35_2 = NuoDiKaEnum.EnemyState.Normal

	gohelper.setActive(arg_35_0._gostate1, var_35_0 and var_35_1 and var_35_2 ~= NuoDiKaEnum.EnemyState.Freeze)
	gohelper.setActive(arg_35_0._gostate2, var_35_0 and var_35_1 and var_35_2 == NuoDiKaEnum.EnemyState.Freeze)
	gohelper.setActive(arg_35_0._goturns, var_35_0 and var_35_1 and arg_35_0._nodeMo:isTriggerTypeEnemy())

	if var_35_0 and var_35_1 then
		local var_35_3 = arg_35_0._nodeMo:getEvent()
		local var_35_4 = NuoDiKaConfig.instance:getEnemyCo(var_35_3.eventParam)

		arg_35_0._txthpnum1.text = arg_35_0._nodeMo.hp
		arg_35_0._txthpnum2.text = arg_35_0._nodeMo.hp
		arg_35_0._txtattacknum1.text = arg_35_0._nodeMo.atk
		arg_35_0._txtattacknum2.text = arg_35_0._nodeMo.atk
		arg_35_0._txtenemyname.text = var_35_4.name
		arg_35_0._txtenemydesc.text = var_35_4.desc

		arg_35_0._simageenemy:LoadImage(ResUrl.getNuoDiKaMonsterIcon(var_35_4.picture))

		arg_35_0._txtturns.text = arg_35_0._nodeMo.interactTimes
	end
end

function var_0_0._refreshItem(arg_36_0)
	local var_36_0 = arg_36_0._nodeMo:isNodeUnlock()
	local var_36_1 = arg_36_0._nodeMo:getEvent() and arg_36_0._nodeMo:isNodeHasItem()

	gohelper.setActive(arg_36_0._goitem, var_36_0 and var_36_1)

	if var_36_0 and var_36_1 then
		local var_36_2 = arg_36_0._nodeMo:getEvent()
		local var_36_3 = NuoDiKaConfig.instance:getItemCo(var_36_2.eventParam)

		arg_36_0._txtitemname.text = var_36_3.name
		arg_36_0._txtitemdesc.text = var_36_3.desc

		arg_36_0._simageitem:LoadImage(ResUrl.getNuoDiKaItemIcon(var_36_3.picture))
	end
end

function var_0_0.showPlaceable(arg_37_0, arg_37_1)
	gohelper.setActive(arg_37_0._goplaceable, arg_37_1)
end

function var_0_0.showDamage(arg_38_0, arg_38_1)
	gohelper.setActive(arg_38_0._godamage, arg_38_1)
end

function var_0_0._showAffect(arg_39_0, arg_39_1, arg_39_2)
	gohelper.setActive(arg_39_0._txtaffected.gameObject, arg_39_1)

	if arg_39_1 then
		arg_39_0._txtaffected.text = arg_39_2 or 0
	end
end

function var_0_0.showEnemyTip(arg_40_0)
	if arg_40_0._goenemytip.activeSelf then
		return
	end

	gohelper.setActive(arg_40_0._goenemytip, true)
	TaskDispatcher.runDelay(function()
		local var_41_0 = recthelper.getHeight(arg_40_0._goenemytip.transform)
		local var_41_1 = recthelper.uiPosToScreenPos(arg_40_0._goenemytip.transform).y + var_41_0
		local var_41_2 = var_41_1 <= UnityEngine.Screen.height and 160 or 160 - (var_41_1 - UnityEngine.Screen.height)

		transformhelper.setLocalPos(arg_40_0._goenemytip.transform, 0, var_41_2, 0)
	end, arg_40_0, 0.01)
end

function var_0_0.hideEnemyTip(arg_42_0)
	gohelper.setActive(arg_42_0._goenemytip, false)
	transformhelper.setLocalPos(arg_42_0._goenemytip.transform, 0, 160, 0)
end

function var_0_0.showItemTip(arg_43_0)
	if arg_43_0._goitemtip.activeSelf then
		return
	end

	gohelper.setActive(arg_43_0._goitemtip, true)
	TaskDispatcher.runDelay(function()
		local var_44_0 = recthelper.getHeight(arg_43_0._goitemtip.transform)
		local var_44_1 = recthelper.uiPosToScreenPos(arg_43_0._goitemtip.transform).y + var_44_0
		local var_44_2 = var_44_1 <= UnityEngine.Screen.height and 160 or 160 - (var_44_1 - UnityEngine.Screen.height)

		transformhelper.setLocalPos(arg_43_0._goitemtip.transform, 0, var_44_2, 0)
	end, arg_43_0, 0.01)
end

function var_0_0.hideItemTip(arg_45_0)
	gohelper.setActive(arg_45_0._goitemtip, false)
	transformhelper.setLocalPos(arg_45_0._goitemtip.transform, 0, 160, 0)
end

function var_0_0.setNodeOffset(arg_46_0, arg_46_1, arg_46_2)
	transformhelper.setLocalPos(arg_46_0._goroot.transform, arg_46_1, arg_46_2, 0)
	transformhelper.setLocalPos(arg_46_0._topgoroot.transform, arg_46_1, arg_46_2, 0)
end

function var_0_0.showFade(arg_47_0, arg_47_1)
	if arg_47_1 then
		arg_47_0._enemyAnim:Play("fade", 0, 0)
		arg_47_0._enemyTopAni:Play("fade", 0, 0)
	else
		arg_47_0._enemyAnim:Play("idle", 0, 0)
		arg_47_0._enemyTopAni:Play("idle", 0, 0)
	end
end

function var_0_0.getNodeRoot(arg_48_0)
	return arg_48_0._goroot
end

function var_0_0.getNodeMo(arg_49_0)
	return arg_49_0._nodeMo
end

function var_0_0._endBlock(arg_50_0)
	UIBlockMgr.instance:endBlock("interactAttack")
	UIBlockMgr.instance:endBlock("enemyDeadUnlock")
	UIBlockMgr.instance:endBlock("cloudUnlock")
	UIBlockMgr.instance:endBlock("enemyDead")
	UIBlockMgr.instance:endBlock("itemScan")
	UIBlockMgr.instance:endBlock("enemyHurt")
	TaskDispatcher.cancelTask(arg_50_0._deadFinished, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._scanFinished, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._hurtFinished, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._unlockAnimFinished, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._unlockFinished, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._enemyDeadUnlockFinished, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._showInteractWarnFinished, arg_50_0)
end

function var_0_0.destroy(arg_51_0)
	arg_51_0:_endBlock()
	arg_51_0:_removeEvents()
	arg_51_0._simageenemy:UnLoadImage()
	arg_51_0._simageitem:UnLoadImage()
	arg_51_0._drag:RemoveDragListener()
	arg_51_0._drag:RemoveDragBeginListener()
	arg_51_0._drag:RemoveDragEndListener()
end

return var_0_0
