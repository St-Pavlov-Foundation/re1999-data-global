module("modules.logic.character.view.CharacterBackpackCardListItem", package.seeall)

slot0 = class("CharacterBackpackCardListItem", ListScrollCell)
slot0.PressColor = GameUtil.parseColor("#C8C8C8")

function slot0.init(slot0, slot1)
	slot0._heroGO = slot1
	slot0._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._heroGO, CommonHeroItem)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)
	slot0._heroItem:addClickDownListener(slot0._onItemClickDown, slot0)
	slot0._heroItem:addClickUpListener(slot0._onItemClickUp, slot0)
	slot0:_initObj()
end

function slot0._initObj(slot0)
	slot0._animator = slot0._heroGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshRedDot, slot0)
end

function slot0.removeEventListeners(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshRedDot, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0:_refreshRedDot()

	if slot0._heroItemContainer then
		slot0._heroItemContainer.spines = nil
	end
end

function slot0._refreshRedDot(slot0)
	if CharacterModel.instance:isHeroCouldExskillUp(slot0._mo.heroId) or CharacterModel.instance:hasCultureRewardGet(slot0._mo.heroId) or CharacterModel.instance:hasItemRewardGet(slot0._mo.heroId) or slot0:_isShowDestinyReddot() then
		slot0._heroItem:setRedDotShow(true)
	else
		slot0._heroItem:setRedDotShow(false)
	end
end

function slot0._onrefreshItem(slot0)
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CharacterController.instance:openCharacterView(slot0._mo)

	if slot0:_isShowDestinyReddot() then
		HeroRpc.instance:setHeroRedDotReadRequest(slot0._mo.heroId, 1)
	end
end

function slot0._onItemClickDown(slot0)
	slot0:_setHeroItemPressState(true)
end

function slot0._onItemClickUp(slot0)
	slot0:_setHeroItemPressState(false)
end

function slot0._setHeroItemPressState(slot0, slot1)
	if not slot0._heroItemContainer then
		slot0._heroItemContainer = slot0:getUserDataTb_()
		slot2 = slot0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)
		slot0._heroItemContainer.images = slot2
		slot0._heroItemContainer.tmps = slot0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)
		slot0._heroItemContainer.compColor = {}
		slot4 = slot2:GetEnumerator()

		while slot4:MoveNext() do
			slot0._heroItemContainer.compColor[slot4.Current] = slot4.Current.color
		end

		slot4 = slot3:GetEnumerator()

		while slot4:MoveNext() do
			slot0._heroItemContainer.compColor[slot4.Current] = slot4.Current.color
		end
	end

	if not slot0._heroItemContainer.spines then
		slot2 = slot0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)
		slot0._heroItemContainer.spines = slot2
		slot3 = slot2:GetEnumerator()

		while slot3:MoveNext() do
			slot0._heroItemContainer.compColor[slot3.Current] = slot3.Current.color
		end
	end

	if slot0._heroItemContainer then
		slot0:_setUIPressState(slot0._heroItemContainer.images, slot1, slot0._heroItemContainer.compColor)
		slot0:_setUIPressState(slot0._heroItemContainer.tmps, slot1, slot0._heroItemContainer.compColor)
		slot0:_setUIPressState(slot0._heroItemContainer.spines, slot1, slot0._heroItemContainer.compColor)
	end
end

function slot0._setUIPressState(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot4 = slot1:GetEnumerator()

	while slot4:MoveNext() do
		slot5 = nil

		if slot2 then
			(slot3 and slot3[slot4.Current] * 0.7 or uv0.PressColor).a = slot4.Current.color.a
		else
			slot5 = slot3 and slot3[slot4.Current] or Color.white
		end

		slot4.Current.color = slot5
	end
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

function slot0._isShowDestinyReddot(slot0)
	if slot0._mo and slot0._mo.destinyStoneMo then
		return slot0._mo:isCanOpenDestinySystem() and slot0._mo.destinyStoneMo:getRedDot() < 1
	end
end

return slot0
