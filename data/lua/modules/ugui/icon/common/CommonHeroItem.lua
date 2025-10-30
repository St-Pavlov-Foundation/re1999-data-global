module("modules.ugui.icon.common.CommonHeroItem", package.seeall)

local var_0_0 = class("CommonHeroItem", ListScrollCell)

function var_0_0._setTxtWidth(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_0[arg_1_1] then
		return
	end

	recthelper.setWidth(arg_1_0[arg_1_1].transform, arg_1_2 or 0)
end

function var_0_0._setWH(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_0[arg_2_1] then
		return
	end

	recthelper.setSize(arg_2_0[arg_2_1].transform, arg_2_2 or 0, arg_2_3 or 0)
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0._btnClick = gohelper.getClick(arg_3_1)
	arg_3_0._lvObj = gohelper.findChild(arg_3_1, "lv")
	arg_3_0._lvTxt = gohelper.findChildText(arg_3_1, "lv/lvltxt")
	arg_3_0._lvTxtEn = gohelper.findChildText(arg_3_1, "lv/lv")
	arg_3_0._nameCnTxt = gohelper.findChildText(arg_3_1, "namecn")
	arg_3_0._nameEnTxt = gohelper.findChildText(arg_3_1, "nameen")
	arg_3_0._newObj = gohelper.findChild(arg_3_1, "new")
	arg_3_0._gofavor = gohelper.findChild(arg_3_1, "favor")
	arg_3_0._rankObj = gohelper.findChild(arg_3_1, "rankobj")
	arg_3_0._rankObjEmpty = gohelper.findChild(arg_3_1, "verticalList/lvnum/rankobj_empty") or gohelper.findChild(arg_3_1, "rankobj")
	arg_3_0._breakObj = gohelper.findChild(arg_3_1, "breakobj")
	arg_3_0._maskgray = gohelper.findChild(arg_3_1, "maskgray")
	arg_3_0._cardIcon = gohelper.findChild(arg_3_1, "mask/charactericon") or gohelper.findChild(arg_3_1, "charactericon")
	arg_3_0._careerIcon = gohelper.findChildImage(arg_3_1, "career")
	arg_3_0._injury1 = gohelper.findChild(arg_3_1, "deephurt")
	arg_3_0._gohurtcn = gohelper.findChild(arg_3_1, "deephurt/hurtcn")
	arg_3_0._gohurten = gohelper.findChild(arg_3_1, "deephurt/hurten")
	arg_3_0._gorestrict = gohelper.findChild(arg_3_1, "restrict")
	arg_3_0._selectframe = gohelper.findChild(arg_3_1, "selectframe")
	arg_3_0._injuryselectframe = gohelper.findChild(arg_3_1, "injuryselectframe")
	arg_3_0._front = gohelper.findChildImage(arg_3_1, "mask/front") or gohelper.findChildImage(arg_3_1, "front")
	arg_3_0._gobuff = gohelper.findChild(arg_3_1, "#go_buff")
	arg_3_0._imagebuff = gohelper.findChildImage(arg_3_1, "#go_buff/#image_buff") or gohelper.findChildImage(arg_3_1, "#image_buff")
	arg_3_0._simagebufftuan = gohelper.findChildSingleImage(arg_3_1, "#go_buff/#simage_bufftuan") or gohelper.findChildSingleImage(arg_3_1, "#simage_bufftuan")
	arg_3_0._goheroitemreddot = gohelper.findChild(arg_3_1, "#go_heroitemreddot")
	arg_3_0._goexskill = gohelper.findChild(arg_3_1, "#go_exskill")
	arg_3_0._imageexskill = gohelper.findChildImage(arg_3_1, "#go_exskill/#image_exskill")
	arg_3_0._inteam = gohelper.findChild(arg_3_1, "inteam")
	arg_3_0._current = gohelper.findChild(arg_3_1, "current")
	arg_3_0._aid = gohelper.findChild(arg_3_1, "aid")
	arg_3_0._gochoose = gohelper.findChild(arg_3_1, "#go_choose")
	arg_3_0._go1st = gohelper.findChild(arg_3_1, "#go_choose/#go_1st")
	arg_3_0._go2nd = gohelper.findChild(arg_3_1, "#go_choose/#go_2nd")
	arg_3_0._go3rd = gohelper.findChild(arg_3_1, "#go_choose/#go_3rd")
	arg_3_0._goeffect = gohelper.findChild(arg_3_1, "effect")
	arg_3_0._gorareEffect1 = gohelper.findChild(arg_3_1, "effect/r")
	arg_3_0._gorareEffect2 = gohelper.findChild(arg_3_1, "effect/sr")
	arg_3_0._gorareEffect3 = gohelper.findChild(arg_3_1, "effect/ssr")
	arg_3_0._goTrialTag = gohelper.findChild(arg_3_1, "trialTag")
	arg_3_0._txtTrialTag = gohelper.findChildTextMesh(arg_3_1, "trialTag/#txt_trialTag")
	arg_3_0._goTrialRepeat = gohelper.findChild(arg_3_1, "trialRepeat")
	arg_3_0._animRepeat = arg_3_0._goTrialRepeat:GetComponent(typeof(UnityEngine.Animator))

	arg_3_0:_initObj()

	arg_3_0._commonHeroCard = CommonHeroCard.create(arg_3_0._cardIcon, arg_3_0.__cname)
	arg_3_0._goSeasonMask = gohelper.findChild(arg_3_1, "seasonmask")
	arg_3_0._goCenterTxt = gohelper.findChild(arg_3_1, "centerTxt")
	arg_3_0._txtCenterTxt = gohelper.findChildTextMesh(arg_3_1, "centerTxt/txtcn")
	arg_3_0.goLost = gohelper.findChild(arg_3_1, "lost")
	arg_3_0.rootAnim = gohelper.findChildAnim(arg_3_1, "")
end

function var_0_0._initObj(arg_4_0)
	arg_4_0._hideFavor = false

	if arg_4_0._breakObj then
		arg_4_0._breakImgs = {}

		for iter_4_0 = 1, 6 do
			arg_4_0._breakImgs[iter_4_0] = gohelper.findChildImage(arg_4_0._breakObj, "break" .. tostring(iter_4_0))
		end
	end

	arg_4_0._rankGOs = arg_4_0:getUserDataTb_()
	arg_4_0._rankEmptyGOs = arg_4_0:getUserDataTb_()

	if arg_4_0._rankGOs then
		for iter_4_1 = 1, 3 do
			local var_4_0 = gohelper.findChildImage(arg_4_0._rankObj, "rank" .. iter_4_1)
			local var_4_1 = gohelper.findChildImage(arg_4_0._rankObjEmpty, "rank" .. iter_4_1)

			table.insert(arg_4_0._rankGOs, var_4_0)
			table.insert(arg_4_0._rankEmptyGOs, var_4_1)
		end
	end

	arg_4_0._rareEffectGOs = arg_4_0:getUserDataTb_()

	table.insert(arg_4_0._rareEffectGOs, arg_4_0._gorareEffect1)
	table.insert(arg_4_0._rareEffectGOs, arg_4_0._gorareEffect2)
	table.insert(arg_4_0._rareEffectGOs, arg_4_0._gorareEffect3)

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._rareEffectGOs) do
		gohelper.setActive(iter_4_3, false)
	end

	arg_4_0._callback = nil
	arg_4_0._callbackObj = nil

	gohelper.setActive(arg_4_0._injury1, false)
	gohelper.setActive(arg_4_0._gorestrict, false)
	gohelper.setActive(arg_4_0._selectframe, false)
	gohelper.setActive(arg_4_0._injuryselectframe, false)
	gohelper.setActive(arg_4_0._gobuff, false)
	gohelper.setActive(arg_4_0._inteam, false)
	gohelper.setActive(arg_4_0._current, false)
	gohelper.setActive(arg_4_0._aid, false)
	gohelper.setActive(arg_4_0._gochoose, false)
	gohelper.setActive(arg_4_0._rankObj, true)
	gohelper.setActive(arg_4_0._rankObjEmpty, true)
	gohelper.setActive(arg_4_0._goTrialTag, false)
	gohelper.setActive(arg_4_0._goTrialRepeat, false)
	gohelper.setActive(arg_4_0._goCenterTxt, false)

	arg_4_0.injuryAnim = arg_4_0._injury1:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0.exSkillFillAmount = {
		0.2,
		0.4,
		0.6,
		0.79,
		1
	}

	arg_4_0:isShowSeasonMask(false)
end

function var_0_0.addClickListener(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._callback = arg_5_1
	arg_5_0._callbackObj = arg_5_2
end

function var_0_0.addClickDownListener(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._clickDownCallback = arg_6_1
	arg_6_0._clickDownCallbackObj = arg_6_2
end

function var_0_0.addClickUpListener(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._clickUpCallback = arg_7_1
	arg_7_0._clickUpCallbackObj = arg_7_2
end

function var_0_0.addEventListeners(arg_8_0)
	arg_8_0._btnClick:AddClickListener(arg_8_0._onItemClick, arg_8_0)
	arg_8_0._btnClick:AddClickDownListener(arg_8_0._onItemClickDown, arg_8_0)
	arg_8_0._btnClick:AddClickUpListener(arg_8_0._onItemClickUp, arg_8_0)
end

function var_0_0.removeEventListeners(arg_9_0)
	arg_9_0._btnClick:RemoveClickListener()
	arg_9_0._btnClick:RemoveClickUpListener()
	arg_9_0._btnClick:RemoveClickDownListener()
end

function var_0_0._onItemClick(arg_10_0)
	if arg_10_0._callback then
		if arg_10_0._callbackObj then
			arg_10_0._callback(arg_10_0._callbackObj, arg_10_0._mo)
		else
			arg_10_0._callback(arg_10_0._mo)
		end
	end
end

function var_0_0._onItemClickDown(arg_11_0)
	if arg_11_0._clickDownCallback and arg_11_0._clickDownCallbackObj then
		arg_11_0._clickDownCallback(arg_11_0._clickDownCallbackObj)
	end
end

function var_0_0._onItemClickUp(arg_12_0)
	if arg_12_0._clickUpCallback and arg_12_0._clickUpCallbackObj then
		arg_12_0._clickUpCallback(arg_12_0._clickUpCallbackObj)
	end
end

function var_0_0.setKeepAnim(arg_13_0)
	arg_13_0.rootAnim.keepAnimatorControllerStateOnDisable = true
end

function var_0_0.setLevel(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 and arg_14_2 == arg_14_0._mo.heroId then
		arg_14_0._lvTxt.text = HeroConfig.instance:getShowLevel(arg_14_1)
	else
		arg_14_0._lvTxt.text = HeroConfig.instance:getShowLevel(arg_14_0._mo.level)
	end
end

function var_0_0.setTrialTxt(arg_15_0, arg_15_1)
	if arg_15_1 then
		gohelper.setActive(arg_15_0._goTrialTag, true)

		arg_15_0._txtTrialTag.text = arg_15_1
	else
		gohelper.setActive(arg_15_0._goTrialTag, false)
	end
end

function var_0_0.setBalanceLv(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = HeroConfig.instance:getShowLevel(arg_16_1)

	arg_16_0._lvTxt.text = "<color=#bfdaff>" .. var_16_0

	if arg_16_0._lvTxtEn then
		SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._lvTxtEn, "#bfdaff")
	end

	if arg_16_0._rankObj then
		arg_16_0:_fillStarContent(arg_16_0._mo.config.rare, var_16_1, true)
	end
end

function var_0_0.setTrialRepeat(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._goTrialRepeat, arg_17_1)
end

function var_0_0.setRepeatAnimFinish(arg_18_0)
	if not arg_18_0._goTrialRepeat.activeSelf then
		return
	end

	arg_18_0._animRepeat:Play(UIAnimationName.Open, 0, 1)
end

function var_0_0.getIsRepeat(arg_19_0)
	return arg_19_0._goTrialRepeat.activeSelf
end

function var_0_0.hideFavor(arg_20_0, arg_20_1)
	arg_20_0._hideFavor = arg_20_1
end

function var_0_0.onUpdateMO(arg_21_0, arg_21_1)
	arg_21_0._mo = arg_21_1

	local var_21_0 = CharacterModel.instance:getFakeLevel(arg_21_0._mo.heroId) or arg_21_1.level

	arg_21_0._lvTxt.text = HeroConfig.instance:getShowLevel(var_21_0)

	if arg_21_0._lvTxtEn then
		SLFramework.UGUI.GuiHelper.SetColor(arg_21_0._lvTxtEn, "#E9E9E9")
	end

	if arg_21_0._nameCnTxt then
		arg_21_0._nameCnTxt.text = arg_21_1:getHeroName()
	end

	if arg_21_0._nameEnTxt then
		arg_21_0._nameEnTxt.text = arg_21_1.config.nameEng
	end

	if arg_21_0._newObj then
		gohelper.setActive(arg_21_0._newObj, arg_21_1.isNew)
	end

	if arg_21_0._gofavor then
		gohelper.setActive(arg_21_0._gofavor, arg_21_1.isFavor and not arg_21_0._hideFavor)
	end

	if arg_21_0._breakObj then
		arg_21_0:_fillBreakContent(arg_21_1.exSkillLevel)
	end

	if arg_21_0._rankObj then
		arg_21_0:_fillStarContent(arg_21_1.config.rare, arg_21_1.rank)
	end

	arg_21_0:updateHero()
	arg_21_0:_updateExSkill()
end

function var_0_0.setAdventureBuff(arg_22_0, arg_22_1)
	return
end

function var_0_0.setHeroGroupType(arg_23_0)
	arg_23_0._heroGroupType = true
end

function var_0_0.updateHero(arg_24_0)
	if arg_24_0._heroGroupType then
		UISpriteSetMgr.instance:setHeroGroupSprite(arg_24_0._front, "bg_pz00" .. tostring(CharacterEnum.Color[arg_24_0._mo.config.rare]))
	else
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._front, "bg_pz00" .. tostring(CharacterEnum.Color[arg_24_0._mo.config.rare]))
		arg_24_0:_showRareEffect(CharacterEnum.Color[arg_24_0._mo.config.rare])
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_24_0._careerIcon, "lssx_" .. tostring(arg_24_0._mo.config.career))

	local var_24_0 = HeroModel.instance:getByHeroId(arg_24_0._mo.heroId)
	local var_24_1 = SkinConfig.instance:getSkinCo(arg_24_0._mo.skin or var_24_0.skin)

	if not var_24_1 then
		logError("找不到皮肤配置, id: " .. tostring(var_24_0.skin))

		return
	end

	arg_24_0._commonHeroCard:onUpdateMO(var_24_1)
end

function var_0_0._updateExSkill(arg_25_0)
	if arg_25_0._mo.exSkillLevel <= 0 then
		gohelper.setActive(arg_25_0._goexskill, false)

		return
	end

	gohelper.setActive(arg_25_0._goexskill, true)

	arg_25_0._imageexskill.fillAmount = arg_25_0.exSkillFillAmount[arg_25_0._mo.exSkillLevel] or 1
end

function var_0_0.setExSkillActive(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._goexskill, arg_26_1)
end

function var_0_0._showRareEffect(arg_27_0, arg_27_1)
	for iter_27_0 = 1, 3 do
		gohelper.setActive(arg_27_0._rareEffectGOs[iter_27_0], arg_27_1 - 3 == iter_27_0)
	end
end

function var_0_0.setEffectVisible(arg_28_0, arg_28_1)
	gohelper.setActive(arg_28_0._goeffect, arg_28_1)
end

function var_0_0.setInjuryTxtVisible(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_0._injury1, arg_29_1)
end

function var_0_0.setInjury(arg_30_0, arg_30_1)
	gohelper.setActive(arg_30_0._injury1, arg_30_1)
	arg_30_0:setDamage(arg_30_1)
end

function var_0_0.setDamage(arg_31_0, arg_31_1)
	ZProj.UGUIHelper.SetGrayscale(arg_31_0._careerIcon.gameObject, arg_31_1)
	ZProj.UGUIHelper.SetGrayscale(arg_31_0._front.gameObject, arg_31_1)

	arg_31_0._isInjury = arg_31_1

	if arg_31_1 then
		if not CommonHeroHelper.instance:getGrayState(arg_31_0._mo.config.id) then
			TaskDispatcher.runDelay(arg_31_0.onInjuryAnimFinished, arg_31_0, 0.5)

			arg_31_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.8, arg_31_0.setGrayFactor, nil, arg_31_0)

			CommonHeroHelper.instance:setGrayState(arg_31_0._mo.config.id, true)
		else
			arg_31_0._commonHeroCard:setGrayFactor(1)
			arg_31_0._commonHeroCard:setGrayScale(true)
			arg_31_0:onInjuryAnimFinished()
		end
	else
		if arg_31_0.tweenid then
			ZProj.TweenHelper.KillById(arg_31_0.tweenid)
			TaskDispatcher.cancelTask(arg_31_0.onInjuryAnimFinished, arg_31_0)
		end

		arg_31_0._commonHeroCard:setGrayScale(false)
	end
end

function var_0_0.setRestrict(arg_32_0, arg_32_1)
	gohelper.setActive(arg_32_0._gorestrict, arg_32_1)

	arg_32_0._isInjury = false
	arg_32_0._isRestrict = arg_32_1

	gohelper.setActive(arg_32_0._gohurtcn, not arg_32_1)
	gohelper.setActive(arg_32_0._gohurten, not arg_32_1)
end

function var_0_0.setGrayFactor(arg_33_0, arg_33_1)
	arg_33_0._commonHeroCard:setGrayFactor(arg_33_1)
end

function var_0_0.onInjuryAnimFinished(arg_34_0)
	arg_34_0.injuryAnim:Play(UIAnimationName.Idle, 0, 1)
end

function var_0_0.setSelect(arg_35_0, arg_35_1)
	if arg_35_0._isRestrict then
		gohelper.setActive(arg_35_0._injuryselectframe, false)
		gohelper.setActive(arg_35_0._selectframe, false)

		return
	end

	if arg_35_0._isInjury then
		gohelper.setActive(arg_35_0._injuryselectframe, arg_35_1)
	else
		gohelper.setActive(arg_35_0._selectframe, arg_35_1)
	end
end

function var_0_0.setSelectFrameSize(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = arg_36_0._selectframe.transform

	recthelper.setAnchor(var_36_0, arg_36_3, arg_36_4)
	recthelper.setWidth(var_36_0, arg_36_1)
	recthelper.setHeight(var_36_0, arg_36_2)
end

function var_0_0.setLevelContentShow(arg_37_0, arg_37_1)
	gohelper.setActive(arg_37_0._lvObj, arg_37_1)
	gohelper.setActive(arg_37_0._lvTxt and arg_37_0._lvTxt.gameObject, arg_37_1)
end

function var_0_0.setNameContentShow(arg_38_0, arg_38_1)
	gohelper.setActive(arg_38_0._nameCnTxt.gameObject, arg_38_1)
	gohelper.setActive(arg_38_0._nameEnTxt.gameObject, arg_38_1)
end

function var_0_0.setRedDotShow(arg_39_0, arg_39_1)
	if arg_39_0._mo.isNew then
		arg_39_1 = false
	end

	gohelper.setActive(arg_39_0._goheroitemreddot, arg_39_1)
end

function var_0_0.setInteam(arg_40_0, arg_40_1)
	gohelper.setActive(arg_40_0._inteam, false)
	gohelper.setActive(arg_40_0._current, false)
	gohelper.setActive(arg_40_0._aid, false)

	if arg_40_1 == 1 then
		gohelper.setActive(arg_40_0._inteam, true)
	elseif arg_40_1 == 2 then
		gohelper.setActive(arg_40_0._current, true)
	elseif arg_40_1 == 3 then
		gohelper.setActive(arg_40_0._aid, true)
	end
end

function var_0_0.setChoose(arg_41_0, arg_41_1)
	gohelper.setActive(arg_41_0._gochoose, arg_41_1)
	gohelper.setActive(arg_41_0._go1st, false)
	gohelper.setActive(arg_41_0._go2nd, false)
	gohelper.setActive(arg_41_0._go3rd, false)

	if arg_41_1 == 1 then
		gohelper.setActive(arg_41_0._go1st, true)
	elseif arg_41_1 == 2 then
		gohelper.setActive(arg_41_0._go2nd, true)
	elseif arg_41_1 == 3 then
		gohelper.setActive(arg_41_0._go3rd, true)
	end
end

function var_0_0.setNewShow(arg_42_0, arg_42_1)
	if arg_42_0._newObj then
		gohelper.setActive(arg_42_0._newObj, arg_42_1)
	end
end

function var_0_0.isShowSeasonMask(arg_43_0, arg_43_1)
	if gohelper.isNil(arg_43_0._goSeasonMask) then
		return
	end

	gohelper.setActive(arg_43_0._goSeasonMask, arg_43_1)
end

function var_0_0._fillBreakContent(arg_44_0, arg_44_1)
	for iter_44_0 = 1, 6 do
		if iter_44_0 <= arg_44_1 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_44_0._breakImgs[iter_44_0], "#d7a93d")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_44_0._breakImgs[iter_44_0], "#626467")
		end
	end
end

function var_0_0._fillStarContent(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	for iter_45_0 = 1, 3 do
		local var_45_0 = arg_45_0._rankGOs[iter_45_0]
		local var_45_1 = arg_45_0._rankEmptyGOs[iter_45_0]

		if arg_45_3 then
			if var_45_0 then
				SLFramework.UGUI.GuiHelper.SetColor(var_45_0, "#a9c7f1")
			end

			if var_45_1 then
				SLFramework.UGUI.GuiHelper.SetColor(var_45_1, "#a9c7f1")
			end
		else
			if var_45_0 then
				SLFramework.UGUI.GuiHelper.SetColor(var_45_0, "#F6F3EC")
			end

			if var_45_1 then
				SLFramework.UGUI.GuiHelper.SetColor(var_45_1, "#F6F3EC")
			end
		end

		gohelper.setActive(var_45_0, iter_45_0 == arg_45_2 - 1)
		gohelper.setActive(var_45_1, iter_45_0 == arg_45_2 - 1)
	end
end

function var_0_0._fillStarContentColor(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	for iter_46_0 = 1, 3 do
		local var_46_0 = arg_46_0._rankGOs[iter_46_0]
		local var_46_1 = arg_46_0._rankEmptyGOs[iter_46_0]

		if var_46_0 then
			SLFramework.UGUI.GuiHelper.SetColor(var_46_0, arg_46_3 or arg_46_4)
		end

		if var_46_1 then
			SLFramework.UGUI.GuiHelper.SetColor(var_46_1, arg_46_3 or arg_46_4)
		end

		gohelper.setActive(var_46_0, iter_46_0 == arg_46_2 - 1)
		gohelper.setActive(var_46_1, iter_46_0 == arg_46_2 - 1)
	end
end

function var_0_0._setTranScale(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	if not arg_47_0[arg_47_1] then
		return
	end

	transformhelper.setLocalScale(arg_47_0[arg_47_1].transform, arg_47_2 or 1, arg_47_3 or 1, arg_47_4 or 1)
end

function var_0_0._setTxtPos(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if not arg_48_0[arg_48_1] then
		return
	end

	recthelper.setAnchor(arg_48_0[arg_48_1].transform, arg_48_2, arg_48_3)
end

function var_0_0._setTxtSizeScale(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if not arg_49_0[arg_49_1] then
		return
	end

	local var_49_0 = arg_49_0[arg_49_1].transform.sizeDelta.x * arg_49_2
	local var_49_1 = arg_49_0[arg_49_1].transform.sizeDelta.y * arg_49_3

	arg_49_0[arg_49_1].transform.sizeDelta = Vector2(var_49_0, var_49_1)
end

function var_0_0.setRankObjEmptyShow(arg_50_0, arg_50_1)
	gohelper.setActive(arg_50_0._rankObj, arg_50_1)
	gohelper.setActive(arg_50_0._rankObjEmpty, not arg_50_1)
end

function var_0_0.setRankObjActive(arg_51_0, arg_51_1)
	gohelper.setActive(arg_51_0._rankObj, arg_51_1)
	gohelper.setActive(arg_51_0._rankObjEmpty, arg_51_1)
end

function var_0_0.setCenterTxt(arg_52_0, arg_52_1)
	if arg_52_1 then
		gohelper.setActive(arg_52_0._goCenterTxt, true)

		arg_52_0._txtCenterTxt.text = arg_52_1
	else
		gohelper.setActive(arg_52_0._goCenterTxt, false)
	end
end

function var_0_0.setLost(arg_53_0, arg_53_1)
	gohelper.setActive(arg_53_0.goLost, arg_53_1)
	arg_53_0:setDamage(arg_53_1)
end

function var_0_0.onDestroy(arg_54_0)
	if arg_54_0._simagebufftuan then
		arg_54_0._simagebufftuan:UnLoadImage()

		arg_54_0._simagebufftuan = nil
	end

	arg_54_0._callback = nil
	arg_54_0._callbackObj = nil
	arg_54_0._careerIcon = nil
	arg_54_0._front = nil
	arg_54_0._frame = nil

	TaskDispatcher.cancelTask(arg_54_0.onInjuryAnimFinished, arg_54_0)

	if arg_54_0.tweenid then
		ZProj.TweenHelper.KillById(arg_54_0.tweenid)
	end
end

function var_0_0._setTxtWidth(arg_55_0, arg_55_1, arg_55_2)
	if not arg_55_0[arg_55_1] then
		return
	end

	recthelper.setWidth(arg_55_0[arg_55_1].transform, arg_55_2 or 0)
end

function var_0_0.setStyle_HeroGroupEdit(arg_56_0)
	if SettingsModel.instance:isOverseas() then
		arg_56_0:_setTranScale("_nameCnTxt", 1.25, 1.25)
		arg_56_0:_setTranScale("_nameEnTxt", 1.25, 1.25)
		arg_56_0:_setTranScale("_lvObj", 1.25, 1.25)
		arg_56_0:_setTranScale("_rankObj", 0.22, 0.22)
		arg_56_0:_setTxtPos("_nameCnTxt", 0, 69)
		arg_56_0:_setTxtPos("_nameEnTxt", 0.55, 41.1)
		arg_56_0:_setTxtPos("_lvObj", 1.7, 82)
		arg_56_0:_setTxtPos("_rankObj", 1.7, -107.7)
		arg_56_0:_setWH("_nameCnTxt", 165, 50)

		return
	end

	arg_56_0:_setTranScale("_nameCnTxt", 1.25, 1.25)
	arg_56_0:_setTranScale("_nameEnTxt", 1.25, 1.25)
	arg_56_0:_setTranScale("_lvObj", 1.25, 1.25)
	arg_56_0:_setTranScale("_rankObj", 0.22, 0.22)
	arg_56_0:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	arg_56_0:_setTxtPos("_nameEnTxt", 0.55, 41.1)
	arg_56_0:_setTxtPos("_lvObj", 1.7, 82)
	arg_56_0:_setTxtPos("_rankObj", 1.7, -107.7)
	arg_56_0:_setTxtSizeScale("_nameCnTxt", 0.8, 1)
end

function var_0_0.setStyle_SeasonPickAssist(arg_57_0)
	arg_57_0:_setTxtWidth("_nameCnTxt", 205)
	arg_57_0:_setTranScale("_nameCnTxt", 1, 1)
	arg_57_0:_setTranScale("_nameEnTxt", 1, 1)
	arg_57_0:_setTranScale("_lvObj", 1, 1)
	arg_57_0:_setTranScale("_rankObj", 0.18, 0.18)
	arg_57_0:_setTxtPos("_rankObj", 2, -37)
	arg_57_0:_setTxtPos("_lvObj", 1.7, 178.6)
	arg_57_0:_setTxtPos("_nameCnTxt", 0.55, 153.4)
	arg_57_0:_setTxtPos("_nameEnTxt", 0.55, 124.3)
	arg_57_0:_setTxtPos("_goexskill", 1.7, -170)
end

function var_0_0.setStyle_RougePickAssist(arg_58_0)
	arg_58_0:_setTxtWidth("_nameCnTxt", 205)
	arg_58_0:_setTranScale("_nameCnTxt", 1, 1)
	arg_58_0:_setTranScale("_nameEnTxt", 1, 1)
	arg_58_0:_setTranScale("_lvObj", 1, 1)
	arg_58_0:_setTranScale("_rankObj", 0.2, 0.2)
	arg_58_0:_setTxtPos("_rankObj", 2, -37)
	arg_58_0:_setTxtPos("_lvObj", 1.7, 165)
	arg_58_0:_setTxtPos("_nameCnTxt", 0.55, 153.4)
	arg_58_0:_setTxtPos("_nameEnTxt", 0.55, 124.3)
	arg_58_0:_setTxtPos("_goexskill", 1.7, -170)
end

function var_0_0.setStyle_CharacterBackpack(arg_59_0)
	if SettingsModel.instance:isOverseas() then
		arg_59_0:_setTranScale("_nameCnTxt", 1, 1)
		arg_59_0:_setTranScale("_nameEnTxt", 1, 1)
		arg_59_0:_setTranScale("_lvObj", 1, 1)
		arg_59_0:_setTranScale("_rankObj", 0.18, 0.18)
		arg_59_0:_setTxtPos("_nameCnTxt", 0, 69)
		arg_59_0:_setTxtPos("_nameEnTxt", 1.1, 42.29)
		arg_59_0:_setTxtPos("_lvObj", 2.02, 75)
		arg_59_0:_setTxtPos("_rankObj", 1.06, -127.22)
		arg_59_0:_setWH("_nameCnTxt", 205, 50)

		return
	end

	arg_59_0:_setTxtWidth("_nameCnTxt", 205)
	arg_59_0:_setTranScale("_nameCnTxt", 1, 1)
	arg_59_0:_setTranScale("_nameEnTxt", 1, 1)
	arg_59_0:_setTranScale("_lvObj", 1, 1)
	arg_59_0:_setTranScale("_rankObj", 0.18, 0.18)
	arg_59_0:_setTxtPos("_nameCnTxt", 0.99, 68.9)
	arg_59_0:_setTxtPos("_nameEnTxt", 1.1, 42.29)
	arg_59_0:_setTxtPos("_lvObj", 2.02, 75)
	arg_59_0:_setTxtPos("_rankObj", 1.06, -127.22)
end

function var_0_0.setStyle_SurvivalHeroGroupEdit(arg_60_0)
	arg_60_0:_setTranScale("_nameCnTxt", 1.25, 1.25)
	arg_60_0:_setTranScale("_nameEnTxt", 1.25, 1.25)
	arg_60_0:_setTranScale("_lvObj", 1.25, 1.25)
	arg_60_0:_setTranScale("_rankObj", 0.22, 0.22)
	arg_60_0:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	arg_60_0:_setTxtPos("_nameEnTxt", 0.55, 36.1)
	arg_60_0:_setTxtPos("_lvObj", 1.7, 75)
	arg_60_0:_setTxtPos("_rankObj", 1.7, -107.7)
end

return var_0_0
