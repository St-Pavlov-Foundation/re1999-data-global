module("modules.logic.rouge.view.RougeCollectionCompositeListItem", package.seeall)

local var_0_0 = class("RougeCollectionCompositeListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocollectionicon = gohelper.findChild(arg_1_0.viewGO, "go_collectionicon")
	arg_1_0._gocancomposite = gohelper.findChild(arg_1_0.viewGO, "go_cancomposite")
	arg_1_0._goselectframe = gohelper.findChild(arg_1_0.viewGO, "go_selectframe")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	RougeController.instance:dispatchEvent(RougeEvent.OnSelectCollectionCompositeItem, arg_4_0._mo.id)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	if not arg_7_0._mo then
		return
	end

	local var_7_0 = arg_7_0._mo.id
	local var_7_1 = arg_7_0._mo.product
	local var_7_2 = arg_7_0:checkIsCanComposite(var_7_0)

	gohelper.setActive(arg_7_0._gocancomposite, var_7_2)

	local var_7_3 = RougeCollectionCompositeListModel.instance:getCurSelectCellId() == arg_7_0._mo.id

	gohelper.setActive(arg_7_0._goselectframe, var_7_3)
	arg_7_0:refreshProductIcon(var_7_1)
end

function var_0_0.refreshProductIcon(arg_8_0, arg_8_1)
	if not arg_8_0._iconItem then
		local var_8_0 = arg_8_0._view.viewContainer:getSetting()
		local var_8_1 = arg_8_0._view:getResInst(var_8_0.otherRes[1], arg_8_0._gocollectionicon, "itemicon")

		arg_8_0._iconItem = RougeCollectionIconItem.New(var_8_1)
	end

	arg_8_0._iconItem:onUpdateMO(arg_8_1)
	arg_8_0._iconItem:setHolesVisible(false)
end

function var_0_0.checkIsCanComposite(arg_9_0, arg_9_1)
	local var_9_0 = RougeCollectionConfig.instance:getCollectionCompositeIdAndCount(arg_9_1)
	local var_9_1 = true

	if var_9_0 then
		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			if iter_9_1 > RougeCollectionModel.instance:getCollectionCountById(iter_9_0) then
				var_9_1 = false

				break
			end
		end
	end

	return var_9_1
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselectframe, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._iconItem then
		arg_11_0._iconItem:destroy()

		arg_11_0._iconItem = nil
	end
end

return var_0_0
