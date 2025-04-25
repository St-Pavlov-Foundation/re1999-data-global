module("modules.logic.fight.view.FightViewCardItem", package.seeall)

slot0 = class("FightViewCardItem", LuaCompBase)
slot0.TagPosForLvs = nil

function slot0.ctor(slot0, slot1)
	slot0.handCardType = slot1 or FightEnum.CardShowType.Default
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._canvasGroup = slot1:GetComponent(gohelper.Type_CanvasGroup)
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

	slot0.goTag = gohelper.findChild(slot1, "tag")
	slot0.tagCanvas = gohelper.onceAddComponent(slot0.goTag, typeof(UnityEngine.CanvasGroup))
	slot0._tagRootTr = gohelper.findChild(slot1, "tag/tag").transform
	slot0._tag = gohelper.findChildSingleImage(slot1, "tag/tag/tagIcon")
	slot0._txt = gohelper.findChildText(slot1, "Text")
	slot0._starGO = gohelper.findChild(slot1, "star")
	slot5 = UnityEngine.CanvasGroup
	slot0._starCanvas = gohelper.onceAddComponent(slot0._starGO, typeof(slot5))
	slot0._innerStartGOs = slot0:getUserDataTb_()

	for slot5 = 1, FightEnum.MaxSkillCardLv do
		slot6 = gohelper.findChild(slot1, "star/star" .. slot5)

		table.insert(slot0._innerStartGOs, slot6)
		table.insert(slot0._starItemCanvas, gohelper.onceAddComponent(slot6, typeof(UnityEngine.CanvasGroup)))
	end

	slot0._layout = gohelper.findChild(slot0.go, "layout")

	gohelper.setActive(slot0._layout, true)

	slot0._predisplay = gohelper.findChild(slot1, "layout/predisplay")
	slot5 = UnityEngine.Animator
	slot0._cardAni = gohelper.onceAddComponent(slot1, typeof(slot5))
	slot0._cardAppearEffectRoot = gohelper.findChild(slot1, "cardAppearEffectRoot")
	slot0._cardMask = gohelper.findChild(slot1, "cardmask")
	slot0._maskList = slot0:getUserDataTb_()

	for slot5 = 1, 4 do
		table.insert(slot0._maskList, gohelper.findChild(slot0._cardMask, "lv" .. slot5))
	end

	slot0._resistanceComp = MonoHelper.addLuaComOnceToGo(slot0.go, FightViewCardItemResistance, slot0)
	slot0._loader = slot0._loader or FightLoaderComponent.New()
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

	slot0.showASFD = false
	slot0.goASFD = gohelper.findChild(slot1, "asfd_icon")
	slot0.txtASFDEnergy = gohelper.findChildText(slot1, "asfd_icon/#txt_Num")
	slot0.goASFDSkill = gohelper.findChild(slot1, "asfd")
	slot0.asfdSkillSimage = gohelper.findChildSingleImage(slot1, "asfd/imgIcon")
	slot0.asfdNumTxt = gohelper.findChildText(slot1, "asfd/#txt_Num")
	slot0.goPreDelete = gohelper.findChild(slot1, "go_predelete")
	slot0.goPreDeleteNormal = gohelper.findChild(slot1, "go_predelete/normal")
	slot0.goPreDeleteUnique = gohelper.findChild(slot1, "go_predelete/ultimate")
	slot0.goPreDeleteLeft = gohelper.findChild(slot1, "go_predelete/Left")
	slot0.goPreDeleteRight = gohelper.findChild(slot1, "go_predelete/Right")
	slot0.goPreDeleteBoth = gohelper.findChild(slot1, "go_predelete/Both")

	slot0:resetPreDelete()

	slot0.goPreDeleteCard = gohelper.findChild(slot1, "go_predeletecard")

	gohelper.setActive(slot0.goPreDeleteCard, false)

	slot0.goRedAndBlue = gohelper.findChild(slot1, "#go_Liangyue")
	slot0.goLyMask = gohelper.findChild(slot1, "#go_Liangyue/mask")
	slot0.goRed = gohelper.findChild(slot1, "#go_Liangyue/red")
	slot0.goBlue = gohelper.findChild(slot1, "#go_Liangyue/green")
	slot0.goBoth = gohelper.findChild(slot1, "#go_Liangyue/both")

	slot0:resetRedAndBlue()

	slot0._heatRoot = gohelper.findChild(slot1, "#go_heat")
end

function slot0.resetPreDelete(slot0)
	gohelper.setActive(slot0.goPreDeleteNormal, false)
	gohelper.setActive(slot0.goPreDeleteUnique, false)
	gohelper.setActive(slot0.goPreDeleteLeft, false)
	gohelper.setActive(slot0.goPreDeleteRight, false)
	gohelper.setActive(slot0.goPreDeleteBoth, false)
end

function slot0.resetRedAndBlue(slot0)
	gohelper.setActive(slot0.goRedAndBlue, true)
	gohelper.setActive(slot0.goLyMask, false)
	gohelper.setActive(slot0.goRed, false)
	gohelper.setActive(slot0.goBlue, false)
	gohelper.setActive(slot0.goBoth, false)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ASFD_EmitterEnergyChange, slot0.onEmitterEnergyChange, slot0)
end

function slot0.onEmitterEnergyChange(slot0)
	if not FightHelper.isASFDSkill(slot0.skillId) then
		return
	end

	slot0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	if slot0._disappearFlow and slot0._disappearFlow.status == WorkStatus.Running then
		return
	end

	if slot0._dissolveFlow and slot0._dissolveFlow.status == WorkStatus.Running then
		return
	end

	AudioMgr.instance:trigger(20248003)

	slot0.asfdSkillAnimator = slot0.asfdSkillAnimator or slot0.goASFDSkill:GetComponent(gohelper.Type_Animator)

	slot0.asfdSkillAnimator:Play("aggrandizement", 0, 0)
end

function slot0.resetAllNode(slot0)
	for slot5 = 1, slot0.tr.childCount do
		gohelper.setActive(slot0.tr:GetChild(slot5 - 1).gameObject, false)
	end
end

function slot0.updateItem(slot0, slot1, slot2, slot3)
	slot0.entityId = slot1
	slot0.skillId = slot2
	slot0._cardInfoMO = slot3

	slot0:resetAllNode()
	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0.goTag, true)
	gohelper.setActive(slot0.goRedAndBlue, true)
	gohelper.setActive(slot0._layout, true)

	slot0._canvasGroup.alpha = 1
	slot0.tagCanvas.alpha = 1

	if FightHelper.isASFDSkill(slot2) then
		return slot0:refreshASFDSkill(slot1, slot2, slot3)
	end

	if FightHelper.isPreDeleteSkill(slot2) then
		return slot0:refreshPreDeleteSkill(slot1, slot2, slot3)
	end

	slot0:_hideAniEffect()

	slot4 = lua_skill.configDict[slot2]

	for slot9, slot10 in ipairs(slot0._lvGOs) do
		gohelper.setActive(slot10, true)
		gohelper.setActiveCanvasGroup(slot10, FightCardModel.instance:getSkillLv(slot1, slot2) == slot9)
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

	slot0:refreshTag()

	slot0._txt.text = slot4.id .. "\nLv." .. slot5

	if FightCardModel.instance:isUniqueSkill(slot0.entityId, slot0.skillId) then
		if not slot0._uniqueCardEffect then
			slot6 = ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka)
			slot0._uniqueCardEffect = gohelper.clone(FightHelper.getPreloadAssetItem(slot6):GetResource(slot6), slot0.go)
		end

		gohelper.setActive(slot0._uniqueCardEffect, true)
	elseif slot0._uniqueCardEffect then
		gohelper.setActive(slot0._uniqueCardEffect, false)
	end

	gohelper.setActive(slot0._predisplay, slot0._cardInfoMO and slot0._cardInfoMO.tempCard)
	slot0:_showUpgradeEffect()
	slot0:_showEnchantsEffect()
	slot0:_refreshGray()
	slot0:_refreshASFD()
	slot0:_refreshPreDeleteArrow()
	slot0:showCardHeat()
end

function slot0.refreshTag(slot0)
	slot0._tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. lua_skill.configDict[slot0.skillId].showTag))

	if uv0.TagPosForLvs[FightCardModel.instance:getSkillLv(slot0.entityId, slot0.skillId)] then
		recthelper.setAnchor(slot0._tagRootTr, slot3[1], slot3[2])
	end

	gohelper.setActive(slot0._tag.gameObject, slot2 < FightEnum.UniqueSkillCardLv)
end

function slot0.showCardHeat(slot0)
	if slot0._cardInfoMO and slot0._cardInfoMO.heatId and slot0._cardInfoMO.heatId ~= 0 then
		slot0:setHeatRootVisible(true)

		if slot0._heatObj then
			slot0:_refreshCardHeat()
		elseif not slot0._loadHeat then
			slot0._loadHeat = true

			slot0._loader:loadAsset("ui/viewres/fight/fightheatview.prefab", slot0._onHeatLoadFinish, slot0)
		end
	else
		slot0:setHeatRootVisible(false)
	end
end

function slot0.setHeatRootVisible(slot0, slot1)
	gohelper.setActive(slot0._heatRoot, slot1)
end

function slot0._refreshCardHeat(slot0)
	if slot0._cardInfoMO and slot0._cardInfoMO.heatId ~= 0 then
		if FightDataHelper.teamDataMgr.myData.cardHeat.values[slot0._cardInfoMO.heatId] then
			slot0._heatText.text = Mathf.Clamp(slot3.value + (FightDataHelper.teamDataMgr.myCardHeatOffset[slot1] or 0), slot3.lowerLimit, slot3.upperLimit)
		else
			slot0._heatText.text = ""
		end
	end
end

function slot0._onHeatLoadFinish(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._heatObj = gohelper.clone(slot2:GetResource(), slot0._heatRoot)
	slot0._heatText = gohelper.findChildText(slot0._heatObj, "heatText")

	slot0:_refreshCardHeat()
end

function slot0._refreshPreDeleteArrow(slot0)
	slot1 = slot0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(slot0.goPreDelete, slot1)

	if slot1 then
		gohelper.setActive(slot0.goPreDeleteBoth, false)
		gohelper.setActive(slot0.goPreDeleteLeft, false)
		gohelper.setActive(slot0.goPreDeleteRight, false)

		slot2 = slot0._cardInfoMO and slot0._cardInfoMO.skillId

		if slot2 and lua_fight_card_pre_delete.configDict[slot2] then
			if slot3.left > 0 and slot3.right > 0 then
				gohelper.setActive(slot0.goPreDeleteBoth, true)
			elseif slot4 then
				gohelper.setActive(slot0.goPreDeleteLeft, true)
			elseif slot5 then
				gohelper.setActive(slot0.goPreDeleteRight, true)
			end

			gohelper.setActive(slot0._starGO, false)
		end
	end
end

function slot0._refreshPreDeleteImage(slot0, slot1)
	slot2 = slot0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(slot0.goPreDelete, slot2)

	if slot2 then
		gohelper.setActive(slot0.goPreDeleteNormal, not FightCardModel.instance:isUniqueSkill(slot0.entityId, slot0.skillId) and slot1)
		gohelper.setActive(slot0.goPreDeleteUnique, slot3 and slot1)
	end
end

function slot0.refreshPreDeleteSkill(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0.goPreDeleteCard, true)
	gohelper.setActive(slot0.goPreDeleteNormal, false)
	gohelper.setActive(slot0.goPreDeleteUnique, false)
	slot0:refreshTag()
	slot0:_refreshPreDeleteArrow()
end

function slot0.refreshASFDSkill(slot0, slot1, slot2, slot3)
	for slot8 = 1, slot0.tr.childCount do
		gohelper.setActive(slot0.tr:GetChild(slot8 - 1).gameObject, false)
	end

	gohelper.setActive(slot0.goASFDSkill, true)
	gohelper.setActive(slot0.goTag, true)
	slot0.asfdSkillSimage:LoadImage(ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon))

	slot0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	slot0._tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

	slot6 = uv0.TagPosForLvs[1]

	recthelper.setAnchor(slot0._tagRootTr, slot6[1], slot6[2])
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
	[FightEnum.EnchantedType.Chaos] = "ui/viewres/fight/card_chaos.prefab",
	[FightEnum.EnchantedType.depresse] = "ui/viewres/fight/card_qmyj.prefab"
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

function slot0._onEnchantEffectLoaded(slot0, slot1, slot2)
end

function slot0._onEnchantEffectsLoaded(slot0)
	for slot4, slot5 in pairs(uv0) do
		if not slot0._enchantsEffect[slot4] and slot0._loader:getAssetItem(slot5) then
			slot7 = slot6:GetResource()

			if slot0._lvGOs then
				slot0._enchantsEffect[slot4] = slot0:getUserDataTb_()

				for slot11, slot12 in ipairs(slot0._lvGOs) do
					slot17 = "#cardeffect"
					slot13 = gohelper.clone(slot7, gohelper.findChild(slot12, slot17))

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

function slot0._onUpgradeEffectLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0._upgradeEffects then
		return
	end

	slot0._upgradeEffects = slot0:getUserDataTb_()

	if slot0._lvGOs and slot2:GetResource() then
		for slot7, slot8 in ipairs(slot0._lvGOs) do
			slot13 = "#cardeffect"
			slot9 = gohelper.clone(slot3, gohelper.findChild(slot8, slot13))

			for slot13 = 1, 4 do
				gohelper.setActive(gohelper.findChild(slot9, "lv" .. slot13), slot13 == slot7)
			end

			table.insert(slot0._upgradeEffects, slot9)
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

	if FightHelper.isASFDSkill(slot0.skillId) then
		return slot0:disappearCard()
	end

	if FightHelper.isPreDeleteSkill(slot0.skillId) then
		return slot0:disappearCard()
	end

	slot0:setASFDActive(false)
	slot0:revertASFDSkillAnimator()

	slot2 = slot0:getUserDataTb_()
	slot2.dissolveScale = slot1 or 1
	slot3 = slot0:getUserDataTb_()

	table.insert(slot3, slot0.go)

	slot2.dissolveSkillItemGOs = slot3

	if not slot0._dissolveFlow then
		slot0._dissolveFlow = FlowSequence.New()

		slot0._dissolveFlow:addWork(FightCardDissolveEffect.New())
	else
		slot0._dissolveFlow:stop()
	end

	slot0:_hideAllEffect()
	slot0._dissolveFlow:start(slot2)
end

function slot0.disappearCard(slot0)
	if not slot0.go.activeInHierarchy then
		return
	end

	slot0:setASFDActive(false)
	slot0:revertASFDSkillAnimator()

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

function slot0.revertASFDSkillAnimator(slot0)
	if not FightHelper.isASFDSkill(slot0.skillId) then
		return
	end

	if slot0.asfdSkillAnimator then
		slot0.asfdSkillAnimator:Play("open", 0, 0)
	end
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
		slot4 = FightCardModel.instance:isUniqueSkill(slot1, slot2)

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

function slot0.setASFDActive(slot0, slot1)
	slot0.showASFD = slot1

	slot0:_refreshASFD()
end

function slot0._refreshASFD(slot0)
	slot1 = slot0.showASFD and slot0._cardInfoMO and slot0._cardInfoMO.energy > 0

	gohelper.setActive(slot0.goASFD, slot1)

	if slot1 then
		slot0.txtASFDEnergy.text = slot0._cardInfoMO.energy
	end
end

function slot0._allocateEnergyDone(slot0)
	slot1 = slot0.showASFD and slot0._cardInfoMO and slot0._cardInfoMO.energy > 0

	gohelper.setActive(slot0.goASFD, slot1)

	if slot1 then
		slot0.txtASFDEnergy.text = slot0._cardInfoMO.energy
		slot0.asfdAnimator = slot0.asfdAnimator or slot0.goASFD:GetComponent(gohelper.Type_Animator)

		slot0.asfdAnimator:Play("open", 0, 0)
	end
end

function slot0.playASFDAnim(slot0, slot1)
	if slot0.goASFD.activeSelf then
		slot0.asfdAnimator = slot0.asfdAnimator or slot0.goASFD:GetComponent(gohelper.Type_Animator)

		slot0.asfdAnimator:Play(slot1, 0, 0)
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

function slot0._onCardAniLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not slot0._cardAniName then
		slot0:_hideAniEffect()

		return
	end

	slot0._cardAni.runtimeAnimatorController = slot2:GetResource()
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

function slot0._onAppearEffectLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._appearEffect = gohelper.clone(slot2:GetResource(), slot0._cardAppearEffectRoot)

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

function slot0.getASFDScreenPos(slot0)
	slot0.rectTrASFD = slot0.rectTrASFD or slot0.goASFD:GetComponent(gohelper.Type_RectTransform)

	return recthelper.uiPosToScreenPos2(slot0.rectTrASFD)
end

function slot0.setActiveRed(slot0, slot1)
	gohelper.setActive(slot0.goRed, slot1)
	slot0:refreshLyMaskActive()
end

function slot0.setActiveBlue(slot0, slot1)
	gohelper.setActive(slot0.goBlue, slot1)
	slot0:refreshLyMaskActive()
end

function slot0.setActiveBoth(slot0, slot1)
	gohelper.setActive(slot0.goBoth, slot1)
	slot0:refreshLyMaskActive()
end

function slot0.refreshLyMaskActive(slot0)
	gohelper.setActive(slot0.goLyMask, slot0.goRed.activeInHierarchy or slot0.goBlue.activeInHierarchy or slot0.goBoth.activeInHierarchy)
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
		slot0._loader:disposeSelf()

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
	gohelper.setActive(slot0.goPreDelete, false)
end

function slot0.IsUniqueSkill(slot0)
	return FightEnum.UniqueSkillCardLv <= FightCardModel.instance:getSkillLv(slot0.entityId, slot0.skillId)
end

return slot0
