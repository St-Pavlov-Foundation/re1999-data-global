module("modules.logic.rouge.view.RougeCollectionListItem", package.seeall)

slot0 = class("RougeCollectionListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_normal/go_new")
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "#go_normal/#image_bg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_collection")
	slot0._imagecollection = gohelper.findChildImage(slot0.viewGO, "#go_normal/#simage_collection")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._godlctag = gohelper.findChild(slot0.viewGO, "#go_dlctag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO, AudioEnum.UI.UI_Common_Click)
	slot0._color = slot0._imagecollection.color
	slot0._orderColor = slot0._txtnum.color
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickItem, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionListItem, slot0._onClickCollectionListItem, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onClickItem(slot0)
	RougeCollectionListModel.instance:setSelectedConfig(slot0._mo)

	if slot0._showNewFlag then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Collection, slot0._mo.id, slot0._updateNewFlag, slot0)
	end
end

function slot0._onClickCollectionListItem(slot0)
	slot0:_updateSelected()
end

function slot0._updateSelected(slot0)
	gohelper.setActive(slot0._goselected, RougeCollectionListModel.instance:getSelectedConfig() and slot1 == slot0._mo)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot1 ~= nil

	gohelper.setActive(slot0.viewGO, slot2)

	if not slot2 then
		return
	end

	slot4 = nil

	if RougeFavoriteModel.instance:collectionIsUnlock(slot1.id) then
		slot0._color.a = RougeOutsideModel.instance:collectionIsPass(slot1.id) and 1 or 0.3
		slot0._imagecollection.color = slot0._color
	end

	slot0._orderColor.a = slot4 and 0.7 or 0.3
	slot0._txtnum.color = slot0._orderColor
	slot0._txtnum.text = RougeCollectionListModel.instance:getPos(slot1.id)
	slot5 = RougeCollectionConfig.instance:getCollectionCfg(slot1.id)

	UISpriteSetMgr.instance:setRougeSprite(slot0._imagebg, "rouge_episode_collectionbg_" .. slot5.showRare, true)
	gohelper.setActive(slot0._gonormal, slot3)
	gohelper.setActive(slot0._golocked, not slot3)
	slot0:_updateSelected()
	slot0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0._mo.id))
	slot0:_updateNewFlag()
	slot0:_refreshDLCTag(slot5.versions, slot3)
end

function slot0._updateNewFlag(slot0)
	slot0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Collection, slot0._mo.id) ~= nil

	gohelper.setActive(slot0._gonew, slot0._showNewFlag)
end

function slot0._refreshDLCTag(slot0, slot1, slot2)
	slot4 = (slot1 and slot1[1]) ~= nil and slot2

	gohelper.setActive(slot0._godlctag, slot4)

	if slot4 then
		UISpriteSetMgr.instance:setRougeSprite(slot0._godlctag:GetComponent(gohelper.Type_Image), "rouge_episode_tagdlc_101")
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
