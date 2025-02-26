module("modules.logic.gm.view.GMResetCardsItem2", package.seeall)

slot0 = class("GMResetCardsItem2", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._mo = nil
	slot0._itemClick = SLFramework.UGUI.UIClickListener.Get(slot1)

	slot0._itemClick:AddClickListener(slot0._onClickItem, slot0)
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
	slot2 = slot1.skillId

	slot0._cardItem:updateItem(slot1.entityId, slot2)

	slot0._cardItem._txt.text = lua_skill.configDict[slot2] and slot3.name or "nil"
end

function slot0._onClickItem(slot0)
	for slot5, slot6 in ipairs(GMResetCardsModel.instance:getModel1():getList()) do
		if not slot6.newSkillId then
			slot6.newEntityId = slot0._mo.entityId
			slot6.newSkillId = slot0._mo.skillId

			slot1:onModelUpdate()

			return
		end
	end

	GameFacade.showToast(ToastEnum.IconId, "cards full")
end

function slot0.onDestroy(slot0)
	if slot0._itemClick then
		slot0._itemClick:RemoveClickListener()

		slot0._itemClick = nil
	end
end

return slot0
