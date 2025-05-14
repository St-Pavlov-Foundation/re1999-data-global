module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagView", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionBagView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#simage_title/#txt_title")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_view")
	arg_1_0._gocollectionbagitem = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionbagitem")
	arg_1_0._btntotalpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_totalpreview")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_right")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_right/#simage_collection")
	arg_1_0._gogrid1 = gohelper.findChild(arg_1_0.viewGO, "#go_right/grids/#go_grid1")
	arg_1_0._gonone1 = gohelper.findChild(arg_1_0.viewGO, "#go_right/grids/#go_grid1/#go_none1")
	arg_1_0._goget1 = gohelper.findChild(arg_1_0.viewGO, "#go_right/grids/#go_grid1/#go_get1")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_right/grids/#go_grid1/#go_get1/#simage_icon1")
	arg_1_0._gogrid2 = gohelper.findChild(arg_1_0.viewGO, "#go_right/grids/#go_grid2")
	arg_1_0._gonone2 = gohelper.findChild(arg_1_0.viewGO, "#go_right/grids/#go_grid2/#go_none2")
	arg_1_0._goget2 = gohelper.findChild(arg_1_0.viewGO, "#go_right/grids/#go_grid2/#go_get2")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_right/grids/#go_grid2/#go_get2/#simage_icon2")
	arg_1_0._gounique = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_container/#go_unique")
	arg_1_0._txtuniquetips = gohelper.findChildText(arg_1_0.viewGO, "#go_right/#go_container/#go_unique/#txt_uniquetips")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_right/#txt_name")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_container")
	arg_1_0._scrolleffectcontainer = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_right/#go_container/#scroll_effectcontainer")
	arg_1_0._goskills = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_skills")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_skills/#go_skillitem")
	arg_1_0._gospdescs = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_spdescs")
	arg_1_0._gospdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_spdescs/#go_spdescitem")
	arg_1_0._goadd = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_add")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#go_add/#btn_add")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_view/Viewport/Content/#go_line")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntotalpreview:AddClickListener(arg_2_0._btntotalpreviewOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(V1a6_CachotCollectionBagController.instance, V1a6_CachotEvent.OnSelectBagCollection, arg_2_0.onSelectBagItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntotalpreview:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(V1a6_CachotCollectionBagController.instance, V1a6_CachotEvent.OnSelectBagCollection, arg_3_0.onSelectBagItem, arg_3_0)
end

function var_0_0._btntotalpreviewOnClick(arg_4_0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionOverView()
end

function var_0_0._btnaddOnClick(arg_5_0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionEnchantView({
		collectionId = arg_5_0._curSelectCollectionId
	})
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goEffectScrollContent = gohelper.findChild(arg_7_0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content")
	arg_7_0._imageCollectionIcon = gohelper.findChildImage(arg_7_0.viewGO, "#go_right/#simage_collection")
	arg_7_0._anim = gohelper.onceAddComponent(arg_7_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.isCanEnchant

	arg_9_0._isCanEnchant = var_9_0 == nil and true or var_9_0

	arg_9_0:initScrollInfo()
	V1a6_CachotCollectionBagController.instance:onOpenView()
	arg_9_0:refreshCollectionSplitLine()

	if V1a6_CachotCollectionBagController.instance.guideMoveCollection then
		V1a6_CachotCollectionBagController.instance.guideMoveCollection = nil

		V1a6_CachotCollectionBagController.instance:moveCollectionWithHole2TopAndSelect()
	end
end

local var_0_1 = 0.2

function var_0_0.onSelectBagItem(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or arg_10_0._curSelectCollectionId

	local var_10_0 = false

	if arg_10_0._curSelectCollectionId and arg_10_1 then
		arg_10_0._anim:Play("switch", 0, 0)

		var_10_0 = true
	end

	arg_10_0:refreshCollectionSplitLine()

	local var_10_1 = V1a6_CachotCollectionBagListModel.instance:getById(arg_10_1)
	local var_10_2 = var_10_1 and var_10_1.cfgId
	local var_10_3 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_10_2)

	gohelper.setActive(arg_10_0._goempty, var_10_1 == nil)
	gohelper.setActive(arg_10_0._goright, var_10_1 ~= nil)
	gohelper.setActive(arg_10_0._btntotalpreview.gameObject, var_10_1 ~= nil)

	if var_10_1 and var_10_3 then
		local var_10_4 = V1a6_CachotCollectionBagListModel.instance:getIndex(var_10_1)

		arg_10_0:scrollFocusOnSelectCell(var_10_4)

		arg_10_0._curSelectCollectionId = var_10_1.id
		arg_10_0._txtname.text = tostring(var_10_3.name)
		arg_10_0._collectionIconUrl = ResUrl.getV1a6CachotIcon("collection/" .. var_10_3.icon)

		arg_10_0:_setCollectionIconVisible()
		TaskDispatcher.cancelTask(arg_10_0._switchCollectionIcon, arg_10_0)
		TaskDispatcher.runDelay(arg_10_0._switchCollectionIcon, arg_10_0, var_10_0 and var_0_1 or 0)

		local var_10_5 = var_10_3.type ~= V1a6_CachotEnum.CollectionType.Enchant and var_10_3.holeNum > 0 and arg_10_0._isCanEnchant

		gohelper.setActive(arg_10_0._goadd, var_10_5)
		arg_10_0:updateCollectionDescScrollSize(var_10_5)
		arg_10_0:refreshHoleUI(var_10_1, var_10_3)
		V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(var_10_3, arg_10_0._txtuniquetips, arg_10_0._gounique)
		V1a6_CachotCollectionHelper.refreshSkillDesc(var_10_3, arg_10_0._goskills, arg_10_0._goskillitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(var_10_3, arg_10_0._gospdescs, arg_10_0._gospdescitem)
	end
end

local var_0_2 = 219
local var_0_3 = 338

function var_0_0.updateCollectionDescScrollSize(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and var_0_2 or var_0_3

	recthelper.setHeight(arg_11_0._scrolleffectcontainer.transform, var_11_0)
end

function var_0_0._setCollectionIconVisible(arg_12_0)
	local var_12_0 = arg_12_0._simagecollection.curImageUrl

	arg_12_0._imageCollectionIcon.enabled = not string.nilorempty(var_12_0)
end

function var_0_0._switchCollectionIcon(arg_13_0)
	arg_13_0._simagecollection:LoadImage(arg_13_0._collectionIconUrl)
end

function var_0_0.refreshHoleUI(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 and arg_14_1 then
		local var_14_0 = arg_14_2.holeNum or 0

		gohelper.setActive(arg_14_0._gogrid1, var_14_0 >= 1)
		gohelper.setActive(arg_14_0._gogrid2, var_14_0 >= 2)

		local var_14_1 = arg_14_1:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
		local var_14_2 = arg_14_1:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)

		arg_14_0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left, var_14_1)
		arg_14_0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right, var_14_2)
	end
end

function var_0_0.refreshSingleHole(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2 and arg_15_2 ~= 0

	gohelper.setActive(arg_15_0["_gonone" .. arg_15_1], not var_15_0)
	gohelper.setActive(arg_15_0["_goget" .. arg_15_1], var_15_0)

	local var_15_1 = V1a6_CachotModel.instance:getRogueInfo()

	if var_15_0 and var_15_1 then
		local var_15_2 = var_15_1:getCollectionByUid(arg_15_2)
		local var_15_3 = var_15_2 and var_15_2.cfgId
		local var_15_4 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_15_3)

		if var_15_4 and arg_15_0["_simageicon" .. arg_15_1] then
			arg_15_0["_simageicon" .. arg_15_1]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_15_4.icon))
		end
	end
end

function var_0_0.scrollFocusOnSelectCell(arg_16_0, arg_16_1)
	local var_16_0 = (math.ceil(arg_16_1 / arg_16_0._scrollLineCount) - 1) * arg_16_0._singleItemHeightAndSpace + arg_16_0._scrollStartSpace
	local var_16_1 = var_16_0 - arg_16_0._csScrollView.VerticalScrollPixel

	if var_16_1 > arg_16_0._scrollHeight or var_16_1 < 0 then
		arg_16_0._csScrollView.VerticalScrollPixel = var_16_0
	end
end

function var_0_0.initScrollInfo(arg_17_0)
	arg_17_0._luaListScrollView = arg_17_0.viewContainer:getScrollView()
	arg_17_0._csScrollView = arg_17_0._luaListScrollView:getCsListScroll()
	arg_17_0._scrollLineCount = arg_17_0._luaListScrollView._param.lineCount
	arg_17_0._singleItemHeightAndSpace = arg_17_0._luaListScrollView._param.cellHeight + arg_17_0._luaListScrollView._param.cellSpaceV
	arg_17_0._scrollStartSpace = arg_17_0._luaListScrollView._param.startSpace
	arg_17_0._scrollHeight = recthelper.getHeight(arg_17_0._scrollview.transform)
end

function var_0_0.releaseSingleImage(arg_18_0)
	if V1a6_CachotEnum.CollectionHole then
		for iter_18_0, iter_18_1 in pairs(V1a6_CachotEnum.CollectionHole) do
			local var_18_0 = arg_18_0["_simageicon" .. iter_18_1]

			if var_18_0 then
				var_18_0:UnLoadImage()
			end
		end
	end

	arg_18_0._simagecollection:UnLoadImage()
end

local var_0_4 = 48

function var_0_0.refreshCollectionSplitLine(arg_19_0)
	local var_19_0 = V1a6_CachotCollectionBagListModel.instance:getUnEnchantCollectionLineNum()
	local var_19_1 = V1a6_CachotCollectionBagListModel.instance:getEnchantCollectionNum()
	local var_19_2 = var_19_0 > 0 and var_19_1 > 0

	gohelper.setActive(arg_19_0._goline, var_19_2)

	if var_19_2 then
		local var_19_3 = arg_19_0.viewContainer:getScrollParam()
		local var_19_4 = var_19_3 and var_19_3.cellHeight or 0
		local var_19_5 = var_19_3 and var_19_3.cellSpaceV or 0
		local var_19_6 = var_19_3 and var_19_3.startSpace or 0
		local var_19_7 = -((var_19_4 + var_19_5) * var_19_0 + var_19_6) + var_0_4

		recthelper.setAnchorY(arg_19_0._goline.transform, var_19_7)
	end
end

function var_0_0.onClose(arg_20_0)
	V1a6_CachotCollectionBagController.instance:onCloseView()
end

function var_0_0.onDestroyView(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._switchCollectionIcon, arg_21_0)
	arg_21_0:releaseSingleImage()
end

return var_0_0
