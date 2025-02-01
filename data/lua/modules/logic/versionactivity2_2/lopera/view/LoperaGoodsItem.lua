module("modules.logic.versionactivity2_2.lopera.view.LoperaGoodsItem", package.seeall)

slot0 = class("LoperaGoodsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_Icon")
	slot0._iconBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#image_Icon")
	slot0._numText = gohelper.findChildText(slot0.viewGO, "image_NumBG/#txt_Num")
	slot0._goNewFlag = gohelper.findChild(slot0.viewGO, "#go_New")
	slot0._canvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	if slot0._iconBtn then
		slot0._iconBtn:AddClickListener(slot0._iconBtnClick, slot0)
	end
end

function slot0.removeEvents(slot0)
	if slot0._iconBtn then
		slot0._iconBtn:RemoveClickListener()
	end
end

function slot0._iconBtnClick(slot0)
	if slot0._itemCount > 0 then
		gohelper.setActive(slot0._goNewFlag, false)
	end

	LoperaController.instance:dispatchEvent(LoperaEvent.GoodItemClick, slot0._idx)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:setItemId(slot1.itemId)

	slot2 = (slot1.quantity or slot1.getQuantity) and (slot1.quantity or slot1:getQuantity())
end

function slot0.onUpdateData(slot0, slot1, slot2, slot3, slot4)
	slot0._cfg = slot1
	slot0._idx = slot3
	slot0._itemCount = slot2
	slot0._numText.text = slot2
	slot5 = false

	if slot4 and slot4.showNewFlag then
		slot5 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. slot1.itemId, 0) == 0 and slot2 > 0
	end

	gohelper.setActive(slot0._goNewFlag, slot5)

	if slot5 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. slot0._cfg.itemId, 1)
	end

	slot0:_refreshIcon(slot1.itemId, slot1)

	if slot0._canvasGroup then
		slot0._canvasGroup.alpha = slot2 > 0 and 1 or 0.5
	end
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

function slot0._refreshIcon(slot0, slot1, slot2)
	UISpriteSetMgr.instance:setLoperaItemSprite(slot0._imageicon, (slot2 or Activity168Config.instance:getGameItemCfg(VersionActivity2_2Enum.ActivityId.Lopera, slot1)).icon, false)
end

function slot0.onDestroyView(slot0)
end

slot0.prefabPath = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem_temporary.prefab"
slot0.prefabPath2 = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem2_temporary.prefab"
slot0.prefabPath3 = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem3_temporary.prefab"

return slot0
