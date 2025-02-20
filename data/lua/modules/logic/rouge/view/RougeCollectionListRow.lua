module("modules.logic.rouge.view.RougeCollectionListRow", package.seeall)

slot0 = class("RougeCollectionListRow", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_Title/#txt_TitleEn")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_title/#image_icon")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "#go_collectionitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gocollectionitem, false)

	slot4 = false

	gohelper.setActive(slot0._txtTitleEn, slot4)

	slot0._itemList = slot0:getUserDataTb_()

	for slot4 = 1, RougeEnum.CollectionListRowNum do
		table.insert(slot0._itemList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gocollectionitem), RougeCollectionListItem))
	end

	slot0._gridLayout = slot0.viewGO:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	for slot5, slot6 in ipairs(slot0._itemList) do
		slot6:onUpdateMO(slot1[slot5])
	end

	slot2 = slot1.type ~= nil

	gohelper.setActive(slot0._gotitle, slot2)

	slot3 = slot0._gridLayout.padding
	slot3.top = slot2 and 61 or 0
	slot0._gridLayout.padding = slot3

	if not slot2 then
		return
	end

	if not RougeCollectionConfig.instance:getTagConfig(slot1.type) then
		return
	end

	slot0._txtTitle.text = slot4.name

	UISpriteSetMgr.instance:setRougeSprite(slot0._imageicon, slot4.iconUrl)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
