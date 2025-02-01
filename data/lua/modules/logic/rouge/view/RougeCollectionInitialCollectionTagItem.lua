module("modules.logic.rouge.view.RougeCollectionInitialCollectionTagItem", package.seeall)

slot0 = class("RougeCollectionInitialCollectionTagItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

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

function slot0.ctor(slot0, slot1)
	RougeSimpleItemBase.ctor(slot0, slot1)
end

function slot0._btnclickOnClick(slot0)
	slot0:parent():setActiveTips(true)
end

function slot0._editableInitView(slot0)
	RougeSimpleItemBase._editableInitView(slot0)

	slot0._imageTagFrame = gohelper.findChildImage(slot0.viewGO, "image_tagframe")
	slot0._imageTagIcon = gohelper.findChildImage(slot0.viewGO, "image_tagicon")

	UISpriteSetMgr.instance:setRougeSprite(slot0._imageTagFrame, "rouge_collection_tagframe_1")
end

function slot0.setData(slot0, slot1)
	UISpriteSetMgr.instance:setRougeSprite(slot0._imageTagIcon, lua_rouge_tag.configDict[slot1].iconUrl)
end

return slot0
