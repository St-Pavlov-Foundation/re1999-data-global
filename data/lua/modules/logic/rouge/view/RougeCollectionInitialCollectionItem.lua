module("modules.logic.rouge.view.RougeCollectionInitialCollectionItem", package.seeall)

local var_0_0 = class("RougeCollectionInitialCollectionItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goenchantlist = gohelper.findChild(arg_1_0.viewGO, "#go_enchantlist")
	arg_1_0._gohole = gohelper.findChild(arg_1_0.viewGO, "#go_enchantlist/#go_hole")
	arg_1_0._gogrid = gohelper.findChild(arg_1_0.viewGO, "Grid/#go_grid")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_collection")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "scroll_desc/Viewport/#go_descContent")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "scroll_desc/Viewport/#go_descContent/#go_descitem")
	arg_1_0._gotags = gohelper.findChild(arg_1_0.viewGO, "#go_tags")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "#go_tags/#go_tagitem")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tags/#go_tagitem/#btn_click")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tags/#go_tips")
	arg_1_0._txttagitem = gohelper.findChildText(arg_1_0.viewGO, "#go_tags/#go_tips/#txt_tagitem")

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

function var_0_0.ctor(arg_4_0, arg_4_1)
	RougeSimpleItemBase.ctor(arg_4_0, arg_4_1)
end

function var_0_0._btnclickOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	RougeSimpleItemBase._editableInitView(arg_6_0)

	arg_6_0._tagObjList = {}
	arg_6_0._tipsTagObjList = {}
	arg_6_0._itemInstTab = arg_6_0:getUserDataTb_()
	arg_6_0._descParams = {
		isAllActive = true
	}
	arg_6_0._txttagitemGo = arg_6_0._txttagitem.gameObject

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "scroll_desc")

	arg_6_0._gridGo = gohelper.findChild(arg_6_0.viewGO, "Grid")
	arg_6_0._scrollViewLimitScrollCmp = var_6_0:GetComponent(gohelper.Type_LimitedScrollRect)

	arg_6_0:_onSetScrollParentGameObject(arg_6_0._scrollViewLimitScrollCmp)
	gohelper.setActive(arg_6_0._gotagitem, false)
	gohelper.setActive(arg_6_0._txttagitemGo, false)
	arg_6_0:_setActiveLTTips(false)
	RougeController.instance:registerCallback(RougeEvent.SwitchCollectionInfoType, arg_6_0._onSwitchCollectionInfoType, arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	GameUtil.onDestroyViewMember_SImage(arg_7_0, "_simagecollection")
	GameUtil.onDestroyViewMemberList(arg_7_0, "_tagObjList")
	GameUtil.onDestroyViewMemberList(arg_7_0, "_tipsTagObjList")
	RougeController.instance:unregisterCallback(RougeEvent.SwitchCollectionInfoType, arg_7_0._onSwitchCollectionInfoType, arg_7_0)
end

function var_0_0.setData(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = RougeCollectionConfig.instance:getCollectionCfg(var_8_0)

	if not var_8_1 then
		logError("not found collectionCfgId" .. tostring(var_8_0))

		return
	end

	arg_8_0._collectionCfgId = var_8_0

	arg_8_0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_8_0))
	gohelper.CreateNumObjList(arg_8_0._goenchantlist, arg_8_0._gohole, var_8_1.holeNum or 0)

	arg_8_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(var_8_0)

	RougeCollectionHelper.loadShapeGrid(var_8_0, arg_8_0._gridGo, arg_8_0._gogrid)
	arg_8_0:_refreshDesc()
	arg_8_0:_refreshTagList(var_8_1.tags or {})
end

function var_0_0._refreshDesc(arg_9_0)
	RougeCollectionDescHelper.setCollectionDescInfos2(arg_9_0._collectionCfgId, nil, arg_9_0._godescContent, arg_9_0._itemInstTab, nil, arg_9_0._descParams)
end

function var_0_0._refreshTagList(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0

		if iter_10_0 > #arg_10_0._tagObjList then
			var_10_0 = arg_10_0:_create_RougeCollectionInitialCollectionTagItem(iter_10_0)

			table.insert(arg_10_0._tagObjList, var_10_0)
		else
			var_10_0 = arg_10_0._tagObjList[iter_10_0]
		end

		var_10_0:onUpdateMO(iter_10_1)
		var_10_0:setActive(true)

		local var_10_1

		if iter_10_0 > #arg_10_0._tipsTagObjList then
			var_10_1 = arg_10_0:_create_RougeCollectionInitialCollectionTipsTagItem(iter_10_0)

			table.insert(arg_10_0._tipsTagObjList, var_10_1)
		else
			var_10_1 = arg_10_0._tipsTagObjList[iter_10_0]
		end

		var_10_1:onUpdateMO(iter_10_1)
		var_10_1:setActive(true)
	end

	local var_10_2 = math.max(#arg_10_0._tagObjList, #arg_10_0._tipsTagObjList)

	for iter_10_2 = #arg_10_1 + 1, var_10_2 do
		local var_10_3 = arg_10_0._tagObjList[iter_10_2]

		if var_10_3 then
			var_10_3:setActive(false)
		end

		local var_10_4 = arg_10_0._tipsTagObjList[iter_10_2]

		if var_10_4 then
			var_10_4:setActive(false)
		end
	end
end

function var_0_0._create_RougeCollectionInitialCollectionTagItem(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.cloneInPlace(arg_11_0._gotagitem)
	local var_11_1 = RougeCollectionInitialCollectionTagItem.New({
		parent = arg_11_0,
		baseViewContainer = arg_11_0:baseViewContainer()
	})

	var_11_1:setIndex(arg_11_1)
	var_11_1:init(var_11_0)

	return var_11_1
end

function var_0_0._create_RougeCollectionInitialCollectionTipsTagItem(arg_12_0, arg_12_1)
	local var_12_0 = gohelper.cloneInPlace(arg_12_0._txttagitemGo)
	local var_12_1 = RougeCollectionInitialCollectionTipsTagItem.New({
		parent = arg_12_0,
		baseViewContainer = arg_12_0:baseViewContainer()
	})

	var_12_1:setIndex(arg_12_1)
	var_12_1:init(var_12_0)

	return var_12_1
end

function var_0_0.setActiveTips(arg_13_0, arg_13_1)
	arg_13_0:_setActiveLTTips(arg_13_1)
	arg_13_0:parent():setActiveBlock(arg_13_1)
end

function var_0_0.onCloseBlock(arg_14_0)
	arg_14_0:_setActiveLTTips(false)
end

function var_0_0._setActiveLTTips(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._gotips, arg_15_1)
end

function var_0_0._onSwitchCollectionInfoType(arg_16_0)
	arg_16_0:_refreshDesc()
end

return var_0_0
