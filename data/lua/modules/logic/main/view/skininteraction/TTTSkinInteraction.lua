module("modules.logic.main.view.skininteraction.TTTSkinInteraction", package.seeall)

local var_0_0 = class("TTTSkinInteraction", BaseSkinInteraction)

function var_0_0._onInit(arg_1_0)
	arg_1_0._tvOff = false
	arg_1_0._closeEffectList = nil
end

function var_0_0.isPlayingVoice(arg_2_0)
	return arg_2_0._tvOff
end

function var_0_0.onCloseFullView(arg_3_0)
	arg_3_0:_openTv()
end

function var_0_0._onClick(arg_4_0, arg_4_1)
	if not arg_4_0:_checkPosInBound(arg_4_1) then
		return
	end

	arg_4_0._lightSpine = arg_4_0._view._lightSpine

	local var_4_0 = CommonConfig.instance:getConstNum(ConstEnum.TTTCloseTv) / 100

	if not arg_4_0._tvOff and var_4_0 > math.random() then
		local var_4_1 = arg_4_0._lightSpine:getSpineGo()

		arg_4_0._tvOff = true

		TaskDispatcher.cancelTask(arg_4_0._hideCloseEffects, arg_4_0)

		arg_4_0._closeEffectList = arg_4_0._closeEffectList or arg_4_0._view:getUserDataTb_()

		local var_4_2 = gohelper.findChild(var_4_1, "mountroot").transform
		local var_4_3 = var_4_2.childCount

		for iter_4_0 = 1, var_4_3 do
			local var_4_4 = var_4_2:GetChild(iter_4_0 - 1)

			for iter_4_1 = 1, var_4_4.childCount do
				local var_4_5 = var_4_4:GetChild(iter_4_1 - 1)

				if string.find(var_4_5.name, "close") then
					gohelper.setActive(var_4_5.gameObject, true)

					arg_4_0._closeEffectList[iter_4_0] = var_4_5.gameObject
				else
					gohelper.setActive(var_4_5.gameObject, false)
				end
			end
		end

		if arg_4_0._lightSpine then
			arg_4_0._lightSpine:stopVoice()
		end

		return
	end

	if arg_4_0:_openTv() then
		return
	end

	arg_4_0:_clickDefault(arg_4_1)
end

function var_0_0._openTv(arg_5_0)
	if arg_5_0._tvOff then
		arg_5_0._tvOff = false

		local var_5_0 = arg_5_0._lightSpine:getSpineGo()

		TaskDispatcher.cancelTask(arg_5_0._hideCloseEffects, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._hideCloseEffects, arg_5_0, 0.2)

		local var_5_1 = gohelper.findChild(var_5_0, "mountroot").transform
		local var_5_2 = var_5_1.childCount

		for iter_5_0 = 1, var_5_2 do
			local var_5_3 = var_5_1:GetChild(iter_5_0 - 1)

			for iter_5_1 = 1, var_5_3.childCount do
				local var_5_4 = var_5_3:GetChild(iter_5_1 - 1)

				if not string.find(var_5_4.name, "close") then
					gohelper.setActive(var_5_4.gameObject, true)
				end
			end
		end

		return true
	end
end

function var_0_0._hideCloseEffects(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._closeEffectList) do
		gohelper.setActive(iter_6_1, false)
	end
end

function var_0_0._onDestroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._hideCloseEffects, arg_7_0)

	arg_7_0._closeEffectList = nil
	arg_7_0._lightSpine = nil
end

return var_0_0
