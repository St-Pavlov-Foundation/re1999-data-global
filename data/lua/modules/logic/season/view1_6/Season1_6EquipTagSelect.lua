module("modules.logic.season.view1_6.Season1_6EquipTagSelect", package.seeall)

local var_0_0 = class("Season1_6EquipTagSelect", BaseView)

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

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._controller = arg_4_1
	arg_4_0._dropListPath = arg_4_2
	arg_4_0._defaultColor = arg_4_3 or "#cac8c5"
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._dropdowntag = gohelper.findChildDropdown(arg_5_0.viewGO, arg_5_0._dropListPath)
	arg_5_0._txtlabel = gohelper.findChildText(arg_5_0._dropdowntag.gameObject, "Label")
	arg_5_0._imagearrow = gohelper.findChildImage(arg_5_0._dropdowntag.gameObject, "arrow")

	arg_5_0._dropdowntag:AddOnValueChanged(arg_5_0.handleDropValueChanged, arg_5_0)

	arg_5_0._clicktag = gohelper.getClick(arg_5_0._dropdowntag.gameObject)

	arg_5_0._clicktag:AddClickListener(arg_5_0.handleClickTag, arg_5_0)
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
end

function var_0_0.onOpen(arg_7_0)
	if arg_7_0._controller.getFilterModel then
		arg_7_0._model = arg_7_0._controller:getFilterModel()
	end

	if not arg_7_0._model then
		return
	end

	arg_7_0._dropdowntag:ClearOptions()
	arg_7_0._dropdowntag:AddOptions(arg_7_0._model:getOptions())
	arg_7_0._dropdowntag:SetValue(0)
	arg_7_0:refreshSelected()
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

function var_0_0.refreshSelected(arg_11_0)
	local var_11_0 = arg_11_0._model:getCurTagId()
	local var_11_1

	if var_11_0 == Activity104EquipTagModel.NoTagId then
		var_11_1 = arg_11_0._defaultColor
	else
		var_11_1 = "#c66030"
	end

	arg_11_0._txtlabel.color = GameUtil.parseColor(var_11_1)

	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._imagearrow, var_11_1)
end

return var_0_0
