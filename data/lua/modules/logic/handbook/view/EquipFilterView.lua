module("modules.logic.handbook.view.EquipFilterView", package.seeall)

local var_0_0 = class("EquipFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goobtain = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_obtain")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_obtain/obtainContainer/#go_get")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_obtain/obtainContainer/#go_notget")
	arg_1_0._goTag = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_tag")
	arg_1_0._goTagContainer = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_tag/#go_tagContainer")
	arg_1_0._gotagItem = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_tag/#go_tagContainer/#go_tagItem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_reset")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

var_0_0.Color = {
	SelectColor = Color.New(1, 0.486, 0.25, 1),
	NormalColor = Color.New(0.898, 0.898, 0.898, 1)
}

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnresetOnClick(arg_5_0)
	arg_5_0.filterMo:reset()
	arg_5_0:refreshUI()
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	EquipFilterModel.instance:applyMo(arg_6_0.filterMo)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gotagItem, false)
end

function var_0_0.initObtainItem(arg_8_0)
	if not arg_8_0.obtainItemGet then
		arg_8_0.obtainItemGet = arg_8_0:createObtainItem(arg_8_0._goget)
		arg_8_0.obtainItemGet.type = EquipFilterModel.ObtainEnum.Get
	end

	if not arg_8_0.obtainItemNotGet then
		arg_8_0.obtainItemNotGet = arg_8_0:createObtainItem(arg_8_0._gonotget)
		arg_8_0.obtainItemNotGet.type = EquipFilterModel.ObtainEnum.NotGet
	end
end

function var_0_0.createObtainItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = arg_9_1
	var_9_0.goUnSelect = gohelper.findChild(var_9_0.go, "unselected")
	var_9_0.goSelect = gohelper.findChild(var_9_0.go, "selected")
	var_9_0.btnClick = gohelper.findChildClick(var_9_0.go, "click")

	var_9_0.btnClick:AddClickListener(arg_9_0.onClickObtainTypeItem, arg_9_0, var_9_0)

	return var_9_0
end

function var_0_0.initTagItem(arg_10_0)
	if arg_10_0.tagItemList then
		return
	end

	arg_10_0.tagItemList = {}

	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(EquipFilterModel.getAllTagList()) do
		local var_10_1 = arg_10_0:createTypeItem()

		var_10_1.tagCo = iter_10_1

		gohelper.setActive(var_10_1.go, true)

		var_10_1.tagText.text = iter_10_1.name

		table.insert(arg_10_0.tagItemList, var_10_1)
	end
end

function var_0_0.createTypeItem(arg_11_0)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = gohelper.cloneInPlace(arg_11_0._gotagItem)
	var_11_0.tagText = gohelper.findChildText(var_11_0.go, "tagText")
	var_11_0.goSelect = gohelper.findChild(var_11_0.go, "selected")
	var_11_0.goUnSelect = gohelper.findChild(var_11_0.go, "unselected")
	var_11_0.btnClick = gohelper.findChildClickWithAudio(var_11_0.go, "click", AudioEnum.UI.UI_Common_Click)

	var_11_0.btnClick:AddClickListener(arg_11_0.onClickTagItem, arg_11_0, var_11_0)

	return var_11_0
end

function var_0_0.onClickTagItem(arg_12_0, arg_12_1)
	if arg_12_0:isSelectTag(arg_12_1.tagCo.id) then
		tabletool.removeValue(arg_12_0.filterMo.selectTagList, arg_12_1.tagCo.id)
	else
		table.insert(arg_12_0.filterMo.selectTagList, arg_12_1.tagCo.id)
	end

	arg_12_0:refreshTagIsSelect(arg_12_1)
end

function var_0_0.onClickObtainTypeItem(arg_13_0, arg_13_1)
	if arg_13_0.filterMo.obtainShowType == arg_13_1.type then
		arg_13_0.filterMo.obtainShowType = EquipFilterModel.ObtainEnum.All
	else
		arg_13_0.filterMo.obtainShowType = arg_13_1.type
	end

	arg_13_0:refreshObtainTypeUIContainer()
end

function var_0_0.initViewParam(arg_14_0)
	arg_14_0.isNotShowObtain = arg_14_0.viewContainer.viewParam and arg_14_0.viewContainer.viewParam.isNotShowObtain
	arg_14_0.parentViewName = arg_14_0.viewContainer.viewParam and arg_14_0.viewContainer.viewParam.viewName
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:initViewParam()

	arg_15_0.filterMo = EquipFilterModel.instance:getFilterMo(arg_15_0.parentViewName):clone()

	if arg_15_0.isNotShowObtain then
		gohelper.setActive(arg_15_0._goobtain, false)
	else
		gohelper.setActive(arg_15_0._goobtain, true)
		arg_15_0:initObtainItem()
	end

	arg_15_0:initTagItem()
	arg_15_0:refreshUI()
end

function var_0_0.refreshUI(arg_16_0)
	if not arg_16_0.isNotShowObtain then
		arg_16_0:refreshObtainTypeUIContainer()
	end

	arg_16_0:refreshTagUIContainer()
end

function var_0_0.refreshObtainTypeUIContainer(arg_17_0)
	arg_17_0:refreshObtainTypeItemIsSelect(arg_17_0.obtainItemGet)
	arg_17_0:refreshObtainTypeItemIsSelect(arg_17_0.obtainItemNotGet)
end

function var_0_0.refreshTagUIContainer(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.tagItemList) do
		arg_18_0:refreshTagIsSelect(iter_18_1)
	end
end

function var_0_0.refreshObtainTypeItemIsSelect(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.filterMo.obtainShowType == arg_19_1.type

	gohelper.setActive(arg_19_1.goSelect, var_19_0)
	gohelper.setActive(arg_19_1.goUnSelect, not var_19_0)
end

function var_0_0.refreshTagIsSelect(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:isSelectTag(arg_20_1.tagCo.id)

	gohelper.setActive(arg_20_1.goSelect, var_20_0)
	gohelper.setActive(arg_20_1.goUnSelect, not var_20_0)

	arg_20_1.tagText.color = var_20_0 and var_0_0.Color.SelectColor or var_0_0.Color.NormalColor
end

function var_0_0.isSelectTag(arg_21_0, arg_21_1)
	return next(arg_21_0.filterMo.selectTagList) and tabletool.indexOf(arg_21_0.filterMo.selectTagList, arg_21_1)
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.tagItemList) do
		iter_23_1.btnClick:RemoveClickListener()
	end

	if not arg_23_0.isNotShowObtain then
		arg_23_0.obtainItemGet.btnClick:RemoveClickListener()
		arg_23_0.obtainItemNotGet.btnClick:RemoveClickListener()
	end
end

return var_0_0
