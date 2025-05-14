module("modules.logic.rouge.view.RougeCollectionListItem", package.seeall)

local var_0_0 = class("RougeCollectionListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_normal/go_new")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/#image_bg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_collection")
	arg_1_0._imagecollection = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/#simage_collection")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._godlctag = gohelper.findChild(arg_1_0.viewGO, "#go_dlctag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = gohelper.getClickWithAudio(arg_4_0.viewGO, AudioEnum.UI.UI_Common_Click)
	arg_4_0._color = arg_4_0._imagecollection.color
	arg_4_0._orderColor = arg_4_0._txtnum.color
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onClickItem, arg_5_0)
	arg_5_0:addEventCb(RougeController.instance, RougeEvent.OnClickCollectionListItem, arg_5_0._onClickCollectionListItem, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0._onClickItem(arg_7_0)
	RougeCollectionListModel.instance:setSelectedConfig(arg_7_0._mo)

	if arg_7_0._showNewFlag then
		local var_7_0 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_7_0, RougeEnum.FavoriteType.Collection, arg_7_0._mo.id, arg_7_0._updateNewFlag, arg_7_0)
	end
end

function var_0_0._onClickCollectionListItem(arg_8_0)
	arg_8_0:_updateSelected()
end

function var_0_0._updateSelected(arg_9_0)
	local var_9_0 = RougeCollectionListModel.instance:getSelectedConfig()

	gohelper.setActive(arg_9_0._goselected, var_9_0 and var_9_0 == arg_9_0._mo)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	local var_10_0 = arg_10_1 ~= nil

	gohelper.setActive(arg_10_0.viewGO, var_10_0)

	if not var_10_0 then
		return
	end

	local var_10_1 = RougeFavoriteModel.instance:collectionIsUnlock(arg_10_1.id)
	local var_10_2

	if var_10_1 then
		var_10_2 = RougeOutsideModel.instance:collectionIsPass(arg_10_1.id)
		arg_10_0._color.a = var_10_2 and 1 or 0.3
		arg_10_0._imagecollection.color = arg_10_0._color
	end

	arg_10_0._orderColor.a = var_10_2 and 0.7 or 0.3
	arg_10_0._txtnum.color = arg_10_0._orderColor
	arg_10_0._txtnum.text = RougeCollectionListModel.instance:getPos(arg_10_1.id)

	local var_10_3 = RougeCollectionConfig.instance:getCollectionCfg(arg_10_1.id)
	local var_10_4 = "rouge_episode_collectionbg_" .. var_10_3.showRare

	UISpriteSetMgr.instance:setRougeSprite(arg_10_0._imagebg, var_10_4, true)
	gohelper.setActive(arg_10_0._gonormal, var_10_1)
	gohelper.setActive(arg_10_0._golocked, not var_10_1)
	arg_10_0:_updateSelected()
	arg_10_0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_10_0._mo.id))
	arg_10_0:_updateNewFlag()
	arg_10_0:_refreshDLCTag(var_10_3.versions, var_10_1)
end

function var_0_0._updateNewFlag(arg_11_0)
	arg_11_0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Collection, arg_11_0._mo.id) ~= nil

	gohelper.setActive(arg_11_0._gonew, arg_11_0._showNewFlag)
end

function var_0_0._refreshDLCTag(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = (arg_12_1 and arg_12_1[1]) ~= nil and arg_12_2

	gohelper.setActive(arg_12_0._godlctag, var_12_0)

	if var_12_0 then
		local var_12_1 = arg_12_0._godlctag:GetComponent(gohelper.Type_Image)

		UISpriteSetMgr.instance:setRougeSprite(var_12_1, "rouge_episode_tagdlc_101")
	end
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
