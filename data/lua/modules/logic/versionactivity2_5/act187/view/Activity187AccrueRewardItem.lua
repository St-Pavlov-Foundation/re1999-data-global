module("modules.logic.versionactivity2_5.act187.view.Activity187AccrueRewardItem", package.seeall)

slot0 = class("Activity187AccrueRewardItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._btnItem = gohelper.findChildClick(slot0.go, "#go_item")
	slot0._imagebg = gohelper.findChildImage(slot0.go, "#go_item/#image_bg")
	slot0._simagereward = gohelper.findChildSingleImage(slot0.go, "#go_item/#simage_reward")
	slot0._imagecircle = gohelper.findChildImage(slot0.go, "#go_item/image_circle")
	slot0._txtrewardcount = gohelper.findChildText(slot0.go, "#go_item/#txt_rewardcount")
	slot0._deadline1 = gohelper.findChild(slot0.go, "#go_item/deadline1")
	slot0._gohasget = gohelper.findChild(slot0.go, "#go_status/#go_hasget")
	slot0._gocanget = gohelper.findChild(slot0.go, "#go_status/#go_canget")
	slot0._btnget = gohelper.findChildClickWithDefaultAudio(slot0.go, "#go_status/#go_canget/#btn_get")
	slot0._imagestatus = gohelper.findChildImage(slot0.go, "#image_point")
	slot0._txtpointvalue = gohelper.findChildText(slot0.go, "#txt_pointvalue")
	slot0._hasGetAnimator = slot0._gohasget:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._btnget:AddClickListener(slot0._btngetOnClick, slot0)
	slot0._btnItem:AddClickListener(slot0._btnitemOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnget:RemoveClickListener()
	slot0._btnItem:RemoveClickListener()
end

function slot0._btngetOnClick(slot0)
	if not slot0.data then
		return
	end

	if not (slot0.id <= Activity187Model.instance:getAccrueRewardIndex()) and slot0.id <= Activity187Model.instance:getFinishPaintingIndex() and not slot3 then
		Activity187Controller.instance:getAccrueReward()
	end
end

function slot0._btnitemOnClick(slot0)
	if not slot0.data then
		return
	end

	MaterialTipController.instance:showMaterialInfo(slot0.data.materilType, slot0.data.materilId)
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1
	slot0.id = slot0.data and slot0.data.accrueId

	slot0:setItem()
	slot0:refreshStatus()
	gohelper.setActive(slot0.go, slot0.data)
end

function slot0.setItem(slot0)
	if not slot0.data then
		return
	end

	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0.data.materilType, slot0.data.materilId)

	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagebg, "bg_pinjidi_" .. slot1.rare)
	slot0._simagereward:LoadImage(slot2)
	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagecircle, "bg_pinjidi_lanse_" .. slot1.rare)

	slot0._txtrewardcount.text = string.format("%s%s", luaLang("multiple"), slot0.data.quantity)
	slot0._txtpointvalue.text = formatLuaLang("times2", slot0.id)
	slot3 = false

	if slot0.data.materilType == MaterialEnum.MaterialType.PowerPotion then
		slot3 = slot1.expireType ~= 0 and not string.nilorempty(slot1.expireTime)
	end

	gohelper.setActive(slot0._deadline1, slot3)
end

function slot0.refreshStatus(slot0, slot1)
	if not slot0.data then
		return
	end

	slot4 = slot0.id <= Activity187Model.instance:getAccrueRewardIndex()

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtpointvalue, slot4 and "#CF7845" or "#968C89")
	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagestatus, "bg_xingjidian" .. (slot4 and "" or "_dis"), true)

	if slot1 and (not slot4 and slot0.id <= Activity187Model.instance:getFinishPaintingIndex()) then
		gohelper.setActive(slot0._gohasget, true)
		gohelper.setActive(slot0._gocanget, false)
		slot0._hasGetAnimator:Play("open")
	else
		gohelper.setActive(slot0._gohasget, slot4)
		gohelper.setActive(slot0._gocanget, slot5)
	end
end

function slot0.onDestroy(slot0)
	slot0._simagereward:UnLoadImage()
end

return slot0
