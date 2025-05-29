module("modules.logic.rouge.view.RougeCollectionOverView", package.seeall)

local var_0_0 = class("RougeCollectionOverView", RougeBaseDLCViewComp)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_4_0._onSwitchCollectionInfoType, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	RougeCollectionOverListModel.instance:onInitData()
	arg_5_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_store_open)
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = RougeCollectionOverListModel.instance:getCount()

	gohelper.setActive(arg_6_0._goempty, var_6_0 <= 0)
	gohelper.setActive(arg_6_0._scrollview.gameObject, var_6_0 > 0)
end

function var_0_0._onSwitchCollectionInfoType(arg_7_0)
	RougeCollectionOverListModel.instance:onModelUpdate()
end

function var_0_0.onClose(arg_8_0)
	ViewMgr.instance:closeView(ViewName.CommonBuffTipView)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

return var_0_0
