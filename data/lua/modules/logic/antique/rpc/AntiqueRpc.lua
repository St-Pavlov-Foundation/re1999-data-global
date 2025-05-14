module("modules.logic.antique.rpc.AntiqueRpc", package.seeall)

local var_0_0 = class("AntiqueRpc", BaseRpc)

function var_0_0.sendGetAntiqueInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = AntiqueModule_pb.GetAntiqueInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetAntiqueInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	AntiqueModel.instance:setAntiqueInfo(arg_2_2.antiques)
end

function var_0_0.onReceiveAntiqueUpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_2.antiques) do
		if not AntiqueModel.instance:getAntique(iter_3_1.antiqueId) then
			GameFacade.showToast(ToastEnum.AntiqueNewGet)
		end
	end

	AntiqueModel.instance:updateAntiqueInfo(arg_3_2.antiques)
end

var_0_0.instance = var_0_0.New()

return var_0_0
