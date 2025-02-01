module("modules.logic.rouge.view.RougeFactionItem_Base", package.seeall)

slot0 = class("RougeFactionItem_Base", RougeItemNodeBase)

function slot0._editableInitView(slot0)
	slot0._itemClick = gohelper.getClickWithAudio(slot0._goBg)
end

function slot0.addEventListeners(slot0)
	RougeItemNodeBase.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
	RougeItemNodeBase.removeEventListeners(slot0)
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_itemClick")
end

function slot0._onItemClick(slot0)
	if not slot0:staticData() then
		return
	end

	if not slot1.baseViewContainer then
		return
	end

	slot2:dispatchEvent(RougeEvent.RougeFactionView_OnSelectIndex, slot0:index())
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot1.styleCO
	slot0._txtname.text = slot2.name
	slot0._txtscrollDesc.text = slot2.desc

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageicon, slot2.icon)
end

function slot0.difficulty(slot0)
	return slot0:parent():difficulty()
end

return slot0
