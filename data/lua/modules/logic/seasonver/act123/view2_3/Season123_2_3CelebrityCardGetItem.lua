module("modules.logic.seasonver.act123.view2_3.Season123_2_3CelebrityCardGetItem", package.seeall)

slot0 = class("Season123_2_3CelebrityCardGetItem", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gorare1 = gohelper.findChild(slot0.viewGO, "#go_rare1")
	slot0._gorare2 = gohelper.findChild(slot0.viewGO, "#go_rare2")
	slot0._gorare3 = gohelper.findChild(slot0.viewGO, "#go_rare3")
	slot0._gorare4 = gohelper.findChild(slot0.viewGO, "#go_rare4")
	slot0._gorare5 = gohelper.findChild(slot0.viewGO, "#go_rare5")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onRefreshViewParam(slot0, slot1, slot2, slot3)
	slot0._uid = slot1
	slot0._noClick = slot2
	slot0._equipId = slot3
end

function slot0.onOpen(slot0)
	slot0:refreshData(slot0._uid)
end

function slot0.refreshData(slot0, slot1)
	slot2 = slot0:_getItemID(slot1)
	slot0._itemId = slot2

	slot0:_checkCreateIcon()
	slot0._icon:updateData(slot2)
	slot0._icon:setIndexLimitShowState(true)
end

function slot0._checkCreateIcon(slot0)
	if not slot0._icon then
		slot0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, Season123_2_3CelebrityCardEquip)

		slot0._icon:setClickCall(slot0.onBtnClick, slot0)

		if slot0._noClick then
			slot1 = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
			slot1.interactable = false
			slot1.blocksRaycasts = false
		end
	end
end

function slot0.onBtnClick(slot0)
	if slot0._noClick then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, slot0._itemId)
end

function slot0._getItemID(slot0, slot1)
	slot2 = nil

	return slot0._equipId or (slot0:getParentView() and slot3.isItemID and slot3:isItemID() and slot1 or Season123Model.instance:getAllItemMo(Season123Model.instance:getCurSeasonId())[slot1] and slot5[slot1].itemId)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._icon then
		slot0._icon:setClickCall(nil, )
		slot0._icon:disposeUI()
	end
end

return slot0
