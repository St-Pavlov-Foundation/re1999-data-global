module("modules.logic.rouge.dlc.102.view.RougeCollectionComp_1_102", package.seeall)

local var_0_0 = class("RougeCollectionComp_1_102", LuaCompBase)

var_0_0.ParentObjPath = "Root"
var_0_0.AssetUrl = "ui/viewres/rouge/dlc/102/rougeequiptipsview.prefab"

local var_0_1 = 76.8
local var_0_2 = 50.2
local var_0_3 = 470.3
local var_0_4 = 436.3
local var_0_5 = 263.5
local var_0_6 = -3.9
local var_0_7 = 0
local var_0_8 = 800

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_tips")
	arg_1_0._gotips = gohelper.findChild(arg_1_1, "#go_tips")
	arg_1_0._scrolloverview = gohelper.findChildScrollRect(arg_1_1, "#go_tips/#scroll_overview")
	arg_1_0._gocontent = gohelper.findChild(arg_1_1, "#go_tips/#scroll_overview/Viewport/Content")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_1, "#go_tips/#scroll_overview/Viewport/Content/#go_collectionitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_1, "#go_tips/#btn_close")
	arg_1_0._collectionItemTab = arg_1_0:getUserDataTb_()

	recthelper.setAnchor(arg_1_0._gotips.transform, var_0_3, var_0_4)
	recthelper.setAnchor(arg_1_0._btntips.transform, var_0_1, var_0_2)
	gohelper.setActive(arg_1_0._btntips, true)
	gohelper.setActive(arg_1_0._gotips, false)
	arg_1_0:_checkIsTipBtnVisible()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateSlotCollectionEffect, arg_2_0._checkIsTipBtnVisible, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btntipOnClick(arg_4_0)
	arg_4_0:refreshUI()
end

function var_0_0._btncloseOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotips, false)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function var_0_0.onUpdateDLC(arg_6_0)
	return
end

function var_0_0._checkIsTipBtnVisible(arg_7_0)
	local var_7_0 = RougeDLCModel102.instance:getCanLevelUpSpCollectionsInSlotArea()
	local var_7_1 = var_7_0 and #var_7_0 or 0

	gohelper.setActive(arg_7_0._btntips.gameObject, var_7_1 > 0)
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = {}

	arg_8_0._spCollections = RougeDLCModel102.instance:getCanLevelUpSpCollectionsInSlotArea()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._spCollections) do
		local var_8_1 = arg_8_0:_getOrCreateCollectionItem(iter_8_0)

		arg_8_0:_refreshCollectionItem(var_8_1, iter_8_1)

		var_8_0[var_8_1] = true
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0._collectionItemTab) do
		if not var_8_0[iter_8_3] then
			gohelper.setActive(iter_8_3.viewGO, false)
		end
	end

	gohelper.setActive(arg_8_0._gotips, true)
	ZProj.UGUIHelper.RebuildLayout(arg_8_0._gocontent.transform)

	local var_8_2 = recthelper.getHeight(arg_8_0._gocontent.transform)
	local var_8_3 = Mathf.Clamp(var_8_2, var_0_7, var_0_8)

	recthelper.setHeight(arg_8_0._scrolloverview.transform, var_8_3)
	arg_8_0:_fitScrollScreenOffset()
end

function var_0_0._fitScrollScreenOffset(arg_9_0)
	gohelper.setActive(arg_9_0._gocontent, false)
	gohelper.fitScreenOffset(arg_9_0._scrolloverview.transform)
	gohelper.setActive(arg_9_0._gocontent, true)
end

function var_0_0._getOrCreateCollectionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._collectionItemTab[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.viewGO = gohelper.cloneInPlace(arg_10_0._gocollectionitem, "item_" .. arg_10_1)
		var_10_0.desccontent = gohelper.findChild(var_10_0.viewGO, "go_desccontent")
		var_10_0.descList = arg_10_0:getUserDataTb_()
		var_10_0.txtname = gohelper.findChildText(var_10_0.viewGO, "name/txt_name")
		var_10_0.txtDec = gohelper.findChild(var_10_0.viewGO, "#txt_dec")
		var_10_0.simageicon = gohelper.findChildSingleImage(var_10_0.viewGO, "image_collection")
		var_10_0.btnclick = gohelper.findChildButtonWithAudio(var_10_0.viewGO, "btn_click")

		var_10_0.btnclick:AddClickListener(arg_10_0._btnclickCollectionItem, arg_10_0, arg_10_1)

		arg_10_0._collectionItemTab[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0._btnclickCollectionItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._spCollections and arg_11_0._spCollections[arg_11_1]

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0:getCollectionId()
	local var_11_2 = Vector2.New(var_0_5, var_0_6)
	local var_11_3 = {
		interactable = false,
		useCloseBtn = false,
		collectionId = var_11_1,
		viewPosition = var_11_2
	}

	RougeController.instance:openRougeCollectionTipView(var_11_3)
end

function var_0_0._refreshCollectionItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2:getCollectionId()
	local var_12_1 = arg_12_2:getCollectionCfgId()

	arg_12_1.txtname.text = RougeCollectionConfig.instance:getCollectionName(var_12_1)

	local var_12_2 = RougeCollectionHelper.getCollectionIconUrl(var_12_1)

	arg_12_1.simageicon:LoadImage(var_12_2)

	local var_12_3 = arg_12_0:_getOrCreateShowDescTypes()
	local var_12_4 = arg_12_0:_getOrCreateExtraParams()

	RougeCollectionDescHelper.setCollectionDescInfos(var_12_0, arg_12_1.desccontent, arg_12_1.descList, var_12_3, var_12_4)
	gohelper.setActive(arg_12_1.viewGO, true)
end

function var_0_0._getOrCreateShowDescTypes(arg_13_0)
	if not arg_13_0._showTypes then
		arg_13_0._showTypes = {
			RougeEnum.CollectionDescType.SpecialText
		}
	end

	return arg_13_0._showTypes
end

function var_0_0._getOrCreateExtraParams(arg_14_0)
	if not arg_14_0._extraParams then
		arg_14_0._extraParams = {
			showDescFuncMap = {
				[RougeEnum.CollectionDescType.SpecialText] = arg_14_0._showSpCollectionLevelUp
			}
		}
	end

	return arg_14_0._extraParams
end

local var_0_9 = "#A08156"
local var_0_10 = "#616161"
local var_0_11 = 1
local var_0_12 = 0.6

function var_0_0._showSpCollectionLevelUp(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetComponent(gohelper.Type_TextMesh)
	local var_15_1 = gohelper.findChild(arg_15_0, "finish")
	local var_15_2 = gohelper.findChild(arg_15_0, "unfinish")

	var_15_0.text = arg_15_1.condition

	gohelper.setActive(var_15_1, arg_15_1.isActive)
	gohelper.setActive(var_15_2, not arg_15_1.isActive)
	SLFramework.UGUI.GuiHelper.SetColor(var_15_0, arg_15_1.isActive and var_0_9 or var_0_10)
	ZProj.UGUIHelper.SetColorAlpha(var_15_0, arg_15_1.isActive and var_0_11 or var_0_12)
end

function var_0_0.unloadCollectionItems(arg_16_0)
	if arg_16_0._collectionItemTab then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._collectionItemTab) do
			iter_16_1.simageicon:UnLoadImage()
			iter_16_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0:unloadCollectionItems()
end

return var_0_0
