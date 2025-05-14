module("modules.logic.activity.view.V2a3_Special_BaseView", package.seeall)

local var_0_0 = class("V2a3_Special_BaseView", Activity101SignViewBase)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.onDestroyView(arg_2_0)
	Activity101SignViewBase._internal_onDestroy(arg_2_0)
end

function var_0_0.internal_onOpen(arg_3_0)
	local var_3_0 = arg_3_0:openMode()
	local var_3_1 = Activity101SignViewBase.eOpenMode

	if var_3_0 == var_3_1.ActivityBeginnerView then
		local var_3_2 = arg_3_0.viewParam.actId
		local var_3_3 = arg_3_0.viewParam.parent

		arg_3_0:internal_set_actId(var_3_2)
		gohelper.addChild(var_3_3, arg_3_0.viewGO)
		arg_3_0:_internal_onOpen()
		arg_3_0:_refresh()
	elseif var_3_0 == var_3_1.PaiLian then
		arg_3_0:_internal_onOpen()
		arg_3_0:_refresh()
	else
		assert(false)
	end
end

function var_0_0.addEvents(arg_4_0)
	var_0_0.super.addEvents(arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	var_0_0.super.removeEvents(arg_5_0)
end

function var_0_0.addReward(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_3.New({
		parent = arg_6_0,
		baseViewContainer = arg_6_0.viewContainer
	})

	var_6_0:setIndex(arg_6_1)
	var_6_0:init(arg_6_2)
	table.insert(arg_6_0.__itemList, var_6_0)

	return var_6_0
end

function var_0_0._createList(arg_7_0)
	if arg_7_0.__itemList then
		return
	end

	arg_7_0.__itemList = {}

	local var_7_0 = arg_7_0:getDataList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0:onFindChind_RewardGo(iter_7_0)

		arg_7_0:addReward(iter_7_0, var_7_1, V2a3_Special_SignItem):onUpdateMO(iter_7_1)
	end
end

function var_0_0._refreshList(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1 then
		var_8_0 = arg_8_0:getTempDataList()
	else
		var_8_0 = arg_8_0:getDataList()
	end

	arg_8_0:onRefreshList(var_8_0)
end

function var_0_0.onRefreshList(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0.__itemList

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_1 = var_9_0[iter_9_0]

		if var_9_1 then
			var_9_1:onUpdateMO(iter_9_1)
			var_9_1:setActive(true)
		end
	end

	for iter_9_2 = #arg_9_1 + 1, #var_9_0 do
		var_9_0[iter_9_2]:setActive(false)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:_refresh()
end

function var_0_0.onFindChind_RewardGo(arg_11_0, arg_11_1)
	assert(false, "please override this function")
end

function var_0_0.onStart(arg_12_0)
	arg_12_0:_createList()
end

return var_0_0
