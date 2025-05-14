module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropItem", package.seeall)

local var_0_0 = class("RougeCollectionDropItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.parent = arg_1_2

	arg_1_0:_editableInitView()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.animator = arg_2_0.go:GetComponent(gohelper.Type_Animator)
	arg_2_0._goselect = gohelper.findChild(arg_2_0.go, "#go_select")
	arg_2_0._goenchantlist = gohelper.findChild(arg_2_0.go, "#go_enchantlist")
	arg_2_0._gohole = gohelper.findChild(arg_2_0.go, "#go_enchantlist/#go_hole")
	arg_2_0._gridLayout = gohelper.findChild(arg_2_0.go, "Grid")
	arg_2_0._gogriditem = gohelper.findChild(arg_2_0.go, "Grid/#go_grid")
	arg_2_0._simagecollection = gohelper.findChildSingleImage(arg_2_0.go, "#simage_collection")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.go, "#txt_name")
	arg_2_0._scrollreward = gohelper.findChild(arg_2_0.go, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_2_0._godescContent = gohelper.findChild(arg_2_0.go, "scroll_desc/Viewport/#go_descContent")
	arg_2_0._gotags = gohelper.findChild(arg_2_0.go, "tagcontent/tags")
	arg_2_0._gotagitem = gohelper.findChild(arg_2_0.go, "tagcontent/tags/#go_tagitem")
	arg_2_0._gotips = gohelper.findChild(arg_2_0.go, "#go_tips")
	arg_2_0._gotipscontent = gohelper.findChild(arg_2_0.go, "#go_tips/#go_tipscontent")
	arg_2_0._gotipitem = gohelper.findChild(arg_2_0.go, "#go_tips/#go_tipscontent/#txt_tagitem")
	arg_2_0._btnopentagtips = gohelper.findChildButtonWithAudio(arg_2_0.go, "tagcontent/#btn_opentagtips")
	arg_2_0._btnclosetagtips = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_tips/#btn_closetips")
	arg_2_0.holeGoList = arg_2_0:getUserDataTb_()

	table.insert(arg_2_0.holeGoList, arg_2_0._gohole)

	arg_2_0.gridList = arg_2_0:getUserDataTb_()
	arg_2_0._itemInstTab = arg_2_0:getUserDataTb_()
	arg_2_0.click = gohelper.getClickWithDefaultAudio(arg_2_0.go)

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	arg_2_0._btnopentagtips:AddClickListener(arg_2_0._opentagtipsOnClick, arg_2_0)
	arg_2_0._btnclosetagtips:AddClickListener(arg_2_0._closetagtipsOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectDropChange, arg_2_0.onSelectDropChange, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_2_0._onSwitchCollectionInfoType, arg_2_0)
end

function var_0_0.onClickSelf(arg_3_0)
	arg_3_0.parent:selectPos(arg_3_0.index)
	arg_3_0:refreshSelect()
end

function var_0_0._opentagtipsOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotips, true)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(arg_4_0.collectionId, nil, arg_4_0._gotipscontent, arg_4_0._gotipitem)
end

function var_0_0._closetagtipsOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotips, false)
end

function var_0_0.onSelectDropChange(arg_6_0)
	arg_6_0.select = arg_6_0.parent:isSelect(arg_6_0.index)

	arg_6_0:refreshSelect()
end

function var_0_0.setParentScroll(arg_7_0, arg_7_1)
	arg_7_0._scrollreward.parentGameObject = arg_7_1
end

function var_0_0.update(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.animator:Play("open", 0, 0)

	arg_8_0.select = false
	arg_8_0.index = arg_8_1
	arg_8_0.collectionId = tonumber(arg_8_2)
	arg_8_0.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(arg_8_0.collectionId)

	arg_8_0:refreshHole()
	RougeCollectionHelper.loadShapeGrid(arg_8_0.collectionId, arg_8_0._gridLayout, arg_8_0._gogriditem, arg_8_0.gridList)
	RougeCollectionHelper.loadCollectionTags(arg_8_0.collectionId, arg_8_0._gotags, arg_8_0._gotagitem)
	arg_8_0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_8_0.collectionId))

	arg_8_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(arg_8_0.collectionId)

	arg_8_0:refreshEffectDesc()
	arg_8_0:refreshSelect()
end

function var_0_0.refreshHole(arg_9_0)
	local var_9_0 = arg_9_0.collectionCo.holeNum

	gohelper.setActive(arg_9_0._goenchantlist, var_9_0 > 0)

	if var_9_0 > 1 then
		for iter_9_0 = 1, var_9_0 do
			local var_9_1 = arg_9_0.holeGoList[iter_9_0]

			if not var_9_1 then
				var_9_1 = gohelper.cloneInPlace(arg_9_0._gohole)

				table.insert(arg_9_0.holeGoList, var_9_1)
			end

			gohelper.setActive(var_9_1, true)
		end

		for iter_9_1 = var_9_0 + 1, #arg_9_0.holeGoList do
			gohelper.setActive(arg_9_0.holeGoList[iter_9_1], false)
		end
	end
end

function var_0_0.refreshEffectDesc(arg_10_0)
	arg_10_0._allClicks = arg_10_0._allClicks or arg_10_0:getUserDataTb_()
	arg_10_0._clickLen = arg_10_0._clickLen or 0

	for iter_10_0 = 1, arg_10_0._clickLen do
		arg_10_0._allClicks[iter_10_0]:RemoveClickListener()
	end

	arg_10_0._clickLen = 0

	RougeCollectionDescHelper.setCollectionDescInfos2(arg_10_0.collectionId, nil, arg_10_0._godescContent, arg_10_0._itemInstTab)

	local var_10_0 = arg_10_0._scrollreward.gameObject:GetComponentsInChildren(typeof(SLFramework.UGUI.UIClickListener), true)

	arg_10_0._clickLen = var_10_0.Length

	for iter_10_1 = 0, arg_10_0._clickLen - 1 do
		arg_10_0._allClicks[iter_10_1 + 1] = var_10_0[iter_10_1]

		arg_10_0._allClicks[iter_10_1 + 1]:AddClickListener(arg_10_0.onClickSelf, arg_10_0)
		gohelper.addUIClickAudio(arg_10_0._allClicks[iter_10_1 + 1].gameObject)
	end
end

function var_0_0.refreshSelect(arg_11_0)
	gohelper.setActive(arg_11_0._goselect, arg_11_0.select)
end

function var_0_0._onSwitchCollectionInfoType(arg_12_0)
	arg_12_0:refreshEffectDesc()
end

function var_0_0.hide(arg_13_0)
	gohelper.setActive(arg_13_0.go, false)
end

function var_0_0.show(arg_14_0)
	gohelper.setActive(arg_14_0.go, true)
end

function var_0_0.onClose(arg_15_0)
	arg_15_0.animator:Play(arg_15_0.select and "close" or "normal", 0, 0)
end

function var_0_0.destroy(arg_16_0)
	if arg_16_0._clickLen then
		for iter_16_0 = 1, arg_16_0._clickLen do
			arg_16_0._allClicks[iter_16_0]:RemoveClickListener()
		end
	end

	arg_16_0.click:RemoveClickListener()
	arg_16_0._btnopentagtips:RemoveClickListener()
	arg_16_0._btnclosetagtips:RemoveClickListener()
	arg_16_0._simagecollection:UnLoadImage()
	arg_16_0:__onDispose()
end

return var_0_0
