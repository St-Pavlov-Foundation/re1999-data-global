module("modules.logic.seasonver.act123.view1_8.Season123_1_8HeroGroupEditItem", package.seeall)

slot0 = class("Season123_1_8HeroGroupEditItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)

	slot0._gohp = gohelper.findChild(slot1, "#go_hp")
	slot0._sliderhp = gohelper.findChildSlider(slot1, "#go_hp/#slider_hp")
	slot0._imagehp = gohelper.findChildImage(slot1, "#go_hp/#slider_hp/Fill Area/Fill")
	slot0._godead = gohelper.findChild(slot1, "#go_dead")

	slot0:_initObj(slot1)
end

function slot0._initObj(slot0, slot1)
	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._isSelect = false
	slot0._enableDeselect = true

	transformhelper.setLocalScale(slot1.transform, 0.8, 0.8, 1)
	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	slot0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 41.1)
	slot0._heroItem:_setTxtPos("_lvObj", 1.7, 82)
	slot0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	slot0._heroItem:_setTranScale("_nameCnTxt", 1, 1)
	slot0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	slot0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, slot0._onAttributeChanged, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._onSkinChanged, slot0)
end

function slot0.removeEventListeners(slot0)
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

function slot0.updateLimitStatus(slot0)
	if HeroGroupModel.instance:isRestrict(slot0._mo.uid) then
		slot0._heroItem:setRestrict(true)
	else
		slot0._heroItem:setRestrict(false)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0:updateLimitStatus()
	slot0._heroItem:setNewShow(false)
	slot0._heroItem:setInteam(Season123HeroGroupEditModel.instance:isInTeamHero(slot0._mo.uid))
	slot0:refreshHp()
	slot0:refreshDead()
end

function slot0.refreshHp(slot0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		if Season123Model.instance:getSeasonHeroMO(Season123HeroGroupEditModel.instance.activityId, Season123HeroGroupEditModel.instance.stage, Season123HeroGroupEditModel.instance.layer, slot0._mo.uid) ~= nil then
			gohelper.setActive(slot0._gohp, true)
			slot0:setHp(slot4.hpRate)
		else
			gohelper.setActive(slot0._gohp, false)
		end
	else
		gohelper.setActive(slot0._gohp, false)
		gohelper.setActive(slot0._godead, false)
	end
end

function slot0.refreshDead(slot0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		slot1 = false

		if Season123Model.instance:getSeasonHeroMO(Season123HeroGroupEditModel.instance.activityId, Season123HeroGroupEditModel.instance.stage, Season123HeroGroupEditModel.instance.layer, slot0._mo.uid) ~= nil then
			slot1 = slot5.hpRate <= 0
		end

		slot0._heroItem:setDamage(slot1)
		gohelper.setActive(slot0._heroItem._maskgray, slot1)
	end
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

	if slot0:checkRestrict(slot0._mo.uid) or slot0:checkHpZero(slot0._mo.uid) then
		return
	end

	if slot0._isSelect and slot0._enableDeselect then
		slot0._view:selectCell(slot0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		slot0._view:selectCell(slot0._index, true)
	end
end

function slot0.checkRestrict(slot0, slot1)
	if HeroGroupModel.instance:isRestrict(slot1) then
		if not string.nilorempty(HeroGroupModel.instance:getCurrentBattleConfig() and slot2.restrictReason) then
			ToastController.instance:showToastWithString(slot3)
		end

		return true
	end

	return false
end

function slot0.checkHpZero(slot0, slot1)
	if Season123Model.instance:getSeasonHeroMO(Season123HeroGroupEditModel.instance.activityId, Season123HeroGroupEditModel.instance.stage, Season123HeroGroupEditModel.instance.layer, slot1) == nil then
		return
	end

	if slot5.hpRate <= 0 then
		return true
	end

	return false
end

function slot0.enableDeselect(slot0, slot1)
	slot0._enableDeselect = slot1
end

function slot0.setHp(slot0, slot1)
	slot3 = Mathf.Clamp(math.floor(slot1 / 10) / 100, 0, 1)

	slot0._sliderhp:SetValue(slot3)
	Season123HeroGroupUtils.setHpBar(slot0._imagehp, slot3)
	gohelper.setActive(slot0._godead, slot3 <= 0)
end

function slot0.onDestroy(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
