module("modules.logic.versionactivity1_9.fairyland.model.FairyLandModel", package.seeall)

local var_0_0 = class("FairyLandModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.stairIndex = 1
	arg_2_0.passPuzzleDict = {}
	arg_2_0.dialogDict = {}
	arg_2_0.finishElementDict = {}
	arg_2_0.hasInfo = false
end

function var_0_0.onGetFairylandInfoReply(arg_3_0, arg_3_1)
	arg_3_0:clear()
	arg_3_0:updateInfo(arg_3_1.info)
end

function var_0_0.onResolvePuzzleReply(arg_4_0, arg_4_1)
	arg_4_0:updateInfo(arg_4_1.info)
end

function var_0_0.onRecordDialogReply(arg_5_0, arg_5_1)
	arg_5_0:updateInfo(arg_5_1.info)
end

function var_0_0.onRecordElementReply(arg_6_0, arg_6_1)
	arg_6_0:updateInfo(arg_6_1.info)
end

function var_0_0.updateInfo(arg_7_0, arg_7_1)
	arg_7_0.hasInfo = true
	arg_7_0.passPuzzleDict = {}
	arg_7_0.dialogDict = {}
	arg_7_0.finishElementDict = {}

	if not arg_7_1 then
		return
	end

	for iter_7_0 = 1, #arg_7_1.passPuzzleId do
		arg_7_0.passPuzzleDict[arg_7_1.passPuzzleId[iter_7_0]] = true
	end

	for iter_7_1 = 1, #arg_7_1.dialogId do
		arg_7_0.dialogDict[arg_7_1.dialogId[iter_7_1]] = true
	end

	for iter_7_2 = 1, #arg_7_1.finishElementId do
		arg_7_0.finishElementDict[arg_7_1.finishElementId[iter_7_2]] = true
	end
end

function var_0_0.setFinishDialog(arg_8_0, arg_8_1)
	if not arg_8_0.dialogDict then
		return
	end

	arg_8_0.dialogDict[arg_8_1] = true
end

function var_0_0.setPos(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.stairIndex = arg_9_1

	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetStairPos, arg_9_2)
end

function var_0_0.getStairPos(arg_10_0)
	return arg_10_0.stairIndex or 1
end

function var_0_0.caleCurStairPos(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = FairyLandConfig.instance:getElements()

	for iter_11_0 = #var_11_1, 1, -1 do
		local var_11_2 = var_11_1[iter_11_0]

		if FairyLandEnum.ConfigType2ElementType[var_11_2.type] ~= FairyLandEnum.ElementType.NPC and arg_11_0:isFinishElement(var_11_2.id) then
			var_11_0 = tonumber(var_11_2.pos)

			break
		end
	end

	return var_11_0
end

function var_0_0.isFinishElement(arg_12_0, arg_12_1)
	return arg_12_0.finishElementDict[arg_12_1]
end

function var_0_0.isPassPuzzle(arg_13_0, arg_13_1)
	return arg_13_0.passPuzzleDict[arg_13_1]
end

function var_0_0.isFinishDialog(arg_14_0, arg_14_1)
	return arg_14_1 == 0 or arg_14_0.dialogDict[arg_14_1]
end

function var_0_0.getCurPuzzle(arg_15_0)
	local var_15_0 = FairyLandConfig.instance:getElements()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if FairyLandEnum.ConfigType2ElementType[iter_15_1.type] == FairyLandEnum.ElementType.NPC then
			local var_15_1 = string.splitToNumber(iter_15_1.puzzleId, "#")

			for iter_15_2, iter_15_3 in ipairs(var_15_1) do
				local var_15_2 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(iter_15_3)

				if not arg_15_0:isPuzzleAllStepFinish(var_15_2.id) and (var_15_2.beforeTalkId == 0 or arg_15_0:isFinishDialog(var_15_2.beforeTalkId)) and arg_15_0:isPuzzleAllStepFinish(iter_15_3 - 1) then
					return var_15_2.id
				end
			end
		end
	end

	return 0
end

function var_0_0.getLatestFinishedPuzzle(arg_16_0)
	local var_16_0 = FairyLandConfig.instance:getElements()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if FairyLandEnum.ConfigType2ElementType[iter_16_1.type] == FairyLandEnum.ElementType.NPC then
			local var_16_1 = string.splitToNumber(iter_16_1.puzzleId, "#")

			for iter_16_2, iter_16_3 in ipairs(var_16_1) do
				local var_16_2 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(iter_16_3)

				if arg_16_0:isPuzzleAllStepFinish(var_16_2.id) then
					return var_16_2.id
				end
			end
		end
	end

	return 0
end

function var_0_0.isPuzzleAllStepFinish(arg_17_0, arg_17_1)
	local var_17_0 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(arg_17_1)

	if not var_17_0 then
		return true
	end

	local var_17_1 = arg_17_0:isFinishDialog(var_17_0.beforeTalkId)
	local var_17_2 = arg_17_0:isFinishDialog(var_17_0.successTalkId)
	local var_17_3 = arg_17_0:isFinishDialog(var_17_0.storyTalkId)
	local var_17_4 = arg_17_0:isPassPuzzle(arg_17_1)

	return var_17_1 and var_17_2 and var_17_3 and var_17_4
end

function var_0_0.getDialogElement(arg_18_0, arg_18_1)
	local var_18_0 = ViewMgr.instance:getContainer(ViewName.FairyLandView)

	if var_18_0 then
		return var_18_0:getElement(arg_18_1)
	end
end

function var_0_0.isFinishFairyLand(arg_19_0)
	local var_19_0 = FairyLandConfig.instance:getElements()

	for iter_19_0 = #var_19_0, 1, -1 do
		if not arg_19_0:isFinishElement(var_19_0[iter_19_0].id) then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
