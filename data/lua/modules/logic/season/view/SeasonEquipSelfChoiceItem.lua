module("modules.logic.season.view.SeasonEquipSelfChoiceItem", package.seeall)

slot0 = class("SeasonEquipSelfChoiceItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gocard = gohelper.findChild(slot0.viewGO, "go_card")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0.onClickDetail, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
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
end

function slot0.checkCreateIcon(slot0)
	if not slot0.icon then
		slot0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[2], slot0._gocard, "icon"), SeasonCelebrityCardEquip)

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

function slot0.onClickDetail(slot0)
	slot0:showDetailTips()
end

function slot0.onDestroyView(slot0)
	if slot0.icon then
		slot0.icon:disposeUI()
	end
end

return slot0
