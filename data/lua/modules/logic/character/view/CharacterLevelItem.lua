module("modules.logic.character.view.CharacterLevelItem", package.seeall)

slot0 = class("CharacterLevelItem", ListScrollCellExtend)
slot1 = 1
slot2 = 0.75
slot3 = 1
slot4 = 0.5

function slot0.onInitView(slot0)
	slot0._click = gohelper.getClickWithDefaultAudio(slot0.viewGO)
	slot0._gocurlv = gohelper.findChild(slot0.viewGO, "#go_curLv")
	slot0._transcurlv = slot0._gocurlv.transform
	slot0._txtcurlv = gohelper.findChildText(slot0.viewGO, "#go_curLv/#txt_curLvNum")
	slot0._txtlvnum = gohelper.findChildText(slot0.viewGO, "#txt_LvNum")
	slot0._translvnum = slot0._txtlvnum.transform
	slot0._txtefflvnum = gohelper.findChildText(slot0.viewGO, "#txt_LvNum/#txt_leveleffect")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_line")
	slot0._gomax = gohelper.findChild(slot0.viewGO, "#go_Max")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0.onClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.characterLevelItemPlayEff, slot0._onPlayLevelUpEff, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, slot0._onChangePreviewLevel, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelScrollChange, slot0._onLevelScrollChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.characterLevelItemPlayEff, slot0._onPlayLevelUpEff, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, slot0._onChangePreviewLevel, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.levelScrollChange, slot0._onLevelScrollChange, slot0)
end

function slot0.onClick(slot0)
	if not slot0._mo then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpClickLevel, slot0._mo.level)
end

function slot0._onItemChanged(slot0)
	if not slot0._view then
		return
	end

	if slot0._view.viewContainer and slot1:getWaitHeroLevelUpRefresh() then
		return
	end

	slot0:refresh()
end

function slot0._onPlayLevelUpEff(slot0, slot1)
	slot2 = slot0._mo and slot0._mo.heroId

	if not (slot2 and HeroModel.instance:getByHeroId(slot2)) then
		return
	end

	if slot0._mo.level == slot1 then
		slot0._animator:Play("click", 0, 0)
	end
end

function slot0._onChangePreviewLevel(slot0, slot1)
	if not slot0._view then
		return
	end

	if slot0._view.viewContainer and slot2:getWaitHeroLevelUpRefresh() then
		return
	end

	slot0:refreshCurLevelMark()
end

function slot0._onLevelScrollChange(slot0, slot1)
	if slot0._itemOffset < (slot1 and math.abs(slot1) or 0) then
		slot0:refreshScale(-slot1, -slot0._rightBoundary, -slot0._itemOffset)
	else
		slot0:refreshScale(slot1, slot0._leftBoundary, slot0._itemOffset)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot3 = slot0._view.viewContainer:getLevelItemWidth()
	slot4 = slot3 / 2
	slot0._itemOffset = (slot0._index - 1) * slot3
	slot0._rightBoundary = slot0._itemOffset + slot4
	slot0._leftBoundary = slot0._itemOffset - slot4

	slot0:refresh()
	slot0:_onLevelScrollChange(slot0._view.viewContainer.characterLevelUpView:getContentOffset())
	slot0._animator:Play("idle", 0, 0)
end

function slot0.refresh(slot0)
	slot1 = slot0._mo and HeroConfig.instance:getShowLevel(slot0._mo.level) or ""
	slot0._txtcurlv.text = slot1
	slot0._txtlvnum.text = slot1
	slot0._txtefflvnum.text = slot1
	slot2 = slot0._mo and slot0._mo.heroId

	if not (slot2 and HeroModel.instance:getByHeroId(slot2)) then
		return
	end

	slot4 = true
	slot11 = slot0._mo.level

	for slot11, slot12 in ipairs(HeroConfig.instance:getLevelUpItems(slot2, slot3.level, slot11)) do
		if ItemModel.instance:getItemQuantity(tonumber(slot12.type), tonumber(slot12.id)) < tonumber(slot12.quantity) then
			slot4 = false

			break
		end
	end

	slot8 = slot1

	if not slot4 then
		slot8 = string.format("<color=#793426>%s</color>", slot1)
	end

	slot0._txtlvnum.text = slot8

	gohelper.setActive(slot0._gomax, slot6 == CharacterModel.instance:getrankEffects(slot2, slot3.rank)[1])
	slot0:refreshCurLevelMark()
end

function slot0.refreshCurLevelMark(slot0)
	slot1 = false
	slot2 = slot0._mo and slot0._mo.heroId

	if slot2 and HeroModel.instance:getByHeroId(slot2) and slot0._mo.level == (slot0._view.viewContainer:getLocalUpLevel() or slot3.level) then
		slot1 = slot5.characterLevelUpView.previewLevel ~= slot4
	end

	gohelper.setActive(slot0._gocurlv, slot1)
	gohelper.setActive(slot0._goline, not slot1)
	gohelper.setActive(slot0._txtlvnum.gameObject, not slot1)
end

function slot0.refreshScale(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 or not slot3 then
		return
	end

	slot4 = GameUtil.remap(slot1, slot2, slot3, uv0, uv1)

	transformhelper.setLocalScale(slot0._translvnum, slot4, slot4, slot4)

	slot6 = slot0._txtlvnum.color
	slot6.a = GameUtil.remap(slot1, slot2, slot3, uv2, uv3)
	slot0._txtlvnum.color = slot6
end

return slot0
