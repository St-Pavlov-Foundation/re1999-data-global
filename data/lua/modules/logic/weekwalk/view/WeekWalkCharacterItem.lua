module("modules.logic.weekwalk.view.WeekWalkCharacterItem", package.seeall)

slot0 = class("WeekWalkCharacterItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)

	slot0._goAnim = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._hpbg = gohelper.findChild(slot1, "hpbg")

	gohelper.setActive(slot0._hpbg, false)

	slot0._hptextwhite = gohelper.findChildText(slot1, "hpbg/hptextwhite")
	slot0._hptextred = gohelper.findChildText(slot1, "hpbg/hptextred")
	slot0._hpimage = gohelper.findChildImage(slot1, "hpbg/hp")

	slot0:_initObj()
end

function slot0._initObj(slot0)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)

	slot2 = 1

	if WeekWalkModel.instance:getInfo() and slot3:getHeroHp(slot0._mo.config.id) then
		slot2 = slot4 / slot0._mo.baseAttr.hp
	end

	slot0._heroItem:setInjury(math.min(slot2, 1) <= 0)
	slot0._heroItem:setAdventureBuff(slot3:getHeroBuff(slot0._mo.heroId))
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	slot1 = {}
	slot1 = slot0._mo

	CharacterController.instance:openCharacterView(slot0._mo)
end

function slot0.getAnimator(slot0)
	return slot0._goAnim
end

function slot0.onDestroy(slot0)
end

return slot0
