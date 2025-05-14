module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverView", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._gounlockeditem = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem")
	arg_1_0._simageframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#simage_frame")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#simage_collection")
	arg_1_0._gogrid1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1")
	arg_1_0._simageget = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1/#simage_get")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1/#simage_get/#simage_icon")
	arg_1_0._gogrid2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid2")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#txt_dec")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#txt_name")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#go_layout")
	arg_1_0._txtcollectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#go_layout/top/#txt_collectionname")
	arg_1_0._goeffectcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#go_layout/#go_effectcontainer")
	arg_1_0._goskills = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_skills")
	arg_1_0._goskilldescitem = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_skills/#go_skilldescitem")
	arg_1_0._gospdescs = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_spdescs")
	arg_1_0._gospdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_spdescs/#go_spdescitem")
	arg_1_0._btncloseTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tips/#btn_closetips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncloseTips:AddClickListener(arg_2_0._btnclosetipsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncloseTips:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclosetipsOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotips, false)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gotips, false)
	arg_6_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickCachotOverItem, arg_6_0.onClickCachotOverItem, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	V1a6_CachotCollectionOverListModel.instance:onInitData()
	arg_8_0:initScrollInfo()
end

function var_0_0.onClickCachotOverItem(arg_9_0, arg_9_1)
	local var_9_0 = V1a6_CachotCollectionOverListModel.instance:getById(arg_9_1)
	local var_9_1 = var_9_0 and var_9_0.cfgId
	local var_9_2 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_9_1)

	if var_9_2 then
		arg_9_0._txtcollectionname.text = var_9_2.name

		V1a6_CachotCollectionHelper.refreshSkillDesc(var_9_2, arg_9_0._goskills, arg_9_0._goskilldescitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(var_9_2, arg_9_0._gospdescs, arg_9_0._gospdescitem)
		arg_9_0:setCollectionTipsPos(arg_9_1)
	end
end

function var_0_0.initScrollInfo(arg_10_0)
	arg_10_0._luaListScrollView = arg_10_0.viewContainer:getScrollView()
	arg_10_0._csScrollView = arg_10_0._luaListScrollView:getCsListScroll()
	arg_10_0._scrollLineCount = arg_10_0._luaListScrollView._param.lineCount
	arg_10_0._scrollCellWidth = arg_10_0._luaListScrollView._param.cellWidth
	arg_10_0._scrollCellHeight = arg_10_0._luaListScrollView._param.cellHeight
	arg_10_0._singleItemHeightAndSpace = arg_10_0._scrollCellHeight + arg_10_0._luaListScrollView._param.cellSpaceV
	arg_10_0._singleItemWidthAndSpace = arg_10_0._scrollCellWidth + arg_10_0._luaListScrollView._param.cellSpaceH
	arg_10_0._scrollStartSpace = arg_10_0._luaListScrollView._param.startSpace
	arg_10_0._scrollHeight = recthelper.getHeight(arg_10_0._scrollview.transform)
	arg_10_0._scrollWidth = recthelper.getWidth(arg_10_0._scrollview.transform)
	arg_10_0._scrollDir = arg_10_0._luaListScrollView._param.scrollDir
end

local var_0_1 = 0.001

function var_0_0.setCollectionTipsPos(arg_11_0, arg_11_1)
	local var_11_0 = V1a6_CachotCollectionOverListModel.instance:getById(arg_11_1)
	local var_11_1 = V1a6_CachotCollectionOverListModel.instance:getIndex(var_11_0)

	if var_11_1 and var_11_1 > 0 then
		arg_11_0._lineIndex = math.ceil(var_11_1 / arg_11_0._scrollLineCount)
		arg_11_0._countIndex = var_11_1 - (arg_11_0._lineIndex - 1) * arg_11_0._scrollLineCount

		local var_11_2 = arg_11_0:getCollectionItemRectValue(var_11_1)
		local var_11_3 = arg_11_0:getCutOutPixelRect(var_11_2)

		if var_11_3.z > 0 or var_11_3.w > 0 then
			arg_11_0:onMoveScroll2Focus(var_11_2, var_11_3)
		else
			arg_11_0:onScrollContentFinishedCallBack()
		end
	end
end

function var_0_0.onMoveScroll2Focus(arg_12_0, arg_12_1, arg_12_2)
	UIBlockMgr.instance:startBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(false)

	local var_12_0 = arg_12_0:getNeedMoveScrollPixel(arg_12_1, arg_12_2)
	local var_12_1, var_12_2, var_12_3 = arg_12_0:getTragetScrollPixelAndDuration(var_12_0)

	arg_12_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_12_2, var_12_3, var_12_1, arg_12_0.onScrollContentCallBack, arg_12_0.onScrollContentFinishedCallBack, arg_12_0, nil, EaseType.Linear)
end

function var_0_0.getCutOutPixelRect(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.x
	local var_13_1 = arg_13_1.y
	local var_13_2 = arg_13_1.z
	local var_13_3 = arg_13_1.w
	local var_13_4 = var_13_1 - var_13_0
	local var_13_5 = var_13_3 - var_13_2
	local var_13_6, var_13_7, var_13_8, var_13_9 = arg_13_0:getScrollViewRect()
	local var_13_10 = var_13_0 < var_13_6 and var_13_6 or var_13_0
	local var_13_11 = var_13_7 < var_13_1 and var_13_7 or var_13_1
	local var_13_12 = var_13_2 < var_13_8 and var_13_8 or var_13_2
	local var_13_13 = var_13_9 < var_13_3 and var_13_9 or var_13_3
	local var_13_14 = var_13_11 - var_13_10
	local var_13_15 = var_13_13 - var_13_12
	local var_13_16 = var_13_14 > 0 and var_13_4 - var_13_14 or var_13_4
	local var_13_17 = var_13_15 > 0 and var_13_5 - var_13_15 or var_13_5

	return Vector4(var_13_10, var_13_12, var_13_16, var_13_17)
end

function var_0_0.getScrollViewRect(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = 0
	local var_14_3 = 0

	if arg_14_0._scrollDir == ScrollEnum.ScrollDirV then
		var_14_2 = arg_14_0._csScrollView.VerticalScrollPixel
		var_14_3 = var_14_2 + arg_14_0._scrollHeight
	else
		var_14_0 = arg_14_0._csScrollView.HorizontalScrollPixel
		var_14_1 = var_14_0 + arg_14_0._scrollWidth
	end

	return var_14_0, var_14_1, var_14_2, var_14_3
end

function var_0_0.getCollectionItemRectValue(arg_15_0)
	local var_15_0 = arg_15_0._scrollDir == ScrollEnum.ScrollDirH and arg_15_0._scrollStartSpace or 0
	local var_15_1 = (arg_15_0._scrollDir == ScrollEnum.ScrollDirV and arg_15_0._scrollStartSpace or 0) + (arg_15_0._lineIndex - 1) * arg_15_0._singleItemHeightAndSpace
	local var_15_2 = var_15_1 + arg_15_0._singleItemHeightAndSpace
	local var_15_3 = var_15_0 + arg_15_0._singleItemWidthAndSpace * arg_15_0._countIndex
	local var_15_4 = var_15_3 + arg_15_0._singleItemWidthAndSpace

	return Vector4(var_15_3, var_15_4, var_15_1, var_15_2)
end

function var_0_0.getNeedMoveScrollPixel(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 0

	if arg_16_0._scrollDir == ScrollEnum.ScrollDirV then
		var_16_0 = arg_16_1.z < arg_16_2.y and -arg_16_2.w or arg_16_2.w
	else
		var_16_0 = arg_16_1.x < arg_16_2.x and -arg_16_2.z or arg_16_2.z
	end

	return var_16_0
end

function var_0_0.getTragetScrollPixelAndDuration(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._scrollDir == ScrollEnum.ScrollDirV and arg_17_0._csScrollView.VerticalScrollPixel or arg_17_0._csScrollView.HorizontalScrollPixel
	local var_17_1 = var_17_0 + arg_17_1

	return math.abs(arg_17_1) * var_0_1, var_17_0, var_17_1
end

function var_0_0.onScrollContentCallBack(arg_18_0, arg_18_1)
	if arg_18_0._scrollDir == ScrollEnum.ScrollDirV then
		arg_18_0._csScrollView.VerticalScrollPixel = arg_18_1
	else
		arg_18_0._csScrollView.HorizontalScrollPixel = arg_18_1
	end
end

function var_0_0.onScrollContentFinishedCallBack(arg_19_0)
	arg_19_0:showCollectionTips()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

var_0_0.TipPosXOffset = -1144

function var_0_0.showCollectionTips(arg_20_0)
	local var_20_0, var_20_1 = recthelper.getAnchor(arg_20_0._scrollview.transform)
	local var_20_2 = var_20_1 - ((arg_20_0._lineIndex - 1) * arg_20_0._singleItemHeightAndSpace - Mathf.Clamp(arg_20_0._csScrollView.VerticalScrollPixel, 0, arg_20_0._csScrollView.VerticalScrollPixel))
	local var_20_3 = arg_20_0._countIndex >= arg_20_0._scrollLineCount and var_0_0.TipPosXOffset or 0
	local var_20_4 = arg_20_0._singleItemWidthAndSpace * arg_20_0._countIndex + var_20_0 + var_20_3

	gohelper.setActive(arg_20_0._gotips, true)
	recthelper.setAnchor(arg_20_0._golayout.transform, var_20_4, var_20_2)
	gohelper.fitScreenOffset(arg_20_0._golayout.transform)
end

function var_0_0.onClose(arg_21_0)
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
