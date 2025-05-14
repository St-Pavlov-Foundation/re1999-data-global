module("modules.logic.room.view.common.RoomThemeTipView", package.seeall)

local var_0_0 = class("RoomThemeTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageblockpackageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/blockpackageiconmask/#simage_blockpackageicon")
	arg_1_0._gosuitcollect = gohelper.findChild(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect")
	arg_1_0._simagebuildingicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#simage_buildingicon")
	arg_1_0._btnsuitcollect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#btn_suitcollect")
	arg_1_0._gocollecticon = gohelper.findChild(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#go_collecticon")
	arg_1_0._txtbuildingname = gohelper.findChildText(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_buildingname")
	arg_1_0._txtcollectdesc = gohelper.findChildText(arg_1_0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_collectdesc")
	arg_1_0._gonormaltitle = gohelper.findChild(arg_1_0.viewGO, "content/title/#go_normaltitle")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "content/title/#go_normaltitle/#txt_name")
	arg_1_0._gohascollect = gohelper.findChild(arg_1_0.viewGO, "content/title/#go_hascollect")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.viewGO, "content/title/#go_hascollect/#txt_name2")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "content/desc/#txt_desc")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/go_scroll/#scroll_item")
	arg_1_0._gocobrand = gohelper.findChild(arg_1_0.viewGO, "content/#go_cobrand")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsuitcollect:AddClickListener(arg_2_0._btnsuitcollectOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsuitcollect:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnsuitcollectOnClick(arg_5_0)
	if RoomModel.instance:isHasGetThemeRewardById(arg_5_0._themeId) then
		return
	end

	if arg_5_0._collectionBonus and #arg_5_0._collectionBonus > 0 then
		local var_5_0 = arg_5_0._collectionBonus[1]
		local var_5_1 = {
			type = var_5_0[1],
			id = var_5_0[2]
		}

		MaterialTipController.instance:showMaterialInfoWithData(var_5_1.type, var_5_1.id, var_5_1)
	end
end

function var_0_0._editableInitView(arg_6_0)
	RoomThemeItemListModel.instance:setItemShowType(RoomThemeItemListModel.SwitchType.Collect)
	gohelper.setActive(gohelper.findChild(arg_6_0.viewGO, "content/themeitem"), false)

	arg_6_0._gocollecticonanimator = arg_6_0._gocollecticon:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._gocobrand, RoomSourcesCobrandLogoItem, arg_6_0)
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0._themeId = RoomConfig.instance:getThemeIdByItem(arg_7_0._itemId, arg_7_0._itemType) or 1

	local var_7_0 = RoomConfig.instance:getThemeConfig(arg_7_0._themeId)

	arg_7_0._collectionBonus = RoomConfig.instance:getThemeCollectionRewards(arg_7_0._themeId)
	arg_7_0._hasCollectionReward = arg_7_0._collectionBonus and #arg_7_0._collectionBonus > 0

	if var_7_0 then
		arg_7_0._simageblockpackageicon:LoadImage(ResUrl.getRoomThemeRewardIcon(var_7_0.rewardIcon))
		RoomThemeItemListModel.instance:setThemeId(arg_7_0._themeId)

		arg_7_0._txtname.text = var_7_0.name
		arg_7_0._txtname2.text = var_7_0.name
		arg_7_0._txtdesc.text = var_7_0.desc
	end

	arg_7_0.cobrandLogoItem:setSourcesTypeStr(var_7_0 and var_7_0.sourcesType)

	local var_7_1 = arg_7_0._hasCollectionReward and RoomModel.instance:isGetThemeRewardById(arg_7_0._themeId)
	local var_7_2 = var_7_1 or RoomModel.instance:isFinshThemeById(arg_7_0._themeId)

	gohelper.setActive(arg_7_0._gosuitcollect, arg_7_0._hasCollectionReward)
	gohelper.setActive(arg_7_0._gonormaltitle, not var_7_2)
	gohelper.setActive(arg_7_0._gohascollect, var_7_2)

	if arg_7_0._hasCollectionReward then
		gohelper.setActive(arg_7_0._gocollecticon, var_7_1)
		gohelper.setActive(arg_7_0._btnsuitcollect, not var_7_1)

		local var_7_3 = arg_7_0._collectionBonus[1]
		local var_7_4, var_7_5 = ItemModel.instance:getItemConfigAndIcon(var_7_3[1], var_7_3[2], true)

		arg_7_0._simagebuildingicon:LoadImage(var_7_5)

		arg_7_0._txtbuildingname.text = var_7_4.name
	end
end

function var_0_0._onUpdateRoomThemeReward(arg_8_0, arg_8_1)
	if arg_8_0._themeId == arg_8_1 then
		arg_8_0:_refreshUI()
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._itemType = arg_9_0.viewParam.type
	arg_9_0._itemId = arg_9_0.viewParam.id

	arg_9_0:addEventCb(RoomController.instance, RoomEvent.UpdateRoomThemeReward, arg_9_0._onUpdateRoomThemeReward, arg_9_0)
	arg_9_0:_refreshUI()
	TaskDispatcher.runDelay(arg_9_0._checkSendReward, arg_9_0, 1.5)

	if RoomModel.instance:isHasGetThemeRewardById(arg_9_0._themeId) then
		gohelper.setActive(arg_9_0._gocollecticonanimator, true)
		arg_9_0._gocollecticonanimator:Play("open", 0, 0)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0._itemType = arg_10_0.viewParam.type
	arg_10_0._itemId = arg_10_0.viewParam.id

	arg_10_0:_refreshUI()
	arg_10_0:_checkSendReward()
end

function var_0_0._checkSendReward(arg_11_0)
	if RoomModel.instance:isHasGetThemeRewardById(arg_11_0._themeId) then
		RoomRpc.instance:sendGetRoomThemeCollectionBonusRequest(arg_11_0._themeId)
	end
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._checkSendReward, arg_12_0)
	arg_12_0:_checkSendReward()
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simageblockpackageicon:UnLoadImage()
	arg_13_0._simagebuildingicon:UnLoadImage()
	arg_13_0.cobrandLogoItem:onDestroy()
end

return var_0_0
