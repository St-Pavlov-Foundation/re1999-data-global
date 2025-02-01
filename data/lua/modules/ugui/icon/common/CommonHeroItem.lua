module("modules.ugui.icon.common.CommonHeroItem", package.seeall)

slot0 = class("CommonHeroItem", ListScrollCell)

function slot0._setTxtWidth(slot0, slot1, slot2)
	if not slot0[slot1] then
		return
	end

	recthelper.setWidth(slot0[slot1].transform, slot2 or 0)
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._btnClick = gohelper.getClick(slot1)
	slot0._lvObj = gohelper.findChild(slot1, "lv")
	slot0._lvTxt = gohelper.findChildText(slot1, "lv/lvltxt")
	slot0._lvTxtEn = gohelper.findChildText(slot1, "lv/lv")
	slot0._nameCnTxt = gohelper.findChildText(slot1, "namecn")
	slot0._nameEnTxt = gohelper.findChildText(slot1, "nameen")
	slot0._newObj = gohelper.findChild(slot1, "new")
	slot0._gofavor = gohelper.findChild(slot1, "favor")
	slot0._rankObj = gohelper.findChild(slot1, "rankobj")
	slot0._rankObjEmpty = gohelper.findChild(slot1, "verticalList/lvnum/rankobj_empty") or gohelper.findChild(slot1, "rankobj")
	slot0._breakObj = gohelper.findChild(slot1, "breakobj")
	slot0._maskgray = gohelper.findChild(slot1, "maskgray")
	slot0._cardIcon = gohelper.findChild(slot1, "mask/charactericon") or gohelper.findChild(slot1, "charactericon")
	slot0._careerIcon = gohelper.findChildImage(slot1, "career")
	slot0._injury1 = gohelper.findChild(slot1, "deephurt")
	slot0._gohurtcn = gohelper.findChild(slot1, "deephurt/hurtcn")
	slot0._gohurten = gohelper.findChild(slot1, "deephurt/hurten")
	slot0._gorestrict = gohelper.findChild(slot1, "restrict")
	slot0._selectframe = gohelper.findChild(slot1, "selectframe")
	slot0._injuryselectframe = gohelper.findChild(slot1, "injuryselectframe")
	slot0._front = gohelper.findChildImage(slot1, "mask/front") or gohelper.findChildImage(slot1, "front")
	slot0._gobuff = gohelper.findChild(slot1, "#go_buff")
	slot0._imagebuff = gohelper.findChildImage(slot1, "#go_buff/#image_buff") or gohelper.findChildImage(slot1, "#image_buff")
	slot0._simagebufftuan = gohelper.findChildSingleImage(slot1, "#go_buff/#simage_bufftuan") or gohelper.findChildSingleImage(slot1, "#simage_bufftuan")
	slot0._goheroitemreddot = gohelper.findChild(slot1, "#go_heroitemreddot")
	slot0._goexskill = gohelper.findChild(slot1, "#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot1, "#go_exskill/#image_exskill")
	slot0._inteam = gohelper.findChild(slot1, "inteam")
	slot0._current = gohelper.findChild(slot1, "current")
	slot0._aid = gohelper.findChild(slot1, "aid")
	slot0._gochoose = gohelper.findChild(slot1, "#go_choose")
	slot0._go1st = gohelper.findChild(slot1, "#go_choose/#go_1st")
	slot0._go2nd = gohelper.findChild(slot1, "#go_choose/#go_2nd")
	slot0._go3rd = gohelper.findChild(slot1, "#go_choose/#go_3rd")
	slot0._goeffect = gohelper.findChild(slot1, "effect")
	slot0._gorareEffect1 = gohelper.findChild(slot1, "effect/r")
	slot0._gorareEffect2 = gohelper.findChild(slot1, "effect/sr")
	slot0._gorareEffect3 = gohelper.findChild(slot1, "effect/ssr")
	slot0._goTrialTag = gohelper.findChild(slot1, "trialTag")
	slot0._txtTrialTag = gohelper.findChildTextMesh(slot1, "trialTag/#txt_trialTag")
	slot0._goTrialRepeat = gohelper.findChild(slot1, "trialRepeat")
	slot0._animRepeat = slot0._goTrialRepeat:GetComponent(typeof(UnityEngine.Animator))

	slot0:_initObj()

	slot0._commonHeroCard = CommonHeroCard.create(slot0._cardIcon, slot0.__cname)
	slot0._goSeasonMask = gohelper.findChild(slot1, "seasonmask")
	slot0._goCenterTxt = gohelper.findChild(slot1, "centerTxt")
	slot0._txtCenterTxt = gohelper.findChildTextMesh(slot1, "centerTxt/txtcn")
end

function slot0._initObj(slot0)
	slot0._hideFavor = false

	if slot0._breakObj then
		slot0._breakImgs = {}

		for slot4 = 1, 6 do
			slot0._breakImgs[slot4] = gohelper.findChildImage(slot0._breakObj, "break" .. tostring(slot4))
		end
	end

	slot0._rankGOs = slot0:getUserDataTb_()
	slot0._rankEmptyGOs = slot0:getUserDataTb_()

	if slot0._rankGOs then
		for slot4 = 1, 3 do
			table.insert(slot0._rankGOs, gohelper.findChildImage(slot0._rankObj, "rank" .. slot4))
			table.insert(slot0._rankEmptyGOs, gohelper.findChildImage(slot0._rankObjEmpty, "rank" .. slot4))
		end
	end

	slot0._rareEffectGOs = slot0:getUserDataTb_()

	table.insert(slot0._rareEffectGOs, slot0._gorareEffect1)
	table.insert(slot0._rareEffectGOs, slot0._gorareEffect2)
	table.insert(slot0._rareEffectGOs, slot0._gorareEffect3)

	for slot4, slot5 in ipairs(slot0._rareEffectGOs) do
		gohelper.setActive(slot5, false)
	end

	slot0._callback = nil
	slot0._callbackObj = nil

	gohelper.setActive(slot0._injury1, false)
	gohelper.setActive(slot0._gorestrict, false)
	gohelper.setActive(slot0._selectframe, false)
	gohelper.setActive(slot0._injuryselectframe, false)
	gohelper.setActive(slot0._gobuff, false)
	gohelper.setActive(slot0._inteam, false)
	gohelper.setActive(slot0._current, false)
	gohelper.setActive(slot0._aid, false)
	gohelper.setActive(slot0._gochoose, false)
	gohelper.setActive(slot0._rankObj, true)
	gohelper.setActive(slot0._rankObjEmpty, true)
	gohelper.setActive(slot0._goTrialTag, false)
	gohelper.setActive(slot0._goTrialRepeat, false)
	gohelper.setActive(slot0._goCenterTxt, false)

	slot0.injuryAnim = slot0._injury1:GetComponent(typeof(UnityEngine.Animator))
	slot0.exSkillFillAmount = {
		0.2,
		0.4,
		0.6,
		0.79,
		1
	}

	slot0:isShowSeasonMask(false)
end

function slot0.addClickListener(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
end

function slot0.addClickDownListener(slot0, slot1, slot2)
	slot0._clickDownCallback = slot1
	slot0._clickDownCallbackObj = slot2
end

function slot0.addClickUpListener(slot0, slot1, slot2)
	slot0._clickUpCallback = slot1
	slot0._clickUpCallbackObj = slot2
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0._onItemClick, slot0)
	slot0._btnClick:AddClickDownListener(slot0._onItemClickDown, slot0)
	slot0._btnClick:AddClickUpListener(slot0._onItemClickUp, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0._btnClick:RemoveClickUpListener()
	slot0._btnClick:RemoveClickDownListener()
end

function slot0._onItemClick(slot0)
	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj, slot0._mo)
		else
			slot0._callback(slot0._mo)
		end
	end
end

function slot0._onItemClickDown(slot0)
	if slot0._clickDownCallback and slot0._clickDownCallbackObj then
		slot0._clickDownCallback(slot0._clickDownCallbackObj)
	end
end

function slot0._onItemClickUp(slot0)
	if slot0._clickUpCallback and slot0._clickUpCallbackObj then
		slot0._clickUpCallback(slot0._clickUpCallbackObj)
	end
end

function slot0.setLevel(slot0, slot1, slot2)
	if slot2 and slot2 == slot0._mo.heroId then
		slot0._lvTxt.text = HeroConfig.instance:getShowLevel(slot1)
	else
		slot0._lvTxt.text = HeroConfig.instance:getShowLevel(slot0._mo.level)
	end
end

function slot0.setTrialTxt(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._goTrialTag, true)

		slot0._txtTrialTag.text = slot1
	else
		gohelper.setActive(slot0._goTrialTag, false)
	end
end

function slot0.setBalanceLv(slot0, slot1)
	slot2, slot3 = HeroConfig.instance:getShowLevel(slot1)
	slot0._lvTxt.text = "<color=#bfdaff>" .. slot2

	if slot0._lvTxtEn then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._lvTxtEn, "#bfdaff")
	end

	if slot0._rankObj then
		slot0:_fillStarContent(slot0._mo.config.rare, slot3, true)
	end
end

function slot0.setTrialRepeat(slot0, slot1)
	gohelper.setActive(slot0._goTrialRepeat, slot1)
end

function slot0.setRepeatAnimFinish(slot0)
	if not slot0._goTrialRepeat.activeSelf then
		return
	end

	slot0._animRepeat:Play(UIAnimationName.Open, 0, 1)
end

function slot0.getIsRepeat(slot0)
	return slot0._goTrialRepeat.activeSelf
end

function slot0.hideFavor(slot0, slot1)
	slot0._hideFavor = slot1
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._lvTxt.text = HeroConfig.instance:getShowLevel(CharacterModel.instance:getFakeLevel(slot0._mo.heroId) or slot1.level)

	if slot0._lvTxtEn then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._lvTxtEn, "#E9E9E9")
	end

	if slot0._nameCnTxt then
		slot0._nameCnTxt.text = slot1:getHeroName()
	end

	if slot0._nameEnTxt then
		slot0._nameEnTxt.text = slot1.config.nameEng
	end

	if slot0._newObj then
		gohelper.setActive(slot0._newObj, slot1.isNew)
	end

	if slot0._gofavor then
		gohelper.setActive(slot0._gofavor, slot1.isFavor and not slot0._hideFavor)
	end

	if slot0._breakObj then
		slot0:_fillBreakContent(slot1.exSkillLevel)
	end

	if slot0._rankObj then
		slot0:_fillStarContent(slot1.config.rare, slot1.rank)
	end

	slot0:updateHero()
	slot0:_updateExSkill()
end

function slot0.setAdventureBuff(slot0, slot1)
	gohelper.setActive(slot0._gobuff, slot1 and slot1 > 0)

	if slot1 and slot1 > 0 then
		slot2 = lua_adventure_buff.configDict[slot1]

		UISpriteSetMgr.instance:setCommonSprite(slot0._imagebuff, "bgbuffdi" .. tostring(slot2.rare))
		slot0._simagebufftuan:LoadImage(ResUrl.getAdventureTarotSmallIcon(tostring(slot2.icon)))
	end
end

function slot0.setHeroGroupType(slot0)
	slot0._heroGroupType = true
end

function slot0.updateHero(slot0)
	if slot0._heroGroupType then
		UISpriteSetMgr.instance:setHeroGroupSprite(slot0._front, "bg_pz00" .. tostring(CharacterEnum.Color[slot0._mo.config.rare]))
	else
		UISpriteSetMgr.instance:setCommonSprite(slot0._front, "bg_pz00" .. tostring(CharacterEnum.Color[slot0._mo.config.rare]))
		slot0:_showRareEffect(CharacterEnum.Color[slot0._mo.config.rare])
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._careerIcon, "lssx_" .. tostring(slot0._mo.config.career))

	if not SkinConfig.instance:getSkinCo(slot0._mo.skin or HeroModel.instance:getByHeroId(slot0._mo.heroId).skin) then
		logError("找不到皮肤配置, id: " .. tostring(slot1.skin))

		return
	end

	slot0._commonHeroCard:onUpdateMO(slot2)
end

function slot0._updateExSkill(slot0)
	if slot0._mo.exSkillLevel <= 0 then
		gohelper.setActive(slot0._goexskill, false)

		return
	end

	gohelper.setActive(slot0._goexskill, true)

	slot0._imageexskill.fillAmount = slot0.exSkillFillAmount[slot0._mo.exSkillLevel] or 1
end

function slot0.setExSkillActive(slot0, slot1)
	gohelper.setActive(slot0._goexskill, slot1)
end

function slot0._showRareEffect(slot0, slot1)
	for slot5 = 1, 3 do
		gohelper.setActive(slot0._rareEffectGOs[slot5], slot1 - 3 == slot5)
	end
end

function slot0.setEffectVisible(slot0, slot1)
	gohelper.setActive(slot0._goeffect, slot1)
end

function slot0.setInjuryTxtVisible(slot0, slot1)
	gohelper.setActive(slot0._injury1, slot1)
end

function slot0.setInjury(slot0, slot1)
	gohelper.setActive(slot0._injury1, slot1)
	slot0:setDamage(slot1)
end

function slot0.setDamage(slot0, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._careerIcon.gameObject, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._front.gameObject, slot1)

	slot0._isInjury = slot1

	if slot1 then
		if not CommonHeroHelper.instance:getGrayState(slot0._mo.config.id) then
			TaskDispatcher.runDelay(slot0.onInjuryAnimFinished, slot0, 0.5)

			slot0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.8, slot0.setGrayFactor, nil, slot0)

			CommonHeroHelper.instance:setGrayState(slot0._mo.config.id, true)
		else
			slot0._commonHeroCard:setGrayFactor(1)
			slot0._commonHeroCard:setGrayScale(true)
			slot0:onInjuryAnimFinished()
		end
	else
		if slot0.tweenid then
			ZProj.TweenHelper.KillById(slot0.tweenid)
			TaskDispatcher.cancelTask(slot0.onInjuryAnimFinished, slot0)
		end

		slot0._commonHeroCard:setGrayScale(false)
	end
end

function slot0.setRestrict(slot0, slot1)
	gohelper.setActive(slot0._gorestrict, slot1)

	slot0._isInjury = false
	slot0._isRestrict = slot1

	gohelper.setActive(slot0._gohurtcn, not slot1)
	gohelper.setActive(slot0._gohurten, not slot1)
end

function slot0.setGrayFactor(slot0, slot1)
	slot0._commonHeroCard:setGrayFactor(slot1)
end

function slot0.onInjuryAnimFinished(slot0)
	slot0.injuryAnim:Play(UIAnimationName.Idle, 0, 1)
end

function slot0.setSelect(slot0, slot1)
	if slot0._isRestrict then
		gohelper.setActive(slot0._injuryselectframe, false)
		gohelper.setActive(slot0._selectframe, false)

		return
	end

	if slot0._isInjury then
		gohelper.setActive(slot0._injuryselectframe, slot1)
	else
		gohelper.setActive(slot0._selectframe, slot1)
	end
end

function slot0.setLevelContentShow(slot0, slot1)
	gohelper.setActive(slot0._lvObj, slot1)
	gohelper.setActive(slot0._lvTxt and slot0._lvTxt.gameObject, slot1)
end

function slot0.setNameContentShow(slot0, slot1)
	gohelper.setActive(slot0._nameCnTxt.gameObject, slot1)
	gohelper.setActive(slot0._nameEnTxt.gameObject, slot1)
end

function slot0.setRedDotShow(slot0, slot1)
	if slot0._mo.isNew then
		slot1 = false
	end

	gohelper.setActive(slot0._goheroitemreddot, slot1)
end

function slot0.setInteam(slot0, slot1)
	gohelper.setActive(slot0._inteam, false)
	gohelper.setActive(slot0._current, false)
	gohelper.setActive(slot0._aid, false)

	if slot1 == 1 then
		gohelper.setActive(slot0._inteam, true)
	elseif slot1 == 2 then
		gohelper.setActive(slot0._current, true)
	elseif slot1 == 3 then
		gohelper.setActive(slot0._aid, true)
	end
end

function slot0.setChoose(slot0, slot1)
	gohelper.setActive(slot0._gochoose, slot1)
	gohelper.setActive(slot0._go1st, false)
	gohelper.setActive(slot0._go2nd, false)
	gohelper.setActive(slot0._go3rd, false)

	if slot1 == 1 then
		gohelper.setActive(slot0._go1st, true)
	elseif slot1 == 2 then
		gohelper.setActive(slot0._go2nd, true)
	elseif slot1 == 3 then
		gohelper.setActive(slot0._go3rd, true)
	end
end

function slot0.setNewShow(slot0, slot1)
	if slot0._newObj then
		gohelper.setActive(slot0._newObj, slot1)
	end
end

function slot0.isShowSeasonMask(slot0, slot1)
	if gohelper.isNil(slot0._goSeasonMask) then
		return
	end

	gohelper.setActive(slot0._goSeasonMask, slot1)
end

function slot0._fillBreakContent(slot0, slot1)
	for slot5 = 1, 6 do
		if slot5 <= slot1 then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._breakImgs[slot5], "#d7a93d")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._breakImgs[slot5], "#626467")
		end
	end
end

function slot0._fillStarContent(slot0, slot1, slot2, slot3)
	for slot7 = 1, 3 do
		slot8 = slot0._rankGOs[slot7]
		slot9 = slot0._rankEmptyGOs[slot7]

		if slot3 then
			if slot8 then
				SLFramework.UGUI.GuiHelper.SetColor(slot8, "#a9c7f1")
			end

			if slot9 then
				SLFramework.UGUI.GuiHelper.SetColor(slot9, "#a9c7f1")
			end
		else
			if slot8 then
				SLFramework.UGUI.GuiHelper.SetColor(slot8, "#F6F3EC")
			end

			if slot9 then
				SLFramework.UGUI.GuiHelper.SetColor(slot9, "#F6F3EC")
			end
		end

		gohelper.setActive(slot8, slot7 == slot2 - 1)
		gohelper.setActive(slot9, slot7 == slot2 - 1)
	end
end

function slot0._fillStarContentColor(slot0, slot1, slot2, slot3, slot4)
	for slot8 = 1, 3 do
		slot10 = slot0._rankEmptyGOs[slot8]

		if slot0._rankGOs[slot8] then
			SLFramework.UGUI.GuiHelper.SetColor(slot9, slot3 or slot4)
		end

		if slot10 then
			SLFramework.UGUI.GuiHelper.SetColor(slot10, slot3 or slot4)
		end

		gohelper.setActive(slot9, slot8 == slot2 - 1)
		gohelper.setActive(slot10, slot8 == slot2 - 1)
	end
end

function slot0._setTranScale(slot0, slot1, slot2, slot3, slot4)
	if not slot0[slot1] then
		return
	end

	transformhelper.setLocalScale(slot0[slot1].transform, slot2 or 1, slot3 or 1, slot4 or 1)
end

function slot0._setTxtPos(slot0, slot1, slot2, slot3)
	if not slot0[slot1] then
		return
	end

	recthelper.setAnchor(slot0[slot1].transform, slot2, slot3)
end

function slot0._setTxtSizeScale(slot0, slot1, slot2, slot3)
	if not slot0[slot1] then
		return
	end

	slot0[slot1].transform.sizeDelta = Vector2(slot0[slot1].transform.sizeDelta.x * slot2, slot0[slot1].transform.sizeDelta.y * slot3)
end

function slot0.setRankObjEmptyShow(slot0, slot1)
	gohelper.setActive(slot0._rankObj, slot1)
	gohelper.setActive(slot0._rankObjEmpty, not slot1)
end

function slot0.setRankObjActive(slot0, slot1)
	gohelper.setActive(slot0._rankObj, slot1)
	gohelper.setActive(slot0._rankObjEmpty, slot1)
end

function slot0.setCenterTxt(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._goCenterTxt, true)

		slot0._txtCenterTxt.text = slot1
	else
		gohelper.setActive(slot0._goCenterTxt, false)
	end
end

function slot0.onDestroy(slot0)
	if slot0._simagebufftuan then
		slot0._simagebufftuan:UnLoadImage()

		slot0._simagebufftuan = nil
	end

	slot0._callback = nil
	slot0._callbackObj = nil
	slot0._careerIcon = nil
	slot0._front = nil
	slot0._frame = nil

	TaskDispatcher.cancelTask(slot0.onInjuryAnimFinished, slot0)

	if slot0.tweenid then
		ZProj.TweenHelper.KillById(slot0.tweenid)
	end
end

return slot0
