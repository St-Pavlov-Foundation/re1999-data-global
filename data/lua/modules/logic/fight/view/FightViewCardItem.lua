module("modules.logic.fight.view.FightViewCardItem", package.seeall)

local var_0_0 = class("FightViewCardItem", LuaCompBase)

var_0_0.TagPosForLvs = nil

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.handCardType = arg_1_1 or FightEnum.CardShowType.Default
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._canvasGroup = arg_2_1:GetComponent(gohelper.Type_CanvasGroup)
	arg_2_0.tr = arg_2_1.transform
	arg_2_0._lvGOs = arg_2_0:getUserDataTb_()
	arg_2_0._lvImgIcons = arg_2_0:getUserDataTb_()
	arg_2_0._lvImgComps = arg_2_0:getUserDataTb_()
	arg_2_0._starItemCanvas = arg_2_0:getUserDataTb_()

	for iter_2_0 = 0, 4 do
		local var_2_0 = gohelper.findChild(arg_2_1, "lv" .. iter_2_0)
		local var_2_1 = gohelper.findChildSingleImage(var_2_0, "imgIcon")
		local var_2_2 = gohelper.findChildImage(var_2_0, "imgIcon")

		gohelper.setActive(var_2_0, true)

		arg_2_0._lvGOs[iter_2_0] = var_2_0
		arg_2_0._lvImgIcons[iter_2_0] = var_2_1
		arg_2_0._lvImgComps[iter_2_0] = var_2_2
	end

	if not var_0_0.TagPosForLvs then
		var_0_0.TagPosForLvs = {}

		for iter_2_1 = 0, 4 do
			local var_2_3, var_2_4 = recthelper.getAnchor(gohelper.findChild(arg_2_1, "tag/pos" .. iter_2_1).transform)

			var_0_0.TagPosForLvs[iter_2_1] = {
				var_2_3,
				var_2_4
			}
		end
	end

	arg_2_0.goTag = gohelper.findChild(arg_2_1, "tag")
	arg_2_0.tagCanvas = gohelper.onceAddComponent(arg_2_0.goTag, typeof(UnityEngine.CanvasGroup))
	arg_2_0._tagRootTr = gohelper.findChild(arg_2_1, "tag/tag").transform
	arg_2_0._tag = gohelper.findChildSingleImage(arg_2_1, "tag/tag/tagIcon")
	arg_2_0._txt = gohelper.findChildText(arg_2_1, "Text")
	arg_2_0._starGO = gohelper.findChild(arg_2_1, "star")
	arg_2_0._starCanvas = gohelper.onceAddComponent(arg_2_0._starGO, typeof(UnityEngine.CanvasGroup))
	arg_2_0._innerStartGOs = arg_2_0:getUserDataTb_()

	for iter_2_2 = 1, FightEnum.MaxSkillCardLv do
		local var_2_5 = gohelper.findChild(arg_2_1, "star/star" .. iter_2_2)

		table.insert(arg_2_0._innerStartGOs, var_2_5)
		table.insert(arg_2_0._starItemCanvas, gohelper.onceAddComponent(var_2_5, typeof(UnityEngine.CanvasGroup)))
	end

	arg_2_0._layout = gohelper.findChild(arg_2_0.go, "layout")

	gohelper.setActive(arg_2_0._layout, true)

	arg_2_0._predisplay = gohelper.findChild(arg_2_1, "layout/predisplay")
	arg_2_0._cardAni = gohelper.onceAddComponent(arg_2_1, typeof(UnityEngine.Animator))
	arg_2_0._cardAppearEffectRoot = gohelper.findChild(arg_2_1, "cardAppearEffectRoot")
	arg_2_0._cardMask = gohelper.findChild(arg_2_1, "cardmask")
	arg_2_0._maskList = arg_2_0:getUserDataTb_()

	for iter_2_3 = 1, 4 do
		table.insert(arg_2_0._maskList, gohelper.findChild(arg_2_0._cardMask, "lv" .. iter_2_3))
	end

	arg_2_0._resistanceComp = MonoHelper.addLuaComOnceToGo(arg_2_0.go, FightViewCardItemResistance, arg_2_0)
	arg_2_0._loader = arg_2_0._loader or FightLoaderComponent.New()
	arg_2_0._countRoot = gohelper.findChild(arg_2_0.go, "layout/count")
	arg_2_0._countText = gohelper.findChildText(arg_2_0.go, "layout/count/#txt_count")

	gohelper.setActive(arg_2_0._countRoot, false)

	arg_2_0._abandon = gohelper.findChild(arg_2_0.go, "layout/abandon")

	gohelper.setActive(arg_2_0._abandon, false)

	arg_2_0._blockadeTwo = gohelper.findChild(arg_2_0.go, "#go_enchant_effect")

	gohelper.setActive(arg_2_0._blockadeTwo, false)

	arg_2_0._blockadeOne = gohelper.findChild(arg_2_0.go, "#go_enchant_uneffect")

	gohelper.setActive(arg_2_0._blockadeOne, false)

	arg_2_0._precision = gohelper.findChild(arg_2_0.go, "AccurateEnchant")

	gohelper.setActive(arg_2_0._precision, false)

	arg_2_0._precisionEffect = gohelper.findChild(arg_2_0.go, "AccurateEnchant/effect")

	gohelper.setActive(arg_2_0._precisionEffect, false)

	arg_2_0.showASFD = false
	arg_2_0.goASFD = gohelper.findChild(arg_2_1, "asfd_icon")
	arg_2_0.txtASFDEnergy = gohelper.findChildText(arg_2_1, "asfd_icon/#txt_Num")
	arg_2_0.goASFDSkill = gohelper.findChild(arg_2_1, "asfd")
	arg_2_0.asfdSkillSimage = gohelper.findChildSingleImage(arg_2_1, "asfd/imgIcon")
	arg_2_0.asfdNumTxt = gohelper.findChildText(arg_2_1, "asfd/#txt_Num")
	arg_2_0.goPreDelete = gohelper.findChild(arg_2_1, "go_predelete")
	arg_2_0.goPreDeleteNormal = gohelper.findChild(arg_2_1, "go_predelete/normal")
	arg_2_0.goPreDeleteUnique = gohelper.findChild(arg_2_1, "go_predelete/ultimate")
	arg_2_0.goPreDeleteLeft = gohelper.findChild(arg_2_1, "go_predelete/Left")
	arg_2_0.goPreDeleteRight = gohelper.findChild(arg_2_1, "go_predelete/Right")
	arg_2_0.goPreDeleteBoth = gohelper.findChild(arg_2_1, "go_predelete/Both")

	arg_2_0:resetPreDelete()

	arg_2_0.goPreDeleteCard = gohelper.findChild(arg_2_1, "go_predeletecard")

	gohelper.setActive(arg_2_0.goPreDeleteCard, false)

	arg_2_0.goRedAndBlue = gohelper.findChild(arg_2_1, "#go_Liangyue")
	arg_2_0.goLyMask = gohelper.findChild(arg_2_1, "#go_Liangyue/mask")
	arg_2_0.goRed = gohelper.findChild(arg_2_1, "#go_Liangyue/red")
	arg_2_0.goBlue = gohelper.findChild(arg_2_1, "#go_Liangyue/green")
	arg_2_0.goBoth = gohelper.findChild(arg_2_1, "#go_Liangyue/both")

	arg_2_0:resetRedAndBlue()

	arg_2_0._heatRoot = gohelper.findChild(arg_2_1, "#go_heat")
	arg_2_0.goBloodPool = gohelper.findChild(arg_2_1, "blood_pool")
	arg_2_0.alfLoadStatus = var_0_0.AlfLoadStatus.None
end

function var_0_0.resetPreDelete(arg_3_0)
	gohelper.setActive(arg_3_0.goPreDeleteNormal, false)
	gohelper.setActive(arg_3_0.goPreDeleteUnique, false)
	gohelper.setActive(arg_3_0.goPreDeleteLeft, false)
	gohelper.setActive(arg_3_0.goPreDeleteRight, false)
	gohelper.setActive(arg_3_0.goPreDeleteBoth, false)
end

function var_0_0.resetRedAndBlue(arg_4_0)
	gohelper.setActive(arg_4_0.goRedAndBlue, true)
	gohelper.setActive(arg_4_0.goLyMask, false)
	gohelper.setActive(arg_4_0.goRed, false)
	gohelper.setActive(arg_4_0.goBlue, false)
	gohelper.setActive(arg_4_0.goBoth, false)
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.ASFD_EmitterEnergyChange, arg_5_0.onEmitterEnergyChange, arg_5_0)
end

function var_0_0.onEmitterEnergyChange(arg_6_0)
	if not FightHelper.isASFDSkill(arg_6_0.skillId) then
		return
	end

	arg_6_0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	if arg_6_0._disappearFlow and arg_6_0._disappearFlow.status == WorkStatus.Running then
		return
	end

	if arg_6_0._dissolveFlow and arg_6_0._dissolveFlow.status == WorkStatus.Running then
		return
	end

	AudioMgr.instance:trigger(20248003)

	arg_6_0.asfdSkillAnimator = arg_6_0.asfdSkillAnimator or arg_6_0.goASFDSkill:GetComponent(gohelper.Type_Animator)

	arg_6_0.asfdSkillAnimator:Play("aggrandizement", 0, 0)
end

function var_0_0.resetAllNode(arg_7_0)
	local var_7_0 = arg_7_0.tr.childCount

	for iter_7_0 = 1, var_7_0 do
		local var_7_1 = arg_7_0.tr:GetChild(iter_7_0 - 1)

		gohelper.setActive(var_7_1.gameObject, false)
	end
end

function var_0_0.updateItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.entityId = arg_8_1
	arg_8_0.skillId = arg_8_2
	arg_8_0._cardInfoMO = arg_8_3

	arg_8_0:resetAllNode()
	gohelper.setActive(arg_8_0.go, true)
	gohelper.setActive(arg_8_0.goTag, true)
	gohelper.setActive(arg_8_0.goRedAndBlue, true)
	gohelper.setActive(arg_8_0._layout, true)

	arg_8_0._canvasGroup.alpha = 1
	arg_8_0.tagCanvas.alpha = 1

	if FightHelper.isBloodPoolSkill(arg_8_2) then
		return arg_8_0:refreshBloodPoolSkill(arg_8_1, arg_8_2, arg_8_3)
	end

	if FightHelper.isASFDSkill(arg_8_2) then
		return arg_8_0:refreshASFDSkill(arg_8_1, arg_8_2, arg_8_3)
	end

	if FightHelper.isPreDeleteSkill(arg_8_2) then
		return arg_8_0:refreshPreDeleteSkill(arg_8_1, arg_8_2, arg_8_3)
	end

	arg_8_0:_hideAniEffect()

	local var_8_0 = lua_skill.configDict[arg_8_2]
	local var_8_1 = FightCardDataHelper.getSkillLv(arg_8_1, arg_8_2)

	for iter_8_0, iter_8_1 in pairs(arg_8_0._lvGOs) do
		gohelper.setActive(iter_8_1, true)
		gohelper.setActiveCanvasGroup(iter_8_1, var_8_1 == iter_8_0)
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0._lvImgIcons) do
		local var_8_2 = ResUrl.getSkillIcon(var_8_0.icon)

		if gohelper.isNil(arg_8_0._lvImgComps[iter_8_2].sprite) then
			iter_8_3:UnLoadImage()
		elseif iter_8_3.curImageUrl ~= var_8_2 then
			iter_8_3:UnLoadImage()
		end

		iter_8_3:LoadImage(var_8_2)
	end

	local var_8_3 = var_8_1 < FightEnum.UniqueSkillCardLv and var_8_1 > 0

	gohelper.setActive(arg_8_0._starGO, var_8_3)

	arg_8_0._starCanvas.alpha = 1

	for iter_8_4, iter_8_5 in ipairs(arg_8_0._innerStartGOs) do
		gohelper.setActive(iter_8_5, iter_8_4 == var_8_1)

		if arg_8_0._starItemCanvas[iter_8_4] then
			arg_8_0._starItemCanvas[iter_8_4].alpha = 1
		end
	end

	arg_8_0:refreshTag()

	arg_8_0._txt.text = var_8_0.id .. "\nLv." .. var_8_1

	if var_8_1 == FightEnum.UniqueSkillCardLv then
		if not arg_8_0._uniqueCardEffect then
			local var_8_4 = ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka)
			local var_8_5 = FightHelper.getPreloadAssetItem(var_8_4)

			arg_8_0._uniqueCardEffect = gohelper.clone(var_8_5:GetResource(var_8_4), arg_8_0.go)
		end

		gohelper.setActive(arg_8_0._uniqueCardEffect, true)
	elseif arg_8_0._uniqueCardEffect then
		gohelper.setActive(arg_8_0._uniqueCardEffect, false)
	end

	gohelper.setActive(arg_8_0._predisplay, arg_8_0._cardInfoMO and arg_8_0._cardInfoMO.tempCard)
	arg_8_0:_showUpgradeEffect()
	arg_8_0:_showEnchantsEffect()
	arg_8_0:_refreshGray()
	arg_8_0:_refreshASFD()
	arg_8_0:_refreshPreDeleteArrow()
	arg_8_0:showCardHeat()
end

function var_0_0.refreshTag(arg_9_0)
	local var_9_0 = lua_skill.configDict[arg_9_0.skillId]
	local var_9_1 = FightCardDataHelper.getSkillLv(arg_9_0.entityId, arg_9_0.skillId)

	arg_9_0._tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_9_0.showTag))

	local var_9_2 = var_0_0.TagPosForLvs[var_9_1]

	if var_9_2 then
		recthelper.setAnchor(arg_9_0._tagRootTr, var_9_2[1], var_9_2[2])
	end

	gohelper.setActive(arg_9_0._tag.gameObject, var_9_1 < FightEnum.UniqueSkillCardLv)
end

function var_0_0.showCardHeat(arg_10_0)
	if arg_10_0._cardInfoMO and arg_10_0._cardInfoMO.heatId and arg_10_0._cardInfoMO.heatId ~= 0 then
		arg_10_0:setHeatRootVisible(true)

		if arg_10_0._heatObj then
			arg_10_0:_refreshCardHeat()
		elseif not arg_10_0._loadHeat then
			arg_10_0._loadHeat = true

			arg_10_0._loader:loadAsset("ui/viewres/fight/fightheatview.prefab", arg_10_0._onHeatLoadFinish, arg_10_0)
		end
	else
		arg_10_0:setHeatRootVisible(false)
	end
end

function var_0_0.setHeatRootVisible(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._heatRoot, arg_11_1)
end

function var_0_0._refreshCardHeat(arg_12_0)
	if arg_12_0._cardInfoMO and arg_12_0._cardInfoMO.heatId ~= 0 then
		local var_12_0 = arg_12_0._cardInfoMO.heatId
		local var_12_1 = FightDataHelper.teamDataMgr.myData.cardHeat.values[var_12_0]

		if var_12_1 then
			local var_12_2 = FightDataHelper.teamDataMgr.myCardHeatOffset[var_12_0] or 0

			arg_12_0._heatText.text = Mathf.Clamp(var_12_1.value + var_12_2, var_12_1.lowerLimit, var_12_1.upperLimit)
		else
			arg_12_0._heatText.text = ""
		end
	end
end

function var_0_0._onHeatLoadFinish(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1 then
		return
	end

	arg_13_0._heatObj = gohelper.clone(arg_13_2:GetResource(), arg_13_0._heatRoot)
	arg_13_0._heatText = gohelper.findChildText(arg_13_0._heatObj, "heatText")

	arg_13_0:_refreshCardHeat()
end

function var_0_0._refreshPreDeleteArrow(arg_14_0)
	local var_14_0 = arg_14_0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(arg_14_0.goPreDelete, var_14_0)

	if var_14_0 then
		gohelper.setActive(arg_14_0.goPreDeleteBoth, false)
		gohelper.setActive(arg_14_0.goPreDeleteLeft, false)
		gohelper.setActive(arg_14_0.goPreDeleteRight, false)

		local var_14_1 = lua_fight_card_pre_delete.configDict[arg_14_0.skillId]

		if var_14_1 then
			local var_14_2 = var_14_1.left > 0
			local var_14_3 = var_14_1.right > 0

			if var_14_2 and var_14_3 then
				gohelper.setActive(arg_14_0.goPreDeleteBoth, true)
			elseif var_14_2 then
				gohelper.setActive(arg_14_0.goPreDeleteLeft, true)
			elseif var_14_3 then
				gohelper.setActive(arg_14_0.goPreDeleteRight, true)
			end

			gohelper.setActive(arg_14_0._starGO, false)
		end
	end
end

function var_0_0._refreshPreDeleteImage(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(arg_15_0.goPreDelete, var_15_0)

	if var_15_0 then
		local var_15_1 = FightCardDataHelper.isBigSkill(arg_15_0.skillId)

		gohelper.setActive(arg_15_0.goPreDeleteNormal, not var_15_1 and arg_15_1)
		gohelper.setActive(arg_15_0.goPreDeleteUnique, var_15_1 and arg_15_1)
	end
end

function var_0_0.refreshPreDeleteSkill(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	gohelper.setActive(arg_16_0.goPreDeleteCard, true)
	gohelper.setActive(arg_16_0.goPreDeleteNormal, false)
	gohelper.setActive(arg_16_0.goPreDeleteUnique, false)
	arg_16_0:refreshTag()
	arg_16_0:_refreshPreDeleteArrow()
end

function var_0_0.refreshBloodPoolSkill(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	gohelper.setActive(arg_17_0.goBloodPool, true)
	gohelper.setActive(arg_17_0.goTag, true)
	gohelper.setActive(arg_17_0._tag.gameObject, true)

	arg_17_0.bloodPoolAnimator = arg_17_0.bloodPoolAnimator or arg_17_0.goBloodPool:GetComponent(gohelper.Type_Animator)

	if arg_17_0.handCardType == FightEnum.CardShowType.Operation then
		arg_17_0.bloodPoolAnimator:Play("open", 0, 0)
		AudioMgr.instance:trigger(20270007)
	else
		arg_17_0.bloodPoolAnimator:Play("open", 0, 1)
	end

	arg_17_0._tag:LoadImage(ResUrl.getAttributeIcon("blood_tex2"))

	local var_17_0 = var_0_0.TagPosForLvs[1]

	recthelper.setAnchor(arg_17_0._tagRootTr, var_17_0[1], var_17_0[2])
end

function var_0_0.refreshASFDSkill(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	gohelper.setActive(arg_18_0.goASFDSkill, true)
	gohelper.setActive(arg_18_0.goTag, true)
	gohelper.setActive(arg_18_0._tag.gameObject, true)

	local var_18_0 = ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon)

	arg_18_0.asfdSkillSimage:LoadImage(var_18_0)

	arg_18_0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	arg_18_0._tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

	local var_18_1 = var_0_0.TagPosForLvs[1]

	recthelper.setAnchor(arg_18_0._tagRootTr, var_18_1[1], var_18_1[2])
end

function var_0_0.updateResistanceByCardInfo(arg_19_0, arg_19_1)
	arg_19_0._resistanceComp:updateByCardInfo(arg_19_1)
end

function var_0_0.updateResistanceByBeginRoundOp(arg_20_0, arg_20_1)
	arg_20_0._resistanceComp:updateByBeginRoundOp(arg_20_1)
end

function var_0_0.updateResistanceBySkillDisplayMo(arg_21_0, arg_21_1)
	arg_21_0._resistanceComp:updateBySkillDisplayMo(arg_21_1)
end

function var_0_0.detectShowBlueStar(arg_22_0)
	local var_22_0 = arg_22_0.entityId and arg_22_0.skillId and FightCardDataHelper.getSkillLv(arg_22_0.entityId, arg_22_0.skillId)

	arg_22_0:showBlueStar(var_22_0)
end

function var_0_0.showBlueStar(arg_23_0, arg_23_1)
	if arg_23_0._lightBlueObj then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._lightBlueObj) do
			gohelper.setActive(iter_23_1.blue, false)
			gohelper.setActive(iter_23_1.dark, true)
		end
	else
		arg_23_0._lightBlueObj = {}
		arg_23_0._lightBlueObj[1] = arg_23_0:getUserDataTb_()
		arg_23_0._lightBlueObj[1].blue = gohelper.findChild(arg_23_0._innerStartGOs[1], "lightblue")
		arg_23_0._lightBlueObj[1].dark = gohelper.findChild(arg_23_0._innerStartGOs[1], "dark2")
		arg_23_0._lightBlueObj[2] = arg_23_0:getUserDataTb_()
		arg_23_0._lightBlueObj[2].blue = gohelper.findChild(arg_23_0._innerStartGOs[2], "lightblue")
		arg_23_0._lightBlueObj[2].dark = gohelper.findChild(arg_23_0._innerStartGOs[2], "dark3")
	end

	if arg_23_1 == 1 or arg_23_1 == 2 then
		local var_23_0 = FightDataHelper.entityMgr:getById(arg_23_0.entityId)

		if var_23_0 and var_23_0:hasBuffFeature(FightEnum.BuffFeature.SkillLevelJudgeAdd) then
			local var_23_1 = arg_23_0._lightBlueObj[arg_23_1]

			gohelper.setActive(var_23_1.blue, true)
			gohelper.setActive(var_23_1.dark, false)
		end
	end
end

function var_0_0.showPrecisionEffect(arg_24_0)
	gohelper.setActive(arg_24_0._precisionEffect, true)
end

function var_0_0.hidePrecisionEffect(arg_25_0)
	gohelper.setActive(arg_25_0._precisionEffect, false)
end

local var_0_1 = {
	[FightEnum.EnchantedType.Frozen] = "ui/viewres/fight/card_freeze.prefab",
	[FightEnum.EnchantedType.Burn] = "ui/viewres/fight/card_flaring.prefab",
	[FightEnum.EnchantedType.Chaos] = "ui/viewres/fight/card_chaos.prefab",
	[FightEnum.EnchantedType.depresse] = "ui/viewres/fight/card_qmyj.prefab"
}

function var_0_0._showEnchantsEffect(arg_26_0)
	gohelper.setActive(arg_26_0._abandon, false)
	gohelper.setActive(arg_26_0._blockadeTwo, false)
	gohelper.setActive(arg_26_0._blockadeOne, false)
	gohelper.setActive(arg_26_0._precision, false)
	gohelper.setActive(arg_26_0._precisionEffect, false)

	if not arg_26_0._cardInfoMO then
		return
	end

	local var_26_0 = arg_26_0:_refreshEnchantEffectActive()

	if #var_26_0 > 0 then
		arg_26_0._loader:loadListAsset(var_26_0, arg_26_0._onEnchantEffectLoaded, arg_26_0._onEnchantEffectsLoaded, arg_26_0)
	end

	if arg_26_0._cardInfoMO.enchants then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._cardInfoMO.enchants) do
			if iter_26_1.enchantId == FightEnum.EnchantedType.Discard then
				gohelper.setActive(arg_26_0._abandon, true)
			elseif iter_26_1.enchantId == FightEnum.EnchantedType.Blockade then
				local var_26_1 = FightDataHelper.handCardMgr.handCard

				if arg_26_0._cardInfoMO.clientData.custom_playedCard then
					gohelper.setActive(arg_26_0._blockadeOne, true)
				elseif arg_26_0._cardInfoMO.clientData.custom_handCardIndex then
					if arg_26_0._cardInfoMO.clientData.custom_handCardIndex == 1 or arg_26_0._cardInfoMO.clientData.custom_handCardIndex == #var_26_1 then
						gohelper.setActive(arg_26_0._blockadeOne, true)
					else
						gohelper.setActive(arg_26_0._blockadeTwo, true)
					end
				else
					gohelper.setActive(arg_26_0._blockadeOne, true)
				end
			elseif iter_26_1.enchantId == FightEnum.EnchantedType.Precision then
				gohelper.setActive(arg_26_0._precision, true)

				if arg_26_0._cardInfoMO.clientData.custom_handCardIndex == 1 then
					FightController.instance:dispatchEvent(FightEvent.RefreshHandCardPrecisionEffect)
				end
			end
		end
	end
end

function var_0_0._refreshEnchantEffectActive(arg_27_0)
	arg_27_0:_hideEnchantsEffect()

	arg_27_0._enchantsEffect = arg_27_0._enchantsEffect or {}

	local var_27_0 = arg_27_0._cardInfoMO.enchants or {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_2 = iter_27_1.enchantId

		if arg_27_0._enchantsEffect[var_27_2] then
			for iter_27_2, iter_27_3 in ipairs(arg_27_0._enchantsEffect[var_27_2]) do
				gohelper.setActive(iter_27_3, true)
			end
		else
			local var_27_3 = var_0_1[var_27_2]

			if var_27_3 then
				table.insert(var_27_1, var_27_3)
			end
		end
	end

	return var_27_1
end

function var_0_0._hideEnchantsEffect(arg_28_0)
	if arg_28_0._enchantsEffect then
		for iter_28_0, iter_28_1 in pairs(arg_28_0._enchantsEffect) do
			for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
				gohelper.setActive(iter_28_3, false)
			end
		end
	end
end

function var_0_0._onEnchantEffectLoaded(arg_29_0, arg_29_1, arg_29_2)
	return
end

function var_0_0._onEnchantEffectsLoaded(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(var_0_1) do
		if not arg_30_0._enchantsEffect[iter_30_0] then
			local var_30_0 = arg_30_0._loader:getAssetItem(iter_30_1)

			if var_30_0 then
				local var_30_1 = var_30_0:GetResource()

				if arg_30_0._lvGOs then
					arg_30_0._enchantsEffect[iter_30_0] = arg_30_0:getUserDataTb_()

					for iter_30_2, iter_30_3 in pairs(arg_30_0._lvGOs) do
						local var_30_2 = gohelper.clone(var_30_1, gohelper.findChild(iter_30_3, "#cardeffect"))

						for iter_30_4 = 0, 4 do
							local var_30_3 = gohelper.findChild(var_30_2, "lv" .. iter_30_4)

							gohelper.setActive(var_30_3, iter_30_4 == iter_30_2)
						end

						table.insert(arg_30_0._enchantsEffect[iter_30_0], var_30_2)
					end
				end
			end
		end
	end

	arg_30_0:_refreshEnchantEffectActive()
end

function var_0_0._showUpgradeEffect(arg_31_0)
	if lua_fight_upgrade_show_skillid.configDict[arg_31_0.skillId] then
		if not arg_31_0._upgradeEffects then
			arg_31_0._loader:loadAsset("ui/viewres/fight/card_aggrandizement.prefab", arg_31_0._onUpgradeEffectLoaded, arg_31_0)

			return
		end

		for iter_31_0, iter_31_1 in ipairs(arg_31_0._upgradeEffects) do
			gohelper.setActive(iter_31_1, false)
			gohelper.setActive(iter_31_1, true)
		end
	else
		arg_31_0:_hideUpgradeEffects()
	end
end

function var_0_0._hideUpgradeEffects(arg_32_0)
	if arg_32_0._upgradeEffects then
		for iter_32_0, iter_32_1 in ipairs(arg_32_0._upgradeEffects) do
			gohelper.setActive(iter_32_1, false)
		end
	end
end

function var_0_0._onUpgradeEffectLoaded(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1 then
		return
	end

	if arg_33_0._upgradeEffects then
		return
	end

	arg_33_0._upgradeEffects = arg_33_0:getUserDataTb_()

	local var_33_0 = arg_33_2:GetResource()

	if arg_33_0._lvGOs and var_33_0 then
		for iter_33_0, iter_33_1 in pairs(arg_33_0._lvGOs) do
			local var_33_1 = gohelper.clone(var_33_0, gohelper.findChild(iter_33_1, "#cardeffect"))

			for iter_33_2 = 0, 4 do
				local var_33_2 = gohelper.findChild(var_33_1, "lv" .. iter_33_2)

				gohelper.setActive(var_33_2, iter_33_2 == iter_33_0)
			end

			table.insert(arg_33_0._upgradeEffects, var_33_1)
		end
	end

	arg_33_0:_showUpgradeEffect()
end

function var_0_0.showCountPart(arg_34_0, arg_34_1)
	gohelper.setActive(arg_34_0._countRoot, true)

	arg_34_0._countText.text = luaLang("multiple") .. arg_34_1
end

function var_0_0.changeToTempCard(arg_35_0)
	gohelper.setActive(arg_35_0._predisplay, true)
end

function var_0_0.dissolveCard(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0.go.activeInHierarchy then
		return
	end

	if FightHelper.isASFDSkill(arg_36_0.skillId) then
		return arg_36_0:disappearCard()
	end

	if FightHelper.isPreDeleteSkill(arg_36_0.skillId) then
		return arg_36_0:disappearCard()
	end

	if FightHelper.isBloodPoolSkill(arg_36_0.skillId) then
		return arg_36_0:disappearCard()
	end

	arg_36_0:setASFDActive(false)
	arg_36_0:revertASFDSkillAnimator()

	local var_36_0 = arg_36_0:getUserDataTb_()

	var_36_0.dissolveScale = arg_36_1 or 1

	local var_36_1 = arg_36_0:getUserDataTb_()

	arg_36_2 = arg_36_2 or arg_36_0.go

	table.insert(var_36_1, arg_36_2)

	var_36_0.dissolveSkillItemGOs = var_36_1

	if not arg_36_0._dissolveFlow then
		arg_36_0._dissolveFlow = FlowSequence.New()

		arg_36_0._dissolveFlow:addWork(FightCardDissolveEffect.New())
	else
		arg_36_0._dissolveFlow:stop()
	end

	arg_36_0:_hideAllEffect()
	arg_36_0._dissolveFlow:start(var_36_0)
end

function var_0_0.disappearCard(arg_37_0)
	if not arg_37_0.go.activeInHierarchy then
		return
	end

	arg_37_0:setASFDActive(false)
	arg_37_0:revertASFDSkillAnimator()

	local var_37_0 = arg_37_0:getUserDataTb_()

	var_37_0.hideSkillItemGOs = arg_37_0:getUserDataTb_()

	table.insert(var_37_0.hideSkillItemGOs, arg_37_0.go)

	if not arg_37_0._disappearFlow then
		arg_37_0._disappearFlow = FlowSequence.New()

		arg_37_0._disappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	else
		arg_37_0._disappearFlow:stop()
	end

	arg_37_0._disappearFlow:start(var_37_0)
end

function var_0_0.revertASFDSkillAnimator(arg_38_0)
	if not FightHelper.isASFDSkill(arg_38_0.skillId) then
		return
	end

	if arg_38_0.asfdSkillAnimator then
		arg_38_0.asfdSkillAnimator:Play("open", 0, 0)
	end
end

function var_0_0.playUsedCardDisplay(arg_39_0, arg_39_1)
	if not arg_39_0.go.activeInHierarchy then
		return
	end

	if not arg_39_0._cardDisplayFlow then
		arg_39_0._cardDisplayFlow = FlowSequence.New()

		arg_39_0._cardDisplayFlow:addWork(FightCardDisplayEffect.New())
	end

	local var_39_0 = arg_39_0:getUserDataTb_()

	var_39_0.skillTipsGO = arg_39_1
	var_39_0.skillItemGO = arg_39_0.go

	arg_39_0._cardDisplayFlow:start(var_39_0)
end

function var_0_0.playUsedCardFinish(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_0.go.activeInHierarchy then
		return
	end

	if not arg_40_0._cardDisplayEndFlow then
		arg_40_0._cardDisplayEndFlow = FlowSequence.New()

		arg_40_0._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())
	end

	local var_40_0 = arg_40_0:getUserDataTb_()

	var_40_0.skillTipsGO = arg_40_1
	var_40_0.skillItemGO = arg_40_0.go
	var_40_0.waitingAreaGO = arg_40_2

	arg_40_0._cardDisplayEndFlow:start(var_40_0)
end

function var_0_0.playCardLevelChange(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if not arg_41_0._cardInfoMO then
		return
	end

	if not arg_41_0.go.activeInHierarchy then
		return
	end

	arg_41_0._cardInfoMO = arg_41_1 or arg_41_0._cardInfoMO

	local var_41_0 = FightConfig.instance:getSkillLv(arg_41_2)
	local var_41_1 = FightConfig.instance:getSkillLv(arg_41_0._cardInfoMO.skillId)

	if not arg_41_0._cardLevelChangeFlow then
		arg_41_0._cardLevelChangeFlow = FlowSequence.New()

		arg_41_0._cardLevelChangeFlow:addWork(FightCardChangeEffect.New())
		arg_41_0._cardLevelChangeFlow:registerDoneListener(arg_41_0._onCardLevelChangeFlowDone, arg_41_0)
	else
		var_41_0 = arg_41_0._cardLevelChangeFlow.status == WorkStatus.Running and arg_41_0._cardLevelChangeFlow.context and arg_41_0._cardLevelChangeFlow.context.oldCardLevel or var_41_0

		arg_41_0._cardLevelChangeFlow:stop()
	end

	local var_41_2 = arg_41_0:getUserDataTb_()

	var_41_2.skillId = arg_41_0._cardInfoMO.skillId
	var_41_2.entityId = arg_41_0._cardInfoMO.uid
	var_41_2.oldCardLevel = var_41_0
	var_41_2.newCardLevel = var_41_1
	var_41_2.cardItem = arg_41_0
	var_41_2.failType = arg_41_3

	arg_41_0._cardLevelChangeFlow:start(var_41_2)

	if var_41_0 <= var_41_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_cardstarup)
	else
		AudioMgr.instance:trigger(20211403)
	end
end

function var_0_0._refreshGray(arg_42_0)
	if arg_42_0._cardInfoMO and arg_42_0._cardInfoMO.status == FightEnum.CardInfoStatus.STATUS_PLAYSETGRAY then
		gohelper.setActive(arg_42_0._cardMask, true)

		local var_42_0 = arg_42_0._cardInfoMO.uid
		local var_42_1 = arg_42_0._cardInfoMO.skillId
		local var_42_2 = FightCardDataHelper.getSkillLv(var_42_0, var_42_1)
		local var_42_3 = FightCardDataHelper.isBigSkill(var_42_1)

		for iter_42_0, iter_42_1 in ipairs(arg_42_0._maskList) do
			if iter_42_0 < 4 then
				gohelper.setActive(iter_42_1, iter_42_0 == var_42_2)
			else
				gohelper.setActive(iter_42_1, var_42_3)
			end
		end
	else
		gohelper.setActive(arg_42_0._cardMask, false)
	end
end

function var_0_0.playCardAroundSetGray(arg_43_0)
	arg_43_0:_refreshGray()
end

function var_0_0.playChangeRankFail(arg_44_0, arg_44_1)
	if arg_44_0._cardInfoMO then
		arg_44_0:playCardLevelChange(arg_44_0._cardInfoMO, arg_44_0._cardInfoMO.skillId, arg_44_1)
	end
end

function var_0_0.setASFDActive(arg_45_0, arg_45_1)
	arg_45_0.showASFD = arg_45_1

	arg_45_0:_refreshASFD()
end

function var_0_0._refreshASFD(arg_46_0)
	local var_46_0 = arg_46_0.showASFD and arg_46_0._cardInfoMO and arg_46_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_46_0.goASFD, var_46_0)

	if var_46_0 then
		arg_46_0.txtASFDEnergy.text = arg_46_0._cardInfoMO.energy
	end
end

function var_0_0.changeEnergy(arg_47_0)
	local var_47_0 = arg_47_0.showASFD and arg_47_0._cardInfoMO and arg_47_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_47_0.goASFD, var_47_0)

	if var_47_0 then
		arg_47_0.txtASFDEnergy.text = arg_47_0._cardInfoMO.energy
		arg_47_0.asfdAnimator = arg_47_0.asfdAnimator or arg_47_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_47_0.asfdAnimator:Play("add", 0, 0)
	end
end

function var_0_0._allocateEnergyDone(arg_48_0)
	local var_48_0 = arg_48_0.showASFD and arg_48_0._cardInfoMO and arg_48_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_48_0.goASFD, var_48_0)

	if var_48_0 then
		arg_48_0.txtASFDEnergy.text = arg_48_0._cardInfoMO.energy
		arg_48_0.asfdAnimator = arg_48_0.asfdAnimator or arg_48_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_48_0.asfdAnimator:Play("open", 0, 0)
	end
end

function var_0_0.playASFDAnim(arg_49_0, arg_49_1)
	if arg_49_0.goASFD.activeSelf then
		arg_49_0.asfdAnimator = arg_49_0.asfdAnimator or arg_49_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_49_0.asfdAnimator:Play(arg_49_1, 0, 0)
	end
end

function var_0_0._onCardLevelChangeFlowDone(arg_50_0)
	arg_50_0:updateItem(arg_50_0._cardInfoMO.uid, arg_50_0._cardInfoMO.skillId, arg_50_0._cardInfoMO)
	FightController.instance:dispatchEvent(FightEvent.CardLevelChangeDone, arg_50_0._cardInfoMO)
	arg_50_0:detectShowBlueStar()
end

function var_0_0.playCardAni(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0._cardAniName = arg_51_2 or UIAnimationName.Open

	arg_51_0._loader:loadAsset(arg_51_1, arg_51_0._onCardAniLoaded, arg_51_0)
end

function var_0_0._onCardAniLoaded(arg_52_0, arg_52_1, arg_52_2)
	if not arg_52_1 then
		return
	end

	if not arg_52_0._cardAniName then
		arg_52_0:_hideAniEffect()

		return
	end

	arg_52_0._cardAni.runtimeAnimatorController = arg_52_2:GetResource()
	arg_52_0._cardAni.enabled = true
	arg_52_0._cardAni.speed = FightModel.instance:getUISpeed()

	SLFramework.AnimatorPlayer.Get(arg_52_0.go):Play(arg_52_0._cardAniName, arg_52_0.onCardAniFinish, arg_52_0)
end

function var_0_0.onCardAniFinish(arg_53_0)
	arg_53_0:_hideAniEffect()
	arg_53_0:hideCardAppearEffect()
end

function var_0_0._hideAniEffect(arg_54_0)
	arg_54_0._cardAniName = nil
	arg_54_0._cardAni.enabled = false

	gohelper.setActive(gohelper.findChild(arg_54_0.go, "vx_balance"), false)
end

function var_0_0.playAppearEffect(arg_55_0)
	gohelper.setActive(arg_55_0._cardAppearEffectRoot, true)

	if not arg_55_0._appearEffect then
		if arg_55_0._appearEffectLoadStart then
			return
		end

		arg_55_0._appearEffectLoadStart = true

		arg_55_0._loader:loadAsset("ui/viewres/fight/card_appear.prefab", arg_55_0._onAppearEffectLoaded, arg_55_0)
	else
		arg_55_0:showAppearEffect()
	end
end

function var_0_0._onAppearEffectLoaded(arg_56_0, arg_56_1, arg_56_2)
	if not arg_56_1 then
		return
	end

	local var_56_0 = arg_56_2:GetResource()

	arg_56_0._appearEffect = gohelper.clone(var_56_0, arg_56_0._cardAppearEffectRoot)

	gohelper.addChild(arg_56_0._cardAppearEffectRoot.transform.parent.parent.gameObject, arg_56_0._cardAppearEffectRoot)
	arg_56_0:showAppearEffect()
end

function var_0_0.showAppearEffect(arg_57_0)
	local var_57_0 = FightCardDataHelper.isBigSkill(arg_57_0.skillId)

	gohelper.setActive(gohelper.findChild(arg_57_0._appearEffect, "nomal_skill"), not var_57_0)
	gohelper.setActive(gohelper.findChild(arg_57_0._appearEffect, "ultimate_skill"), var_57_0)
end

function var_0_0.hideCardAppearEffect(arg_58_0)
	gohelper.setActive(arg_58_0._cardAppearEffectRoot, false)
end

function var_0_0.getASFDScreenPos(arg_59_0)
	arg_59_0.rectTrASFD = arg_59_0.rectTrASFD or arg_59_0.goASFD:GetComponent(gohelper.Type_RectTransform)

	return recthelper.uiPosToScreenPos2(arg_59_0.rectTrASFD)
end

function var_0_0.setActiveRed(arg_60_0, arg_60_1)
	gohelper.setActive(arg_60_0.goRed, arg_60_1)
	arg_60_0:refreshLyMaskActive()
end

function var_0_0.setActiveBlue(arg_61_0, arg_61_1)
	gohelper.setActive(arg_61_0.goBlue, arg_61_1)
	arg_61_0:refreshLyMaskActive()
end

function var_0_0.setActiveBoth(arg_62_0, arg_62_1)
	gohelper.setActive(arg_62_0.goBoth, arg_62_1)
	arg_62_0:refreshLyMaskActive()
end

function var_0_0.refreshLyMaskActive(arg_63_0)
	local var_63_0 = arg_63_0.goRed.activeInHierarchy or arg_63_0.goBlue.activeInHierarchy or arg_63_0.goBoth.activeInHierarchy

	gohelper.setActive(arg_63_0.goLyMask, var_63_0)
end

function var_0_0.releaseEffectFlow(arg_64_0)
	if arg_64_0._cardLevelChangeFlow then
		arg_64_0._cardLevelChangeFlow:unregisterDoneListener(arg_64_0._onCardLevelChangeFlowDone, arg_64_0)
		arg_64_0._cardLevelChangeFlow:stop()

		arg_64_0._cardLevelChangeFlow = nil
	end

	if arg_64_0._dissolveFlow then
		arg_64_0._dissolveFlow:stop()

		arg_64_0._dissolveFlow = nil
	end

	if arg_64_0._cardDisplayFlow then
		arg_64_0._cardDisplayFlow:stop()

		arg_64_0._cardDisplayFlow = nil
	end

	if arg_64_0._cardDisplayEndFlow then
		arg_64_0._cardDisplayEndFlow:stop()

		arg_64_0._cardDisplayEndFlow = nil
	end

	if arg_64_0._disappearFlow then
		if not gohelper.isNil(arg_64_0.go) then
			gohelper.onceAddComponent(arg_64_0.go, gohelper.Type_CanvasGroup).alpha = 1
		end

		arg_64_0._disappearFlow:stop()

		arg_64_0._disappearFlow = nil
	end
end

function var_0_0.onDestroy(arg_65_0)
	if arg_65_0._loader then
		arg_65_0._loader:disposeSelf()

		arg_65_0._loader = nil
	end

	arg_65_0:releaseEffectFlow()

	for iter_65_0, iter_65_1 in pairs(arg_65_0._lvGOs) do
		arg_65_0._lvImgIcons[iter_65_0]:UnLoadImage()
	end

	arg_65_0._tag:UnLoadImage()
	arg_65_0:clearAlfEffect()
end

function var_0_0._hideAllEffect(arg_66_0)
	arg_66_0:_hideUpgradeEffects()
	arg_66_0:_hideEnchantsEffect()
	gohelper.setActive(arg_66_0.goPreDelete, false)
end

var_0_0.AlfLoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}

function var_0_0.tryPlayAlfEffect(arg_67_0)
	if not arg_67_0._cardInfoMO then
		return
	end

	if not FightHeroALFComp.ALFSkillDict[arg_67_0._cardInfoMO.clientData.custom_fromSkillId] then
		return
	end

	arg_67_0.showAlfEffectIng = true

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectAppear, arg_67_0)

	if arg_67_0.alfLoadStatus == var_0_0.AlfLoadStatus.Loaded then
		arg_67_0:_tryPlayAlfEffect()
	elseif arg_67_0.alfLoadStatus == var_0_0.AlfLoadStatus.Loading then
		-- block empty
	else
		arg_67_0.alfLoadStatus = var_0_0.AlfLoadStatus.Loading
		arg_67_0.alfLoader = PrefabInstantiate.Create(arg_67_0.tr.parent.gameObject)

		arg_67_0.alfLoader:startLoad(FightHeroALFComp.CardAddEffect, arg_67_0.onLoadedAlfEffect, arg_67_0)
	end
end

function var_0_0.onLoadedAlfEffect(arg_68_0)
	arg_68_0.goAlfAddCardEffect = arg_68_0.alfLoader:getInstGO()
	arg_68_0.goAlfAddCardAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_68_0.goAlfAddCardEffect)
	arg_68_0.alfLoadStatus = var_0_0.AlfLoadStatus.Loaded

	arg_68_0:_tryPlayAlfEffect()
end

function var_0_0._tryPlayAlfEffect(arg_69_0)
	if not arg_69_0.goAlfAddCardAnimatorPlayer then
		return
	end

	gohelper.setActive(arg_69_0.go, false)
	gohelper.setActive(arg_69_0.goAlfAddCardEffect, true)
	arg_69_0.goAlfAddCardAnimatorPlayer:Play("open", arg_69_0.playAlfCloseAnim, arg_69_0)
end

function var_0_0.playAlfCloseAnim(arg_70_0)
	arg_70_0.goAlfAddCardAnimatorPlayer:Play("close", arg_70_0.playAlfCloseAnimDone, arg_70_0)
	TaskDispatcher.runDelay(arg_70_0.showCardGo, arg_70_0, 0.2 / FightModel.instance:getUISpeed())
end

function var_0_0.showCardGo(arg_71_0)
	gohelper.setActive(arg_71_0.go, true)
	arg_71_0:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")
end

function var_0_0.playAlfCloseAnimDone(arg_72_0)
	gohelper.setActive(arg_72_0.goAlfAddCardEffect, false)

	arg_72_0.showAlfEffectIng = false

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectEnd, arg_72_0)
end

function var_0_0.clearAlfEffect(arg_73_0)
	if arg_73_0.alfLoader then
		arg_73_0.alfLoader:dispose()

		arg_73_0.alfLoader = nil
	end

	arg_73_0.alfLoadStatus = var_0_0.AlfLoadStatus.None
	arg_73_0.goAlfAddCardEffect = nil

	if arg_73_0.goAlfAddCardAnimatorPlayer then
		arg_73_0.goAlfAddCardAnimatorPlayer:Stop()

		arg_73_0.goAlfAddCardAnimatorPlayer = nil
	end

	TaskDispatcher.cancelTask(arg_73_0.showCardGo, arg_73_0)
end

return var_0_0
