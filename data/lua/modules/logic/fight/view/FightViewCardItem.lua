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
	arg_2_0.skillIconBg = arg_2_0:getUserDataTb_()
	arg_2_0.attributeBg = arg_2_0:getUserDataTb_()
	arg_2_0.highlightEffect = arg_2_0:getUserDataTb_()

	for iter_2_0 = 0, 4 do
		local var_2_0 = gohelper.findChild(arg_2_1, "lv" .. iter_2_0)
		local var_2_1 = gohelper.findChildSingleImage(var_2_0, "imgIcon")
		local var_2_2 = gohelper.findChildImage(var_2_0, "imgIcon")

		gohelper.setActive(var_2_0, true)

		arg_2_0._lvGOs[iter_2_0] = var_2_0
		arg_2_0._lvImgIcons[iter_2_0] = var_2_1
		arg_2_0._lvImgComps[iter_2_0] = var_2_2

		local var_2_3 = gohelper.findChild(var_2_0, "image")

		arg_2_0.attributeBg[iter_2_0] = var_2_3

		local var_2_4 = gohelper.findChild(var_2_0, "bg")

		arg_2_0.skillIconBg[iter_2_0] = var_2_4
		arg_2_0.highlightEffect[iter_2_0] = gohelper.findChild(var_2_0, "#pc_highlighted")
	end

	if not var_0_0.TagPosForLvs then
		var_0_0.TagPosForLvs = {}

		for iter_2_1 = 0, 4 do
			local var_2_5, var_2_6 = recthelper.getAnchor(gohelper.findChild(arg_2_1, "tag/pos" .. iter_2_1).transform)

			var_0_0.TagPosForLvs[iter_2_1] = {
				var_2_5,
				var_2_6
			}
		end
	end

	arg_2_0.goTag = gohelper.findChild(arg_2_1, "tag")
	arg_2_0.tagCanvas = gohelper.onceAddComponent(arg_2_0.goTag, typeof(UnityEngine.CanvasGroup))
	arg_2_0._tagRootTr = gohelper.findChild(arg_2_1, "tag/tag").transform
	arg_2_0._tag = gohelper.findChildSingleImage(arg_2_1, "tag/tag/tagIcon")
	arg_2_0.tagTransform = arg_2_0._tag.transform
	arg_2_0._txt = gohelper.findChildText(arg_2_1, "Text")
	arg_2_0._starGO = gohelper.findChild(arg_2_1, "star")
	arg_2_0._starCanvas = gohelper.onceAddComponent(arg_2_0._starGO, typeof(UnityEngine.CanvasGroup))
	arg_2_0._innerStartGOs = arg_2_0:getUserDataTb_()

	for iter_2_2 = 1, FightEnum.MaxSkillCardLv do
		local var_2_7 = gohelper.findChild(arg_2_1, "star/star" .. iter_2_2)

		table.insert(arg_2_0._innerStartGOs, var_2_7)
		table.insert(arg_2_0._starItemCanvas, gohelper.onceAddComponent(var_2_7, typeof(UnityEngine.CanvasGroup)))
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
	arg_2_0.xingtiTxt = gohelper.findChildText(arg_2_1, "txt_xingti")
	arg_2_0.xingtiGo = arg_2_0.xingtiTxt.gameObject
	arg_2_0.alfLoadStatus = var_0_0.AlfLoadStatus.None
	arg_2_0.useSkin = false

	if (arg_2_0.handCardType == FightEnum.CardShowType.HandCard or arg_2_0.handCardType == FightEnum.CardShowType.Operation or arg_2_0.handCardType == FightEnum.CardShowType.PlayCard) and FightCardDataHelper.getCardSkin() == 672801 then
		arg_2_0.useSkin = true
	end

	if arg_2_0.useSkin then
		local var_2_8 = gohelper.create2d(arg_2_1, "skinFrontBg")

		arg_2_0.frontBgRoot = var_2_8

		gohelper.setActive(var_2_8, true)
		gohelper.setSibling(var_2_8, 5)

		local var_2_9 = gohelper.create2d(var_2_8, "skinFrontBgNormal")
		local var_2_10 = gohelper.create2d(var_2_8, "skinFrontBgBigSkill")

		arg_2_0.frontBgNormal = var_2_9
		arg_2_0.frontBgBigSkill = var_2_10
		arg_2_0.imgFrontBgNormal = gohelper.onceAddComponent(var_2_9, gohelper.Type_Image)
		arg_2_0.imgFrontBgBigSkill = gohelper.onceAddComponent(var_2_10, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(arg_2_0.imgFrontBgNormal, "card_dz4", true)
		UISpriteSetMgr.instance:setFightSkillCardSprite(arg_2_0.imgFrontBgBigSkill, "card_dz", true)
		recthelper.setAnchorY(var_2_9.transform, -14)
		recthelper.setAnchorY(var_2_10.transform, 20)

		local var_2_11 = gohelper.create2d(arg_2_1, "skinBackBg")

		arg_2_0.backBgRoot = var_2_11

		gohelper.setActive(var_2_11, true)
		gohelper.setSibling(var_2_11, 0)

		local var_2_12 = gohelper.onceAddComponent(var_2_11, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_12, "card_dz3", true)

		for iter_2_4 = 1, #arg_2_0._innerStartGOs do
			local var_2_13 = arg_2_0._innerStartGOs[iter_2_4].transform

			for iter_2_5 = 0, var_2_13.childCount - 1 do
				local var_2_14 = var_2_13:GetChild(iter_2_5)
				local var_2_15 = var_2_14.name
				local var_2_16 = gohelper.onceAddComponent(var_2_14.gameObject, gohelper.Type_Image)

				if var_2_15 == "light" then
					UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_16, "xx1", true)
				elseif var_2_15 == "lightblue" then
					UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_16, "xx3", true)
				else
					UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_16, "xx2", true)
				end
			end
		end

		for iter_2_6 = 0, 4 do
			gohelper.setActive(arg_2_0.skillIconBg[iter_2_6], false)
			gohelper.setActive(arg_2_0.attributeBg[iter_2_6], false)
		end
	end

	arg_2_0.playedHideCardOpenAnim = false
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
	arg_5_0:addEventCb(FightController.instance, FightEvent.UpdateBuffActInfo, arg_5_0.onUpdateBuffActInfo, arg_5_0)

	if arg_5_0:checkCanShowHideCardEffect() then
		arg_5_0:addEventCb(FightController.instance, FightEvent.OnAddHideCardBuff, arg_5_0.onAddHideCardBuff, arg_5_0)
		arg_5_0:addEventCb(FightController.instance, FightEvent.OnRemoveHideCardBuff, arg_5_0.OnRemoveHideCardBuff, arg_5_0)
	end
end

function var_0_0.onAddHideCardBuff(arg_6_0)
	arg_6_0.playedHideCardOpenAnim = false

	arg_6_0:refreshCardIcon()
end

function var_0_0.OnRemoveHideCardBuff(arg_7_0)
	arg_7_0:refreshCardIcon()
end

local var_0_1 = "ui/viewres/fight/fighttower/card_mshboss.prefab"

function var_0_0.refreshHideCardVx(arg_8_0)
	if not arg_8_0:checkCanShowHideCardEffect() then
		return
	end

	if arg_8_0.goHideCardVx then
		local var_8_0 = FightCardDataHelper.getSkillLv(arg_8_0.entityId, arg_8_0.skillId) == FightEnum.UniqueSkillCardLv
		local var_8_1

		if var_8_0 then
			var_8_1 = FightModel.instance.bigSkillIcon ~= nil
		else
			var_8_1 = FightModel.instance.smallSkillIcon ~= nil
		end

		gohelper.setActive(arg_8_0.goHideCardVx, var_8_1)
		gohelper.setActive(arg_8_0.goHideCardVxNormal, var_8_1 and not var_8_0)
		gohelper.setActive(arg_8_0.goHideCardVxBigSkill, var_8_1 and var_8_0)

		if var_8_1 and not arg_8_0.playedHideCardOpenAnim then
			if var_8_0 then
				arg_8_0.hideCardBigSkillAnim:Play("open")
			else
				arg_8_0.hideCardNormalAnim:Play("open")
			end

			arg_8_0.playedHideCardOpenAnim = true
		end
	else
		if arg_8_0.hideVxLoader then
			return
		end

		arg_8_0.hideVxLoader = MultiAbLoader.New()

		arg_8_0.hideVxLoader:addPath(var_0_1)
		arg_8_0.hideVxLoader:startLoad(arg_8_0.onHideCardVxLoaded, arg_8_0)
	end
end

var_0_0.HideCardVxGoName = "hideCardVx"

function var_0_0.onHideCardVxLoaded(arg_9_0)
	local var_9_0 = arg_9_0.hideVxLoader:getAssetItem(var_0_1):GetResource()

	arg_9_0.goHideCardVx = gohelper.clone(var_9_0, arg_9_0.go, var_0_0.HideCardVxGoName)
	arg_9_0.goHideCardVxNormal = gohelper.findChild(arg_9_0.goHideCardVx, "normal")

	local var_9_1 = gohelper.findChild(arg_9_0.goHideCardVxNormal, "ani")

	arg_9_0.hideCardNormalAnim = ZProj.ProjAnimatorPlayer.Get(var_9_1)
	arg_9_0.goHideCardVxBigSkill = gohelper.findChild(arg_9_0.goHideCardVx, "ultimate")

	local var_9_2 = gohelper.findChild(arg_9_0.goHideCardVxBigSkill, "ani")

	arg_9_0.hideCardBigSkillAnim = ZProj.ProjAnimatorPlayer.Get(var_9_2)

	arg_9_0:refreshHideCardVx()
end

function var_0_0.onUpdateBuffActInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.actId ~= FightEnum.BuffActId.NoUseCardEnergyRecordByRound then
		return
	end

	arg_10_0:refreshXiTiSpecialSkill(arg_10_0.entityId, arg_10_0.skillId)
end

function var_0_0.onEmitterEnergyChange(arg_11_0)
	if not FightHelper.isASFDSkill(arg_11_0.skillId) then
		return
	end

	arg_11_0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	if arg_11_0._disappearFlow and arg_11_0._disappearFlow.status == WorkStatus.Running then
		return
	end

	if arg_11_0._dissolveFlow and arg_11_0._dissolveFlow.status == WorkStatus.Running then
		return
	end

	AudioMgr.instance:trigger(20248003)

	arg_11_0.asfdSkillAnimator = arg_11_0.asfdSkillAnimator or arg_11_0.goASFDSkill:GetComponent(gohelper.Type_Animator)

	arg_11_0.asfdSkillAnimator:Play("aggrandizement", 0, 0)
end

function var_0_0.resetAllNode(arg_12_0)
	local var_12_0 = arg_12_0.tr.childCount

	for iter_12_0 = 1, var_12_0 do
		local var_12_1 = arg_12_0.tr:GetChild(iter_12_0 - 1)

		gohelper.setActive(var_12_1.gameObject, false)
	end
end

function var_0_0.updateItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.entityId = arg_13_1
	arg_13_0.skillId = arg_13_2
	arg_13_0._cardInfoMO = arg_13_3

	arg_13_0:resetAllNode()
	gohelper.setActive(arg_13_0.go, true)
	gohelper.setActive(arg_13_0.goTag, true)
	gohelper.setActive(arg_13_0.goRedAndBlue, true)
	gohelper.setActive(arg_13_0._layout, true)
	gohelper.setActive(arg_13_0.frontBgRoot, true)
	gohelper.setActive(arg_13_0.backBgRoot, true)

	arg_13_0._canvasGroup.alpha = 1
	arg_13_0.tagCanvas.alpha = 1

	if FightHelper.isBloodPoolSkill(arg_13_2) then
		gohelper.setActive(arg_13_0.frontBgRoot, false)

		return arg_13_0:refreshBloodPoolSkill(arg_13_1, arg_13_2, arg_13_3)
	end

	if FightHelper.isASFDSkill(arg_13_2) then
		gohelper.setActive(arg_13_0.frontBgRoot, false)

		return arg_13_0:refreshASFDSkill(arg_13_1, arg_13_2, arg_13_3)
	end

	if FightHelper.isPreDeleteSkill(arg_13_2) then
		gohelper.setActive(arg_13_0.frontBgRoot, false)

		return arg_13_0:refreshPreDeleteSkill(arg_13_1, arg_13_2, arg_13_3)
	end

	arg_13_0:_hideAniEffect()
	arg_13_0:refreshCardIcon()

	local var_13_0 = FightCardDataHelper.getSkillLv(arg_13_0.entityId, arg_13_0.skillId)
	local var_13_1 = var_13_0 < FightEnum.UniqueSkillCardLv and var_13_0 > 0

	gohelper.setActive(arg_13_0._starGO, var_13_1)

	arg_13_0._starCanvas.alpha = 1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._innerStartGOs) do
		gohelper.setActive(iter_13_1, iter_13_0 == var_13_0)

		if arg_13_0._starItemCanvas[iter_13_0] then
			arg_13_0._starItemCanvas[iter_13_0].alpha = 1
		end
	end

	arg_13_0:refreshTag()

	local var_13_2 = lua_skill.configDict[arg_13_0.skillId]

	arg_13_0._txt.text = var_13_2.id .. "\nLv." .. var_13_0

	local var_13_3 = var_13_0 == FightEnum.UniqueSkillCardLv

	if arg_13_0.useSkin then
		var_13_3 = false
	end

	if var_13_0 == FightEnum.UniqueSkillCardLv and not arg_13_0._uniqueCardEffect then
		local var_13_4 = ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka)
		local var_13_5 = FightHelper.getPreloadAssetItem(var_13_4)

		arg_13_0._uniqueCardEffect = gohelper.clone(var_13_5:GetResource(var_13_4), arg_13_0.go)
	end

	gohelper.setActive(arg_13_0._uniqueCardEffect, var_13_3)
	gohelper.setActive(arg_13_0.frontBgNormal, var_13_0 ~= FightEnum.UniqueSkillCardLv)
	gohelper.setActive(arg_13_0.frontBgBigSkill, var_13_0 == FightEnum.UniqueSkillCardLv)
	gohelper.setActive(arg_13_0._predisplay, arg_13_0._cardInfoMO and arg_13_0._cardInfoMO.tempCard)
	arg_13_0:_showUpgradeEffect()
	arg_13_0:_showEnchantsEffect()
	arg_13_0:_refreshGray()
	arg_13_0:_refreshASFD()
	arg_13_0:_refreshPreDeleteArrow()
	arg_13_0:showCardHeat()
	arg_13_0:refreshXiTiSpecialSkill(arg_13_1, arg_13_2, arg_13_3)
end

function var_0_0.refreshCardIcon(arg_14_0)
	local var_14_0 = lua_skill.configDict[arg_14_0.skillId]
	local var_14_1 = FightCardDataHelper.getSkillLv(arg_14_0.entityId, arg_14_0.skillId)

	for iter_14_0, iter_14_1 in pairs(arg_14_0._lvGOs) do
		gohelper.setActive(iter_14_1, true)
		gohelper.setActiveCanvasGroup(iter_14_1, var_14_1 == iter_14_0)
	end

	local var_14_2

	if arg_14_0:checkCanShowHideCardEffect() then
		var_14_2 = FightModel.instance:getHandCardSkillIcon(arg_14_0.entityId, var_14_0)
	else
		var_14_2 = ResUrl.getSkillIcon(var_14_0.icon)
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._lvImgIcons) do
		if gohelper.isNil(arg_14_0._lvImgComps[iter_14_2].sprite) then
			iter_14_3:UnLoadImage()
		elseif iter_14_3.curImageUrl ~= var_14_2 then
			iter_14_3:UnLoadImage()
		end

		iter_14_3:LoadImage(var_14_2)
	end

	arg_14_0:refreshHideCardVx()
end

function var_0_0.checkCanShowHideCardEffect(arg_15_0)
	return arg_15_0.handCardType == FightEnum.CardShowType.HandCard or arg_15_0.handCardType == FightEnum.CardShowType.Operation
end

function var_0_0._onPcKeyAdapter(arg_16_0)
	if arg_16_0.showASFD and PCInputController.instance:getIsUse() and PlayerPrefsHelper.getNumber("keyTips", 0) ~= 0 then
		local var_16_0 = arg_16_0.goASFD.transform.localPosition

		var_16_0.y = 200
		arg_16_0.goASFD.transform.localPosition = var_16_0
	else
		local var_16_1 = arg_16_0.goASFD.transform.localPosition

		var_16_1.y = 170
		arg_16_0.goASFD.transform.localPosition = var_16_1
	end
end

function var_0_0.refreshTag(arg_17_0)
	local var_17_0 = lua_skill.configDict[arg_17_0.skillId]
	local var_17_1 = FightCardDataHelper.getSkillLv(arg_17_0.entityId, arg_17_0.skillId)
	local var_17_2 = "attribute_"
	local var_17_3 = 168
	local var_17_4 = 56

	if arg_17_0.useSkin then
		var_17_2 = "v2a8_skin/attribute_"
		var_17_3 = 180
		var_17_4 = 64
	end

	local var_17_5 = ResUrl.getAttributeIcon(var_17_2 .. var_17_0.showTag)

	arg_17_0._tag:LoadImage(var_17_5)
	recthelper.setSize(arg_17_0.tagTransform, var_17_3, var_17_4)

	local var_17_6 = var_0_0.TagPosForLvs[var_17_1]

	if var_17_6 then
		recthelper.setAnchor(arg_17_0._tagRootTr, var_17_6[1], var_17_6[2])

		if arg_17_0.useSkin then
			recthelper.setAnchorY(arg_17_0._tagRootTr, -200)
		end
	end

	gohelper.setActive(arg_17_0._tag.gameObject, var_17_1 < FightEnum.UniqueSkillCardLv)
end

function var_0_0.showCardHeat(arg_18_0)
	if arg_18_0._cardInfoMO and arg_18_0._cardInfoMO.heatId and arg_18_0._cardInfoMO.heatId ~= 0 then
		arg_18_0:setHeatRootVisible(true)

		if arg_18_0._heatObj then
			arg_18_0:_refreshCardHeat()
		elseif not arg_18_0._loadHeat then
			arg_18_0._loadHeat = true

			arg_18_0._loader:loadAsset("ui/viewres/fight/fightheatview.prefab", arg_18_0._onHeatLoadFinish, arg_18_0)
		end
	else
		arg_18_0:setHeatRootVisible(false)
	end
end

function var_0_0.setHeatRootVisible(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._heatRoot, arg_19_1)
end

function var_0_0._refreshCardHeat(arg_20_0)
	if arg_20_0._cardInfoMO and arg_20_0._cardInfoMO.heatId ~= 0 then
		local var_20_0 = arg_20_0._cardInfoMO.heatId
		local var_20_1 = FightDataHelper.teamDataMgr.myData.cardHeat.values[var_20_0]

		if var_20_1 then
			local var_20_2 = FightDataHelper.teamDataMgr.myCardHeatOffset[var_20_0] or 0

			arg_20_0._heatText.text = Mathf.Clamp(var_20_1.value + var_20_2, var_20_1.lowerLimit, var_20_1.upperLimit)
		else
			arg_20_0._heatText.text = ""
		end
	end
end

function var_0_0._onHeatLoadFinish(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1 then
		return
	end

	arg_21_0._heatObj = gohelper.clone(arg_21_2:GetResource(), arg_21_0._heatRoot)
	arg_21_0._heatText = gohelper.findChildText(arg_21_0._heatObj, "heatText")

	arg_21_0:_refreshCardHeat()
end

function var_0_0._refreshPreDeleteArrow(arg_22_0)
	local var_22_0 = arg_22_0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(arg_22_0.goPreDelete, var_22_0)

	if var_22_0 then
		gohelper.setActive(arg_22_0.goPreDeleteBoth, false)
		gohelper.setActive(arg_22_0.goPreDeleteLeft, false)
		gohelper.setActive(arg_22_0.goPreDeleteRight, false)

		local var_22_1 = lua_fight_card_pre_delete.configDict[arg_22_0.skillId]

		if var_22_1 then
			local var_22_2 = var_22_1.left > 0
			local var_22_3 = var_22_1.right > 0

			if var_22_2 and var_22_3 then
				gohelper.setActive(arg_22_0.goPreDeleteBoth, true)
			elseif var_22_2 then
				gohelper.setActive(arg_22_0.goPreDeleteLeft, true)
			elseif var_22_3 then
				gohelper.setActive(arg_22_0.goPreDeleteRight, true)
			end

			gohelper.setActive(arg_22_0._starGO, false)
		end
	end
end

function var_0_0._refreshPreDeleteImage(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(arg_23_0.goPreDelete, var_23_0)

	if var_23_0 then
		local var_23_1 = FightCardDataHelper.isBigSkill(arg_23_0.skillId)

		gohelper.setActive(arg_23_0.goPreDeleteNormal, not var_23_1 and arg_23_1)
		gohelper.setActive(arg_23_0.goPreDeleteUnique, var_23_1 and arg_23_1)
	end
end

function var_0_0.refreshPreDeleteSkill(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	gohelper.setActive(arg_24_0.goPreDeleteCard, true)
	gohelper.setActive(arg_24_0.goPreDeleteNormal, false)
	gohelper.setActive(arg_24_0.goPreDeleteUnique, false)
	arg_24_0:refreshTag()
	arg_24_0:_refreshPreDeleteArrow()
end

function var_0_0.refreshBloodPoolSkill(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	gohelper.setActive(arg_25_0.goBloodPool, true)
	gohelper.setActive(arg_25_0.goTag, true)
	gohelper.setActive(arg_25_0._tag.gameObject, true)

	arg_25_0.bloodPoolAnimator = arg_25_0.bloodPoolAnimator or arg_25_0.goBloodPool:GetComponent(gohelper.Type_Animator)

	if arg_25_0.handCardType == FightEnum.CardShowType.Operation then
		arg_25_0.bloodPoolAnimator:Play("open", 0, 0)
		AudioMgr.instance:trigger(20270007)
	else
		arg_25_0.bloodPoolAnimator:Play("open", 0, 1)
	end

	arg_25_0._tag:LoadImage(ResUrl.getAttributeIcon("blood_tex2"))

	local var_25_0 = var_0_0.TagPosForLvs[1]

	recthelper.setAnchor(arg_25_0._tagRootTr, var_25_0[1], var_25_0[2])
end

function var_0_0.refreshASFDSkill(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	gohelper.setActive(arg_26_0.goASFDSkill, true)
	gohelper.setActive(arg_26_0.goTag, true)
	gohelper.setActive(arg_26_0._tag.gameObject, true)

	local var_26_0 = ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon)

	arg_26_0.asfdSkillSimage:LoadImage(var_26_0)

	arg_26_0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	arg_26_0._tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

	local var_26_1 = var_0_0.TagPosForLvs[1]

	recthelper.setAnchor(arg_26_0._tagRootTr, var_26_1[1], var_26_1[2])
	arg_26_0:_onPcKeyAdapter()
end

function var_0_0.refreshXiTiSpecialSkill(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not FightHelper.isXiTiSpecialSkill(arg_27_2) then
		gohelper.setActive(arg_27_0.xingtiGo, false)

		return
	end

	gohelper.setActive(arg_27_0.xingtiGo, true)

	arg_27_0.xingtiTxt.text = FightASFDHelper.getLastRoundRecordCardEnergy()
end

function var_0_0.updateResistanceByCardInfo(arg_28_0, arg_28_1)
	arg_28_0._resistanceComp:updateByCardInfo(arg_28_1)
end

function var_0_0.updateResistanceByBeginRoundOp(arg_29_0, arg_29_1)
	arg_29_0._resistanceComp:updateByBeginRoundOp(arg_29_1)
end

function var_0_0.updateResistanceBySkillDisplayMo(arg_30_0, arg_30_1)
	arg_30_0._resistanceComp:updateBySkillDisplayMo(arg_30_1)
end

function var_0_0.detectShowBlueStar(arg_31_0)
	local var_31_0 = arg_31_0.entityId and arg_31_0.skillId and FightCardDataHelper.getSkillLv(arg_31_0.entityId, arg_31_0.skillId)

	arg_31_0:showBlueStar(var_31_0)
end

function var_0_0.showBlueStar(arg_32_0, arg_32_1)
	if arg_32_0._lightBlueObj then
		for iter_32_0, iter_32_1 in ipairs(arg_32_0._lightBlueObj) do
			gohelper.setActive(iter_32_1.blue, false)
			gohelper.setActive(iter_32_1.dark, true)
		end
	else
		arg_32_0._lightBlueObj = {}
		arg_32_0._lightBlueObj[1] = arg_32_0:getUserDataTb_()
		arg_32_0._lightBlueObj[1].blue = gohelper.findChild(arg_32_0._innerStartGOs[1], "lightblue")
		arg_32_0._lightBlueObj[1].dark = gohelper.findChild(arg_32_0._innerStartGOs[1], "dark2")
		arg_32_0._lightBlueObj[2] = arg_32_0:getUserDataTb_()
		arg_32_0._lightBlueObj[2].blue = gohelper.findChild(arg_32_0._innerStartGOs[2], "lightblue")
		arg_32_0._lightBlueObj[2].dark = gohelper.findChild(arg_32_0._innerStartGOs[2], "dark3")
	end

	if arg_32_1 == 1 or arg_32_1 == 2 then
		local var_32_0 = FightDataHelper.entityMgr:getById(arg_32_0.entityId)

		if var_32_0 and var_32_0:hasBuffFeature(FightEnum.BuffFeature.SkillLevelJudgeAdd) then
			local var_32_1 = arg_32_0._lightBlueObj[arg_32_1]

			gohelper.setActive(var_32_1.blue, true)
			gohelper.setActive(var_32_1.dark, false)
		end
	end
end

function var_0_0.showPrecisionEffect(arg_33_0)
	gohelper.setActive(arg_33_0._precisionEffect, true)
end

function var_0_0.hidePrecisionEffect(arg_34_0)
	gohelper.setActive(arg_34_0._precisionEffect, false)
end

local var_0_2 = {
	[FightEnum.EnchantedType.Frozen] = "ui/viewres/fight/card_freeze.prefab",
	[FightEnum.EnchantedType.Burn] = "ui/viewres/fight/card_flaring.prefab",
	[FightEnum.EnchantedType.Chaos] = "ui/viewres/fight/card_chaos.prefab",
	[FightEnum.EnchantedType.depresse] = "ui/viewres/fight/card_qmyj.prefab"
}

function var_0_0._showEnchantsEffect(arg_35_0)
	gohelper.setActive(arg_35_0._abandon, false)
	gohelper.setActive(arg_35_0._blockadeTwo, false)
	gohelper.setActive(arg_35_0._blockadeOne, false)
	gohelper.setActive(arg_35_0._precision, false)
	gohelper.setActive(arg_35_0._precisionEffect, false)

	if not arg_35_0._cardInfoMO then
		return
	end

	local var_35_0 = arg_35_0:_refreshEnchantEffectActive()

	if #var_35_0 > 0 then
		arg_35_0._loader:loadListAsset(var_35_0, arg_35_0._onEnchantEffectLoaded, arg_35_0._onEnchantEffectsLoaded, arg_35_0)
	end

	if arg_35_0._cardInfoMO.enchants then
		for iter_35_0, iter_35_1 in ipairs(arg_35_0._cardInfoMO.enchants) do
			if iter_35_1.enchantId == FightEnum.EnchantedType.Discard then
				gohelper.setActive(arg_35_0._abandon, true)
			elseif iter_35_1.enchantId == FightEnum.EnchantedType.Blockade then
				local var_35_1 = FightDataHelper.handCardMgr.handCard

				if arg_35_0._cardInfoMO.clientData.custom_playedCard then
					gohelper.setActive(arg_35_0._blockadeOne, true)
				elseif arg_35_0._cardInfoMO.clientData.custom_handCardIndex then
					if arg_35_0._cardInfoMO.clientData.custom_handCardIndex == 1 or arg_35_0._cardInfoMO.clientData.custom_handCardIndex == #var_35_1 then
						gohelper.setActive(arg_35_0._blockadeOne, true)
					else
						gohelper.setActive(arg_35_0._blockadeTwo, true)
					end
				else
					gohelper.setActive(arg_35_0._blockadeOne, true)
				end
			elseif iter_35_1.enchantId == FightEnum.EnchantedType.Precision then
				gohelper.setActive(arg_35_0._precision, true)

				if arg_35_0._cardInfoMO.clientData.custom_handCardIndex == 1 then
					FightController.instance:dispatchEvent(FightEvent.RefreshHandCardPrecisionEffect)
				end
			end
		end
	end
end

function var_0_0._refreshEnchantEffectActive(arg_36_0)
	arg_36_0:_hideEnchantsEffect()

	arg_36_0._enchantsEffect = arg_36_0._enchantsEffect or {}

	local var_36_0 = arg_36_0._cardInfoMO.enchants or {}
	local var_36_1 = {}

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		local var_36_2 = iter_36_1.enchantId

		if arg_36_0._enchantsEffect[var_36_2] then
			for iter_36_2, iter_36_3 in ipairs(arg_36_0._enchantsEffect[var_36_2]) do
				gohelper.setActive(iter_36_3, true)
			end
		else
			local var_36_3 = var_0_2[var_36_2]

			if var_36_3 then
				table.insert(var_36_1, var_36_3)
			end
		end
	end

	return var_36_1
end

function var_0_0._hideEnchantsEffect(arg_37_0)
	if arg_37_0._enchantsEffect then
		for iter_37_0, iter_37_1 in pairs(arg_37_0._enchantsEffect) do
			for iter_37_2, iter_37_3 in ipairs(iter_37_1) do
				gohelper.setActive(iter_37_3, false)
			end
		end
	end
end

function var_0_0._onEnchantEffectLoaded(arg_38_0, arg_38_1, arg_38_2)
	return
end

function var_0_0._onEnchantEffectsLoaded(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in pairs(var_0_2) do
		if not arg_39_0._enchantsEffect[iter_39_0] then
			local var_39_0 = arg_39_1:getAssetItem(iter_39_1)

			if var_39_0 then
				local var_39_1 = var_39_0:GetResource()

				if arg_39_0._lvGOs then
					arg_39_0._enchantsEffect[iter_39_0] = arg_39_0:getUserDataTb_()

					for iter_39_2, iter_39_3 in pairs(arg_39_0._lvGOs) do
						local var_39_2 = gohelper.clone(var_39_1, gohelper.findChild(iter_39_3, "#cardeffect"))

						for iter_39_4 = 0, 4 do
							local var_39_3 = gohelper.findChild(var_39_2, "lv" .. iter_39_4)

							gohelper.setActive(var_39_3, iter_39_4 == iter_39_2)
						end

						table.insert(arg_39_0._enchantsEffect[iter_39_0], var_39_2)
					end
				end
			end
		end
	end

	arg_39_0:_refreshEnchantEffectActive()
end

function var_0_0._showUpgradeEffect(arg_40_0)
	if lua_fight_upgrade_show_skillid.configDict[arg_40_0.skillId] then
		if not arg_40_0._upgradeEffects then
			arg_40_0._loader:loadAsset("ui/viewres/fight/card_aggrandizement.prefab", arg_40_0._onUpgradeEffectLoaded, arg_40_0)

			return
		end

		for iter_40_0, iter_40_1 in ipairs(arg_40_0._upgradeEffects) do
			gohelper.setActive(iter_40_1, false)
			gohelper.setActive(iter_40_1, true)
		end
	else
		arg_40_0:_hideUpgradeEffects()
	end
end

function var_0_0._hideUpgradeEffects(arg_41_0)
	if arg_41_0._upgradeEffects then
		for iter_41_0, iter_41_1 in ipairs(arg_41_0._upgradeEffects) do
			gohelper.setActive(iter_41_1, false)
		end
	end
end

function var_0_0._onUpgradeEffectLoaded(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_1 then
		return
	end

	if arg_42_0._upgradeEffects then
		return
	end

	arg_42_0._upgradeEffects = arg_42_0:getUserDataTb_()

	local var_42_0 = arg_42_2:GetResource()

	if arg_42_0._lvGOs and var_42_0 then
		for iter_42_0, iter_42_1 in pairs(arg_42_0._lvGOs) do
			local var_42_1 = gohelper.clone(var_42_0, gohelper.findChild(iter_42_1, "#cardeffect"))

			for iter_42_2 = 0, 4 do
				local var_42_2 = gohelper.findChild(var_42_1, "lv" .. iter_42_2)

				gohelper.setActive(var_42_2, iter_42_2 == iter_42_0)
			end

			table.insert(arg_42_0._upgradeEffects, var_42_1)
		end
	end

	arg_42_0:_showUpgradeEffect()
end

function var_0_0.showCountPart(arg_43_0, arg_43_1)
	gohelper.setActive(arg_43_0._countRoot, true)

	arg_43_0._countText.text = luaLang("multiple") .. arg_43_1
end

function var_0_0.changeToTempCard(arg_44_0)
	gohelper.setActive(arg_44_0._predisplay, true)
end

function var_0_0.dissolveCard(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_0.go.activeInHierarchy then
		return
	end

	if FightHelper.isASFDSkill(arg_45_0.skillId) then
		return arg_45_0:disappearCard()
	end

	if FightHelper.isPreDeleteSkill(arg_45_0.skillId) then
		return arg_45_0:disappearCard()
	end

	if FightHelper.isBloodPoolSkill(arg_45_0.skillId) then
		return arg_45_0:disappearCard()
	end

	arg_45_0:setASFDActive(false)
	arg_45_0:revertASFDSkillAnimator()

	local var_45_0 = arg_45_0:getUserDataTb_()

	var_45_0.dissolveScale = arg_45_1 or 1

	local var_45_1 = arg_45_0:getUserDataTb_()

	arg_45_2 = arg_45_2 or arg_45_0.go

	table.insert(var_45_1, arg_45_2)

	var_45_0.dissolveSkillItemGOs = var_45_1

	if not arg_45_0._dissolveFlow then
		arg_45_0._dissolveFlow = FlowSequence.New()

		arg_45_0._dissolveFlow:addWork(FightCardDissolveEffect.New())
	else
		arg_45_0._dissolveFlow:stop()
	end

	arg_45_0:_hideAllEffect()
	arg_45_0._dissolveFlow:start(var_45_0)
end

function var_0_0.disappearCard(arg_46_0)
	if not arg_46_0.go.activeInHierarchy then
		return
	end

	arg_46_0:setASFDActive(false)
	arg_46_0:revertASFDSkillAnimator()

	local var_46_0 = arg_46_0:getUserDataTb_()

	var_46_0.hideSkillItemGOs = arg_46_0:getUserDataTb_()

	table.insert(var_46_0.hideSkillItemGOs, arg_46_0.go)

	if not arg_46_0._disappearFlow then
		arg_46_0._disappearFlow = FlowSequence.New()

		arg_46_0._disappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	else
		arg_46_0._disappearFlow:stop()
	end

	arg_46_0._disappearFlow:start(var_46_0)
end

function var_0_0.revertASFDSkillAnimator(arg_47_0)
	if not FightHelper.isASFDSkill(arg_47_0.skillId) then
		return
	end

	if arg_47_0.asfdSkillAnimator then
		arg_47_0.asfdSkillAnimator:Play("open", 0, 0)
	end
end

function var_0_0.playUsedCardDisplay(arg_48_0, arg_48_1)
	if not arg_48_0.go.activeInHierarchy then
		return
	end

	if not arg_48_0._cardDisplayFlow then
		arg_48_0._cardDisplayFlow = FlowSequence.New()

		arg_48_0._cardDisplayFlow:addWork(FightCardDisplayEffect.New())
	end

	local var_48_0 = arg_48_0:getUserDataTb_()

	var_48_0.skillTipsGO = arg_48_1
	var_48_0.skillItemGO = arg_48_0.go

	arg_48_0._cardDisplayFlow:start(var_48_0)
end

function var_0_0.playUsedCardFinish(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_0.go.activeInHierarchy then
		return
	end

	if not arg_49_0._cardDisplayEndFlow then
		arg_49_0._cardDisplayEndFlow = FlowSequence.New()

		arg_49_0._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())
	end

	local var_49_0 = arg_49_0:getUserDataTb_()

	var_49_0.skillTipsGO = arg_49_1
	var_49_0.skillItemGO = arg_49_0.go
	var_49_0.waitingAreaGO = arg_49_2

	arg_49_0._cardDisplayEndFlow:start(var_49_0)
end

function var_0_0.playCardLevelChange(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	if not arg_50_0._cardInfoMO then
		return
	end

	if not arg_50_0.go.activeInHierarchy then
		return
	end

	arg_50_0._cardInfoMO = arg_50_1 or arg_50_0._cardInfoMO

	local var_50_0 = FightConfig.instance:getSkillLv(arg_50_2)
	local var_50_1 = FightConfig.instance:getSkillLv(arg_50_0._cardInfoMO.skillId)

	if not arg_50_0._cardLevelChangeFlow then
		arg_50_0._cardLevelChangeFlow = FlowSequence.New()

		arg_50_0._cardLevelChangeFlow:addWork(FightCardChangeEffect.New())
		arg_50_0._cardLevelChangeFlow:registerDoneListener(arg_50_0._onCardLevelChangeFlowDone, arg_50_0)
	else
		var_50_0 = arg_50_0._cardLevelChangeFlow.status == WorkStatus.Running and arg_50_0._cardLevelChangeFlow.context and arg_50_0._cardLevelChangeFlow.context.oldCardLevel or var_50_0

		arg_50_0._cardLevelChangeFlow:stop()
	end

	local var_50_2 = arg_50_0:getUserDataTb_()

	var_50_2.skillId = arg_50_0._cardInfoMO.skillId
	var_50_2.entityId = arg_50_0._cardInfoMO.uid
	var_50_2.oldCardLevel = var_50_0
	var_50_2.newCardLevel = var_50_1
	var_50_2.cardItem = arg_50_0
	var_50_2.failType = arg_50_3

	arg_50_0._cardLevelChangeFlow:start(var_50_2)

	if var_50_0 <= var_50_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_cardstarup)
	else
		AudioMgr.instance:trigger(20211403)
	end
end

function var_0_0._refreshGray(arg_51_0)
	if arg_51_0._cardInfoMO and arg_51_0._cardInfoMO.status == FightEnum.CardInfoStatus.STATUS_PLAYSETGRAY then
		gohelper.setActive(arg_51_0._cardMask, true)

		local var_51_0 = arg_51_0._cardInfoMO.uid
		local var_51_1 = arg_51_0._cardInfoMO.skillId
		local var_51_2 = FightCardDataHelper.getSkillLv(var_51_0, var_51_1)
		local var_51_3 = FightCardDataHelper.isBigSkill(var_51_1)

		for iter_51_0, iter_51_1 in ipairs(arg_51_0._maskList) do
			if iter_51_0 < 4 then
				gohelper.setActive(iter_51_1, iter_51_0 == var_51_2)
			else
				gohelper.setActive(iter_51_1, var_51_3)
			end
		end
	else
		gohelper.setActive(arg_51_0._cardMask, false)
	end
end

function var_0_0.playCardAroundSetGray(arg_52_0)
	arg_52_0:_refreshGray()
end

function var_0_0.playChangeRankFail(arg_53_0, arg_53_1)
	if arg_53_0._cardInfoMO then
		arg_53_0:playCardLevelChange(arg_53_0._cardInfoMO, arg_53_0._cardInfoMO.skillId, arg_53_1)
	end
end

function var_0_0.setASFDActive(arg_54_0, arg_54_1)
	arg_54_0.showASFD = arg_54_1

	arg_54_0:_refreshASFD()
end

function var_0_0._refreshASFD(arg_55_0)
	local var_55_0 = arg_55_0.showASFD and arg_55_0._cardInfoMO and arg_55_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_55_0.goASFD, var_55_0)

	if var_55_0 then
		arg_55_0.txtASFDEnergy.text = arg_55_0._cardInfoMO.energy
	end

	arg_55_0:_onPcKeyAdapter()
end

function var_0_0.changeEnergy(arg_56_0)
	local var_56_0 = arg_56_0.showASFD and arg_56_0._cardInfoMO and arg_56_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_56_0.goASFD, var_56_0)

	if var_56_0 then
		arg_56_0.txtASFDEnergy.text = arg_56_0._cardInfoMO.energy
		arg_56_0.asfdAnimator = arg_56_0.asfdAnimator or arg_56_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_56_0.asfdAnimator:Play("add", 0, 0)
	end
end

function var_0_0._allocateEnergyDone(arg_57_0)
	local var_57_0 = arg_57_0.showASFD and arg_57_0._cardInfoMO and arg_57_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_57_0.goASFD, var_57_0)

	if var_57_0 then
		arg_57_0.txtASFDEnergy.text = arg_57_0._cardInfoMO.energy
		arg_57_0.asfdAnimator = arg_57_0.asfdAnimator or arg_57_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_57_0.asfdAnimator:Play("open", 0, 0)
	end
end

function var_0_0.playASFDAnim(arg_58_0, arg_58_1)
	if arg_58_0.goASFD.activeSelf then
		arg_58_0.asfdAnimator = arg_58_0.asfdAnimator or arg_58_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_58_0.asfdAnimator:Play(arg_58_1, 0, 0)
	end
end

function var_0_0._onCardLevelChangeFlowDone(arg_59_0)
	arg_59_0:updateItem(arg_59_0._cardInfoMO.uid, arg_59_0._cardInfoMO.skillId, arg_59_0._cardInfoMO)
	FightController.instance:dispatchEvent(FightEvent.CardLevelChangeDone, arg_59_0._cardInfoMO)
	arg_59_0:detectShowBlueStar()
end

function var_0_0.playCardAni(arg_60_0, arg_60_1, arg_60_2)
	arg_60_0._cardAniName = arg_60_2 or UIAnimationName.Open

	arg_60_0._loader:loadAsset(arg_60_1, arg_60_0._onCardAniLoaded, arg_60_0)
end

function var_0_0._onCardAniLoaded(arg_61_0, arg_61_1, arg_61_2)
	if not arg_61_1 then
		return
	end

	if not arg_61_0._cardAniName then
		arg_61_0:_hideAniEffect()

		return
	end

	arg_61_0._cardAni.runtimeAnimatorController = arg_61_2:GetResource()
	arg_61_0._cardAni.enabled = true
	arg_61_0._cardAni.speed = FightModel.instance:getUISpeed()

	SLFramework.AnimatorPlayer.Get(arg_61_0.go):Play(arg_61_0._cardAniName, arg_61_0.onCardAniFinish, arg_61_0)
end

function var_0_0.onCardAniFinish(arg_62_0)
	arg_62_0:_hideAniEffect()
	arg_62_0:hideCardAppearEffect()
end

function var_0_0._hideAniEffect(arg_63_0)
	arg_63_0._cardAniName = nil
	arg_63_0._cardAni.enabled = false

	gohelper.setActive(gohelper.findChild(arg_63_0.go, "vx_balance"), false)
end

function var_0_0.playAppearEffect(arg_64_0)
	gohelper.setActive(arg_64_0._cardAppearEffectRoot, true)

	if not arg_64_0._appearEffect then
		if arg_64_0._appearEffectLoadStart then
			return
		end

		arg_64_0._appearEffectLoadStart = true

		arg_64_0._loader:loadAsset("ui/viewres/fight/card_appear.prefab", arg_64_0._onAppearEffectLoaded, arg_64_0)
	else
		arg_64_0:showAppearEffect()
	end
end

function var_0_0._onAppearEffectLoaded(arg_65_0, arg_65_1, arg_65_2)
	if not arg_65_1 then
		return
	end

	local var_65_0 = arg_65_2:GetResource()

	arg_65_0._appearEffect = gohelper.clone(var_65_0, arg_65_0._cardAppearEffectRoot)

	gohelper.addChild(arg_65_0._cardAppearEffectRoot.transform.parent.parent.gameObject, arg_65_0._cardAppearEffectRoot)
	arg_65_0:showAppearEffect()
end

function var_0_0.showAppearEffect(arg_66_0)
	local var_66_0 = FightCardDataHelper.isBigSkill(arg_66_0.skillId)

	gohelper.setActive(gohelper.findChild(arg_66_0._appearEffect, "nomal_skill"), not var_66_0)
	gohelper.setActive(gohelper.findChild(arg_66_0._appearEffect, "ultimate_skill"), var_66_0)
end

function var_0_0.hideCardAppearEffect(arg_67_0)
	gohelper.setActive(arg_67_0._cardAppearEffectRoot, false)
end

function var_0_0.getASFDScreenPos(arg_68_0)
	arg_68_0.rectTrASFD = arg_68_0.rectTrASFD or arg_68_0.goASFD:GetComponent(gohelper.Type_RectTransform)

	return recthelper.uiPosToScreenPos2(arg_68_0.rectTrASFD)
end

function var_0_0.setActiveRed(arg_69_0, arg_69_1)
	gohelper.setActive(arg_69_0.goRed, arg_69_1)
	arg_69_0:refreshLyMaskActive()
end

function var_0_0.setActiveBlue(arg_70_0, arg_70_1)
	gohelper.setActive(arg_70_0.goBlue, arg_70_1)
	arg_70_0:refreshLyMaskActive()
end

function var_0_0.setActiveBoth(arg_71_0, arg_71_1)
	gohelper.setActive(arg_71_0.goBoth, arg_71_1)
	arg_71_0:refreshLyMaskActive()
end

function var_0_0.refreshLyMaskActive(arg_72_0)
	local var_72_0 = arg_72_0.goRed.activeInHierarchy or arg_72_0.goBlue.activeInHierarchy or arg_72_0.goBoth.activeInHierarchy

	gohelper.setActive(arg_72_0.goLyMask, var_72_0)
end

function var_0_0.releaseEffectFlow(arg_73_0)
	if arg_73_0._cardLevelChangeFlow then
		arg_73_0._cardLevelChangeFlow:unregisterDoneListener(arg_73_0._onCardLevelChangeFlowDone, arg_73_0)
		arg_73_0._cardLevelChangeFlow:stop()

		arg_73_0._cardLevelChangeFlow = nil
	end

	if arg_73_0._dissolveFlow then
		arg_73_0._dissolveFlow:stop()

		arg_73_0._dissolveFlow = nil
	end

	if arg_73_0._cardDisplayFlow then
		arg_73_0._cardDisplayFlow:stop()

		arg_73_0._cardDisplayFlow = nil
	end

	if arg_73_0._cardDisplayEndFlow then
		arg_73_0._cardDisplayEndFlow:stop()

		arg_73_0._cardDisplayEndFlow = nil
	end

	if arg_73_0._disappearFlow then
		if not gohelper.isNil(arg_73_0.go) then
			gohelper.onceAddComponent(arg_73_0.go, gohelper.Type_CanvasGroup).alpha = 1
		end

		arg_73_0._disappearFlow:stop()

		arg_73_0._disappearFlow = nil
	end
end

function var_0_0.onDestroy(arg_74_0)
	if arg_74_0._loader then
		arg_74_0._loader:disposeSelf()

		arg_74_0._loader = nil
	end

	if arg_74_0.hideVxLoader then
		arg_74_0.hideVxLoader:dispose()

		arg_74_0.hideVxLoader = nil
	end

	arg_74_0:releaseEffectFlow()

	for iter_74_0, iter_74_1 in pairs(arg_74_0._lvGOs) do
		arg_74_0._lvImgIcons[iter_74_0]:UnLoadImage()
	end

	arg_74_0._tag:UnLoadImage()
	arg_74_0:clearAlfEffect()
end

function var_0_0._hideAllEffect(arg_75_0)
	arg_75_0:_hideUpgradeEffects()
	arg_75_0:_hideEnchantsEffect()
	gohelper.setActive(arg_75_0.goPreDelete, false)
end

var_0_0.AlfLoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}

function var_0_0.tryPlayAlfEffect(arg_76_0)
	if not arg_76_0._cardInfoMO then
		return
	end

	if not FightHeroALFComp.ALFSkillDict[arg_76_0._cardInfoMO.clientData.custom_fromSkillId] then
		return
	end

	arg_76_0.showAlfEffectIng = true

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectAppear, arg_76_0)

	if arg_76_0.alfLoadStatus == var_0_0.AlfLoadStatus.Loaded then
		arg_76_0:_tryPlayAlfEffect()
	elseif arg_76_0.alfLoadStatus == var_0_0.AlfLoadStatus.Loading then
		-- block empty
	else
		arg_76_0.alfLoadStatus = var_0_0.AlfLoadStatus.Loading
		arg_76_0.alfLoader = PrefabInstantiate.Create(arg_76_0.tr.parent.gameObject)

		local var_76_0 = FightHeroSpEffectConfig.instance:getAlfCardAddEffect()

		arg_76_0.alfLoader:startLoad(var_76_0, arg_76_0.onLoadedAlfEffect, arg_76_0)
	end
end

function var_0_0.onLoadedAlfEffect(arg_77_0)
	arg_77_0.goAlfAddCardEffect = arg_77_0.alfLoader:getInstGO()
	arg_77_0.goAlfAddCardAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_77_0.goAlfAddCardEffect)
	arg_77_0.alfLoadStatus = var_0_0.AlfLoadStatus.Loaded

	arg_77_0:_tryPlayAlfEffect()
end

function var_0_0._tryPlayAlfEffect(arg_78_0)
	if not arg_78_0.goAlfAddCardAnimatorPlayer then
		return
	end

	gohelper.setActive(arg_78_0.go, false)
	gohelper.setActive(arg_78_0.goAlfAddCardEffect, true)
	arg_78_0.goAlfAddCardAnimatorPlayer:Play("open", arg_78_0.playAlfCloseAnim, arg_78_0)
end

function var_0_0.playAlfCloseAnim(arg_79_0)
	arg_79_0.goAlfAddCardAnimatorPlayer:Play("close", arg_79_0.playAlfCloseAnimDone, arg_79_0)
	TaskDispatcher.runDelay(arg_79_0.showCardGo, arg_79_0, 0.2 / FightModel.instance:getUISpeed())
end

function var_0_0.showCardGo(arg_80_0)
	gohelper.setActive(arg_80_0.go, true)
	arg_80_0:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")
end

function var_0_0.playAlfCloseAnimDone(arg_81_0)
	gohelper.setActive(arg_81_0.goAlfAddCardEffect, false)

	arg_81_0.showAlfEffectIng = false

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectEnd, arg_81_0)
end

function var_0_0.showHightLightEffect(arg_82_0, arg_82_1)
	if arg_82_0.highlightEffect then
		for iter_82_0, iter_82_1 in ipairs(arg_82_0.highlightEffect) do
			if iter_82_1 then
				gohelper.setActive(iter_82_1, arg_82_1)
			end
		end
	end
end

function var_0_0.clearAlfEffect(arg_83_0)
	if arg_83_0.alfLoader then
		arg_83_0.alfLoader:dispose()

		arg_83_0.alfLoader = nil
	end

	arg_83_0.alfLoadStatus = var_0_0.AlfLoadStatus.None
	arg_83_0.goAlfAddCardEffect = nil

	if arg_83_0.goAlfAddCardAnimatorPlayer then
		arg_83_0.goAlfAddCardAnimatorPlayer:Stop()

		arg_83_0.goAlfAddCardAnimatorPlayer = nil
	end

	TaskDispatcher.cancelTask(arg_83_0.showCardGo, arg_83_0)
end

return var_0_0
