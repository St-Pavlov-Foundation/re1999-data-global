module("modules.logic.versionactivity1_4.act130.view.Activity130CollectItem", package.seeall)

slot0 = class("Activity130CollectItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._imageitembg = gohelper.findChildImage(slot0._go, "image_ItemBG")
	slot0._imageicon = gohelper.findChildImage(slot0._go, "#image_Icon")
	slot0._txtIndex = gohelper.findChildText(slot0._go, "#txt_Num")
	slot0._txtDesc = gohelper.findChildText(slot0._go, "#txt_Item")
	slot0._txtTitle = gohelper.findChildText(slot0._go, "#txt_Type")

	slot0:addEventListeners()
end

function slot0.setItem(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._index = slot2

	gohelper.setActive(slot0._go, true)
	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	slot0._txtIndex.text = string.format("%02d", slot0._index)
	slot1 = Activity130Model.instance:getCurEpisodeId()

	if not Activity130Model.instance:isCollectUnlock(slot1, Activity130Model.instance:getCollects(slot1)[slot0._index]) then
		slot0._txtDesc.text = "?????"

		UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0._imageicon, "v1a4_role37_collectitemiconempty")

		return
	end

	slot0._txtDesc.text = slot0._config.operDesc
	slot0._txtTitle.text = slot0._config.name

	UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0._imageicon, slot0._config.shapegetImg)
end

function slot0.hideItem(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._btnclickOnClick(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeEventListeners()
end

return slot0
