module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagItem", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionBagItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_collection")
	arg_1_0._imageframe = gohelper.findChildImage(arg_1_0.viewGO, "#image_frame")
	arg_1_0._gogrid1 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid1")
	arg_1_0._gonone1 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid1/#go_none1")
	arg_1_0._goget1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "layout/#go_grid1/#go_get1")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "layout/#go_grid1/#go_get1/#simage_icon1")
	arg_1_0._gonone2 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid2/#go_none2")
	arg_1_0._gogrid2 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid2")
	arg_1_0._goget2 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid2/#go_get2")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "layout/#go_grid2/#go_get2/#simage_icon2")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._isSelect then
		return
	end

	if arg_4_0._clickCallBack then
		arg_4_0._clickCallBack(arg_4_0._clickCallBackObj)
	else
		arg_4_0:defaultClickCallBack()
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.viewGO, not arg_8_1.isFake)

	if arg_8_1.isFake then
		return
	end

	arg_8_0._mo = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_9_0._mo.cfgId)

	if var_9_0 then
		arg_9_0:refreshEnchants(var_9_0)
		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_9_0._imageframe, string.format("v1a6_cachot_img_collectionframe%s", var_9_0.showRare))

		local var_9_1 = arg_9_0._mo.state

		gohelper.setActive(arg_9_0._gonew, var_9_1 == V1a6_CachotEnum.CollectionState.New)
		arg_9_0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_9_0.icon))
	end
end

function var_0_0.refreshEnchants(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._gogrid1, arg_10_1 and arg_10_1.holeNum >= 1)
	gohelper.setActive(arg_10_0._gogrid2, arg_10_1 and arg_10_1.holeNum >= 2)

	if not arg_10_1 or not (arg_10_1.holeNum > 0) then
		return
	end

	arg_10_0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left)
	arg_10_0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right)
end

function var_0_0.refreshSingleHole(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._mo and arg_11_0._mo:getEnchantId(arg_11_1)

	if var_11_0 and var_11_0 ~= 0 then
		gohelper.setActive(arg_11_0["_gonone" .. arg_11_1], false)
		gohelper.setActive(arg_11_0["_goget" .. arg_11_1], true)

		local var_11_1 = V1a6_CachotModel.instance:getRogueInfo()
		local var_11_2 = var_11_1 and var_11_1:getCollectionByUid(var_11_0)
		local var_11_3 = var_11_2 and var_11_2.cfgId
		local var_11_4 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_11_3)

		if var_11_4 then
			arg_11_0["_simageicon" .. arg_11_1]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_11_4.icon))
		end
	else
		gohelper.setActive(arg_11_0["_gonone" .. arg_11_1], true)
		gohelper.setActive(arg_11_0["_goget" .. arg_11_1], false)
	end
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	arg_12_0._isSelect = arg_12_1

	gohelper.setActive(arg_12_0._goselect, arg_12_1)
end

function var_0_0.setClickCallBack(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._clickCallBack = arg_13_1
	arg_13_0._clickCallBackObj = arg_13_2
end

function var_0_0.defaultClickCallBack(arg_14_0)
	V1a6_CachotCollectionBagController.instance:onSelectBagItemByIndex(arg_14_0._index)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._clickCallBack = nil
	arg_15_0._clickCallBackObj = nil

	arg_15_0._simagecollection:UnLoadImage()
end

return var_0_0
