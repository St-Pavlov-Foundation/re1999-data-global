module("modules.logic.critter.model.CritterModel", package.seeall)

local var_0_0 = class("CritterModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._sortAttrIdKeyMap = {}
	arg_1_0._trainPreveiewMODict = {}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:clear()
	arg_2_0:clearData()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:clearData()
end

function var_0_0.clearData(arg_4_0)
	return
end

function var_0_0.isCritterUnlock(arg_5_0, arg_5_1)
	local var_5_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Critter)

	if not var_5_0 and GuideModel.instance:isGuideFinish(CritterEnum.OppenFuncGuide.Critter) then
		var_5_0 = true
	end

	if not var_5_0 and arg_5_1 then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Critter))
	end

	return var_5_0
end

function var_0_0.initCritter(arg_6_0, arg_6_1)
	local var_6_0 = {}

	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			local var_6_1 = arg_6_0:getById(iter_6_1.uid) or CritterMO.New()

			var_6_1:init(iter_6_1)
			table.insert(var_6_0, var_6_1)
		end
	end

	arg_6_0:setList(var_6_0)
end

function var_0_0.addCritter(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getById(arg_7_1.uid)

	if not var_7_0 then
		var_7_0 = CritterMO.New()

		var_7_0:init(arg_7_1)
		arg_7_0:addAtLast(var_7_0)
	else
		var_7_0:init(arg_7_1)
	end

	return var_7_0
end

function var_0_0.setLockCritter(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getById(arg_8_1)

	if var_8_0 then
		var_8_0.lock = arg_8_2 == true
	end
end

function var_0_0.setSortAttIdByKey(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._sortAttrIdKeyMap[arg_9_1] = arg_9_2
end

function var_0_0.getSortAttIdByKey(arg_10_0, arg_10_1)
	return arg_10_0._sortAttrIdKeyMap[arg_10_1]
end

function var_0_0.onStartTrainCritterReply(arg_11_0, arg_11_1)
	return
end

function var_0_0.onSelectEventOptionReply(arg_12_0, arg_12_1)
	return
end

function var_0_0.onFastForwardTrainReply(arg_13_0, arg_13_1)
	return
end

function var_0_0.removeCritters(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		arg_14_0:removeCritter(iter_14_1)
	end
end

function var_0_0.removeCritter(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getById(arg_15_1)

	if var_15_0 then
		arg_15_0:remove(var_15_0)
	end
end

function var_0_0.getCritterMOByUid(arg_16_0, arg_16_1)
	return arg_16_0:getById(arg_16_1)
end

function var_0_0.getAllCritters(arg_17_0)
	return arg_17_0:getList()
end

function var_0_0.getMaturityCritters(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = arg_18_0:getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if iter_18_1:isMaturity() then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function var_0_0.getCultivatingCritters(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = arg_19_0:getList()

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if iter_19_1:isCultivating() then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.getCritterSkinId(arg_20_0, arg_20_1)
	local var_20_0
	local var_20_1 = arg_20_0:getCritterMOByUid(arg_20_1)

	if var_20_1 then
		var_20_0 = var_20_1:getSkinId()
	end

	return var_20_0
end

function var_0_0.getCanIncubateCritters(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = arg_21_0:getList()

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		if iter_21_1:isMaturity() then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.checkGotCritter(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.defineId == arg_22_1 then
			return true
		end
	end

	return false
end

function var_0_0.getMoodCritters(arg_23_0, arg_23_1)
	local var_23_0 = {}
	local var_23_1 = arg_23_0:getList()

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if arg_23_1 >= iter_23_1:getMoodValue() then
			table.insert(var_23_0, iter_23_1.id)
		end
	end

	return var_23_0
end

function var_0_0.getTrainPreviewMO(arg_24_0, arg_24_1, arg_24_2)
	return RoomHelper.get2KeyValue(arg_24_0._trainPreveiewMODict, arg_24_1, arg_24_2)
end

function var_0_0.addTrainPreviewMO(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.id
	local var_25_1 = arg_25_1.trainInfo.heroId

	return RoomHelper.add2KeyValue(arg_25_0._trainPreveiewMODict, var_25_0, var_25_1, arg_25_1)
end

function var_0_0.getCritterCntById(arg_26_0, arg_26_1)
	local var_26_0 = 0
	local var_26_1 = arg_26_0:getList()

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		if iter_26_1.defineId == arg_26_1 then
			var_26_0 = var_26_0 + 1
		end
	end

	return var_26_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
