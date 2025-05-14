module("modules.logic.rouge.view.RougeCollectionHandBookFavoriteView", package.seeall)

local var_0_0 = class("RougeCollectionHandBookFavoriteView", RougeCollectionHandBookView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnLayout = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_layout")
	arg_1_0._goUnselectLayout = gohelper.findChild(arg_1_0._btnLayout.gameObject, "unselected")
	arg_1_0._goSelectLayout = gohelper.findChild(arg_1_0._btnLayout.gameObject, "selected")

	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnLayout:AddClickListener(arg_2_0._btnLayoutOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnLayout:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._btnLayout, true)
	arg_4_0:_setFilterSelected(false)
end

function var_0_0._btnLayoutOnClick(arg_5_0)
	if arg_5_0._isAllSelected then
		return
	end

	arg_5_0:_setFilterSelected(false)
end

function var_0_0._setFilterSelected(arg_6_0, arg_6_1)
	var_0_0.super._setFilterSelected(arg_6_0, arg_6_1)
	arg_6_0:_setAllSelected(not arg_6_1)
end

function var_0_0._setAllSelected(arg_7_0, arg_7_1)
	arg_7_0._isAllSelected = arg_7_1

	gohelper.setActive(arg_7_0._goSelectLayout, arg_7_1)
	gohelper.setActive(arg_7_0._goUnselectLayout, not arg_7_1)

	if arg_7_0._isAllSelected then
		arg_7_0._baseTagSelectMap = {}
		arg_7_0._extraTagSelectMap = {}

		RougeCollectionHandBookListModel.instance:onInitData()
	end
end

return var_0_0
