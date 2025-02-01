module("modules.logic.season.view1_6.Season1_6EquipSelfChoiceItem", package.seeall)

slot0 = class("Season1_6EquipSelfChoiceItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gocard = gohelper.findChild(slot0.viewGO, "go_card")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "tag")
	slot0._txtcount = gohelper.findChildTextMesh(slot0.viewGO, "tag/bg/#txt_count")
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._cfg = slot1.cfg

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:checkCreateIcon()
	slot0.icon:updateData(slot0._cfg.equipId)
	gohelper.setActive(slot0._goselect, Activity104SelfChoiceListModel.instance.curSelectedItemId == slot0._cfg.equipId)

	slot0._txtcount.text = tostring(Activity104Model.instance:getItemCount(slot0._cfg.equipId, slot0._view.viewParam.actId))
end

function slot0.checkCreateIcon(slot0)
	if not slot0.icon then
		slot0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[2], slot0._gocard, "icon"), Season1_6CelebrityCardEquip)

		slot0.icon:setClickCall(slot0.onClickSelf, slot0)
		slot0.icon:setLongPressCall(slot0.onLongPress, slot0)
	end
end

function slot0.showDetailTips(slot0)
	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, slot0._cfg.equipId, {
		actId = slot0._view.viewParam.actId
	})
end

function slot0.onClickSelf(slot0)
	if Activity104SelfChoiceListModel.instance.curSelectedItemId ~= slot0._cfg.equipId then
		Activity104EquipSelfChoiceController.instance:changeSelectCard(slot0._cfg.equipId)
	end
end

function slot0.onLongPress(slot0)
	slot0:showDetailTips()
end

function slot0.onDestroyView(slot0)
	if slot0.icon then
		slot0.icon:disposeUI()
	end
end

return slot0
