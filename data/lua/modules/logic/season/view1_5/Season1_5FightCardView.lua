module("modules.logic.season.view1_5.Season1_5FightCardView", package.seeall)

local var_0_0 = class("Season1_5FightCardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCardItem = gohelper.findChild(arg_1_0.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(arg_1_0._goCardItem, false)

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
	return
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = Activity104Model.instance:getFightCardDataList()

	if not arg_5_0.itemList then
		arg_5_0.itemList = {}
	end

	for iter_5_0 = 1, math.max(#arg_5_0.itemList, #var_5_0) do
		local var_5_1 = var_5_0[iter_5_0]
		local var_5_2 = arg_5_0.itemList[iter_5_0] or arg_5_0:createItem(iter_5_0)

		arg_5_0:updateItem(var_5_2, var_5_1)
	end
end

function var_0_0.createItem(arg_6_0, arg_6_1)
	local var_6_0 = gohelper.cloneInPlace(arg_6_0._goCardItem, string.format("card%s", arg_6_1))
	local var_6_1 = Season1_5FightCardItem.New(var_6_0)

	arg_6_0.itemList[arg_6_1] = var_6_1

	return var_6_1
end

function var_0_0.updateItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1:setData(arg_7_2)
end

function var_0_0.destroyItem(arg_8_0, arg_8_1)
	arg_8_1:destroy()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0.itemList then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.itemList) do
			arg_10_0:destroyItem(iter_10_1)
		end

		arg_10_0.itemList = nil
	end
end

return var_0_0
