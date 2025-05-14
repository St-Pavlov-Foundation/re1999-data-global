module("modules.logic.equip.view.EquipStrengthenCostItem", package.seeall)

local var_0_0 = class("EquipStrengthenCostItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._goblank = gohelper.findChild(arg_1_0.viewGO, "#go_blank")

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
	arg_4_0._click = gohelper.getClickWithAudio(arg_4_0.viewGO)

	arg_4_0._click:AddClickListener(arg_4_0._onClick, arg_4_0)
end

function var_0_0._onClick(arg_5_0)
	EquipController.instance:openEquipChooseView()
end

function var_0_0.onUpdateParam(arg_6_0)
	if not arg_6_0.viewParam then
		arg_6_0._goblank:SetActive(true)
		arg_6_0._goitem:SetActive(false)

		return
	end

	arg_6_0._goblank:SetActive(false)
	arg_6_0._goitem:SetActive(true)

	if not arg_6_0._itemIcon then
		arg_6_0._itemIcon = IconMgr.instance:getCommonEquipIcon(arg_6_0._goitem)
	end

	arg_6_0._itemIcon:setEquipMO(arg_6_0.viewParam)
	arg_6_0._itemIcon:showLevel()
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._click:RemoveClickListener()
end

return var_0_0
