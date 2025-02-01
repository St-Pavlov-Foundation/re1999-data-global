module("modules.logic.player.view.ShowCharacterCardItem", package.seeall)

slot0 = class("ShowCharacterCardItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)

	slot0._mask = gohelper.findChild(slot0._gocharactercarditem, "nummask")
	slot0._masknum = gohelper.findChildText(slot0._gocharactercarditem, "nummask/num")
	slot0._shownum = 0

	slot0:_initObj()
end

function slot0._initObj(slot0)
	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0._heroItem:setNewShow(false)
	slot0:_initShowHeroList()
end

function slot0._initShowHeroList(slot0)
	slot2 = 0

	slot0:_initnum(slot0:_clecknum(PlayerModel.instance:getShowHeros()))
end

function slot0._onItemClick(slot0)
	slot1 = PlayerModel.instance:getShowHeros()

	if slot0._shownum ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		slot0._heroItem:setChoose(nil)
		PlayerModel.instance:setShowHero(slot0._shownum, 0)

		slot0._shownum = 0
	else
		slot0:_addHeroShow(slot1)

		if slot0._shownum ~= 0 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		end

		PlayerModel.instance:setShowHero(slot0._shownum, slot0._mo.heroId)
	end
end

function slot0._addHeroShow(slot0, slot1)
	for slot5 = 1, #slot1 do
		if slot1[slot5] == 0 then
			slot0:_initnum(slot5)

			return
		end
	end
end

function slot0._clecknum(slot0, slot1)
	slot2 = 0

	for slot6 = 1, #slot1 do
		if slot1[slot6] ~= 0 and slot0._mo.heroId == slot1[slot6].heroId then
			slot2 = slot6
		end
	end

	return slot2
end

function slot0._initnum(slot0, slot1)
	if slot1 == 0 then
		slot0._heroItem:setChoose(nil)
	else
		slot0._heroItem:setChoose(slot1)
	end

	slot0._shownum = slot1
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onDestroy(slot0)
end

return slot0
