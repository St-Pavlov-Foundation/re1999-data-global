module("modules.logic.handbook.model.HandbookCGTripleListModel", package.seeall)

local var_0_0 = class("HandbookCGTripleListModel", MixScrollModel)

function var_0_0.setCGList(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.cgType
	local var_1_1 = arg_1_1.cgList
	local var_1_2 = {}
	local var_1_3
	local var_1_4

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if HandbookModel.instance:isCGUnlock(iter_1_1.id) then
			local var_1_5 = iter_1_1.storyChapterId

			var_1_4 = var_1_4 or {}

			if not var_1_3 or var_1_3 ~= var_1_5 then
				if #var_1_4 > 0 then
					local var_1_6 = HandbookCGTripleMO.New()

					var_1_6:init({
						cgList = var_1_4,
						cgType = var_1_0
					})
					table.insert(var_1_2, var_1_6)

					var_1_4 = {}
				end

				local var_1_7 = HandbookCGTripleMO.New()

				var_1_7:init({
					isTitle = true,
					storyChapterId = var_1_5
				})
				table.insert(var_1_2, var_1_7)
			end

			if iter_1_1.preCgId == 0 then
				table.insert(var_1_4, iter_1_1)
			end

			var_1_3 = var_1_5
		end

		if var_1_4 and #var_1_4 >= 3 or iter_1_0 == #var_1_1 and var_1_4 and #var_1_4 > 0 then
			local var_1_8 = HandbookCGTripleMO.New()

			var_1_8:init({
				cgList = var_1_4,
				cgType = var_1_0
			})
			table.insert(var_1_2, var_1_8)

			var_1_4 = nil
		end
	end

	arg_1_0:setList(var_1_2)
end

function var_0_0.getInfoList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0:getList()) do
		local var_2_1 = iter_2_1.isTitle
		local var_2_2 = var_2_1 and 0 or 1
		local var_2_3 = var_2_1 and 90 or 298
		local var_2_4 = SLFramework.UGUI.MixCellInfo.New(var_2_2, var_2_3, nil)

		table.insert(var_2_0, var_2_4)
	end

	return var_2_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
