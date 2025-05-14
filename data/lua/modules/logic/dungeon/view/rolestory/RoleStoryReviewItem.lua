module("modules.logic.dungeon.view.rolestory.RoleStoryReviewItem", package.seeall)

local var_0_0 = class("RoleStoryReviewItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "selectbg")
	arg_1_0.txtSelectOrder = gohelper.findChildTextMesh(arg_1_0.goSelect, "#txt_selectorder")
	arg_1_0.goNormal = gohelper.findChild(arg_1_0.viewGO, "normalbg")
	arg_1_0.txtNormalOrder = gohelper.findChildTextMesh(arg_1_0.goNormal, "#txt_normalorder")
	arg_1_0.txtStoryName = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_storyname")
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClickBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickBtnClick(arg_4_0)
	if not arg_4_0.data then
		return
	end

	if arg_4_0.selectDispatchId == arg_4_0.data.id then
		return
	end

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ClickReviewItem, arg_4_0.data.id)
end

function var_0_0.refreshItem(arg_5_0)
	if not arg_5_0.data then
		gohelper.setActive(arg_5_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_5_0.viewGO, true)

	arg_5_0.txtSelectOrder.text = string.format("%02d", arg_5_0.index)
	arg_5_0.txtNormalOrder.text = string.format("%02d", arg_5_0.index)
	arg_5_0.txtStoryName.text = arg_5_0.data.name

	local var_5_0 = arg_5_0.selectDispatchId == arg_5_0.data.id

	gohelper.setActive(arg_5_0.goSelect, var_5_0)
	gohelper.setActive(arg_5_0.goNormal, not var_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.data = arg_6_1
	arg_6_0.index = arg_6_2

	arg_6_0:refreshItem()
end

function var_0_0.updateSelect(arg_7_0, arg_7_1)
	arg_7_0.selectDispatchId = arg_7_1

	arg_7_0:refreshItem()
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
