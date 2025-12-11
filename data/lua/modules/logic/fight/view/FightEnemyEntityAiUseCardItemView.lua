module("modules.logic.fight.view.FightEnemyEntityAiUseCardItemView", package.seeall)

local var_0_0 = class("FightEnemyEntityAiUseCardItemView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = arg_1_0.viewGO

	arg_1_0.go = var_1_0
	arg_1_0.tr = arg_1_0.viewGO.transform
	arg_1_0._imgMat = gohelper.findChildImage(var_1_0, "imgMat")
	arg_1_0._imgTag = gohelper.findChildImage(var_1_0, "imgTag")
	arg_1_0._imgBgs = arg_1_0:getUserDataTb_()
	arg_1_0._imgBgGos = arg_1_0:getUserDataTb_()

	for iter_1_0 = 0, 4 do
		arg_1_0._imgBgs[iter_1_0] = gohelper.findChildImage(var_1_0, "imgBg/" .. iter_1_0)
		arg_1_0._imgBgGos[iter_1_0] = gohelper.findChild(var_1_0, "imgBg/" .. iter_1_0)
	end

	arg_1_0._imgBg2 = gohelper.findChildImage(var_1_0, "forbid/mask")

	if isDebugBuild then
		arg_1_0._imgTag.raycastTarget = true
		arg_1_0._click = gohelper.getClick(arg_1_0.go)

		arg_1_0:com_registClick(arg_1_0._click, arg_1_0._onClickOp)
	end

	arg_1_0.topPosRectTr = gohelper.findChildComponent(var_1_0, "topPos", gohelper.Type_RectTransform)
	arg_1_0.goEmitNormal = gohelper.findChild(var_1_0, "#emit_normal")
	arg_1_0.goEmitUitimate = gohelper.findChild(var_1_0, "#emit_uitimate")
	arg_1_0.animator = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registMsg(FightMsgId.DiscardUnUsedEnemyAiCard, arg_2_0.onDiscardUnUsedEnemyAiCard)
	arg_2_0:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.onCloseView)
	arg_2_0:com_registFightEvent(FightEvent.OnSelectMonsterCardMo, arg_2_0.onSelectMonsterCardMo)
	arg_2_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_2_0.onSkillPlayStart)
	arg_2_0:com_registFightEvent(FightEvent.OnInvokeSkill, arg_2_0.onInvokeSkill)
	arg_2_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_2_0.onBuffUpdate)
	arg_2_0:com_registFightEvent(FightEvent.OnExPointChange, arg_2_0.onExPointChange)
	arg_2_0:com_registFightEvent(FightEvent.InvalidEnemyUsedCard, arg_2_0.onInvalidEnemyUsedCard)
end

function var_0_0.onSelectMonsterCardMo(arg_3_0, arg_3_1)
	local var_3_0 = FightHelper.isSameCardMo(arg_3_1, arg_3_0.cardData)

	gohelper.setActive(arg_3_0.goEmitNormal, var_3_0 and not arg_3_0.isBigSkill)
	gohelper.setActive(arg_3_0.goEmitUitimate, var_3_0 and arg_3_0.isBigSkill)
end

function var_0_0.onCloseView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.FightEnemyActionView then
		gohelper.setActive(arg_4_0.goEmitNormal, false)
		gohelper.setActive(arg_4_0.goEmitUitimate, false)
	end
end

function var_0_0.onRefreshItemData(arg_5_0, arg_5_1)
	arg_5_0.cardData = arg_5_1
	arg_5_0.entityId = arg_5_0.cardData.uid
	arg_5_0.skillId = arg_5_0.cardData.skillId
	arg_5_0.entityData = FightDataHelper.entityMgr:getById(arg_5_0.entityId)
	arg_5_0.isBigSkill = FightCardDataHelper.isBigSkill(arg_5_0.skillId)

	if lua_skill_next.configDict[arg_5_0.skillId] then
		arg_5_0.isBigSkill = false
	end

	arg_5_0:refreshCanUseCardState()

	local var_5_0 = lua_skill.configDict[arg_5_1.skillId]

	gohelper.setActive(arg_5_0.go, var_5_0 ~= nil)

	if not var_5_0 then
		return
	end

	local var_5_1 = FightCardDataHelper.getSkillLv(arg_5_0.entityId, arg_5_0.skillId)

	var_5_1 = arg_5_0.isBigSkill and FightEnum.UniqueSkillCardLv or var_5_1 == FightEnum.UniqueSkillCardLv and 1 or var_5_1

	UISpriteSetMgr.instance:setFightSprite(arg_5_0._imgTag, "jnk_gj" .. var_5_0.showTag)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._imgBgs) do
		gohelper.setActive(iter_5_1.gameObject, iter_5_0 == var_5_1)
	end

	if arg_5_0._imgBg2 and arg_5_0._imgBgs[var_5_1] then
		arg_5_0._imgBg2.sprite = arg_5_0._imgBgs[var_5_1].sprite
	end

	gohelper.setActive(arg_5_0._imgTag.gameObject, var_5_1 ~= FightEnum.UniqueSkillCardLv)
	arg_5_0.animator:Play(arg_5_0.canUseCard and "fightname_op_in" or "fightname_forbid_in", 0, 0)
	arg_5_0.animator:Update(0)
end

function var_0_0.refreshCanUseCardState(arg_6_0)
	if arg_6_0.forceCanNotUse then
		arg_6_0.canUseCard = false

		return
	end

	arg_6_0.canUseCard = arg_6_0:checkCanUseCard()

	if arg_6_0.isBigSkill and arg_6_0.entityData.exPoint < arg_6_0.entityData:getUniqueSkillPoint() then
		arg_6_0.canUseCard = false
	end
end

function var_0_0.checkCanUseCard(arg_7_0)
	if not FightModel.instance:isSeason2() then
		return FightViewHandCardItemLock.canUseCardSkill(arg_7_0.entityId, arg_7_0.skillId)
	end

	local var_7_0 = arg_7_0.entityData:getBuffList()
	local var_7_1 = false
	local var_7_2 = arg_7_0:getSelfIndex()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.buffId == 832400103 then
			var_7_1 = true

			if var_7_2 == 1 then
				return false
			end

			break
		end
	end

	if var_7_1 then
		var_7_0 = FightDataUtil.coverData(var_7_0)

		for iter_7_2 = #var_7_0, 1, -1 do
			if var_7_0[iter_7_2].buffId == 832400103 then
				table.remove(var_7_0, iter_7_2)
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(arg_7_0.entityId, arg_7_0.skillId, var_7_0)
end

function var_0_0.onSkillPlayStart(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1.id ~= arg_8_0.entityId then
		return
	end

	if arg_8_3.cardIndex == arg_8_0.cardData.clientData.custom_enemyCardIndex then
		arg_8_0.animator:Play("fightname_op_play", 0, 0)
		arg_8_0.animator:Update(0)
		arg_8_0:com_registSingleTimer(arg_8_0.onPlayEnd, 0.5)

		arg_8_0.played = true
	end
end

function var_0_0.onInvokeSkill(arg_9_0, arg_9_1)
	if arg_9_1.fromId ~= arg_9_0.entityId then
		return
	end

	if arg_9_1.cardIndex == arg_9_0.cardData.clientData.custom_enemyCardIndex then
		arg_9_0.animator:Play("fightname_op_play", 0, 0)
		arg_9_0.animator:Update(0)
		arg_9_0:com_registSingleTimer(arg_9_0.onPlayEnd, 0.5)

		arg_9_0.played = true
	end
end

function var_0_0.onPlayEnd(arg_10_0)
	arg_10_0:removeSelf()
end

function var_0_0.onBuffUpdate(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 ~= arg_11_0.entityId then
		return
	end

	if arg_11_2 == FightEnum.EffectType.BUFFADD or arg_11_2 == FightEnum.EffectType.BUFFDEL then
		arg_11_0:refreshLockState()
	end
end

function var_0_0.onDiscardUnUsedEnemyAiCard(arg_12_0)
	if not arg_12_0.played then
		local var_12_0 = arg_12_0:com_registWork(FightWorkPlayAnimator, arg_12_0.viewGO, "fightname_forbid_imprison", FightModel.instance:getUISpeed())

		FightMsgMgr.replyMsg(FightMsgId.DiscardUnUsedEnemyAiCard, var_12_0)

		local var_12_1 = FightCardDataHelper.getSkillLv(arg_12_0.entityId, arg_12_0.skillId)
		local var_12_2 = arg_12_0._imgBgGos[var_12_1]

		if var_12_2 then
			local var_12_3 = var_12_2:GetComponent(typeof(UnityEngine.Animation))

			gohelper.onceAddComponent(var_12_2, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

			if var_12_3 then
				var_12_3:Play("fightname_forbid_dissvelop")
			end

			arg_12_0._imgBgs[var_12_1].material = arg_12_0._imgMat.material
		end
	end
end

function var_0_0.onExPointChange(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1 == arg_13_0.entityId then
		arg_13_0:refreshLockState()
	end
end

function var_0_0.refreshLockState(arg_14_0)
	local var_14_0 = arg_14_0.canUseCard

	arg_14_0:refreshCanUseCardState()

	if var_14_0 ~= arg_14_0.canUseCard then
		arg_14_0.animator:Play(arg_14_0.canUseCard and "fightname_forbid_unlock" or "fightname_forbid_in", 0, 0)
		arg_14_0.animator:Update(0)
	end
end

function var_0_0.onInvalidEnemyUsedCard(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0.cardData.clientData.custom_enemyCardIndex then
		arg_15_0.forceCanNotUse = true

		arg_15_0:refreshLockState()
	end
end

function var_0_0._onClickOp(arg_16_0)
	if arg_16_0.cardData then
		logNormal(arg_16_0.cardData.skillId .. " " .. lua_skill.configDict[arg_16_0.cardData.skillId].name)
	end
end

function var_0_0.onDestructor(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._imgBgs) do
		iter_17_1.material = nil
	end
end

return var_0_0
