module("modules.logic.gm.view.GMResetCardsItem1", package.seeall)

slot0 = class("GMResetCardsItem1", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._mo = nil
	slot0._itemClick = SLFramework.UGUI.UIClickListener.Get(slot1)

	slot0._itemClick:AddClickListener(slot0._onClickItem, slot0)

	slot0._canvasGroup = gohelper.onceAddComponent(slot1, gohelper.Type_CanvasGroup)
end

function slot0.onUpdateMO(slot0, slot1)
	if not slot0._cardItem then
		slot2 = slot0._view.viewContainer
		slot0._cardGO = slot2:getResInst(slot2:getSetting().otherRes[1], gohelper.findChild(slot0.go, "card"), "card")
		slot0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._cardGO, FightViewCardItem)

		gohelper.setActive(gohelper.findChild(slot0._cardItem.go, "Image"), true)
		gohelper.setActive(slot0._cardItem._txt, true)
		transformhelper.transformhelper.setLocalScale(slot0._cardGO.transform, 0.8, 0.8, 0.8)
	end

	slot0._mo = slot1
	slot3 = slot1.newSkillId or slot1.oldSkillId

	slot0._cardItem:updateItem(slot1.newEntityId or slot1.oldEntityId, slot3)

	slot0._canvasGroup.alpha = slot1.newSkillId and 1 or 0.5
	slot0._cardItem._txt.text = lua_skill.configDict[slot3] and slot4.name or "nil"
end

function slot0._onClickItem(slot0)
	slot0._mo.newSkillId = nil
	slot0._mo.newEntityId = nil
	slot0._canvasGroup.alpha = 0.5

	GMResetCardsModel.instance:getModel1():onModelUpdate()
end

function slot0.onDestroy(slot0)
	if slot0._itemClick then
		slot0._itemClick:RemoveClickListener()

		slot0._itemClick = nil
	end
end

return slot0
