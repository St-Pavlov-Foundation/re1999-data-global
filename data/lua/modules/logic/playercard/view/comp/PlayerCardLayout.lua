module("modules.logic.playercard.view.comp.PlayerCardLayout", package.seeall)

local var_0_0 = class("PlayerCardLayout", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.setLayoutList(arg_4_0, arg_4_1)
	arg_4_0._layoutList = arg_4_1
end

function var_0_0.setData(arg_5_0, arg_5_1)
	if arg_5_0._layoutList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._layoutList) do
			local var_5_0 = iter_5_1:getLayoutKey()
			local var_5_1 = arg_5_1[var_5_0] or var_5_0

			iter_5_1:setLayoutIndex(var_5_1)
		end

		table.sort(arg_5_0._layoutList, SortUtil.keyLower("index"))
		arg_5_0:refreshLayout()
	end
end

function var_0_0.refreshLayout(arg_6_0)
	if not arg_6_0._layoutList then
		return
	end

	table.sort(arg_6_0._layoutList, SortUtil.keyLower("index"))

	local var_6_0 = -197

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._layoutList) do
		local var_6_1 = iter_6_1:getLayoutGO()

		recthelper.setAnchorY(var_6_1.transform, var_6_0)

		var_6_0 = var_6_0 - iter_6_1:getHeight() - 5
	end
end

function var_0_0.setEditMode(arg_7_0, arg_7_1)
	if arg_7_0._layoutList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._layoutList) do
			iter_7_1:setEditMode(arg_7_1)
		end
	end
end

function var_0_0.startUpdate(arg_8_0, arg_8_1)
	if arg_8_0._inUpdate then
		return
	end

	arg_8_0.dragItem = arg_8_1
	arg_8_0._inUpdate = true

	LateUpdateBeat:Add(arg_8_0._lateUpdate, arg_8_0)

	if arg_8_0._layoutList then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._layoutList) do
			iter_8_1:onStartDrag()
		end
	end
end

function var_0_0.closeUpdate(arg_9_0)
	if not arg_9_0._inUpdate then
		return
	end

	arg_9_0.dragItem = nil
	arg_9_0._inUpdate = false

	LateUpdateBeat:Remove(arg_9_0._lateUpdate, arg_9_0)

	if arg_9_0._layoutList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._layoutList) do
			iter_9_1:onEndDrag()
		end
	end
end

function var_0_0._lateUpdate(arg_10_0)
	arg_10_0:caleLayout()
end

function var_0_0.caleLayout(arg_11_0)
	if not arg_11_0.dragItem then
		return
	end

	if arg_11_0._layoutList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._layoutList) do
			if not iter_11_1.inDrag and arg_11_0.dragItem:isInArea(iter_11_1:getCenterScreenPosY()) then
				arg_11_0.dragItem:exchangeIndex(iter_11_1)
				arg_11_0:refreshLayout()

				break
			end
		end
	end
end

function var_0_0.getLayoutData(arg_12_0)
	local var_12_0 = {}

	if arg_12_0._layoutList then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._layoutList) do
			table.insert(var_12_0, string.format("%s_%s", iter_12_1:getLayoutKey(), iter_12_0))
		end
	end

	return table.concat(var_12_0, "&")
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:closeUpdate()
end

return var_0_0
