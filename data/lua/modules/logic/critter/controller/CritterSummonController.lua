module("modules.logic.critter.controller.CritterSummonController", package.seeall)

local var_0_0 = class("CritterSummonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.summonCritterInfoReply(arg_5_0, arg_5_1)
	CritterSummonModel.instance:initSummonPools(arg_5_1.poolInfos)
end

function var_0_0.summonCritterReply(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.critterInfos
	local var_6_1 = {}

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_2 = CritterModel.instance:addCritter(iter_6_1)

			table.insert(var_6_1, var_6_2)
		end
	end

	if var_6_1 and #var_6_1 > 0 then
		CritterSummonModel.instance:onSummon(arg_6_1.poolId, arg_6_1.hasSummonCritter)

		local var_6_3 = {
			mode = RoomSummonEnum.SummonType.Summon,
			poolId = arg_6_1.poolId,
			critterMo = var_6_1[1],
			critterMOList = var_6_1
		}

		arg_6_0:dispatchEvent(CritterSummonEvent.onStartSummon, var_6_3)
	end
end

function var_0_0.resetSummonCritterPoolReply(arg_7_0, arg_7_1)
	arg_7_0:dispatchEvent(CritterSummonEvent.onResetSummon, arg_7_1.poolId, arg_7_1.poolId)
end

function var_0_0.refreshSummon(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	CritterRpc.instance:sendSummonCritterInfoRequest(arg_8_2, arg_8_3)
end

function var_0_0.openSummonRuleTipView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.RoomCritterSummonRuleTipsView, {
		type = arg_9_1
	})
end

function var_0_0.openSummonView(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 and arg_10_2 then
		local var_10_0 = RoomSummonEnum.SummonMode[arg_10_2.mode].CameraId

		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(arg_10_1, var_10_0, function()
			arg_10_0:_reallyOpenSummonView(arg_10_2)
		end)
	else
		arg_10_0:_reallyOpenSummonView(arg_10_2)
	end
end

function var_0_0._reallyOpenSummonView(arg_12_0, arg_12_1)
	arg_12_0:dispatchEvent(CritterSummonEvent.onStartSummonAnim, arg_12_1)
	ViewMgr.instance:openView(ViewName.RoomCritterSummonSkipView, arg_12_1)
end

function var_0_0.openSummonGetCritterView(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = arg_13_1 or {}
	arg_13_1.isSkip = arg_13_2

	ViewMgr.instance:openView(ViewName.RoomGetCritterView, arg_13_1)
end

function var_0_0.onCanDrag(arg_14_0)
	arg_14_0:dispatchEvent(CritterSummonEvent.onCanDrag)
end

function var_0_0.onSummonDragEnd(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:dispatchEvent(CritterSummonEvent.onDragEnd, arg_15_1, arg_15_2)
end

function var_0_0.onFinishSummonAnim(arg_16_0, arg_16_1)
	arg_16_0:dispatchEvent(CritterSummonEvent.onEndSummon, arg_16_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
