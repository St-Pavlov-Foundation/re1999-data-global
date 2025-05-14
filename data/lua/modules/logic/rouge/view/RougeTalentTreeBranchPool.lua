module("modules.logic.rouge.view.RougeTalentTreeBranchPool", package.seeall)

local var_0_0 = class("RougeTalentTreeBranchPool", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._resPath = arg_1_1 or ""
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:initPool()
end

function var_0_0.initPool(arg_6_0)
	arg_6_0._gopool = gohelper.findChild(arg_6_0.viewGO, "#go_pool")

	if not arg_6_0._gopool then
		arg_6_0._gopool = gohelper.create2d(arg_6_0.viewGO, "#go_pool")

		local var_6_0 = gohelper.onceAddComponent(arg_6_0._gopool, gohelper.Type_CanvasGroup)

		var_6_0.alpha = 0
		var_6_0.interactable = false
		var_6_0.blocksRaycasts = false

		recthelper.setAnchorX(arg_6_0._gopool.transform, 10000)
	end

	arg_6_0._tfpool = arg_6_0._gopool.transform
	arg_6_0._iconIndex = 1
	arg_6_0._freeIconList = {}
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.getIcon(arg_9_0, arg_9_1)
	if string.nilorempty(arg_9_0._resPath) then
		logError("resPath is nil")

		return
	end

	local var_9_0 = arg_9_0:getOrCreateIconInternal()

	if arg_9_1 then
		var_9_0.viewGO.transform:SetParent(arg_9_1.transform, false)
	end

	recthelper.setAnchor(var_9_0.viewGO.transform, 0, 0)
	transformhelper.setLocalScale(var_9_0.viewGO.transform, 1, 1, 1)

	return var_9_0
end

function var_0_0.getOrCreateIconInternal(arg_10_0)
	local var_10_0
	local var_10_1 = arg_10_0._freeIconList and #arg_10_0._freeIconList or 0

	if var_10_1 <= 0 then
		var_10_0 = arg_10_0:createIconInternal()
	else
		var_10_0 = table.remove(arg_10_0._freeIconList, var_10_1)
	end

	return var_10_0
end

function var_0_0.createIconInternal(arg_11_0)
	local var_11_0 = RougeTalentTreeBranchItem.New()
	local var_11_1 = arg_11_0:getResInst(arg_11_0._resPath, arg_11_0._gopool, "branchitem" .. tostring(arg_11_0._iconIndex))

	arg_11_0._iconIndex = arg_11_0._iconIndex + 1

	var_11_0:init(var_11_1)

	return var_11_0
end

function var_0_0.recycleIcon(arg_12_0, arg_12_1)
	if not gohelper.isNil(arg_12_1.viewGO) then
		arg_12_1.viewGO.transform:SetParent(arg_12_0._tfpool)
	end

	if arg_12_0._freeIconList then
		table.insert(arg_12_0._freeIconList, arg_12_1)
	end
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0:release()
end

function var_0_0.release(arg_14_0)
	if arg_14_0._freeIconList then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._freeIconList) do
			iter_14_1:dispose()
		end

		arg_14_0._freeIconList = nil
	end
end

return var_0_0
