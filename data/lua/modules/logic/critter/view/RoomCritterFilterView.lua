module("modules.logic.critter.view.RoomCritterFilterView", package.seeall)

local var_0_0 = class("RoomCritterFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/#btn_closefilterview")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content")
	arg_1_0._gofilterCategoryItem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/filterTypeItem")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_ok")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btnclosefilterviewOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.filterCategoryItemDict) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1.tagItemDict) do
			iter_3_3.btnClick:RemoveClickListener()
		end
	end
end

function var_0_0._btnclosefilterviewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnokOnClick(arg_5_0)
	CritterFilterModel.instance:applyMO(arg_5_0.filterMO)
	arg_5_0:closeThis()
end

function var_0_0._btnresetOnClick(arg_6_0)
	arg_6_0.filterMO:reset()
	arg_6_0:refresh()
end

function var_0_0.onClickTagItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.filterType
	local var_7_1 = arg_7_1.tagId

	if arg_7_0:isSelectTag(var_7_0, var_7_1) then
		arg_7_0.filterMO:unselectedTag(var_7_0, var_7_1)
	else
		arg_7_0.filterMO:selectedTag(var_7_0, var_7_1)
	end

	arg_7_0:refreshTag(arg_7_1)
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0.filterTypeList = arg_9_0.viewParam.filterTypeList
	arg_9_0.parentViewName = arg_9_0.viewParam.viewName
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:onUpdateParam()

	arg_10_0.filterCategoryItemDict = {}
	arg_10_0.filterMO = CritterFilterModel.instance:getFilterMO(arg_10_0.parentViewName, true):clone()

	gohelper.CreateObjList(arg_10_0, arg_10_0._onSetFilterCategoryItem, arg_10_0.filterTypeList, arg_10_0._gocontent, arg_10_0._gofilterCategoryItem)
	arg_10_0:refresh()
end

function var_0_0._onSetFilterCategoryItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = arg_11_1
	var_11_0.filterType = arg_11_2

	local var_11_1 = CritterConfig.instance:getCritterFilterTypeCfg(arg_11_2, true)
	local var_11_2 = gohelper.findChildText(var_11_0.go, "title/dmgTypeCn")
	local var_11_3 = gohelper.findChildText(var_11_0.go, "title/dmgTypeCn/dmgTypeEn")

	var_11_2.text = var_11_1.name
	var_11_3.text = var_11_1.nameEn

	local var_11_4 = gohelper.findChild(var_11_0.go, "layout")
	local var_11_5 = gohelper.findChild(var_11_0.go, "layout/#go_tabItem1")
	local var_11_6 = gohelper.findChild(var_11_0.go, "layout/#go_tabItem2")

	gohelper.setActive(var_11_5, false)
	gohelper.setActive(var_11_6, false)

	var_11_0.tagItemDict = {}

	local var_11_7 = CritterConfig.instance:getCritterTabDataList(var_11_0.filterType)

	for iter_11_0, iter_11_1 in ipairs(var_11_7) do
		local var_11_8 = iter_11_1.filterTab
		local var_11_9 = var_11_5

		if not string.nilorempty(iter_11_1.icon) then
			var_11_9 = var_11_6
		end

		local var_11_10 = gohelper.clone(var_11_9, var_11_4, var_11_8)
		local var_11_11 = arg_11_0:getTagItem(iter_11_1, var_11_10, var_11_0.filterType)

		var_11_0.tagItemDict[var_11_8] = var_11_11
	end

	arg_11_0.filterCategoryItemDict[arg_11_2] = var_11_0
end

function var_0_0.getTagItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1.name
	local var_12_1 = arg_12_1.icon
	local var_12_2 = arg_12_0:getUserDataTb_()

	var_12_2.go = arg_12_2
	var_12_2.tagId = arg_12_1.filterTab
	var_12_2.filterType = arg_12_3
	var_12_2.gounselected = gohelper.findChild(var_12_2.go, "unselected")
	var_12_2.goselected = gohelper.findChild(var_12_2.go, "selected")
	var_12_2.btnClick = gohelper.findChildClickWithAudio(var_12_2.go, "click", AudioEnum.UI.UI_Common_Click)

	var_12_2.btnClick:AddClickListener(arg_12_0.onClickTagItem, arg_12_0, var_12_2)

	local var_12_3 = gohelper.findChildText(var_12_2.go, "unselected/info1")
	local var_12_4 = gohelper.findChildText(var_12_2.go, "selected/info2")

	var_12_3.text = var_12_0
	var_12_4.text = var_12_0

	if not string.nilorempty(var_12_1) then
		local var_12_5 = gohelper.findChildImage(var_12_2.go, "unselected/#image_icon")
		local var_12_6 = gohelper.findChildImage(var_12_2.go, "selected/#image_icon")

		UISpriteSetMgr.instance:setCritterSprite(var_12_5, var_12_1)
		UISpriteSetMgr.instance:setCritterSprite(var_12_6, var_12_1)
	end

	gohelper.setActive(var_12_2.go, true)

	return var_12_2
end

function var_0_0.refresh(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.filterCategoryItemDict) do
		for iter_13_2, iter_13_3 in pairs(iter_13_1.tagItemDict) do
			arg_13_0:refreshTag(iter_13_3)
		end
	end
end

function var_0_0.refreshTag(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.filterType
	local var_14_1 = arg_14_1.tagId
	local var_14_2 = arg_14_0:isSelectTag(var_14_0, var_14_1)

	gohelper.setActive(arg_14_1.goselected, var_14_2)
	gohelper.setActive(arg_14_1.gounselected, not var_14_2)
end

function var_0_0.isSelectTag(arg_15_0, arg_15_1, arg_15_2)
	return (arg_15_0.filterMO:isSelectedTag(arg_15_1, arg_15_2))
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
