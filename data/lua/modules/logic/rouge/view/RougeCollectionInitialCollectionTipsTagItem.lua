module("modules.logic.rouge.view.RougeCollectionInitialCollectionTipsTagItem", package.seeall)

slot0 = class("RougeCollectionInitialCollectionTipsTagItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	RougeSimpleItemBase.ctor(slot0, slot1)
end

function slot0._editableInitView(slot0)
	RougeSimpleItemBase._editableInitView(slot0)

	slot0._txt = gohelper.findChildText(slot0.viewGO, "")
	slot0._img = gohelper.findChildImage(slot0.viewGO, "image_tagicon")
end

function slot0.setData(slot0, slot1)
	slot2 = lua_rouge_tag.configDict[slot1]
	slot0._txt.text = slot2.name

	UISpriteSetMgr.instance:setRougeSprite(slot0._img, slot2.iconUrl)
end

return slot0
