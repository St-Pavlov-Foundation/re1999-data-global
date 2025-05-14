module("modules.logic.room.view.layout.RoomLayoutBgSelectItem", package.seeall)

local var_0_0 = class("RoomLayoutBgSelectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_item")
	arg_1_0._simagecover = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_cover")
	arg_1_0._txtcovername = gohelper.findChildText(arg_1_0.viewGO, "content/covernamebg/#txt_covername")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "content/#go_select")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._btnitemOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
end

function var_0_0._btnitemOnClick(arg_4_0)
	arg_4_0:_selectThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0._selectThis(arg_8_0)
	if arg_8_0._bgResMO then
		RoomLayoutBgResListModel.instance:setSelect(arg_8_0._bgResMO.id)
		RoomLayoutController.instance:dispatchEvent(RoomEvent.UISelectLayoutPlanCoverItem)
	end
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._bgResMO = arg_9_1

	if arg_9_1 then
		arg_9_0._simagecover:LoadImage(arg_9_1:getResPath())

		arg_9_0._txtcovername.text = arg_9_1:getName()
	end
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagecover:UnLoadImage()
end

return var_0_0
