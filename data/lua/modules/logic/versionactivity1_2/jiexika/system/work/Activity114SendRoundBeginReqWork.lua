module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114SendRoundBeginReqWork", package.seeall)

local var_0_0 = class("Activity114SendRoundBeginReqWork", Activity114ReqBaseWork)

function var_0_0.onStart(arg_1_0)
	if Activity114Model.instance.serverData.day ~= arg_1_0.context.day or Activity114Model.instance.serverData.round ~= arg_1_0.context.round then
		arg_1_0:onDone(true)

		return
	end

	Activity114Rpc.instance:markRoundStory(Activity114Model.instance.id, arg_1_0.onReply, arg_1_0)
end

function var_0_0.onReply(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 == 0 then
		local var_2_0 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, arg_2_0.context.day, arg_2_0.context.round)

		if var_2_0 and var_2_0.isSkip == 1 then
			local var_2_1 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, arg_2_0.context.day, arg_2_0.context.round + 1) or Activity114Config.instance:getRoundCo(Activity114Model.instance.id, arg_2_0.context.day + 1, 1)

			if var_2_1 then
				Activity114Model.instance.serverData.day = var_2_1.day
				Activity114Model.instance.serverData.round = var_2_1.id
			else
				logError("没有下回合配置？" .. arg_2_0.context.day .. "  #  " .. arg_2_0.context.round)
			end
		else
			Activity114Model.instance.serverData.isReadRoundStory = true
		end
	end

	var_0_0.super.onReply(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
end

return var_0_0
