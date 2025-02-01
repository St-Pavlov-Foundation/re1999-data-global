module("modules.logic.seasonver.act166.view.Season166HeroGroupQuickEditItem", package.seeall)

slot0 = class("Season166HeroGroupQuickEditItem", Season166HeroGroupEditItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._txtorder = gohelper.findChildText(slot1, "#go_orderbg/#txt_order")
	slot0._goorderbg = gohelper.findChild(slot1, "#go_orderbg")

	slot0:enableDeselect(false)
	slot0._heroItem:setNewShow(false)
	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	slot0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	slot0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
	gohelper.setActive(slot0._goorderbg, false)

	slot0._itemAnim.speed = 1
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0._heroItem:setNewShow(false)

	if not slot1:isTrial() and slot1.level < HeroGroupBalanceHelper.getHeroBalanceLv(slot1.heroId) then
		slot0._heroItem:setBalanceLv(slot2)
	end

	slot0:updateTrialTag()
	slot0:updateTrialRepeat()

	slot2 = Season166HeroGroupQuickEditModel.instance:getHeroTeamPos(slot0._mo.uid)
	slot0._team_pos_index = slot2

	if slot2 ~= 0 then
		if not slot0._open_ani_finish then
			TaskDispatcher.runDelay(slot0._show_goorderbg, slot0, 0.3)
		else
			slot0:_show_goorderbg()
		end
	else
		gohelper.setActive(slot0._goorderbg, false)
	end

	slot0._open_ani_finish = true

	slot0:refreshSelectState()
end

function slot0._show_goorderbg(slot0)
	gohelper.setActive(slot0._goorderbg, true)

	slot0._txtorder.text = slot0._team_pos_index
end

function slot0.updateTrialRepeat(slot0, slot1)
	if slot1 and (slot1.heroId ~= slot0._mo.heroId or slot1 == slot0._mo) then
		return
	end

	slot0.isRepeat = Season166HeroGroupQuickEditModel.instance:isRepeatHero(slot0._mo.heroId, slot0._mo.uid)

	slot0._heroItem:setTrialRepeat(slot0.isRepeat)
end

function slot0.refreshSelectState(slot0)
	gohelper.setActive(slot0._goMainSelect, false)
	gohelper.setActive(slot0._goHelpSelect, false)
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

	if slot0._mo:isTrial() and not Season166HeroGroupQuickEditModel.instance:isInTeamHero(slot0._mo.uid) and Season166HeroGroupQuickEditModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if slot0._mo and not Season166HeroGroupQuickEditModel.instance:selectHero(slot0._mo.uid) then
		return
	end

	if slot0._isSelect and slot0._enableDeselect then
		slot0._view:selectCell(slot0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		slot0._view:selectCell(slot0._index, true)
	end
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
