module("modules.logic.versionactivity1_5.aizila.view.AiZiLaGoodsItem", package.seeall)

slot0 = class("AiZiLaGoodsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#image_rare")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._imageselected = gohelper.findChildImage(slot0.viewGO, "#image_selected")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "#go_count")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_count/#txt_count")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goredPoint = gohelper.findChild(slot0.viewGO, "#go_redPiont")
	slot0._imagecountBG = gohelper.findChildImage(slot0.viewGO, "#go_count")
	slot0._singleicon = gohelper.findChildSingleImage(slot0.viewGO, "#image_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._itemId then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.V1a5AiZiLa, slot0._itemId)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._imageselected, false)
	slot0:setShowCount(true)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:setItemId(slot1.itemId)

	if slot1.quantity or slot1.getQuantity then
		slot0:setCountStr(slot1.quantity or slot1:getQuantity())
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._imageselected, slot1)
end

function slot0.setItemId(slot0, slot1)
	slot0._itemId = slot1

	slot0:_refreshIcon(slot1)
end

function slot0.setShowCount(slot0, slot1, slot2)
	if slot0._isShow ~= slot1 then
		slot0._isShow = slot1

		gohelper.setActive(slot0._gocount, slot1)
	end

	if slot2 == true then
		slot0._imagecountBG.enabled = true
	elseif slot2 == false then
		slot0._imagecountBG.enabled = false
	end
end

function slot0.setCountStr(slot0, slot1)
	slot0._txtcount.text = slot1
end

function slot0._refreshIcon(slot0, slot1)
	if (slot1 or slot0._itemId) ~= slot0._lastItemId and AiZiLaConfig.instance:getItemCo(slot1) then
		slot0._lastItemId = slot1

		slot0._singleicon:LoadImage(ResUrl.getV1a5AiZiLaItemIcon(slot2.icon))
		UISpriteSetMgr.instance:setV1a5AiZiLaSprite(slot0._imagerare, AiZiLaEnum.RareIcon[slot2.rare])
	end
end

function slot0.onDestroyView(slot0)
	slot0._singleicon:UnLoadImage()
end

slot0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_goodsitem.prefab"
slot0.prefabPath2 = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_goodsitem2.prefab"

return slot0
