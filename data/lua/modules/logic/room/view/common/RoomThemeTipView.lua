module("modules.logic.room.view.common.RoomThemeTipView", package.seeall)

slot0 = class("RoomThemeTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simageblockpackageicon = gohelper.findChildSingleImage(slot0.viewGO, "content/blockpackageiconmask/#simage_blockpackageicon")
	slot0._gosuitcollect = gohelper.findChild(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect")
	slot0._simagebuildingicon = gohelper.findChildSingleImage(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#simage_buildingicon")
	slot0._btnsuitcollect = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#btn_suitcollect")
	slot0._gocollecticon = gohelper.findChild(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#go_collecticon")
	slot0._txtbuildingname = gohelper.findChildText(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_buildingname")
	slot0._txtcollectdesc = gohelper.findChildText(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_collectdesc")
	slot0._gonormaltitle = gohelper.findChild(slot0.viewGO, "content/title/#go_normaltitle")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "content/title/#go_normaltitle/#txt_name")
	slot0._gohascollect = gohelper.findChild(slot0.viewGO, "content/title/#go_hascollect")
	slot0._txtname2 = gohelper.findChildText(slot0.viewGO, "content/title/#go_hascollect/#txt_name2")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "content/desc/#txt_desc")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "content/go_scroll/#scroll_item")
	slot0._gocobrand = gohelper.findChild(slot0.viewGO, "content/#go_cobrand")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsuitcollect:AddClickListener(slot0._btnsuitcollectOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnsuitcollect:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnsuitcollectOnClick(slot0)
	if RoomModel.instance:isHasGetThemeRewardById(slot0._themeId) then
		return
	end

	if slot0._collectionBonus and #slot0._collectionBonus > 0 then
		slot1 = slot0._collectionBonus[1]
		slot2 = {
			type = slot1[1],
			id = slot1[2]
		}

		MaterialTipController.instance:showMaterialInfoWithData(slot2.type, slot2.id, slot2)
	end
end

function slot0._editableInitView(slot0)
	RoomThemeItemListModel.instance:setItemShowType(RoomThemeItemListModel.SwitchType.Collect)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "content/themeitem"), false)

	slot0._gocollecticonanimator = slot0._gocollecticon:GetComponent(typeof(UnityEngine.Animator))
	slot0.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocobrand, RoomSourcesCobrandLogoItem, slot0)
end

function slot0._refreshUI(slot0)
	slot0._themeId = RoomConfig.instance:getThemeIdByItem(slot0._itemId, slot0._itemType) or 1
	slot0._collectionBonus = RoomConfig.instance:getThemeCollectionRewards(slot0._themeId)
	slot0._hasCollectionReward = slot0._collectionBonus and #slot0._collectionBonus > 0

	if RoomConfig.instance:getThemeConfig(slot0._themeId) then
		slot0._simageblockpackageicon:LoadImage(ResUrl.getRoomThemeRewardIcon(slot1.rewardIcon))
		RoomThemeItemListModel.instance:setThemeId(slot0._themeId)

		slot0._txtname.text = slot1.name
		slot0._txtname2.text = slot1.name
		slot0._txtdesc.text = slot1.desc
	end

	slot0.cobrandLogoItem:setSourcesTypeStr(slot1 and slot1.sourcesType)

	slot3 = slot0._hasCollectionReward and RoomModel.instance:isGetThemeRewardById(slot0._themeId) or RoomModel.instance:isFinshThemeById(slot0._themeId)

	gohelper.setActive(slot0._gosuitcollect, slot0._hasCollectionReward)
	gohelper.setActive(slot0._gonormaltitle, not slot3)
	gohelper.setActive(slot0._gohascollect, slot3)

	if slot0._hasCollectionReward then
		gohelper.setActive(slot0._gocollecticon, slot2)
		gohelper.setActive(slot0._btnsuitcollect, not slot2)

		slot4 = slot0._collectionBonus[1]
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot4[1], slot4[2], true)

		slot0._simagebuildingicon:LoadImage(slot6)

		slot0._txtbuildingname.text = slot5.name
	end
end

function slot0._onUpdateRoomThemeReward(slot0, slot1)
	if slot0._themeId == slot1 then
		slot0:_refreshUI()
	end
end

function slot0.onOpen(slot0)
	slot0._itemType = slot0.viewParam.type
	slot0._itemId = slot0.viewParam.id

	slot0:addEventCb(RoomController.instance, RoomEvent.UpdateRoomThemeReward, slot0._onUpdateRoomThemeReward, slot0)
	slot0:_refreshUI()
	TaskDispatcher.runDelay(slot0._checkSendReward, slot0, 1.5)

	if RoomModel.instance:isHasGetThemeRewardById(slot0._themeId) then
		gohelper.setActive(slot0._gocollecticonanimator, true)
		slot0._gocollecticonanimator:Play("open", 0, 0)
	end
end

function slot0.onUpdateParam(slot0)
	slot0._itemType = slot0.viewParam.type
	slot0._itemId = slot0.viewParam.id

	slot0:_refreshUI()
	slot0:_checkSendReward()
end

function slot0._checkSendReward(slot0)
	if RoomModel.instance:isHasGetThemeRewardById(slot0._themeId) then
		RoomRpc.instance:sendGetRoomThemeCollectionBonusRequest(slot0._themeId)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._checkSendReward, slot0)
	slot0:_checkSendReward()
end

function slot0.onDestroyView(slot0)
	slot0._simageblockpackageicon:UnLoadImage()
	slot0._simagebuildingicon:UnLoadImage()
	slot0.cobrandLogoItem:onDestroy()
end

return slot0
