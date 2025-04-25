module("modules.logic.lifecircle.view.LifeCircleSignRewardsItemItem", package.seeall)

slot0 = class("LifeCircleSignRewardsItemItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "#image_bg")
	slot0._simageReward = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Reward")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "#go_hasget")
	slot0._txtrewardcount = gohelper.findChildText(slot0.viewGO, "#txt_rewardcount")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
slot2 = Color.New(1, 1, 1, 1)
slot3 = Color.New(0.5, 0.5, 0.5, 1)
slot4 = Color.New(1, 1, 1, 1)
slot5 = Color.New(0.227451, 0.227451, 0.227451, 1)
slot6 = Color.New(0.227451, 0.227451, 0.227451, 1)

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._simageRewardGo = slot0._simageReward.gameObject
	slot0._simageRewardImg = slot0._simageReward:GetComponent(gohelper.Type_Image)
	slot0._imagebgGo = slot0._imagebg.gameObject
	slot0._itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0._simageRewardGo)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_itemIcon")
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0._isClaimed(slot0)
	return slot0:parent():isClaimed()
end

function slot0._logindaysid(slot0)
	return slot0:parent():logindaysid()
end

function slot0._setData_Normal(slot0, slot1)
	slot2 = slot1[1]
	slot3 = slot1[2]
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2, slot3)

	slot0._itemIcon:setMOValue(slot2, slot3, slot1[3])
	slot0._itemIcon:isShowQuality(false)
	slot0._itemIcon:isShowEquipAndItemCount(false)
	slot0._itemIcon:customOnClickCallback(slot0._onItemClick, slot0)

	if slot0._itemIcon:isEquipIcon() then
		slot0._itemIcon:setScale(0.7)
	else
		slot0._itemIcon:setScale(0.8)
	end

	slot0:_setBg(slot5.rare)

	slot0._txtrewardcount.text = slot4 and luaLang("multiple") .. slot4 or ""
end

function slot0._setBg(slot0, slot1)
	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagebg, "bg_pinjidi_" .. tostring(slot1 or 0))
end

function slot0._setData_LastOne(slot0)
	slot0._txtrewardcount.text = ""

	gohelper.setActive(slot0._imagebgGo, true)
	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagebg, "bg_pinjidi_0")
	slot0:_setBg(0)
end

function slot0.setData(slot0, slot1)
	uv0.super.setData(slot0, slot1)

	slot3 = slot0:_isClaimed() and uv1 or uv2
	slot4 = slot2 and uv3 or uv4
	slot5 = slot2 and uv5 or uv6

	gohelper.setActive(slot0._simageRewardGo, slot1 and true or false)

	slot6 = slot1 and true or false

	slot0:_setActive_itemIcon(slot6)

	slot0._simageRewardImg.enabled = not slot6

	if not slot1 then
		slot0:_setData_LastOne()
	else
		slot0:_setData_Normal(slot1)
	end

	slot0._simageRewardImg.color = slot3
	slot0._imagebg.color = slot4
	slot0._txtrewardcount.color = slot5

	gohelper.setActive(slot0._gohasget, slot2)
end

function slot0._onItemClick(slot0)
	if not slot0:parent():onItemClick() then
		return
	end

	if not slot0._mo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(slot2[1], slot2[2])
end

function slot0._setActive_itemIcon(slot0, slot1)
	if slot1 then
		slot0._itemIcon:setPropItemScale(1)
	else
		slot0._itemIcon:setPropItemScale(0)
	end
end

return slot0
