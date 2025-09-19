module("modules.logic.fight.view.FightViewPlayCardItem", package.seeall)

local var_0_0 = class("FightViewPlayCardItem", LuaCompBase)
local var_0_1 = 0.76

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._emtpyGO = gohelper.findChild(arg_1_1, "imgEmpty")
	arg_1_0._emptyNormal = gohelper.findChild(arg_1_1, "imgEmpty/emptyNormal")

	local var_1_0 = FightCardDataHelper.getCardSkin()
	local var_1_1 = gohelper.findChildImage(arg_1_1, "imgEmpty/emptyNormal")
	local var_1_2 = gohelper.findChildSingleImage(arg_1_1, "imgMove/Image")
	local var_1_3 = "singlebg_lang/txt_fight/change.png"

	if var_1_0 == 672801 then
		UISpriteSetMgr.instance:setFightSkillCardSprite(var_1_1, "card_dz5", true)

		var_1_3 = "singlebg_lang/txt_fight/change2.png"

		local var_1_4 = gohelper.cloneInPlace(arg_1_0._emptyNormal.gameObject, "emptyDarkBg")

		var_1_4 = var_1_4 and gohelper.onceAddComponent(var_1_4, gohelper.Type_Image)

		if var_1_4 then
			UISpriteSetMgr.instance:setFightSkillCardSprite(var_1_4, "card_dz6", true)
		end
	end

	var_1_2:UnLoadImage()
	var_1_2:LoadImage(var_1_3)

	arg_1_0._moveGO = gohelper.findChild(arg_1_1, "imgMove")
	arg_1_0._moveAnimComp = arg_1_0._moveGO:GetComponent(typeof(UnityEngine.Animation))
	arg_1_0._lockGO = gohelper.findChild(arg_1_1, "lock")

	if FightCardDataHelper.getCardSkin() == 672801 then
		FightViewHandCardItem.replaceLockBg(arg_1_0._lockGO)
	end

	local var_1_5 = ViewMgr.instance:getContainer(ViewName.FightView)
	local var_1_6 = var_1_5:getSetting().otherRes[1]

	arg_1_0._innerGO = var_1_5:getResInst(var_1_6, arg_1_0.go, "card")

	transformhelper.setLocalScale(arg_1_0._innerGO.transform, var_0_1, var_0_1, var_0_1)
	gohelper.setSiblingBefore(arg_1_0._innerGO, arg_1_0._lockGO)

	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_0.go)
	arg_1_0._goEffect1 = gohelper.create2d(arg_1_0.go, "effect1")
	arg_1_0._goEffect2 = gohelper.create2d(arg_1_0.go, "effect2")
	arg_1_0._goEffect3 = gohelper.create2d(arg_1_0.go, "effect3")

	gohelper.setSiblingBefore(arg_1_0._goEffect1, arg_1_0._innerGO)
	gohelper.setSiblingAfter(arg_1_0._goEffect2, arg_1_0._innerGO)
	gohelper.setSiblingAfter(arg_1_0._goEffect3, arg_1_0._innerGO)
	transformhelper.setLocalScale(arg_1_0._goEffect1.transform, var_0_1, var_0_1, var_0_1)
	transformhelper.setLocalScale(arg_1_0._goEffect2.transform, var_0_1, var_0_1, var_0_1)
	transformhelper.setLocalScale(arg_1_0._goEffect3.transform, var_0_1, var_0_1, var_0_1)
	gohelper.setActive(arg_1_0._goEffect1, false)
	gohelper.setActive(arg_1_0._goEffect2, false)
	gohelper.setActive(arg_1_0._goEffect3, false)

	arg_1_0._effectLoader1 = nil
	arg_1_0._effectLoader2 = nil
	arg_1_0._effectLoader3 = nil
	arg_1_0._conversionGO = gohelper.findChild(arg_1_1, "conversion")
	arg_1_0.rankChangeRoot = gohelper.findChild(arg_1_1, "#go_Grade")
	arg_1_0._seasonRoot = gohelper.findChild(arg_1_1, "imgEmpty/SeasonRoot")
	arg_1_0._seasonEmpty1 = gohelper.findChild(arg_1_1, "imgEmpty/SeasonRoot/imgEmpty1")
	arg_1_0._seasonEmpty2 = gohelper.findChild(arg_1_1, "imgEmpty/SeasonRoot/imgEmpty2")
	arg_1_0._seasonCurActIndex = gohelper.findChild(arg_1_1, "imgEmpty/SeasonRoot/#go_Selected")
	arg_1_0._seasonCurActArrow = gohelper.findChild(arg_1_1, "imgEmpty/SeasonRoot/image_SelectedArrow")

	local var_1_7 = FightModel.instance:isSeason2()

	gohelper.setActive(arg_1_0._seasonRoot, var_1_7)
	gohelper.setActive(arg_1_0._emptyNormal, not var_1_7)

	arg_1_0.goASFD = gohelper.findChild(arg_1_1, "asfd_icon")
	arg_1_0.asfdAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.goASFD)
	arg_1_0.txtASFDEnergy = gohelper.findChildText(arg_1_1, "asfd_icon/#txt_Num")

	gohelper.setSiblingAfter(arg_1_0.goASFD, arg_1_0._innerGO)
end

function var_0_0.refreshSeasonArrowShow(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0._seasonEmpty1, arg_2_1)
	gohelper.setActive(arg_2_0._seasonEmpty2, not arg_2_1)
	gohelper.setActive(arg_2_0._seasonCurActIndex, arg_2_1)
	gohelper.setActive(arg_2_0._seasonCurActArrow, arg_2_1)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._click:AddClickListener(arg_3_0._onClickThis, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._click:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_4_0._delayHideEffect, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDisableMoveAnim, arg_4_0)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._effectLoader1 then
		arg_5_0._effectLoader1:dispose()

		arg_5_0._effectLoader1 = nil
	end

	if arg_5_0._effectLoader2 then
		arg_5_0._effectLoader2:dispose()

		arg_5_0._effectLoader2 = nil
	end

	if arg_5_0._effectLoader3 then
		arg_5_0._effectLoader3:dispose()

		arg_5_0._effectLoader3 = nil
	end

	arg_5_0._tailEffectGO = nil
end

function var_0_0.updateItem(arg_6_0, arg_6_1)
	arg_6_0.fightBeginRoundOp = arg_6_1

	local var_6_0 = arg_6_1
	local var_6_1 = not var_6_0
	local var_6_2 = var_6_0 and (var_6_0:isMoveCard() or var_6_0:isMoveUniversal())
	local var_6_3 = FightCardDataHelper.checkOpAsPlayCardHandle(var_6_0)

	gohelper.setActive(arg_6_0._emtpyGO, var_6_1)
	gohelper.setActive(arg_6_0._moveGO, var_6_2)
	TaskDispatcher.cancelTask(arg_6_0._delayDisableMoveAnim, arg_6_0)

	if var_6_2 then
		arg_6_0._moveAnimComp.enabled = true

		TaskDispatcher.runDelay(arg_6_0._delayDisableMoveAnim, arg_6_0, 1)
	end

	gohelper.setActive(arg_6_0._innerGO, var_6_3)

	if var_6_3 then
		if not arg_6_0._cardItem then
			arg_6_0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._innerGO, FightViewCardItem, FightEnum.CardShowType.Operation)
		end

		arg_6_0._cardItem:updateItem(var_6_0.belongToEntityId, var_6_0.skillId)

		local var_6_4 = FightDataHelper.entityMgr:getById(var_6_0.belongToEntityId)
		local var_6_5 = FightBuffHelper.simulateBuffList(var_6_4, var_6_0)

		FightViewHandCardItemLock.setCardLock(var_6_0 and var_6_0.belongToEntityId, var_6_0 and var_6_0.skillId, arg_6_0._lockGO, false, var_6_5)
		arg_6_0:_setCardPreRemove(var_6_0, var_6_5)
		arg_6_0._cardItem:detectShowBlueStar()
		arg_6_0._cardItem:updateResistanceByBeginRoundOp(arg_6_1)

		if var_6_0:isPlayerFinisherSkill() then
			gohelper.setActive(arg_6_0._lockGO, false)
		end
	else
		gohelper.setActive(arg_6_0._lockGO, false)
	end

	if arg_6_0.fightBeginRoundOp then
		if arg_6_0.PARENTVIEW and arg_6_0.PARENTVIEW.refreshRankUpDown then
			arg_6_0.PARENTVIEW:refreshRankUpDown()
		end
	else
		gohelper.setActive(arg_6_0.rankChangeRoot, false)
	end

	arg_6_0:refreshASFDEnergy()
	arg_6_0:refreshRedAndBlueArea()
end

function var_0_0.refreshRedAndBlueArea(arg_7_0)
	if not arg_7_0._cardItem then
		return
	end

	local var_7_0 = arg_7_0.fightBeginRoundOp and arg_7_0.fightBeginRoundOp.cardColor

	arg_7_0._cardItem:setActiveRed(var_7_0 == FightEnum.CardColor.Red)
	arg_7_0._cardItem:setActiveBlue(var_7_0 == FightEnum.CardColor.Blue)
	arg_7_0._cardItem:setActiveBoth(var_7_0 == FightEnum.CardColor.Both)
end

function var_0_0.refreshASFDEnergy(arg_8_0)
	local var_8_0 = arg_8_0.fightBeginRoundOp and arg_8_0.fightBeginRoundOp.cardInfoMO
	local var_8_1 = var_8_0 and var_8_0.energy
	local var_8_2 = var_8_1 and var_8_1 > 0
	local var_8_3 = arg_8_0.goASFD.activeSelf

	gohelper.setActive(arg_8_0.goASFD, var_8_2)

	if var_8_2 then
		arg_8_0.txtASFDEnergy.text = var_8_1

		if var_8_3 then
			arg_8_0.asfdAnimatorPlayer:Play("open", arg_8_0.resetToASFDIdle, arg_8_0)
		end
	end
end

function var_0_0.resetToASFDIdle(arg_9_0)
	arg_9_0.asfdAnimatorPlayer:Play("idle")
end

function var_0_0.playASFDCloseAnim(arg_10_0)
	arg_10_0.asfdAnimatorPlayer:Play("close", arg_10_0.hideASFD, arg_10_0)
end

function var_0_0.hideASFD(arg_11_0)
	gohelper.setActive(arg_11_0.goASFD, false)
end

function var_0_0.setCopyCard(arg_12_0)
	arg_12_0._isCopyCard = true
end

function var_0_0.isCopyCard(arg_13_0)
	return arg_13_0._isCopyCard
end

local var_0_2 = Color.New(1, 1, 1, 0.5)

function var_0_0._setCardPreRemove(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == nil then
		return
	end

	if FightViewHandCardItemLock.canUseCardSkill(arg_14_1.belongToEntityId, arg_14_1.skillId, arg_14_2) then
		return
	end

	if FightViewHandCardItemLock.canPreRemove(arg_14_1.belongToEntityId, arg_14_1.skillId, arg_14_1, arg_14_2) then
		FightViewHandCardItemLock.setCardPreRemove(arg_14_1.belongToEntityId, arg_14_1.skillId, arg_14_0._lockGO, false)
	end
end

function var_0_0.showPlayCardEffect(arg_15_0, arg_15_1, arg_15_2)
	gohelper.setActive(arg_15_0._emtpyGO, false)
end

function var_0_0._delayHideEffect(arg_16_0)
	gohelper.setActive(arg_16_0._goEffect1, false)
	gohelper.setActive(arg_16_0._goEffect2, false)
	gohelper.setActive(arg_16_0._goEffect3, false)
	gohelper.destroy(arg_16_0._tailEffectGO)

	arg_16_0._tailEffectGO = nil
end

function var_0_0.hideExtMoveEffect(arg_17_0)
	gohelper.setActive(arg_17_0._conversionGO, false)
end

function var_0_0.showExtMoveEffect(arg_18_0)
	gohelper.setActive(arg_18_0._conversionGO, true)
end

function var_0_0.showExtMoveEndEffect(arg_19_0)
	gohelper.setActive(arg_19_0._conversionGO, false)
end

function var_0_0._delayDisableMoveAnim(arg_20_0)
	arg_20_0._moveAnimComp.enabled = false
end

local var_0_3 = {}

function var_0_0._onClickThis(arg_21_0)
	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard then
		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.Discard)
	end

	if not FightDataHelper.stageMgr:isFree(var_0_3) then
		return
	end

	FightRpc.instance:sendResetRoundRequest()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightResetCard)
	FightAudioMgr.instance:stopAllCardAudio()
end

return var_0_0
