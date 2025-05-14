module("modules.logic.guide.controller.action.impl.WaitGuideActionGetCritter", package.seeall)

local var_0_0 = class("WaitGuideActionGetCritter", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	CritterController.instance:registerCallback(CritterEvent.CritterGuideReply, arg_1_0._onCritterGuideReply, arg_1_0)
	CritterRpc.instance:sendGainGuideCritterRequest(arg_1_0.guideId, arg_1_0.stepId)

	arg_1_0.noOpenView = tonumber(arg_1_0.actionParam) == 1
end

function var_0_0._check(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._onCritterGuideReply(arg_3_0, arg_3_1)
	if not arg_3_0.noOpenView then
		local var_3_0 = arg_3_1.uids

		for iter_3_0 = 1, #var_3_0 do
			local var_3_1 = CritterModel.instance:getCritterMOByUid(var_3_0[iter_3_0])

			if var_3_1 then
				local var_3_2 = {
					mode = RoomSummonEnum.SummonType.Summon,
					critterMo = var_3_1
				}

				ViewMgr.instance:openView(ViewName.RoomGetCritterView, var_3_2)

				break
			end
		end
	end

	arg_3_0:_check()
end

function var_0_0.clearWork(arg_4_0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterGuideReply, arg_4_0._onCritterGuideReply, arg_4_0)
end

return var_0_0
