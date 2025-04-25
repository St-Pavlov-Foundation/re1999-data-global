module("modules.logic.fight.view.FightViewDissolveCard", package.seeall)

slot0 = class("FightViewDissolveCard", BaseView)

function slot0.onInitView(slot0)
	slot0.cardContainer = gohelper.findChild(slot0.viewGO, "root/dissolveCard")
	slot0.goCardItem = gohelper.findChild(slot0.viewGO, "root/dissolveCard/#scroll_cards/Viewport/Content/cardItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.CardScale = 0.62
slot0.ShowCardDuration = 0.5
slot0.DissolveCardDuration = 1

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.cardContainer, false)
	gohelper.setActive(slot0.goCardItem, false)

	slot0.cardItemList = {}
end

function slot0.onDeleteCard(slot0, slot1)
	if not slot1 then
		return slot0:dissolveCardDone()
	end

	for slot5, slot6 in ipairs(slot0.cardItemList) do
		gohelper.setActive(slot6.go, false)
	end

	gohelper.setActive(slot0.cardContainer, true)

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0:getCardItem(slot5)

		gohelper.setActive(slot7.innerCardGo, true)
		slot7.innerCardItem:updateItem(slot6.uid, slot6.skillId, slot6)

		slot8 = FightCardModel.instance:isUniqueSkill(slot6.uid, slot6.skillId)

		gohelper.setActive(slot7.goPlaySkillEffect, not slot8)
		gohelper.setActive(slot7.goPlayBigSkillEffect, slot8)
	end

	TaskDispatcher.cancelTask(slot0.dissolveCardDone, slot0)
	TaskDispatcher.cancelTask(slot0.startDissolve, slot0)
	TaskDispatcher.runDelay(slot0.startDissolve, slot0, slot0.ShowCardDuration / FightModel.instance:getUISpeed())
end

function slot0.startDissolve(slot0)
	for slot5, slot6 in ipairs(slot0.cardItemList) do
		slot6.innerCardItem:dissolveCard(slot0.CardScale)
		gohelper.setActive(slot6.goPlaySkillEffect, false)
		gohelper.setActive(slot6.goPlayBigSkillEffect, false)
	end

	TaskDispatcher.cancelTask(slot0.dissolveCardDone, slot0)
	TaskDispatcher.runDelay(slot0.dissolveCardDone, slot0, slot0.DissolveCardDuration / FightModel.instance:getUISpeed())
end

function slot0.getCardItem(slot0, slot1)
	if slot0.cardItemList[slot1] then
		gohelper.setActive(slot2.go, true)

		return slot2
	end

	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0.goCardItem)

	gohelper.setActive(slot2.go, true)

	slot2.innerCardGo = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot2.go, "card")
	slot2.innerCardItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.innerCardGo, FightViewCardItem)
	slot4 = slot0.CardScale

	transformhelper.setLocalScale(slot2.innerCardGo.transform, slot4, slot4, slot4)

	slot2.goPlaySkillEffect = slot0:addPlaySkillEffect(slot2.go)
	slot2.goPlayBigSkillEffect = slot0:addPlayBigSkillEffect(slot2.go)

	gohelper.setActive(slot2.goPlaySkillEffect, false)
	gohelper.setActive(slot2.goPlayBigSkillEffect, false)
	transformhelper.setLocalScale(slot2.goPlaySkillEffect.transform, slot4, slot4, slot4)
	transformhelper.setLocalScale(slot2.goPlayBigSkillEffect.transform, slot4, slot4, slot4)
	table.insert(slot0.cardItemList, slot2)

	return slot2
end

function slot0.addPlaySkillEffect(slot0, slot1)
	slot2 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02)

	return gohelper.clone(FightHelper.getPreloadAssetItem(slot2):GetResource(slot2), slot1)
end

function slot0.addPlayBigSkillEffect(slot0, slot1)
	slot2 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03)

	return gohelper.clone(FightHelper.getPreloadAssetItem(slot2):GetResource(slot2), slot1)
end

function slot0.dissolveCardDone(slot0)
	gohelper.setActive(slot0.cardContainer, false)
	FightController.instance:dispatchEvent(FightEvent.CardDeckDeleteDone)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.dissolveCardDone, slot0)
	TaskDispatcher.cancelTask(slot0.startDissolve, slot0)
end

return slot0
