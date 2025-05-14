module("modules.logic.rouge.dlc.102.view.RougeCollectionOverView_1_102", package.seeall)

local var_0_0 = class("RougeCollectionOverView_1_102", BaseViewExtended)

var_0_0.ParentObjPath = "#go_rougemapdetailcontainer"
var_0_0.AssetUrl = "ui/viewres/rouge/dlc/102/rougeequiptipsview.prefab"

local var_0_1 = -62
local var_0_2 = -18.6
local var_0_3 = -38.06
local var_0_4 = 25.5
local var_0_5 = -78
local var_0_6 = 0
local var_0_7 = 0
local var_0_8 = 800

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tips")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._scrolloverview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tips/#scroll_overview")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#scroll_overview/Viewport/Content")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#go_collectionitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tips/#btn_close")
	arg_1_0._collectionItemTab = arg_1_0:getUserDataTb_()

	recthelper.setAnchor(arg_1_0._gotips.transform, var_0_3, var_0_4)
	recthelper.setAnchor(arg_1_0._btntips.transform, var_0_1, var_0_2)
	gohelper.setActive(arg_1_0._btntips, true)
	gohelper.setActive(arg_1_0._gotips, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btntipOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotips, true)
	arg_4_0:refreshUI()
end

function var_0_0._btncloseOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotips, false)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function var_0_0.onUpdateDLC(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._spCollections = RougeDLCModel102.instance:getCanLevelUpSpCollectionsInSlotArea()

	local var_7_0 = arg_7_0._spCollections and #arg_7_0._spCollections or 0

	gohelper.setActive(arg_7_0._btntips.gameObject, var_7_0 > 0)
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = {}

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

	ZProj.UGUIHelper.RebuildLayout(arg_8_0._gocontent.transform)

	local var_8_2 = recthelper.getHeight(arg_8_0._gocontent.transform)
	local var_8_3 = Mathf.Clamp(var_8_2, var_0_7, var_0_8)

	recthelper.setHeight(arg_8_0._scrolloverview.transform, var_8_3)
end

function var_0_0._getOrCreateCollectionItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._collectionItemTab[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()
		var_9_0.viewGO = gohelper.cloneInPlace(arg_9_0._gocollectionitem, "item_" .. arg_9_1)
		var_9_0.desccontent = gohelper.findChild(var_9_0.viewGO, "go_desccontent")
		var_9_0.descList = arg_9_0:getUserDataTb_()
		var_9_0.txtname = gohelper.findChildText(var_9_0.viewGO, "name/txt_name")
		var_9_0.txtDec = gohelper.findChild(var_9_0.viewGO, "#txt_dec")
		var_9_0.simageicon = gohelper.findChildSingleImage(var_9_0.viewGO, "image_collection")
		var_9_0.btnclick = gohelper.findChildButtonWithAudio(var_9_0.viewGO, "btn_click")

		var_9_0.btnclick:AddClickListener(arg_9_0._btnclickCollectionItem, arg_9_0, arg_9_1)

		arg_9_0._collectionItemTab[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0._btnclickCollectionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._spCollections and arg_10_0._spCollections[arg_10_1]

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0:getCollectionId()
	local var_10_2 = Vector2.New(var_0_5, var_0_6)
	local var_10_3 = {
		interactable = false,
		useCloseBtn = false,
		collectionId = var_10_1,
		viewPosition = var_10_2
	}

	RougeController.instance:openRougeCollectionTipView(var_10_3)
end

function var_0_0._refreshCollectionItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getCollectionId()
	local var_11_1 = arg_11_2:getCollectionCfgId()

	arg_11_1.txtname.text = RougeCollectionConfig.instance:getCollectionName(var_11_1)

	local var_11_2 = RougeCollectionHelper.getCollectionIconUrl(var_11_1)

	arg_11_1.simageicon:LoadImage(var_11_2)

	local var_11_3 = arg_11_0:_getOrCreateShowDescTypes()
	local var_11_4 = arg_11_0:_getOrCreateExtraParams()

	RougeCollectionDescHelper.setCollectionDescInfos(var_11_0, arg_11_1.desccontent, arg_11_1.descList, var_11_3, var_11_4)
	gohelper.setActive(arg_11_1.viewGO, true)
end

function var_0_0._getOrCreateShowDescTypes(arg_12_0)
	if not arg_12_0._showTypes then
		arg_12_0._showTypes = {
			RougeEnum.CollectionDescType.SpecialText
		}
	end

	return arg_12_0._showTypes
end

function var_0_0._getOrCreateExtraParams(arg_13_0)
	if not arg_13_0._extraParams then
		arg_13_0._extraParams = {
			showDescFuncMap = {
				[RougeEnum.CollectionDescType.SpecialText] = arg_13_0._showSpCollectionLevelUp
			}
		}
	end

	return arg_13_0._extraParams
end

local var_0_9 = "#A08156"
local var_0_10 = "#616161"
local var_0_11 = 1
local var_0_12 = 0.6

function var_0_0._showSpCollectionLevelUp(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetComponent(gohelper.Type_TextMesh)
	local var_14_1 = gohelper.findChild(arg_14_0, "finish")
	local var_14_2 = gohelper.findChild(arg_14_0, "unfinish")

	var_14_0.text = arg_14_1.condition

	gohelper.setActive(var_14_1, arg_14_1.isActive)
	gohelper.setActive(var_14_2, not arg_14_1.isActive)
	SLFramework.UGUI.GuiHelper.SetColor(var_14_0, arg_14_1.isActive and var_0_9 or var_0_10)
	ZProj.UGUIHelper.SetColorAlpha(var_14_0, arg_14_1.isActive and var_0_11 or var_0_12)
end

function var_0_0.unloadCollectionItems(arg_15_0)
	if arg_15_0._collectionItemTab then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._collectionItemTab) do
			iter_15_1.simageicon:UnLoadImage()
			iter_15_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0:unloadCollectionItems()
end

return var_0_0
