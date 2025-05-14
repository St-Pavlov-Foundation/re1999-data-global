module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantView", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionEnchantView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#simage_title/#txt_title")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_view")
	arg_1_0._gocollectionbagitem = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionbagitem")
	arg_1_0._dropcollectionclassify = gohelper.findChildDropdown(arg_1_0.viewGO, "left/#drop_collectionclassify")
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "#go_middle")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_middle/#simage_collection")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_middle/#txt_name")
	arg_1_0._gogrid1 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid1")
	arg_1_0._gogridselect1 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid1/#go_gridselect1")
	arg_1_0._gogridadd1 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid1/#go_gridadd1")
	arg_1_0._gogridget1 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid1/#go_gridget1")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_middle/grids/#go_grid1/#go_gridget1/#simage_icon1")
	arg_1_0._btngridclick1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_middle/grids/#go_grid1/#btn_gridclick1")
	arg_1_0._gogrid2 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid2")
	arg_1_0._gogridselect2 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid2/#go_gridselect2")
	arg_1_0._gogridadd2 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid2/#go_gridadd2")
	arg_1_0._gogridget2 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/grids/#go_grid2/#go_gridget2")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_middle/grids/#go_grid2/#go_gridget2/#simage_icon2")
	arg_1_0._btngridclick2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_middle/grids/#go_grid2/#btn_gridclick2")
	arg_1_0._gounique = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#go_unique")
	arg_1_0._txtuniquetips = gohelper.findChildText(arg_1_0.viewGO, "#go_middle/#go_unique/#txt_uniquetips")
	arg_1_0._gocollectionenchantitem = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem")
	arg_1_0._simageframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#simage_frame")
	arg_1_0._goenchant = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#go_enchant")
	arg_1_0._txtdes = gohelper.findChildText(arg_1_0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#txt_des")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goencahntempty = gohelper.findChild(arg_1_0.viewGO, "right/#go_enchantempty")
	arg_1_0._scrolleffectcontainer = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_middle/#scroll_effectcontainer")
	arg_1_0._goskills = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_skills")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_skills/#go_skillitem")
	arg_1_0._gospdescs = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_spdescs")
	arg_1_0._gospdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_spdescs/#go_spdescitem")
	arg_1_0._gocollectionempty = gohelper.findChild(arg_1_0.viewGO, "left/#go_collectionempty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngridclick1:AddClickListener(arg_2_0._btngridclick1OnClick, arg_2_0)
	arg_2_0._btngridclick2:AddClickListener(arg_2_0._btngridclick2OnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._dropcollectionclassify:AddOnValueChanged(arg_2_0._onSwitchCategory, arg_2_0)
	arg_2_0:addEventCb(V1a6_CachotCollectionEnchantController.instance, V1a6_CachotEvent.OnSelectEnchantCollection, arg_2_0.onSelectBagItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngridclick1:RemoveClickListener()
	arg_3_0._btngridclick2:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._dropcollectionclassify:RemoveOnValueChanged()
	arg_3_0:removeEventCb(V1a6_CachotCollectionEnchantController.instance, V1a6_CachotEvent.OnSelectEnchantCollection, arg_3_0.onSelectBagItem, arg_3_0)
end

function var_0_0._btngridclick1OnClick(arg_4_0)
	arg_4_0:refreshAllHoleSelectState(V1a6_CachotEnum.CollectionHole.Left)

	local var_4_0 = arg_4_0:checkIsCouldRemoveEnchant(V1a6_CachotEnum.CollectionHole.Left)

	V1a6_CachotCollectionEnchantController.instance:onSelectHoleGrid(V1a6_CachotEnum.CollectionHole.Left, var_4_0)
end

function var_0_0._btngridclick2OnClick(arg_5_0)
	arg_5_0:refreshAllHoleSelectState(V1a6_CachotEnum.CollectionHole.Right)

	local var_5_0 = arg_5_0:checkIsCouldRemoveEnchant(V1a6_CachotEnum.CollectionHole.Right)

	V1a6_CachotCollectionEnchantController.instance:onSelectHoleGrid(V1a6_CachotEnum.CollectionHole.Right, var_5_0)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._categoryList = {
		var_0_0.AllFilterType,
		V1a6_CachotEnum.CollectionType.Weapon,
		V1a6_CachotEnum.CollectionType.Protect,
		V1a6_CachotEnum.CollectionType.Decorate
	}
	arg_7_0._anim = gohelper.onceAddComponent(arg_7_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.collectionId

	arg_9_0:refreshUI(var_9_0)
end

function var_0_0.refreshUI(arg_10_0, arg_10_1)
	V1a6_CachotCollectionEnchantController.instance:onOpenView(arg_10_1)
	arg_10_0:initCategory()
	arg_10_0:initEnchantsListUI()
	arg_10_0:initCollectionsListUI()
end

local var_0_1 = 0.2

function var_0_0.onSelectBagItem(arg_11_0, arg_11_1)
	local var_11_0 = V1a6_CachotEnchantBagListModel.instance:getById(arg_11_1)

	if var_11_0 then
		local var_11_1 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_11_0.cfgId)

		if var_11_1 then
			arg_11_0._txtname.text = tostring(var_11_1.name)
			arg_11_0._collectionIconUrl = ResUrl.getV1a6CachotIcon("collection/" .. var_11_1.icon)

			gohelper.setActive(arg_11_0._goadd, var_11_1.holeNum > 0)
			arg_11_0:refreshHoleUI(var_11_0, var_11_1)
			arg_11_0:refreshCollectionDesc(var_11_0, var_11_1)
			V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(var_11_1, arg_11_0._txtuniquetips, arg_11_0._gounique)

			local var_11_2 = false

			if arg_11_0._curSelectCollectionId and arg_11_0._curSelectCollectionId ~= arg_11_1 then
				arg_11_0._anim:Play("swicth", 0, 0)

				var_11_2 = true
			end

			TaskDispatcher.cancelTask(arg_11_0._switchCollectionIcon, arg_11_0)
			TaskDispatcher.runDelay(arg_11_0._switchCollectionIcon, arg_11_0, var_11_2 and var_0_1 or 0)

			arg_11_0._curSelectCollectionId = arg_11_1
		end
	else
		arg_11_0._curSelectCollectionId = nil
	end

	gohelper.setActive(arg_11_0._gomiddle, var_11_0 ~= nil)
	arg_11_0:resetHoleClickCount()
end

function var_0_0._switchCollectionIcon(arg_12_0)
	arg_12_0._simagecollection:LoadImage(arg_12_0._collectionIconUrl)
end

function var_0_0.refreshHoleUI(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 and arg_13_2 then
		local var_13_0 = arg_13_2.holeNum or 0

		gohelper.setActive(arg_13_0._gogrid1, var_13_0 >= 1)
		gohelper.setActive(arg_13_0._gogrid2, var_13_0 >= 2)

		local var_13_1 = arg_13_1:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
		local var_13_2 = arg_13_1:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)

		arg_13_0:refreshSingleHoleUI(V1a6_CachotEnum.CollectionHole.Left, var_13_1)
		arg_13_0:refreshSingleHoleUI(V1a6_CachotEnum.CollectionHole.Right, var_13_2)
	end
end

function var_0_0.refreshSingleHoleUI(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex()
	local var_14_1 = arg_14_2 and arg_14_2 ~= 0

	gohelper.setActive(arg_14_0["_gogridadd" .. arg_14_1], not var_14_1)
	gohelper.setActive(arg_14_0["_gogridget" .. arg_14_1], var_14_1)
	gohelper.setActive(arg_14_0["_gogridselect" .. arg_14_1], var_14_0 == arg_14_1)

	if var_14_1 then
		local var_14_2 = V1a6_CachotModel.instance:getRogueInfo()
		local var_14_3 = var_14_2 and var_14_2:getCollectionByUid(arg_14_2)
		local var_14_4 = var_14_3 and var_14_3.cfgId
		local var_14_5 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_14_4)

		if var_14_5 and arg_14_0["_simageicon" .. arg_14_1] then
			arg_14_0["_simageicon" .. arg_14_1]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_14_5.icon))
		end
	end
end

function var_0_0.refreshAllHoleSelectState(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(V1a6_CachotEnum.CollectionHole) do
		gohelper.setActive(arg_15_0["_gogridselect" .. iter_15_1], arg_15_1 == iter_15_1)
	end
end

function var_0_0.refreshCollectionDesc(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		V1a6_CachotCollectionHelper.refreshSkillDesc(arg_16_2, arg_16_0._goskills, arg_16_0._goskillitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(arg_16_2, arg_16_0._gospdescs, arg_16_0._gospdescitem)
	end

	arg_16_0._scrolleffectcontainer.verticalNormalizedPosition = 1
end

var_0_0.AllFilterType = 6

function var_0_0.initCategory(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._categoryList) do
		local var_17_1

		if iter_17_1 == var_0_0.AllFilterType then
			var_17_1 = luaLang("cachot_CollectionTypeName_All")
		else
			var_17_1 = luaLang(V1a6_CachotEnum.CollectionTypeName[iter_17_1])
		end

		table.insert(var_17_0, var_17_1)
	end

	arg_17_0._dropcollectionclassify:AddOptions(var_17_0)
end

function var_0_0.initEnchantsListUI(arg_18_0)
	local var_18_0 = V1a6_CachotCollectionEnchantListModel.instance:isEnchantEmpty()

	gohelper.setActive(arg_18_0._goencahntempty, var_18_0)
end

function var_0_0.initCollectionsListUI(arg_19_0)
	local var_19_0 = V1a6_CachotEnchantBagListModel.instance:isBagEmpty()

	gohelper.setActive(arg_19_0._gocollectionempty, var_19_0)
	gohelper.setActive(arg_19_0._gomiddle, not var_19_0)
end

function var_0_0._onSwitchCategory(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 + 1

	local var_20_0 = arg_20_0._categoryList[arg_20_1]

	if var_20_0 then
		arg_20_0._scrollview.verticalNormalizedPosition = 1

		V1a6_CachotCollectionEnchantController.instance:switchCategory(var_20_0)
		arg_20_0:initCollectionsListUI()
	end
end

var_0_0.RemoveEnchantMinClickCount = 2

function var_0_0.checkIsCouldRemoveEnchant(arg_21_0, arg_21_1)
	if arg_21_1 ~= arg_21_0._checkHoleIndex then
		arg_21_0:resetHoleClickCount()
	end

	arg_21_0._checkHoleIndex = arg_21_1
	arg_21_0._holeClickCount = arg_21_0._holeClickCount + 1

	if arg_21_0._holeClickCount >= var_0_0.RemoveEnchantMinClickCount then
		arg_21_0:checkHoleClickToast(arg_21_1)
		arg_21_0:resetHoleClickCount()

		return true
	end
end

function var_0_0.resetHoleClickCount(arg_22_0)
	arg_22_0._holeClickCount = 0
end

local var_0_2 = 2

function var_0_0.checkHoleClickToast(arg_23_0, arg_23_1)
	if V1a6_CachotCollectionEnchantListModel.instance:isEnchantEmpty() then
		ToastController.instance:showToast(ToastEnum.V1a6Cachot_EnchantListEmpty)
	else
		local var_23_0 = V1a6_CachotEnchantBagListModel.instance:getById(arg_23_0._curSelectCollectionId)
		local var_23_1 = var_23_0 and var_23_0:getEnchantId(arg_23_1)
		local var_23_2 = var_23_1 and var_23_1 ~= V1a6_CachotEnum.EmptyEnchantId

		if var_23_0 and not var_23_2 and arg_23_0._holeClickCount and arg_23_0._holeClickCount >= var_0_2 then
			ToastController.instance:showToast(ToastEnum.V1a6Cachot_SelectCollectionEnchant)
		end
	end
end

function var_0_0.releaseSingleImage(arg_24_0)
	if V1a6_CachotEnum.CollectionHole then
		for iter_24_0, iter_24_1 in pairs(V1a6_CachotEnum.CollectionHole) do
			local var_24_0 = arg_24_0["_simageicon" .. iter_24_1]

			if var_24_0 then
				var_24_0:UnLoadImage()
			end
		end
	end
end

function var_0_0.onClose(arg_25_0)
	V1a6_CachotCollectionEnchantController.instance:onCloseView()
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._switchCollectionIcon, arg_26_0)
	arg_26_0:releaseSingleImage()
end

return var_0_0
