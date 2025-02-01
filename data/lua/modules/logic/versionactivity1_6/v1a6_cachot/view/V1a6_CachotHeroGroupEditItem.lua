module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditItem", package.seeall)

slot0 = class("V1a6_CachotHeroGroupEditItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)

	slot0._hptextwhite = gohelper.findChildText(slot1, "hpbg/hptextwhite")
	slot0._hptextred = gohelper.findChildText(slot1, "hpbg/hptextred")
	slot0._hpimage = gohelper.findChildImage(slot1, "hpbg/hp")
	slot0._goselect = gohelper.findChild(slot1, "#go_select")
	slot0._gohp = gohelper.findChild(slot1, "#go_hp")
	slot0._sliderhp = gohelper.findChildSlider(slot1, "#go_hp/#slider_hp")
	slot0._godead = gohelper.findChild(slot1, "#go_dead")

	gohelper.setActive(slot0._goselect, false)
	gohelper.setActive(slot0._gohp, false)
	gohelper.setActive(slot0._godead, false)
	slot0:_initObj(slot1)
end

function slot0._initObj(slot0, slot1)
	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._isSelect = false
	slot0._enableDeselect = true

	transformhelper.setLocalScale(slot1.transform, 0.8, 0.8, 1)

	slot2 = GameConfig:GetCurLangType() == LangSettings.zh and 1.25 or 1

	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	slot0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 40)
	slot0._heroItem:_setTxtPos("_lvObj", 1.7, 80)
	slot0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	slot0._heroItem:_setTranScale("_nameCnTxt", slot2, slot2)
	slot0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)

	slot0._heroGroupModel = V1a6_CachotHeroGroupModel.instance
	slot0._heroSingleGroupModel = V1a6_CachotHeroSingleGroupModel.instance
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._onSkinChanged, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, slot0.updateTrialRepeat, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._onSkinChanged(slot0)
	slot0._heroItem:updateHero()
end

function slot0.setAdventureBuff(slot0, slot1)
	slot0._heroItem:setAdventureBuff(slot1)
end

function slot0.updateLimitStatus(slot0)
	if HeroGroupQuickEditListModel.instance.adventure then
		gohelper.setActive(slot0._gohp, false)
		slot0._heroItem:setInjury(WeekWalkModel.instance:getCurMapHeroCd(slot0._mo.config.id) > 0)
	else
		gohelper.setActive(slot0._gohp, false)

		if slot0._heroGroupModel:isRestrict(slot0._mo.uid) then
			slot0._heroItem:setRestrict(true)
		else
			slot0._heroItem:setRestrict(false)
		end
	end
end

function slot0._updateBySeatLevel(slot0)
	slot2 = slot0._mo.level

	if V1a6_CachotHeroGroupEditListModel.instance:getSeatLevel() then
		slot2 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(slot0._mo, slot3)
	end

	slot4, slot5 = HeroConfig.instance:getShowLevel(slot2)
	slot0._heroItem._lvTxt.text = tostring(slot4)
	slot7, slot8 = nil
	slot9 = "#FFFFFF"

	if slot1 ~= slot2 then
		slot7 = "#bfdaff"
		slot8 = "#81abe5"
	else
		slot7 = "#E9E9E9"
		slot8 = "#F6F3EC"
	end

	if slot0._isDead then
		slot9 = "#6F6F6F"
		slot7 = "#6F6F6F"
		slot8 = "#595959"
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._heroItem._lvTxt, slot7)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._heroItem._lvTxtEn, slot7)
	slot0._heroItem:_fillStarContentColor(slot0._mo.config.rare, slot5, slot8)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._heroItem._nameCnTxt, slot9)
	gohelper.setActive(slot0._heroItem._maskgray, slot0._isDead)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)

	if not slot1:isTrial() and slot1.level < HeroGroupBalanceHelper.getHeroBalanceLv(slot1.heroId) then
		slot0._heroItem:setBalanceLv(slot2)
	end

	slot0:updateLimitStatus()
	slot0:updateTrialTag()
	slot0:updateTrialRepeat()

	slot2 = V1a6_CachotHeroGroupEditListModel.instance:isInTeamHero(slot0._mo.uid)
	slot0._inTeam = slot2

	slot0._heroItem:setNewShow(false)
	slot0._heroItem:setInteam(slot2)
	slot0:_updateCachot()
	slot0:_updateBySeatLevel()
end

function slot0._updateCachot(slot0)
	if V1a6_CachotHeroGroupEditListModel.instance:getHeroGroupEditType() == V1a6_CachotEnum.HeroGroupEditType.Init then
		return
	end

	if not V1a6_CachotModel.instance:getTeamInfo():getHeroHp(slot0._mo.heroId) then
		return
	end

	slot3 = slot2 and slot2.life or 0

	gohelper.setActive(slot0._gohp, true)
	slot0._sliderhp:SetValue(slot3 / 1000)

	slot4 = slot3 <= 0

	gohelper.setActive(slot0._godead, slot4)
	slot0._heroItem:setDamage(slot4)

	slot0._heroItem._isInjury = false
	slot0._isDead = slot4
end

function slot0.updateTrialTag(slot0)
	slot1 = nil

	if slot0._mo:isTrial() then
		slot1 = luaLang("herogroup_trial_tag0")
	end

	slot0._heroItem:setTrialTxt(slot1)
end

function slot0.updateTrialRepeat(slot0)
	if slot0._heroSingleGroupModel:getById(slot0._view.viewContainer.viewParam.singleGroupMOId) and not slot1:isEmpty() and (slot1.trial and slot1:getTrialCO().heroId == slot0._mo.heroId or not slot1.trial and (not slot1:getHeroCO() or slot1:getHeroCO().id == slot0._mo.heroId)) then
		if not slot1.trial and not slot1.aid and not slot1:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(slot1.id))
		end

		slot0._heroItem:setTrialRepeat(false)

		return
	end

	slot0._heroItem:setTrialRepeat(V1a6_CachotHeroGroupEditListModel.instance:isRepeatHero(slot0._mo.heroId, slot0._mo.uid))
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	slot0._heroItem:setSelect(slot1)

	if slot1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, slot0._mo)
	end
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	slot1 = slot0._heroSingleGroupModel:getById(slot0._view.viewContainer.viewParam.singleGroupMOId)

	if slot0._mo:isTrial() and not slot0._heroSingleGroupModel:isInGroup(slot0._mo.uid) and (slot1:isEmpty() or not slot1.trial) and V1a6_CachotHeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if slot0._mo.isPosLock or not slot1:isEmpty() and slot1.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if slot0._heroGroupModel:isRestrict(slot0._mo.uid) then
		if not string.nilorempty(slot0._heroGroupModel:getCurrentBattleConfig() and slot2.restrictReason) then
			ToastController.instance:showToastWithString(slot3)
		end

		return
	end

	if V1a6_CachotHeroGroupEditListModel.instance:getHeroGroupEditType() == V1a6_CachotEnum.HeroGroupEditType.Event and slot0._inTeam then
		GameFacade.showToast(ToastEnum.V1a6CachotToast03)

		return
	end

	if slot0._isSelect and slot0._enableDeselect and not slot0._mo.isPosLock then
		slot0._view:selectCell(slot0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		slot0._view:selectCell(slot0._index, true)
	end
end

function slot0.enableDeselect(slot0, slot1)
	slot0._enableDeselect = slot1
end

function slot0.onDestroy(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
