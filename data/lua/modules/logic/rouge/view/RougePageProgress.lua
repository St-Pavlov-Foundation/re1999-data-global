module("modules.logic.rouge.view.RougePageProgress", package.seeall)

local var_0_0 = class("RougePageProgress", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._highLightRange = {
		false,
		false
	}
	arg_1_0._totalPage = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._itemList = arg_2_0:getUserDataTb_()
	arg_2_0._goLayout = gohelper.findChild(arg_2_1, "Root/#go_Layout")

	local var_2_0 = arg_2_0._goLayout.transform
	local var_2_1 = var_2_0.childCount

	for iter_2_0 = 0, var_2_1 - 1 do
		local var_2_2 = var_2_0:GetChild(iter_2_0)
		local var_2_3 = RougePageProgressItem.New(arg_2_0)

		var_2_3:init(var_2_2)
		var_2_3:setHighLight(false)

		if iter_2_0 == var_2_1 - 1 then
			var_2_3:setLineActiveByState(nil)
		else
			var_2_3:setLineActiveByState(RougePageProgressItem.LineStateEnum.Done)
		end

		table.insert(arg_2_0._itemList, var_2_3)
	end

	arg_2_0._totalPage = var_2_1
end

function var_0_0.setHighLightRange(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or 1

	local var_3_0 = arg_3_0._highLightRange[1]
	local var_3_1 = arg_3_0._highLightRange[2]

	if var_3_0 == arg_3_2 and var_3_1 == arg_3_1 then
		return
	end

	local var_3_2 = var_3_1 and math.max(var_3_1, arg_3_2) or arg_3_2
	local var_3_3 = var_3_0 and math.min(var_3_0, arg_3_1) or arg_3_1

	for iter_3_0 = var_3_2, var_3_3 do
		arg_3_0._itemList[iter_3_0]:setHighLight(true)
	end

	if var_3_0 then
		for iter_3_1 = var_3_0, var_3_2 - 1 do
			arg_3_0._itemList[iter_3_1]:setHighLight(false)
		end
	end

	if var_3_1 then
		for iter_3_2 = var_3_3 + 1, var_3_1 do
			arg_3_0._itemList[iter_3_2]:setHighLight(false)
		end
	end

	arg_3_0._highLightRange[1] = arg_3_2
	arg_3_0._highLightRange[2] = arg_3_1
end

function var_0_0.onDestroyView(arg_4_0)
	return
end

function var_0_0.initData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1 or 0

	assert(var_5_0 <= arg_5_0:capacity(), "[RougePageProgress] initData: totalPage=" .. tostring(var_5_0) .. " maxPage=" .. tostring(arg_5_0:capacity()))

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._itemList) do
		local var_5_1 = iter_5_0 <= var_5_0

		if arg_5_2 then
			local var_5_2 = RougePageProgressItem.LineStateEnum.Done

			if iter_5_0 == arg_5_2 then
				var_5_2 = RougePageProgressItem.LineStateEnum.Edit
			end

			if arg_5_2 < iter_5_0 then
				var_5_2 = RougePageProgressItem.LineStateEnum.Locked
			end

			if iter_5_0 == arg_5_1 then
				if arg_5_2 == arg_5_1 then
					var_5_2 = RougePageProgressItem.LineStateEnum.Done
				elseif arg_5_2 + 1 == arg_5_1 then
					var_5_2 = RougePageProgressItem.LineStateEnum.Edit
				else
					var_5_2 = RougePageProgressItem.LineStateEnum.Locked
				end
			end

			if var_5_1 then
				iter_5_1:setLineActiveByState(var_5_2)
			end
		end

		iter_5_1:setActive(var_5_1)
	end

	arg_5_0._totalPage = var_5_0
end

function var_0_0.capacity(arg_6_0)
	return arg_6_0._itemList and #arg_6_0._itemList or 0
end

function var_0_0.count(arg_7_0)
	return arg_7_0._totalPage
end

function var_0_0.highLightRange(arg_8_0)
	return arg_8_0._highLightRange[1], arg_8_0._highLightRange[2]
end

function var_0_0._getCurStartProgress(arg_9_0)
	local var_9_0 = arg_9_0:_getStartProgressCount()

	if ViewMgr.instance:isOpen(ViewName.RougeInitTeamView) then
		return var_9_0
	end

	local var_9_1 = var_9_0 - 1

	if ViewMgr.instance:isOpen(ViewName.RougeFactionView) then
		return var_9_1
	end

	local var_9_2 = var_9_1 - 1

	if RougeModel.instance:isCanSelectRewards() then
		if ViewMgr.instance:isOpen(ViewName.RougeCollectionGiftView) then
			return var_9_2
		end

		var_9_2 = var_9_2 - 1
	end

	if ViewMgr.instance:isOpen(ViewName.RougeDifficultyView) then
		return var_9_2
	end

	return var_9_2 - 1
end

function var_0_0._getStartProgressCount(arg_10_0)
	local var_10_0 = 3

	if RougeModel.instance:isCanSelectRewards() then
		var_10_0 = var_10_0 + 1
	end

	return var_10_0
end

function var_0_0.setData(arg_11_0)
	arg_11_0:initData(arg_11_0:_getStartProgressCount(), arg_11_0:_getCurStartProgress())
	arg_11_0:setHighLightRange(arg_11_0:_getCurStartProgress())
end

return var_0_0
