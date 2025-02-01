module("modules.logic.versionactivity1_4.act129.view.Activity129RewardItem", package.seeall)

slot0 = class("Activity129RewardItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goItem = gohelper.findChild(slot1, "#go_Item")
	slot0.txtNum = gohelper.findChildTextMesh(slot1, "Num/#txt_ItemNum")
	slot0.goGet = gohelper.findChild(slot1, "#go_Get")
	slot0.goLimit = gohelper.findChild(slot1, "#go_limit")
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4)
	slot0.hideMark = false

	gohelper.setActive(slot0.go, true)
	gohelper.setAsLastSibling(slot0.go)

	if not slot0.itemIcon then
		slot0.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0.goItem)
	end

	slot0.itemIcon:setMOValue(slot1[1], slot1[2], slot1[3], nil, true)
	slot0.itemIcon:isShowEffect(true)
	slot0.itemIcon:setCountTxtSize(34)
	gohelper.setActive(slot0.goLimit, tabletool.indexOf(string.splitToNumber(ItemModel.instance:getItemConfig(slot1[1], slot1[2]).tag or ""), 1) ~= nil)

	if (slot1[4] or 0) > 0 then
		slot11 = slot7 - (Activity129Model.instance:getActivityMo(slot2):getPoolMo(slot3) and slot9:getGoodsGetNum(slot4, slot1[1], slot1[2]) or 0)
		slot0.txtNum.text = string.format("%s/%s", slot11, slot7)

		gohelper.setActive(slot0.goGet, slot11 <= 0)
	else
		slot0.txtNum.text = "<size=40>∞</size>"

		gohelper.setActive(slot0.goGet, false)
	end
end

function slot0.setHideMark(slot0)
	slot0.hideMark = true
end

function slot0.checkHide(slot0)
	if slot0.hideMark then
		gohelper.setActive(slot0.go, false)
	end
end

function slot0.onDestroy(slot0)
end

return slot0
