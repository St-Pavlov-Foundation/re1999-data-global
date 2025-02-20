module("modules.logic.fight.view.FightViewCardItem", package.seeall)

slot0 = class("FightViewCardItem", LuaCompBase)
slot0.TagPosForLvs = nil

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._lvGOs = slot0:getUserDataTb_()
	slot0._lvImgIcons = slot0:getUserDataTb_()
	slot0._lvImgComps = slot0:getUserDataTb_()
	slot0._starItemCanvas = slot0:getUserDataTb_()

	for slot5 = 1, 4 do
		slot6 = gohelper.findChild(slot1, "lv" .. slot5)

		gohelper.setActive(slot6, true)
		table.insert(slot0._lvGOs, slot6)
		table.insert(slot0._lvImgIcons, gohelper.findChildSingleImage(slot6, "imgIcon"))
		table.insert(slot0._lvImgComps, gohelper.findChildImage(slot6, "imgIcon"))
	end

	if not uv0.TagPosForLvs then
		uv0.TagPosForLvs = {}

		for slot5 = 1, 4 do
			slot6, slot7 = recthelper.getAnchor(gohelper.findChild(slot1, "tag/pos" .. slot5).transform)
			uv0.TagPosForLvs[slot5] = {
				slot6,
				slot7
			}
		end
	end

	slot0._tagRootTr = gohelper.findChild(slot1, "tag/tag").transform
	slot0._tag = gohelper.findChildSingleImage(slot1, "tag/tag/tagIcon")
	slot0._txt = gohelper.findChildText(slot1, "Text")
	slot0._starGO = gohelper.findChild(slot1, "star")
	slot5 = typeof
	slot0._starCanvas = gohelper.onceAddComponent(slot0._starGO, slot5(UnityEngine.CanvasGroup))
	slot0._innerStartGOs = slot0:getUserDataTb_()

	for slot5 = 1, FightEnum.MaxSkillCardLv do
		slot6 = gohelper.findChild(slot1, "star/star" .. slot5)

		table.insert(slot0._innerStartGOs, slot6)
		table.insert(slot0._starItemCanvas, gohelper.onceAddComponent(slot6, typeof(UnityEngine.CanvasGroup)))
	end

	slot0._predisplay = gohelper.findChild(slot1, "layout/predisplay")
	slot0._cardAni = gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator))
	slot0._cardAppearEffectRoot = gohelper.findChild(slot1, "cardAppearEffectRoot")
	slot5 = "cardmask"
	slot0._cardMask = gohelper.findChild(slot1, slot5)
	slot0._maskList = slot0:getUserDataTb_()

	for slot5 = 1, 4 do
		table.insert(slot0._maskList, gohelper.findChild(slot0._cardMask, "lv" .. slot5))
	end

	slot0._resistanceComp = MonoHelper.addLuaComOnceToGo(slot0.go, FightViewCardItemResistance, slot0)
	slot0._loader = slot0._loader or LoaderComponent.New()
	slot0._countRoot = gohelper.findChild(slot0.go, "layout/count")
	slot0._countText = gohelper.findChildText(slot0.go, "layout/count/#txt_count")

	gohelper.setActive(slot0._countRoot, false)

	slot0._abandon = gohelper.findChild(slot0.go, "layout/abandon")

	gohelper.setActive(slot0._abandon, false)

	slot0._blockadeTwo = gohelper.findChild(slot0.go, "#go_enchant_effect")

	gohelper.setActive(slot0._blockadeTwo, false)

	slot0._blockadeOne = gohelper.findChild(slot0.go, "#go_enchant_uneffect")

	gohelper.setActive(slot0._blockadeOne, false)

	slot0._precision = gohelper.findChild(slot0.go, "AccurateEnchant")

	gohelper.setActive(slot0._precision, false)

	slot0._precisionEffect = gohelper.findChild(slot0.go, "AccurateEnchant/effect")

	gohelper.setActive(slot0._precisionEffect, false)
end

function slot0.updateItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._countRoot, false)
	slot0:_hideAniEffect()

	slot0.entityId = slot1
	slot0.skillId = slot2
	slot0._cardInfoMO = slot3
	slot4 = lua_skill.configDict[slot2]
	slot9 = slot2

	for slot9, slot10 in ipairs(slot0._lvGOs) do
		gohelper.setActiveCanvasGroup(slot10, FightCardModel.instance:getSkillLv(slot1, slot9) == slot9)
	end

	for slot9, slot10 in ipairs(slot0._lvImgIcons) do
		slot11 = ResUrl.getSkillIcon(slot4.icon)

		if gohelper.isNil(slot0._lvImgComps[slot9].sprite) then
			slot10:UnLoadImage()
		elseif slot10.curImageUrl ~= slot11 then
			slot10:UnLoadImage()
		end

		slot10:LoadImage(slot11)
	end

	gohelper.setActive(slot0._starGO, slot5 < FightEnum.UniqueSkillCardLv)

	slot0._starCanvas.alpha = 1

	for slot9, slot10 in ipairs(slot0._innerStartGOs) do
		gohelper.setActive(slot10, slot9 == slot5)

		if slot0._starItemCanvas[slot9] then
			slot0._starItemCanvas[slot9].alpha = 1
		end
	end

	slot0._tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot4.showTag))

	if uv0.TagPosForLvs[slot5] then
		recthelper.setAnchor(slot0._tagRootTr, slot6[1], slot6[2])
	end

	gohelper.setActive(slot0._tag.gameObject, slot5 < FightEnum.UniqueSkillCardLv)

	slot0._txt.text = slot4.id .. "\nLv." .. slot5

	if FightCardModel.instance:isUniqueSkill(slot0.entityId, slot0.skillId) then
		if not slot0._uniqueCardEffect then
			slot7 = ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka)
			slot0._uniqueCardEffect = gohelper.clone(FightHelper.getPreloadAssetItem(slot7):GetResource(slot7), slot0.go)
		end

		gohelper.setActive(slot0._uniqueCardEffect, true)
	elseif slot0._uniqueCardEffect then
		gohelper.setActive(slot0._uniqueCardEffect, false)
	end

	gohelper.setActive(slot0._predisplay, slot0._cardInfoMO and slot0._cardInfoMO.tempCard)
	slot0:_showUpgradeEffect()
	slot0:_showEnchantsEffect()
	slot0:_refreshGray()
end

function slot0.updateResistanceByCardInfo(slot0, slot1)
	slot0._resistanceComp:updateByCardInfo(slot1)
end

function slot0.updateResistanceByBeginRoundOp(slot0, slot1)
	slot0._resistanceComp:updateByBeginRoundOp(slot1)
end

function slot0.updateResistanceBySkillDisplayMo(slot0, slot1)
	slot0._resistanceComp:updateBySkillDisplayMo(slot1)
end

function slot0.detectShowBlueStar(slot0)
	slot0:showBlueStar(slot0.entityId and slot0.skillId and FightCardModel.instance:getSkillLv(slot0.entityId, slot0.skillId))
end

function slot0.showBlueStar(slot0, slot1)
	if slot0._lightBlueObj then
		for slot5, slot6 in ipairs(slot0._lightBlueObj) do
			gohelper.setActive(slot6.blue, false)
			gohelper.setActive(slot6.dark, true)
		end
	else
		slot0._lightBlueObj = {
			slot0:getUserDataTb_()
		}
		slot0._lightBlueObj[1].blue = gohelper.findChild(slot0._innerStartGOs[1], "lightblue")
		slot0._lightBlueObj[1].dark = gohelper.findChild(slot0._innerStartGOs[1], "dark2")
		slot0._lightBlueObj[2] = slot0:getUserDataTb_()
		slot0._lightBlueObj[2].blue = gohelper.findChild(slot0._innerStartGOs[2], "lightblue")
		slot0._lightBlueObj[2].dark = gohelper.findChild(slot0._innerStartGOs[2], "dark3")
	end

	if (slot1 == 1 or slot1 == 2) and FightDataHelper.entityMgr:getById(slot0.entityId) and slot2:hasBuffFeature(FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		slot3 = slot0._lightBlueObj[slot1]

		gohelper.setActive(slot3.blue, true)
		gohelper.setActive(slot3.dark, false)
	end
end

function slot0.showPrecisionEffect(slot0)
	gohelper.setActive(slot0._precisionEffect, true)
end

function slot0.hidePrecisionEffect(slot0)
	gohelper.setActive(slot0._precisionEffect, false)
end

slot1 = {
	[FightEnum.EnchantedType.Frozen] = "ui/viewres/fight/card_freeze.prefab",
	[FightEnum.EnchantedType.Burn] = "ui/viewres/fight/card_flaring.prefab",
	[FightEnum.EnchantedType.Chaos] = "ui/viewres/fight/card_chaos.prefab"
}

function slot0._showEnchantsEffect(slot0)
	gohelper.setActive(slot0._abandon, false)
	gohelper.setActive(slot0._blockadeTwo, false)
	gohelper.setActive(slot0._blockadeOne, false)
	gohelper.setActive(slot0._precision, false)
	gohelper.setActive(slot0._precisionEffect, false)

	if not slot0._cardInfoMO then
		return
	end

	if #slot0:_refreshEnchantEffectActive() > 0 then
		slot0._loader:loadListAsset(slot1, slot0._onEnchantEffectLoaded, slot0._onEnchantEffectsLoaded, slot0)
	end

	if slot0._cardInfoMO.enchants then
		for slot5, slot6 in ipairs(slot0._cardInfoMO.enchants) do
			if slot6.enchantId == FightEnum.EnchantedType.Discard then
				gohelper.setActive(slot0._abandon, true)
			elseif slot6.enchantId == FightEnum.EnchantedType.Blockade then
				slot7 = FightCardModel.instance:getHandCards()

				if slot0._cardInfoMO.custom_playedCard then
					gohelper.setActive(slot0._blockadeOne, true)
				elseif slot0._cardInfoMO.custom_handCardIndex then
					if slot0._cardInfoMO.custom_handCardIndex == 1 or slot0._cardInfoMO.custom_handCardIndex == #slot7 then
						gohelper.setActive(slot0._blockadeOne, true)
					else
						gohelper.setActive(slot0._blockadeTwo, true)
					end
				else
					gohelper.setActive(slot0._blockadeOne, true)
				end
			elseif slot6.enchantId == FightEnum.EnchantedType.Precision then
				gohelper.setActive(slot0._precision, true)

				if slot0._cardInfoMO.custom_handCardIndex == 1 then
					FightController.instance:dispatchEvent(FightEvent.RefreshHandCardPrecisionEffect)
				end
			end
		end
	end
end

function slot0._refreshEnchantEffectActive(slot0)
	slot0:_hideEnchantsEffect()

	slot0._enchantsEffect = slot0._enchantsEffect or {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._cardInfoMO.enchants or {}) do
		if slot0._enchantsEffect[slot7.enchantId] then
			for slot12, slot13 in ipairs(slot0._enchantsEffect[slot8]) do
				gohelper.setActive(slot13, true)
			end
		elseif uv0[slot8] then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0._hideEnchantsEffect(slot0)
	if slot0._enchantsEffect then
		for slot4, slot5 in pairs(slot0._enchantsEffect) do
			for slot9, slot10 in ipairs(slot5) do
				gohelper.setActive(slot10, false)
			end
		end
	end
end

function slot0._onEnchantEffectLoaded(slot0)
end

function slot0._onEnchantEffectsLoaded(slot0)
	for slot4, slot5 in pairs(uv0) do
		if not slot0._enchantsEffect[slot4] and slot0._loader:getAssetItem(slot5) then
			slot7 = slot6:GetResource()

			if slot0._lvGOs then
				slot11 = slot0
				slot0._enchantsEffect[slot4] = slot0.getUserDataTb_(slot11)

				for slot11, slot12 in ipairs(slot0._lvGOs) do
					slot13 = gohelper.clone(slot7, gohelper.findChild(slot12, "#cardeffect"))

					for slot17 = 1, 4 do
						gohelper.setActive(gohelper.findChild(slot13, "lv" .. slot17), slot17 == slot11)
					end

					table.insert(slot0._enchantsEffect[slot4], slot13)
				end
			end
		end
	end

	slot0:_refreshEnchantEffectActive()
end

function slot0._showUpgradeEffect(slot0)
	if lua_fight_upgrade_show_skillid.configDict[slot0.skillId] then
		if not slot0._upgradeEffects then
			slot0._loader:loadAsset("ui/viewres/fight/card_aggrandizement.prefab", slot0._onUpgradeEffectLoaded, slot0)

			return
		end

		for slot4, slot5 in ipairs(slot0._upgradeEffects) do
			gohelper.setActive(slot5, false)
			gohelper.setActive(slot5, true)
		end
	else
		slot0:_hideUpgradeEffects()
	end
end

function slot0._hideUpgradeEffects(slot0)
	if slot0._upgradeEffects then
		for slot4, slot5 in ipairs(slot0._upgradeEffects) do
			gohelper.setActive(slot5, false)
		end
	end
end

function slot0._onUpgradeEffectLoaded(slot0, slot1)
	if slot0._upgradeEffects then
		return
	end

	slot0._upgradeEffects = slot0:getUserDataTb_()

	if slot0._lvGOs and slot1:GetResource() then
		for slot6, slot7 in ipairs(slot0._lvGOs) do
			slot8 = gohelper.clone(slot2, gohelper.findChild(slot7, "#cardeffect"))

			for slot12 = 1, 4 do
				gohelper.setActive(gohelper.findChild(slot8, "lv" .. slot12), slot12 == slot6)
			end

			table.insert(slot0._upgradeEffects, slot8)
		end
	end

	slot0:_showUpgradeEffect()
end

function slot0.showCountPart(slot0, slot1)
	gohelper.setActive(slot0._countRoot, true)

	slot0._countText.text = luaLang("multiple") .. slot1
end

function slot0.changeToTempCard(slot0)
	gohelper.setActive(slot0._predisplay, true)
end

function slot0.dissolveCard(slot0, slot1)
	if not slot0.go.activeInHierarchy then
		return
	end

	slot2 = slot0:getUserDataTb_()
	slot2.dissolveScale = slot1 or 1
	slot3 = slot0:getUserDataTb_()

	table.insert(slot3, slot0.go)

	slot2.dissolveSkillItemGOs = slot3

	if not slot0._dissolveFlow then
		slot0._dissolveFlow = FlowSequence.New()

		slot0._dissolveFlow:addWork(FightCardDissolveEffect.New())
	end

	slot0:_hideAllEffect()
	slot0._dissolveFlow:start(slot2)
end

function slot0.disappearCard(slot0)
	if not slot0.go.activeInHierarchy then
		return
	end

	slot1 = slot0:getUserDataTb_()
	slot1.hideSkillItemGOs = slot0:getUserDataTb_()

	table.insert(slot1.hideSkillItemGOs, slot0.go)

	if not slot0._disappearFlow then
		slot0._disappearFlow = FlowSequence.New()

		slot0._disappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	else
		slot0._disappearFlow:stop()
	end

	slot0._disappearFlow:start(slot1)
end

function slot0.playUsedCardDisplay(slot0, slot1)
	if not slot0.go.activeInHierarchy then
		return
	end

	if not slot0._cardDisplayFlow then
		slot0._cardDisplayFlow = FlowSequence.New()

		slot0._cardDisplayFlow:addWork(FightCardDisplayEffect.New())
	end

	slot2 = slot0:getUserDataTb_()
	slot2.skillTipsGO = slot1
	slot2.skillItemGO = slot0.go

	slot0._cardDisplayFlow:start(slot2)
end

function slot0.playUsedCardFinish(slot0, slot1, slot2)
	if not slot0.go.activeInHierarchy then
		return
	end

	if not slot0._cardDisplayEndFlow then
		slot0._cardDisplayEndFlow = FlowSequence.New()

		slot0._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())
	end

	slot3 = slot0:getUserDataTb_()
	slot3.skillTipsGO = slot1
	slot3.skillItemGO = slot0.go
	slot3.waitingAreaGO = slot2

	slot0._cardDisplayEndFlow:start(slot3)
end

function slot0.playCardLevelChange(slot0, slot1, slot2, slot3)
	if not slot0._cardInfoMO then
		return
	end

	if not slot0.go.activeInHierarchy then
		return
	end

	slot0._cardInfoMO = slot1 or slot0._cardInfoMO
	slot4 = FightConfig.instance:getSkillLv(slot2)
	slot5 = FightConfig.instance:getSkillLv(slot0._cardInfoMO.skillId)

	if not slot0._cardLevelChangeFlow then
		slot0._cardLevelChangeFlow = FlowSequence.New()

		slot0._cardLevelChangeFlow:addWork(FightCardChangeEffect.New())
		slot0._cardLevelChangeFlow:registerDoneListener(slot0._onCardLevelChangeFlowDone, slot0)
	else
		if slot0._cardLevelChangeFlow.status == WorkStatus.Running and slot0._cardLevelChangeFlow.context then
			slot4 = slot0._cardLevelChangeFlow.context.oldCardLevel or slot4
		end

		slot0._cardLevelChangeFlow:stop()
	end

	slot6 = slot0:getUserDataTb_()
	slot6.skillId = slot0._cardInfoMO.skillId
	slot6.entityId = slot0._cardInfoMO.uid
	slot6.oldCardLevel = slot4
	slot6.newCardLevel = slot5
	slot6.cardItem = slot0
	slot6.failType = slot3

	slot0._cardLevelChangeFlow:start(slot6)

	if slot4 <= slot5 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_cardstarup)
	else
		AudioMgr.instance:trigger(20211403)
	end
end

function slot0._refreshGray(slot0)
	if slot0._cardInfoMO and slot0._cardInfoMO.status == FightEnum.CardInfoStatus.STATUS_PLAYSETGRAY then
		gohelper.setActive(slot0._cardMask, true)

		slot1 = slot0._cardInfoMO.uid
		slot2 = slot0._cardInfoMO.skillId
		slot8 = slot2
		slot4 = FightCardModel.instance:isUniqueSkill(slot1, slot8)

		for slot8, slot9 in ipairs(slot0._maskList) do
			if slot8 < 4 then
				gohelper.setActive(slot9, slot8 == FightCardModel.instance:getSkillLv(slot1, slot2))
			else
				gohelper.setActive(slot9, slot4)
			end
		end
	else
		gohelper.setActive(slot0._cardMask, false)
	end
end

function slot0.playCardAroundSetGray(slot0)
	slot0:_refreshGray()
end

function slot0.playChangeRankFail(slot0, slot1)
	if slot0._cardInfoMO then
		slot0:playCardLevelChange(slot0._cardInfoMO, slot0._cardInfoMO.skillId, slot1)
	end
end

function slot0._onCardLevelChangeFlowDone(slot0)
	slot0:updateItem(slot0._cardInfoMO.uid, slot0._cardInfoMO.skillId, slot0._cardInfoMO)
	FightController.instance:dispatchEvent(FightEvent.CardLevelChangeDone, slot0._cardInfoMO)
	slot0:detectShowBlueStar()
end

function slot0.playCardAni(slot0, slot1, slot2)
	slot0._cardAniName = slot2 or UIAnimationName.Open

	slot0._loader:loadAsset(slot1, slot0._onCardAniLoaded, slot0)
end

function slot0._onCardAniLoaded(slot0, slot1)
	if not slot0._cardAniName then
		slot0:_hideAniEffect()

		return
	end

	slot0._cardAni.runtimeAnimatorController = slot1:GetResource()
	slot0._cardAni.enabled = true
	slot0._cardAni.speed = FightModel.instance:getUISpeed()

	SLFramework.AnimatorPlayer.Get(slot0.go):Play(slot0._cardAniName, slot0.onCardAniFinish, slot0)
end

function slot0.onCardAniFinish(slot0)
	slot0:_hideAniEffect()
	slot0:hideCardAppearEffect()
end

function slot0._hideAniEffect(slot0)
	slot0._cardAniName = nil
	slot0._cardAni.enabled = false

	gohelper.setActive(gohelper.findChild(slot0.go, "vx_balance"), false)
end

function slot0.playAppearEffect(slot0)
	gohelper.setActive(slot0._cardAppearEffectRoot, true)

	if not slot0._appearEffect then
		if slot0._appearEffectLoadStart then
			return
		end

		slot0._appearEffectLoadStart = true

		slot0._loader:loadAsset("ui/viewres/fight/card_appear.prefab", slot0._onAppearEffectLoaded, slot0)
	else
		slot0:showAppearEffect()
	end
end

function slot0._onAppearEffectLoaded(slot0, slot1)
	slot0._appearEffect = gohelper.clone(slot1:GetResource(), slot0._cardAppearEffectRoot)

	gohelper.addChild(slot0._cardAppearEffectRoot.transform.parent.parent.gameObject, slot0._cardAppearEffectRoot)
	slot0:showAppearEffect()
end

function slot0.showAppearEffect(slot0)
	slot1 = FightCardModel.instance:isUniqueSkill(slot0.entityId, slot0.skillId)

	gohelper.setActive(gohelper.findChild(slot0._appearEffect, "nomal_skill"), not slot1)
	gohelper.setActive(gohelper.findChild(slot0._appearEffect, "ultimate_skill"), slot1)
end

function slot0.hideCardAppearEffect(slot0)
	gohelper.setActive(slot0._cardAppearEffectRoot, false)
end

function slot0.releaseEffectFlow(slot0)
	if slot0._cardLevelChangeFlow then
		slot0._cardLevelChangeFlow:unregisterDoneListener(slot0._onCardLevelChangeFlowDone, slot0)
		slot0._cardLevelChangeFlow:stop()

		slot0._cardLevelChangeFlow = nil
	end

	if slot0._dissolveFlow then
		slot0._dissolveFlow:stop()

		slot0._dissolveFlow = nil
	end

	if slot0._cardDisplayFlow then
		slot0._cardDisplayFlow:stop()

		slot0._cardDisplayFlow = nil
	end

	if slot0._cardDisplayEndFlow then
		slot0._cardDisplayEndFlow:stop()

		slot0._cardDisplayEndFlow = nil
	end

	if slot0._disappearFlow then
		if not gohelper.isNil(slot0.go) then
			gohelper.onceAddComponent(slot0.go, gohelper.Type_CanvasGroup).alpha = 1
		end

		slot0._disappearFlow:stop()

		slot0._disappearFlow = nil
	end
end

function slot0.onDestroy(slot0)
	if slot0._loader then
		slot0._loader:releaseSelf()

		slot0._loader = nil
	end

	slot0:releaseEffectFlow()

	for slot4, slot5 in ipairs(slot0._lvGOs) do
		slot0._lvImgIcons[slot4]:UnLoadImage()
	end

	slot0._tag:UnLoadImage()
end

function slot0._hideAllEffect(slot0)
	slot0:_hideUpgradeEffects()
	slot0:_hideEnchantsEffect()
end

function slot0.IsUniqueSkill(slot0)
	return FightEnum.UniqueSkillCardLv <= FightCardModel.instance:getSkillLv(slot0.entityId, slot0.skillId)
end

return slot0
