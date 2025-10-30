module("modules.logic.season.view3_0.Season3_0EquipTagSelect2", package.seeall)

local var_0_0 = class("Season3_0EquipTagSelect2", BaseView)

function var_0_0.onInitView(arg_1_0)
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

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._controller = arg_4_1
	arg_4_0._dropListPath = arg_4_2
	arg_4_0._dropListPath2 = arg_4_3
	arg_4_0._defaultColor = arg_4_4 or "#cac8c5"
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._dropdowntag = gohelper.findChildDropdown(arg_5_0.viewGO, arg_5_0._dropListPath)
	arg_5_0._txtlabel = gohelper.findChildText(arg_5_0._dropdowntag.gameObject, "Label")
	arg_5_0._imagearrow = gohelper.findChildImage(arg_5_0._dropdowntag.gameObject, "arrow")

	arg_5_0._dropdowntag:AddOnValueChanged(arg_5_0.handleDropValueChanged, arg_5_0)

	arg_5_0._clicktag = gohelper.getClick(arg_5_0._dropdowntag.gameObject)

	arg_5_0._clicktag:AddClickListener(arg_5_0.handleClickTag, arg_5_0)

	arg_5_0._dropdowntag2 = gohelper.findChildDropdown(arg_5_0.viewGO, arg_5_0._dropListPath2)
	arg_5_0._txtlabel2 = gohelper.findChildText(arg_5_0._dropdowntag2.gameObject, "Label")
	arg_5_0._imagearrow2 = gohelper.findChildImage(arg_5_0._dropdowntag2.gameObject, "Arrow")

	arg_5_0._dropdowntag2:AddOnValueChanged(arg_5_0.handleDropValueChanged2, arg_5_0)

	arg_5_0._clicktag2 = gohelper.getClick(arg_5_0._dropdowntag2.gameObject)

	arg_5_0._clicktag2:AddClickListener(arg_5_0.handleClickTag, arg_5_0)
end

function var_0_0.onDestroyView(arg_6_0)
	if arg_6_0._dropdowntag then
		arg_6_0._dropdowntag:RemoveOnValueChanged()

		arg_6_0._dropdowntag = nil
	end

	if arg_6_0._clicktag then
		arg_6_0._clicktag:RemoveClickListener()

		arg_6_0._clicktag = nil
	end

	if arg_6_0._dropdowntag2 then
		arg_6_0._dropdowntag2:RemoveOnValueChanged()

		arg_6_0._dropdowntag2 = nil
	end

	if arg_6_0._clicktag2 then
		arg_6_0._clicktag2:RemoveClickListener()

		arg_6_0._clicktag2 = nil
	end
end

function var_0_0.onOpen(arg_7_0)
	if arg_7_0._controller.getFilterModel then
		arg_7_0._model = arg_7_0._controller:getFilterModel()
	end

	if arg_7_0._model then
		arg_7_0._dropdowntag:ClearOptions()
		arg_7_0._dropdowntag:AddOptions(arg_7_0._model:getOptions())
		arg_7_0._dropdowntag:SetValue(0)
		arg_7_0:refreshSelected()
	end

	if arg_7_0._controller.getFilterModel2 then
		arg_7_0._model2 = arg_7_0._controller:getFilterModel2()
	end

	if arg_7_0._model2 then
		arg_7_0._dropdowntag2:ClearOptions()
		arg_7_0._dropdowntag2:AddOptions(arg_7_0._model2:getOptions())
		arg_7_0._dropdowntag2:SetValue(4)
		arg_7_0:refreshSelected2()
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.handleClickTag(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0.handleDropValueChanged(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1

	if arg_10_0._controller.setSelectTag and arg_10_0._model then
		arg_10_0._controller:setSelectTag(var_10_0)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		arg_10_0:refreshSelected()
	else
		logError("controller setSelectTag not implement!")
	end
end

function var_0_0.handleDropValueChanged2(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1

	if arg_11_0._controller.setSelectFilterId and arg_11_0._model then
		arg_11_0._controller:setSelectFilterId(var_11_0)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		arg_11_0:refreshSelected2()
	else
		logError("controller setSelectFilterId not implement!")
	end
end

function var_0_0.refreshSelected(arg_12_0)
	local var_12_0 = arg_12_0._model:getCurTagId()
	local var_12_1

	if var_12_0 == Activity104EquipTagModel.NoTagId then
		var_12_1 = arg_12_0._defaultColor
	else
		var_12_1 = "#c66030"
	end

	arg_12_0._txtlabel.color = GameUtil.parseColor(var_12_1)

	SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._imagearrow, var_12_1)
end

function var_0_0.refreshSelected2(arg_13_0)
	local var_13_0 = arg_13_0._model2:getCurId()
	local var_13_1

	if var_13_0 == Activity104EquipCountModel.DefaultId then
		var_13_1 = arg_13_0._defaultColor
	else
		var_13_1 = "#c66030"
	end

	arg_13_0._txtlabel2.text = arg_13_0._model2:getOptionTxt(var_13_0, var_13_1)
end

return var_0_0
