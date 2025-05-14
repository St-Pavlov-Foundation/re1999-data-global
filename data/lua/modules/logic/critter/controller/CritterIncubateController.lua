module("modules.logic.critter.controller.CritterIncubateController", package.seeall)

local var_0_0 = class("CritterIncubateController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._incubateCritterList = nil
	arg_1_0._incubateCritterList = 1
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._incubateCritterList = nil
	arg_4_0._incubateCritterList = 1
end

function var_0_0.getIncubateCritterIds(arg_5_0)
	local var_5_0 = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(1)
	local var_5_1 = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(2)

	return var_5_0, var_5_1
end

function var_0_0.onIncubateCritterPreview(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:getIncubateCritterIds()

	CritterRpc.instance:sendIncubateCritterPreviewRequest(var_6_0, var_6_1)
end

function var_0_0.openRoomCritterDetailView(arg_7_0)
	local var_7_0 = CritterIncubateModel.instance:getChildMOList()

	CritterController.instance:openRoomCritterDetailView(true, nil, true, var_7_0)
end

function var_0_0.onIncubateCritterPreviewReply(arg_8_0, arg_8_1)
	CritterIncubateModel.instance:setCritterPreviewInfo(arg_8_1.childes)
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onIncubateCritterPreviewReply)
end

function var_0_0.onIncubateCritter(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:getIncubateCritterIds()

	CritterRpc.instance:sendIncubateCritterRequest(var_9_0, var_9_1)
end

function var_0_0.incubateCritterReply(arg_10_0, arg_10_1)
	arg_10_0._incubateCritterList = arg_10_1.childes
	arg_10_0._showCritterIndex = 1

	if not LuaUtil.tableNotEmpty(arg_10_0._incubateCritterList) then
		return
	end

	local var_10_0 = arg_10_0._incubateCritterList[arg_10_0._showCritterIndex]

	if LuaUtil.tableNotEmpty(var_10_0) then
		local var_10_1 = CritterModel.instance:addCritter(var_10_0)
		local var_10_2 = {
			mode = RoomSummonEnum.SummonType.Incubate,
			parent1 = arg_10_1.parent1,
			parent2 = arg_10_1.parent2,
			critterMo = var_10_1
		}

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onStartSummon, var_10_2)
	end
end

function var_0_0.checkHasChildCritter(arg_11_0)
	if not LuaUtil.tableNotEmpty(arg_11_0._incubateCritterList) then
		return
	end

	if not arg_11_0._showCritterIndex then
		return
	end

	if arg_11_0._showCritterIndex >= #arg_11_0._incubateCritterList then
		return
	end

	arg_11_0._showCritterIndex = arg_11_0._showCritterIndex + 1

	local var_11_0 = arg_11_0._incubateCritterList[arg_11_0._showCritterIndex]

	if LuaUtil.tableNotEmpty(var_11_0) then
		return (CritterModel.instance:addCritter(var_11_0))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
