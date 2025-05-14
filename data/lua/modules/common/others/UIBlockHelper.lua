module("modules.common.others.UIBlockHelper", package.seeall)

local var_0_0 = class("UIBlockHelper")

function var_0_0._init(arg_1_0)
	if not arg_1_0._inited then
		arg_1_0._inited = true
		arg_1_0._blockTimeDict = {}
		arg_1_0._blockViewDict = {}
		arg_1_0._blockViewCount = {}
		arg_1_0._nextRemoveBlockTime = 0

		setmetatable(arg_1_0._blockViewCount, {
			__index = function()
				return 0
			end
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	end
end

function var_0_0.startBlock(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:_init()

	if arg_3_0._blockTimeDict[arg_3_1] and arg_3_0._blockViewDict[arg_3_1] ~= arg_3_3 then
		logError("不支持改变绑定的界面")

		return
	end

	arg_3_2 = arg_3_2 or 0.1

	UIBlockMgr.instance:startBlock(arg_3_1)

	if arg_3_3 and not arg_3_0._blockTimeDict[arg_3_1] then
		arg_3_0._blockViewDict[arg_3_1] = arg_3_3
		arg_3_0._blockViewCount[arg_3_3] = arg_3_0._blockViewCount[arg_3_3] + 1
	end

	arg_3_0._blockTimeDict[arg_3_1] = UnityEngine.Time.time + arg_3_2

	arg_3_0:_checkNextRemoveBlock()
end

function var_0_0.endBlock(arg_4_0, arg_4_1)
	if not arg_4_0._blockTimeDict or not arg_4_0._blockTimeDict[arg_4_1] then
		return
	end

	arg_4_0:_endBlock(arg_4_1)
	arg_4_0:_checkNextRemoveBlock()
end

function var_0_0._checkNextRemoveBlock(arg_5_0)
	local var_5_0 = UnityEngine.Time.time
	local var_5_1 = math.huge

	for iter_5_0, iter_5_1 in pairs(arg_5_0._blockTimeDict) do
		if iter_5_1 < var_5_0 then
			arg_5_0:endBlock(iter_5_0)
		elseif iter_5_1 < var_5_1 then
			var_5_1 = iter_5_1
		end
	end

	if var_5_1 ~= math.huge then
		if var_5_1 ~= arg_5_0._nextRemoveBlockTime then
			arg_5_0._nextRemoveBlockTime = var_5_1

			TaskDispatcher.cancelTask(arg_5_0._checkNextRemoveBlock, arg_5_0)
			TaskDispatcher.runDelay(arg_5_0._checkNextRemoveBlock, arg_5_0, var_5_1 - var_5_0)
		end
	elseif arg_5_0._nextRemoveBlockTime ~= 0 then
		arg_5_0._nextRemoveBlockTime = 0

		TaskDispatcher.cancelTask(arg_5_0._checkNextRemoveBlock, arg_5_0)
	end
end

function var_0_0._endBlock(arg_6_0, arg_6_1)
	UIBlockMgr.instance:endBlock(arg_6_1)

	arg_6_0._blockTimeDict[arg_6_1] = nil

	if arg_6_0._blockViewDict[arg_6_1] then
		local var_6_0 = arg_6_0._blockViewDict[arg_6_1]

		arg_6_0._blockViewCount[var_6_0] = arg_6_0._blockViewCount[var_6_0] - 1

		if arg_6_0._blockViewCount[var_6_0] == 0 then
			arg_6_0._blockViewCount[var_6_0] = nil
		end
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_0._blockViewCount[arg_7_1] > 0 then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._blockViewDict) do
			if iter_7_1 == arg_7_1 then
				arg_7_0:endBlock(iter_7_0)
			end
		end

		arg_7_0:_checkNextRemoveBlock()
	end
end

function var_0_0.clearAll(arg_8_0)
	if not arg_8_0._blockTimeDict then
		return
	end

	for iter_8_0 in pairs(arg_8_0._blockTimeDict) do
		arg_8_0:_endBlock(iter_8_0)
	end

	arg_8_0._nextRemoveBlockTime = 0

	TaskDispatcher.cancelTask(arg_8_0._checkNextRemoveBlock, arg_8_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
