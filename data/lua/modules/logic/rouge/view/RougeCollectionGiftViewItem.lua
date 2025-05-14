module("modules.logic.rouge.view.RougeCollectionGiftViewItem", package.seeall)

local var_0_0 = class("RougeCollectionGiftViewItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "tags/#go_tagitem")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "tags/#go_tips")
	arg_1_0._txttagitem = gohelper.findChildText(arg_1_0.viewGO, "tags/#go_tips/#txt_tagitem")
	arg_1_0._goenchantlist = gohelper.findChild(arg_1_0.viewGO, "#go_enchantlist")
	arg_1_0._gohole = gohelper.findChild(arg_1_0.viewGO, "#go_enchantlist/#go_hole")
	arg_1_0._gogrid = gohelper.findChild(arg_1_0.viewGO, "Grid/#go_grid")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_collection")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._goskillcontainer = gohelper.findChild(arg_1_0.viewGO, "scroll_desc/Viewport/#go_skillcontainer")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "scroll_desc/Viewport/#go_skillcontainer/#go_skillitem")

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

function var_0_0.ctor(arg_4_0, arg_4_1)
	RougeSimpleItemBase.ctor(arg_4_0, arg_4_1)
end

function var_0_0._btnclickOnClick(arg_5_0)
	return
end

function var_0_0.addEventListeners(arg_6_0)
	RougeSimpleItemBase.addEventListeners(arg_6_0)
	arg_6_0._itemClick:AddClickListener(arg_6_0._onItemClick, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	RougeSimpleItemBase.removeEventListeners(arg_7_0)
	GameUtil.onDestroyViewMember_ClickListener(arg_7_0, "_itemClick")
end

function var_0_0.onDestroyView(arg_8_0)
	RougeSimpleItemBase.onDestroyView(arg_8_0)
	arg_8_0._simagecollection:UnLoadImage()
	GameUtil.onDestroyViewMemberList(arg_8_0, "_tagObjList")
	GameUtil.onDestroyViewMemberList(arg_8_0, "_tipsTagObjList")
end

function var_0_0._onItemClick(arg_9_0)
	arg_9_0:baseViewContainer():dispatchEvent(RougeEvent.RougeCollectionGiftView_OnSelectIndex, arg_9_0:index())
end

function var_0_0.setSelected(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_1)
end

function var_0_0._editableInitView(arg_11_0)
	RougeSimpleItemBase._editableInitView(arg_11_0)

	arg_11_0._gridList = arg_11_0:getUserDataTb_()
	arg_11_0._tagObjList = {}
	arg_11_0._tipsTagObjList = {}

	local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "scroll_desc")

	arg_11_0:_onSetScrollParentGameObject(var_11_0:GetComponent(gohelper.Type_LimitedScrollRect))

	arg_11_0._itemClick = gohelper.getClickWithAudio(arg_11_0.viewGO)
	arg_11_0._gridLayout = gohelper.findChild(arg_11_0.viewGO, "Grid")
	arg_11_0._txttagitemGo = arg_11_0._txttagitem.gameObject

	gohelper.setActive(arg_11_0._gohole, false)
	gohelper.setActive(arg_11_0._gogrid, false)
	gohelper.setActive(arg_11_0._gotagitem, false)
	gohelper.setActive(arg_11_0._txttagitemGo, false)
	arg_11_0:setSelected(false)
	arg_11_0:_setActiveLTTips(false)
end

function var_0_0.setData(arg_12_0, arg_12_1)
	if arg_12_1.type == RougeCollectionGiftView.Type.DropGroup then
		arg_12_0:_onUpdateMO_DropGroup(arg_12_1)
	else
		arg_12_0:_onUpdateMO_default(arg_12_1)
	end
end

function var_0_0._onUpdateMO_default(arg_13_0, arg_13_1)
	arg_13_0:_createDescList(arg_13_1.descList)
	GameUtil.loadSImage(arg_13_0._simagecollection, arg_13_1.resUrl)

	arg_13_0._txtname.text = arg_13_1.title
end

function var_0_0._onUpdateMO_DropGroup(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.data.collectionId

	arg_14_0:_createDescList(arg_14_1.descList)

	local var_14_1 = RougeCollectionConfig.instance:getCollectionCfg(var_14_0)

	arg_14_0:_refreshHole(var_14_1.holeNum)
	arg_14_0:_refreshGrids(var_14_0)
	arg_14_0:_refreshTagList(var_14_1.tags or {})
	GameUtil.loadSImage(arg_14_0._simagecollection, RougeCollectionHelper.getCollectionIconUrl(var_14_0))

	arg_14_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(var_14_0)
end

function var_0_0._refreshHole(arg_15_0, arg_15_1)
	gohelper.CreateNumObjList(arg_15_0._goenchantlist, arg_15_0._gohole, arg_15_1 or 0)
end

function var_0_0._refreshGrids(arg_16_0, arg_16_1)
	RougeCollectionHelper.loadShapeGrid(arg_16_1, arg_16_0._gridLayout, arg_16_0._gogrid, arg_16_0._gridList)
end

function var_0_0._createDescList(arg_17_0, arg_17_1)
	gohelper.CreateObjList(arg_17_0, arg_17_0._descListCallback, arg_17_1, arg_17_0._goskillcontainer, arg_17_0._goskillitem)
end

function var_0_0._descListCallback(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	gohelper.findChildText(arg_18_1, "txt_desc").text = arg_18_2
end

function var_0_0._refreshTagList(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_0

		if iter_19_0 > #arg_19_0._tagObjList then
			var_19_0 = arg_19_0:_create_RougeCollectionInitialCollectionTagItem(iter_19_0)

			table.insert(arg_19_0._tagObjList, var_19_0)
		else
			var_19_0 = arg_19_0._tagObjList[iter_19_0]
		end

		var_19_0:onUpdateMO(iter_19_1)
		var_19_0:setActive(true)

		local var_19_1

		if iter_19_0 > #arg_19_0._tipsTagObjList then
			var_19_1 = arg_19_0:_create_RougeCollectionInitialCollectionTipsTagItem(iter_19_0)

			table.insert(arg_19_0._tipsTagObjList, var_19_1)
		else
			var_19_1 = arg_19_0._tipsTagObjList[iter_19_0]
		end

		var_19_1:onUpdateMO(iter_19_1)
		var_19_1:setActive(true)
	end

	local var_19_2 = math.max(#arg_19_0._tagObjList, #arg_19_0._tipsTagObjList)

	for iter_19_2 = #arg_19_1 + 1, var_19_2 do
		local var_19_3 = arg_19_0._tagObjList[iter_19_2]

		if var_19_3 then
			var_19_3:setActive(false)
		end

		local var_19_4 = arg_19_0._tipsTagObjList[iter_19_2]

		if var_19_4 then
			var_19_4:setActive(false)
		end
	end
end

function var_0_0._create_RougeCollectionInitialCollectionTagItem(arg_20_0, arg_20_1)
	local var_20_0 = gohelper.cloneInPlace(arg_20_0._gotagitem)
	local var_20_1 = RougeCollectionInitialCollectionTagItem.New({
		parent = arg_20_0,
		baseViewContainer = arg_20_0:baseViewContainer()
	})

	var_20_1:setIndex(arg_20_1)
	var_20_1:init(var_20_0)

	return var_20_1
end

function var_0_0._create_RougeCollectionInitialCollectionTipsTagItem(arg_21_0, arg_21_1)
	local var_21_0 = gohelper.cloneInPlace(arg_21_0._txttagitemGo)
	local var_21_1 = RougeCollectionInitialCollectionTipsTagItem.New({
		parent = arg_21_0,
		baseViewContainer = arg_21_0:baseViewContainer()
	})

	var_21_1:setIndex(arg_21_1)
	var_21_1:init(var_21_0)

	return var_21_1
end

function var_0_0.setActiveTips(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._gotips, arg_22_1)
	arg_22_0:parent():setActiveBlock(arg_22_1)
end

function var_0_0.onCloseBlock(arg_23_0)
	arg_23_0:_setActiveLTTips(false)
end

function var_0_0._setActiveLTTips(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._gotips, arg_24_1)
end

return var_0_0
