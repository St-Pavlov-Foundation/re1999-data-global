module("modules.logic.seasonver.act123.view2_3.Season123_2_3HeroGroupQuickEditItem", package.seeall)

slot0 = class("Season123_2_3HeroGroupQuickEditItem", Season123_2_3HeroGroupEditItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._imageorder = gohelper.findChildImage(slot1, "#go_orderbg/#image_order")
	slot0._goorderbg = gohelper.findChild(slot1, "#go_orderbg")
	slot0._gohp = gohelper.findChild(slot1, "#go_hp")
	slot0._sliderhp = gohelper.findChildSlider(slot1, "#go_hp/#slider_hp")
	slot0._imagehp = gohelper.findChildImage(slot1, "#go_hp/#slider_hp/Fill Area/Fill")
	slot0._godead = gohelper.findChild(slot1, "#go_dead")

	slot0:enableDeselect(false)
	slot0._heroItem:setNewShow(false)
	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	slot0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 36.1)
	slot0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	slot0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
	gohelper.setActive(slot0._goorderbg, false)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0._heroItem:setNewShow(false)
	slot0:updateLimitStatus()

	slot2 = Season123HeroGroupQuickEditModel.instance:getHeroTeamPos(slot0._mo.uid)
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

	slot0:refreshHp()
	slot0:refreshDead()
end

function slot0._show_goorderbg(slot0)
	gohelper.setActive(slot0._goorderbg, true)
	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imageorder, "biandui_shuzi_" .. slot0._team_pos_index)
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0:checkRestrict(slot0._mo.uid) or slot0:checkHpZero(slot0._mo.uid) then
		return
	end

	if slot0._mo and not Season123HeroGroupQuickEditModel.instance:selectHero(slot0._mo.uid) then
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
