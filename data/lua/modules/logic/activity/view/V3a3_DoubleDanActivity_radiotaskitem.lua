module("modules.logic.activity.view.V3a3_DoubleDanActivity_radiotaskitem", package.seeall)

local var_0_0 = class("V3a3_DoubleDanActivity_radiotaskitem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_reddot")

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

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._txtDateUnSelected = gohelper.findChildText(arg_5_0.viewGO, "txt_DateUnSelected")
	arg_5_0._goDateSelected = gohelper.findChild(arg_5_0.viewGO, "image_Selected")
	arg_5_0._txtDateSelected = gohelper.findChildText(arg_5_0.viewGO, "image_Selected/txt_DateSelected")
	arg_5_0._goDateLocked = gohelper.findChild(arg_5_0.viewGO, "image_Locked")
	arg_5_0._goRed = gohelper.findChild(arg_5_0.viewGO, "#go_reddot")
	arg_5_0._click = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "btn_click")
	arg_5_0._txtDateUnSelectedGo = arg_5_0._txtDateUnSelected.gameObject
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0._click:AddClickListener(arg_6_0._onClick, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0._click:RemoveClickListener()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goDateSelected, arg_8_1)
	gohelper.setActive(arg_8_0._txtDateUnSelectedGo, not arg_8_1)
end

function var_0_0._isDayOpen(arg_9_0)
	return arg_9_0:_assetGetViewContainer():isDayOpen(arg_9_0._index)
end

function var_0_0._isType101RewardCouldGet(arg_10_0)
	return arg_10_0:_assetGetViewContainer():isType101RewardCouldGet(arg_10_0._index)
end

function var_0_0.setData(arg_11_0)
	local var_11_0 = not arg_11_0:_isDayOpen()
	local var_11_1 = arg_11_0:_isType101RewardCouldGet()
	local var_11_2 = formatLuaLang("warmup_radiotaskitem_day", arg_11_0._index)

	arg_11_0._txtDateUnSelected.text = var_11_2
	arg_11_0._txtDateSelected.text = var_11_2

	gohelper.setActive(arg_11_0._goDateLocked, var_11_0)
	gohelper.setActive(arg_11_0._goRed, var_11_1)
end

function var_0_0._onClick(arg_12_0)
	local var_12_0 = arg_12_0:_assetGetParent()

	if not arg_12_0:_isDayOpen() then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeNotOpen)

		return
	end

	var_12_0:onClickTab(arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	var_0_0.super.onDestroyView(arg_13_0)
end

return var_0_0
