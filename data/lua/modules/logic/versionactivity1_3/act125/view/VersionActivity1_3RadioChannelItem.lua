module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioChannelItem", package.seeall)

local var_0_0 = class("VersionActivity1_3RadioChannelItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtFMChannelNumSelected = gohelper.findChildText(arg_1_1, "txt_FMChannelNumSelected")
	arg_1_0._txtFMChannelNumUnSelected = gohelper.findChildText(arg_1_1, "txt_FMChannelNumUnSelected")
	arg_1_0._click = gohelper.getClick(arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.OnFMScrollValueChange, arg_2_0._refreshFMSliderItem, arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnFMScrollValueChange, arg_3_0._refreshFMSliderItem, arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	gohelper.setActive(arg_4_0._txtFMChannelNumSelected.gameObject, not arg_4_1.isEmpty)
	gohelper.setActive(arg_4_0._txtFMChannelNumUnSelected.gameObject, not arg_4_1.isEmpty)

	arg_4_0._id = arg_4_1.id

	if arg_4_1.isEmpty then
		return
	end

	arg_4_0._txtFMChannelNumSelected.text = arg_4_1.value
	arg_4_0._txtFMChannelNumUnSelected.text = arg_4_1.value
end

local var_0_1 = 0.05

function var_0_0._refreshFMSliderItem(arg_5_0, arg_5_1)
	local var_5_0 = transformhelper.getPos(arg_5_0.go.transform)
	local var_5_1 = Mathf.Abs(var_5_0 - arg_5_1) <= var_0_1

	arg_5_0:onSelect(false)

	if var_5_1 then
		arg_5_0._view:selectCell(arg_5_0._index, true)
	end
end

function var_0_0._onClick(arg_6_0)
	if arg_6_0._index and not arg_6_0._mo.isEmpty then
		arg_6_0._view:selectCell(arg_6_0._index, true)
		Activity125Controller.instance:dispatchEvent(Activity125Event.OnChannelItemClick, arg_6_0._id)
	end
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._txtFMChannelNumSelected.gameObject, arg_7_1 and not arg_7_0._mo.isEmpty)
	gohelper.setActive(arg_7_0._txtFMChannelNumUnSelected.gameObject, not arg_7_1 and not arg_7_0._mo.isEmpty)

	if arg_7_1 then
		Activity125Controller.instance:dispatchEvent(Activity125Event.OnChannelSelected, arg_7_0._id)
	end
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
