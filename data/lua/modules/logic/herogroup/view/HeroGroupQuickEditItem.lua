module("modules.logic.herogroup.view.HeroGroupQuickEditItem", package.seeall)

slot0 = class("HeroGroupQuickEditItem", HeroGroupEditItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._goframe = gohelper.findChild(slot1, "frame")
	slot0._imageorder = gohelper.findChildImage(slot1, "#go_orderbg/#image_order")
	slot0._goorderbg = gohelper.findChild(slot1, "#go_orderbg")

	slot0:enableDeselect(false)
	slot0._heroItem:setNewShow(false)
	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	slot0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 41.1)
	slot0._heroItem:_setTxtPos("_lvObj", 1.7, 82)
	slot0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	slot0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
	gohelper.setActive(slot0._goorderbg, false)
	gohelper.setActive(slot0._goframe, false)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0._heroItem:setNewShow(false)

	if not slot1:isTrial() and slot1.level < HeroGroupBalanceHelper.getHeroBalanceLv(slot1.heroId) then
		slot0._heroItem:setBalanceLv(slot2)
	end

	slot0:updateLimitStatus()
	slot0:updateTrialTag()
	slot0:updateTrialRepeat()
	slot0._heroItem:setRepeatAnimFinish()

	slot2 = HeroGroupQuickEditListModel.instance:getHeroTeamPos(slot0._mo.uid)
	slot0._team_pos_index = slot2

	if slot2 ~= 0 then
		if not slot0._open_ani_finish then
			TaskDispatcher.runDelay(slot0._show_goorderbg, slot0, 0.3)
		else
			slot0:_show_goorderbg()
		end
	else
		gohelper.setActive(slot0._goorderbg, false)
		gohelper.setActive(slot0._goframe, false)
	end

	slot0._open_ani_finish = true
end

function slot0.updateTrialRepeat(slot0, slot1)
	if slot1 and (slot1.heroId ~= slot0._mo.heroId or slot1 == slot0._mo) then
		return
	end

	slot0._heroItem:setTrialRepeat(HeroGroupQuickEditListModel.instance:isRepeatHero(slot0._mo.heroId, slot0._mo.uid))
end

function slot0._show_goorderbg(slot0)
	gohelper.setActive(slot0._goorderbg, true)
	gohelper.setActive(slot0._goframe, true)
	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imageorder, "biandui_shuzi_" .. slot0._team_pos_index)
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if slot0._mo and slot0._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if slot0._mo and HeroSingleGroupModel.instance:isAidConflict(slot0._mo.heroId) then
		GameFacade.showToast(ToastEnum.HeroIsAidConflict)

		return
	end

	if HeroGroupModel.instance:isRestrict(slot0._mo.uid) then
		if not string.nilorempty(HeroGroupModel.instance:getCurrentBattleConfig() and slot1.restrictReason) then
			ToastController.instance:showToastWithString(slot2)
		end

		return
	end

	if slot0._mo:isTrial() and not HeroGroupQuickEditListModel.instance:inInTeam(slot0._mo.uid) and HeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if slot0._mo and not slot0._mo.isPosLock and not HeroGroupQuickEditListModel.instance:selectHero(slot0._mo.uid) then
		return
	end

	if slot0._isSelect and slot0._enableDeselect and not slot0._mo.isPosLock then
		slot0._view:selectCell(slot0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		slot0._view:selectCell(slot0._index, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, slot0._mo)
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	if slot1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, slot0._mo)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._show_goorderbg, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
