module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroItem", package.seeall)

slot0 = class("Season123_1_8PickHeroItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._goOrder = gohelper.findChild(slot1, "#go_orderbg")
	slot0._txtorder = gohelper.findChildText(slot1, "#go_orderbg/#txt_level")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0.onItemClick, slot0)
	slot0:initHeroItem(slot1)
end

function slot0.initHeroItem(slot0, slot1)
	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

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
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(HeroModel.instance:getById(slot0._mo.id))
	slot0._heroItem:setNewShow(false)

	slot3 = Season123PickHeroModel.instance:isHeroSelected(slot0._mo.id)

	slot0._heroItem:setSelect(slot3)
	gohelper.setActive(slot0._goOrder, slot3)

	if slot3 then
		slot0._txtorder.text = tostring(Season123PickHeroModel.instance:getSelectedIndex(slot0._mo.id))
	end
end

function slot0.onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	Season123PickHeroController.instance:setHeroSelect(slot0._mo.id, not Season123PickHeroModel.instance:isHeroSelected(slot0._mo.id))
end

function slot0.onDestroy(slot0)
	if slot0._heroItem then
		slot0._heroItem:onDestroy()

		slot0._heroItem = nil
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
