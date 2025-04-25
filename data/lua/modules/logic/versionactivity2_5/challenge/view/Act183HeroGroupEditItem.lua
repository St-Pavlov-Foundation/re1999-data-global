module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupEditItem", package.seeall)

slot0 = class("Act183HeroGroupEditItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._gorepress = gohelper.findChild(slot1, "go_repress")
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)
	slot0:_initObj(slot1)
end

function slot0._initObj(slot0, slot1)
	slot0._heroItem:_setTxtWidth("_nameCnTxt", 180)

	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._isSelect = false
	slot0._enableDeselect = true

	transformhelper.setLocalScale(slot1.transform, 0.8, 0.8, 1)
	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	slot0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	slot0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
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

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)

	if not slot1:isTrial() and slot1.level < HeroGroupBalanceHelper.getHeroBalanceLv(slot1.heroId) then
		slot0._heroItem:setBalanceLv(slot2)
	end

	slot0:updateTrialTag()
	slot0:updateTrialRepeat()
	slot0._heroItem:setNewShow(false)
	slot0._heroItem:setInteam(Act183HeroGroupEditListModel.instance:isInTeamHero(slot0._mo.uid))

	slot0._isRepress = Act183Model.instance:isHeroRepressInPreEpisode(HeroGroupModel.instance.episodeId, slot0._mo.heroId)

	gohelper.setActive(slot0._gorepress, slot0._isRepress)
	slot0._heroItem._commonHeroCard:setGrayScale(slot0._isRepress)
end

function slot0.updateTrialTag(slot0)
	slot1 = nil

	if slot0._mo:isTrial() then
		slot1 = luaLang("herogroup_trial_tag0")
	end

	slot0._heroItem:setTrialTxt(slot1)
end

function slot0.updateTrialRepeat(slot0)
	if HeroSingleGroupModel.instance:getById(slot0._view.viewContainer.viewParam.singleGroupMOId) and not slot1:isEmpty() and (slot1.trial and slot1:getTrialCO().heroId == slot0._mo.heroId or not slot1.trial and (not slot1:getHeroCO() or slot1:getHeroCO().id == slot0._mo.heroId)) then
		if not slot1.trial and not slot1.aid and not slot1:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(slot1.id))
		end

		slot0._heroItem:setTrialRepeat(false)

		return
	end

	slot0._heroItem:setTrialRepeat(Act183HeroGroupEditListModel.instance:isRepeatHero(slot0._mo.heroId, slot0._mo.uid))
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

	if slot0._isRepress then
		GameFacade.showToast(ToastEnum.Act183HeroRepress)

		return
	end

	slot1 = HeroSingleGroupModel.instance:getById(slot0._view.viewContainer.viewParam.singleGroupMOId)

	if slot0._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(slot0._mo.uid) and (slot1:isEmpty() or not slot1.trial) and Act183HeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if slot0._mo.isPosLock or not slot1:isEmpty() and slot1.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if HeroGroupModel.instance:isRestrict(slot0._mo.uid) then
		if not string.nilorempty(HeroGroupModel.instance:getCurrentBattleConfig() and slot2.restrictReason) then
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

function slot0.onDestroy(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
