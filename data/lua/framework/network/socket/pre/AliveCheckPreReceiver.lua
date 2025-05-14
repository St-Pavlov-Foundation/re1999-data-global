module("framework.network.socket.pre.AliveCheckPreReceiver", package.seeall)

local var_0_0 = class("AliveCheckPreReceiver", BasePreReceiver)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._aliveCheckPreSender = arg_1_1
	arg_1_0._currDownTag = nil
	arg_1_0._currRespName = "nil"
end

function var_0_0.getCurrDownTag(arg_2_0)
	return arg_2_0._currDownTag
end

function var_0_0.clearCurrDownTag(arg_3_0)
	arg_3_0._currDownTag = nil
end

function var_0_0.preReceiveMsg(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if arg_4_5 and arg_4_5 ~= 255 then
		if arg_4_0._currDownTag then
			arg_4_3 = arg_4_3 or "nil"

			if arg_4_0._currDownTag == arg_4_5 then
				if arg_4_0._currRespName == arg_4_3 then
					local var_4_0 = string.format("downTag重复: tag=%d name=%s", arg_4_5, arg_4_3)

					logError(var_4_0)
				else
					local var_4_1 = string.format("downTag一样，协议不一样: tag=%d %s->%s", arg_4_5, arg_4_0._currRespName, arg_4_3)

					logError(var_4_1)
				end

				return true
			elseif arg_4_0._currDownTag == 0 and arg_4_5 ~= 1 or arg_4_0._currDownTag ~= 127 and arg_4_5 == 0 or arg_4_0._currDownTag > 0 and arg_4_5 > 0 and arg_4_5 - arg_4_0._currDownTag > 1 then
				local var_4_2 = string.format("downTag跳跃: tag=%d->%d %s->%s", arg_4_0._currDownTag, arg_4_5, arg_4_0._currRespName, arg_4_3)

				logError(var_4_2)
				ConnectAliveMgr.instance:lostMessage()

				return
			end
		end

		arg_4_0._currRespName = arg_4_3 or "nil"
		arg_4_0._currDownTag = arg_4_5
	end

	arg_4_0._aliveCheckPreSender:onReceiveMsg(arg_4_2)
end

return var_0_0
