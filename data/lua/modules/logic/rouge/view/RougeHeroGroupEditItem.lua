module("modules.logic.rouge.view.RougeHeroGroupEditItem", package.seeall)

slot0 = class("RougeHeroGroupEditItem", RougeLuaCompBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._go = slot1
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)

	slot0._gohp = gohelper.findChild(slot1, "#go_hp")

	gohelper.setActive(slot0._gohp, false)

	slot0._goassit = gohelper.findChild(slot1, "assit")
	slot0._sliderhp = gohelper.findChildSlider(slot1, "#go_hp/#slider_hp")
	slot0._godead = gohelper.findChild(slot1, "#go_dead")
	slot0._goframehp = gohelper.findChild(slot1, "frame_hp")
	slot0._itemAnimator = gohelper.onceAddComponent(slot1, gohelper.Type_Animator)

	slot0:_initCapacity()
	slot0:_initObj(slot1)
	slot0:initDLCs()
end

function slot0._initCapacity(slot0)
	slot0._gopoint = gohelper.findChild(slot0._go, "volume/point")

	gohelper.setActive(slot0._gopoint, false)

	slot0._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._go, RougeCapacityComp)

	slot0._capacityComp:setSpriteType("rouge_team_volume_3", "rouge_team_volume_3")
	slot0._capacityComp:setPoint(slot0._gopoint)
	slot0._capacityComp:initCapacity()
end

function slot0._initObj(slot0, slot1)
	slot0._heroItem:_setTxtWidth("_nameCnTxt", 180)

	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._isSelect = false
	slot0._enableDeselect = true

	transformhelper.setLocalScale(slot1.transform, 0.8, 0.8, 1)
	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	slot0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 36.1)
	slot0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	slot0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)

	slot0._heroGroupEditListModel = RougeHeroGroupEditListModel.instance
	slot0._heroGroupQuickEditListModel = HeroGroupQuickEditListModel.instance
	slot0._heroSingleGroupModel = RougeHeroSingleGroupModel.instance
	slot0._heroGroupModel = RougeHeroGroupModel.instance
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._onSkinChanged, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, slot0.updateTrialRepeat, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnSwitchHeroGroupEditMode, slot0._onSwitchHeroGroupEditMode, slot0)
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
	if slot0._heroGroupQuickEditListModel.adventure then
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

function slot0._updateCapacity(slot0, slot1)
	slot0._capacity = RougeConfig1.instance:getRoleCapacity(slot1.config.rare)

	if slot0._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.FightAssit and RougeController.instance:useHalfCapacity() then
		slot2 = RougeConfig1.instance:getRoleHalfCapacity(slot1.config.rare)

		slot0._capacityComp:updateMaxNumAndOpaqueNum(slot0._capacity, slot2)

		slot0._capacity = slot2

		return
	end

	slot0._capacityComp:updateMaxNumAndOpaqueNum(slot0._capacity, slot0._capacity)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0:_updateCapacity(slot1)

	if not slot1:isTrial() and slot1.level < RougeHeroGroupBalanceHelper.getHeroBalanceLv(slot1.heroId) then
		slot0._heroItem:setBalanceLv(slot2)
	end

	slot0:updateTrialTag()
	slot0:updateTrialRepeat()

	slot3 = slot0._heroGroupEditListModel:getTeamPosIndex(slot0._mo.uid)

	if slot0._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.FightAssit or slot4 == RougeEnum.HeroGroupEditType.Fight then
		slot5 = slot0._heroGroupEditListModel:isInTeamHero(slot0._mo.uid) == 1 and slot3 and RougeEnum.FightTeamNormalHeroNum < slot3

		gohelper.setActive(slot0._goassit, slot5)

		if slot5 then
			slot2 = nil
		end
	else
		gohelper.setActive(slot0._goassit, false)
	end

	slot0._heroItem:setNewShow(false)
	slot0._heroItem:setInteam(slot2)
	slot0:_updateHp()
	slot0:tickUpdateDLCs(slot1)
end

function slot0._isHideHp(slot0)
	if slot0._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.Init or slot0._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.SelectHero then
		return true
	end
end

function slot0._updateHp(slot0)
	if slot0:_isHideHp() then
		return
	end

	if not RougeModel.instance:getTeamInfo():getHeroHp(slot0._mo.heroId) then
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

	slot0._heroItem:setTrialRepeat(slot0._heroGroupEditListModel:isRepeatHero(slot0._mo.heroId, slot0._mo.uid))
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1
	slot2 = slot0:_isHideHp()

	slot0._heroItem:setSelect(slot1 and slot2)
	gohelper.setActive(slot0._goframehp, slot1 and not slot2)

	if slot1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, slot0._mo)
	end
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0._isDead then
		GameFacade.showToast(ToastEnum.V1a6CachotToast04)

		return
	end

	if slot0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if not slot0._heroGroupEditListModel:canAddCapacity(slot0._view.viewContainer.viewParam.singleGroupMOId, slot0._mo) then
		GameFacade.showToast(ToastEnum.RougeTeamCapacityFull)

		return
	end

	slot1 = slot0._heroSingleGroupModel:getById(slot0._view.viewContainer.viewParam.singleGroupMOId)

	if slot0._mo:isTrial() and not slot0._heroSingleGroupModel:isInGroup(slot0._mo.uid) and (slot1:isEmpty() or not slot1.trial) and slot0._heroGroupEditListModel:isTrialLimit() then
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

function slot0._onSwitchHeroGroupEditMode(slot0)
	slot0._itemAnimator:Play("rougeherogroupedititem_open", 0, 0)
	slot0._animator:Play("open", 0, 0)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
