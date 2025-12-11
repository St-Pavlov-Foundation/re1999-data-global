module("modules.logic.reddot.model.RedDotGroupMo", package.seeall)

local var_0_0 = pureTable("RedDotGroupMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = tonumber(arg_1_1.defineId)
	arg_1_0.infos = arg_1_0:_buildDotInfo(arg_1_1.infos)
	arg_1_0.replaceAll = arg_1_1.replaceAll
end

function var_0_0._buildDotInfo(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = BootNativeUtil.isIOS()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if var_2_1 and ActivityEnum.IOSHideActIdMap[tonumber(iter_2_1.id)] then
			logNormal("红点初始化 iOS临时屏蔽双端登录活动红点")
		else
			local var_2_2 = RedDotInfoMo.New()

			var_2_2:init(iter_2_1)

			var_2_0[tonumber(iter_2_1.id)] = var_2_2
		end
	end

	return var_2_0
end

function var_0_0._resetDotInfo(arg_3_0, arg_3_1)
	if arg_3_1.replaceAll then
		arg_3_0.infos = {}
	end

	local var_3_0 = BootNativeUtil.isIOS()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.infos) do
		if var_3_0 and ActivityEnum.IOSHideActIdMap[tonumber(iter_3_1.id)] then
			logNormal("红点更新 iOS临时屏蔽双端登录活动红点")
		elseif arg_3_0.infos[tonumber(iter_3_1.id)] then
			arg_3_0.infos[tonumber(iter_3_1.id)]:reset(iter_3_1)
		else
			local var_3_1 = RedDotInfoMo.New()

			var_3_1:init(iter_3_1)

			arg_3_0.infos[tonumber(iter_3_1.id)] = var_3_1
		end
	end

	arg_3_0.replaceAll = arg_3_1.replaceAll
end

return var_0_0
