module("modules.logic.rouge.view.RougeCollectionDetailBtnComp", package.seeall)

local var_0_0 = class("RougeCollectionDetailBtnComp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btndetails = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_details")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetails:AddClickListener(arg_2_0._btndetailsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetails:RemoveClickListener()
end

function var_0_0._btndetailsOnClick(arg_4_0)
	RougeCollectionModel.instance:switchCollectionInfoType()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_5_0._onSwitchCollectionInfoType, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshDetailBtnUI()
end

function var_0_0.refreshDetailBtnUI(arg_7_0)
	local var_7_0 = RougeCollectionModel.instance:getCurCollectionInfoType()
	local var_7_1 = gohelper.findChild(arg_7_0._btndetails.gameObject, "circle/select")

	gohelper.setActive(var_7_1, var_7_0 == RougeEnum.CollectionInfoType.Complex)
end

function var_0_0._onSwitchCollectionInfoType(arg_8_0)
	arg_8_0:refreshDetailBtnUI()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
