module("modules.logic.seasonver.act166.view.Season166HeroGroupEditItem", package.seeall)

slot0 = class("Season166HeroGroupEditItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)

	slot0._goSelectState = gohelper.findChild(slot1, "selectState")
	slot0._goCurSelect = gohelper.findChild(slot1, "selectState/go_currentSelect")
	slot0._goMainSelect = gohelper.findChild(slot1, "selectState/go_mainSelect")
	slot0._goHelpSelect = gohelper.findChild(slot1, "selectState/go_helpSelect")

	slot0:_initObj(slot1)
end

function slot0._initObj(slot0, slot1)
	slot0._heroItem:_setTxtWidth("_nameCnTxt", 180)

	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._itemAnim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._itemAnim.keepAnimatorControllerStateOnDisable = true
	slot0._itemAnim.speed = 0
	slot0._isFirstEnter = true
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

slot0.CurSelectItem = 2
slot0.OtherSelectItem = 1

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, slot0._onAttributeChanged, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._onSkinChanged, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, slot0.updateTrialRepeat, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, slot0._onAttributeChanged, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._onSkinChanged, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, slot0.updateTrialRepeat, slot0)
end

function slot0._onSkinChanged(slot0)
	slot0._heroItem:updateHero()
end

function slot0._onAttributeChanged(slot0, slot1, slot2)
	slot0._heroItem:setLevel(slot1, slot2)
end

function slot0.setAdventureBuff(slot0, slot1)
	slot0._heroItem:setAdventureBuff(slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)

	if slot0._isFirstEnter then
		slot0._isFirstEnter = false

		TaskDispatcher.runDelay(slot0.playEnterAnim, slot0, math.ceil((Season166HeroGroupEditModel.instance:getIndex(slot0._mo) - 1) % 5) * 0.001)
	end

	if not slot1:isTrial() and slot1.level < HeroGroupBalanceHelper.getHeroBalanceLv(slot1.heroId) then
		slot0._heroItem:setBalanceLv(slot2)
	end

	slot0._heroItem:setNewShow(false)
	slot0:refreshSelectState(Season166HeroGroupEditModel.instance:isInTeamHero(slot0._mo.uid))
	slot0:updateTrialTag()
	slot0:updateTrialRepeat()
end

function slot0.playEnterAnim(slot0)
	slot0._itemAnim.speed = 1

	TaskDispatcher.cancelTask(slot0.playEnterAnim, slot0)
end

function slot0.checkIsAssist(slot0)
	return Season166HeroSingleGroupModel.instance.assistMO and slot0._mo.uid == slot1.heroUid
end

function slot0.updateTrialTag(slot0)
	slot1 = nil

	if slot0._mo:isTrial() then
		slot1 = luaLang("herogroup_trial_tag0")
	end

	slot0._heroItem:setTrialTxt(slot1)
end

function slot0.updateTrialRepeat(slot0)
	slot2 = Season166HeroSingleGroupModel.instance:getById(slot0._view.viewContainer.viewParam.singleGroupMOId)

	if Season166HeroSingleGroupModel.instance.assistMO and slot2 and slot2.heroUid == slot1.heroUid then
		return
	end

	if slot2 and not slot2:isEmpty() and (slot2.trial and slot2:getTrialCO().heroId == slot0._mo.heroId or not slot2.trial and (not slot2:getHeroCO() or slot2:getHeroCO().id == slot0._mo.heroId)) then
		if not slot2.trial and not slot2.aid and not slot2:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(slot2.id))
		end

		slot0._heroItem:setTrialRepeat(false)

		return
	end

	slot0._heroItem:setTrialRepeat(Season166HeroGroupEditModel.instance:isRepeatHero(slot0._mo.heroId, slot0._mo.uid))
end

function slot0.refreshSelectState(slot0, slot1)
	gohelper.setActive(slot0._goCurSelect, slot1 == uv0.CurSelectItem)

	slot2, slot3 = Season166HeroSingleGroupModel.instance:checkIsMainHero(slot0._mo.uid)

	gohelper.setActive(slot0._goMainSelect, slot2 and slot1 == uv0.OtherSelectItem)
	gohelper.setActive(slot0._goHelpSelect, not slot2 and slot3 ~= 0 and slot1 == uv0.OtherSelectItem)
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

	slot1 = Season166HeroSingleGroupModel.instance:getById(slot0._view.viewContainer.viewParam.singleGroupMOId)

	if slot0._mo:isTrial() and not Season166HeroSingleGroupModel.instance:isInGroup(slot0._mo.uid) and (slot1:isEmpty() or not slot1.trial) and Season166HeroGroupEditModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if slot0._mo.isPosLock or not slot1:isEmpty() and slot1.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if slot0._isSelect and slot0._enableDeselect then
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
	TaskDispatcher.cancelTask(slot0.playEnterAnim, slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
