module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameEffectComp", package.seeall)

local var_0_0 = class("AssassinStealthGameEffectComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.effectGoDic = arg_1_0:getUserDataTb_()
	arg_1_0.showingEffDict = {}

	arg_1_0:_cancelCheckTask()
end

function var_0_0.playEffect(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	if arg_2_0.showingEffDict[arg_2_1] then
		return
	end

	local var_2_0 = arg_2_1 and arg_2_1 ~= 0 and AssassinConfig.instance:getAssassinEffectResName(arg_2_1)

	if not var_2_0 or string.nilorempty(var_2_0) then
		if arg_2_2 then
			if arg_2_3 then
				arg_2_2(arg_2_3, arg_2_4)
			else
				arg_2_2(arg_2_4)
			end
		end

		return
	end

	local var_2_1 = arg_2_0.effectGoDic[var_2_0]

	if var_2_1 then
		if not gohelper.isNil(arg_2_5) then
			var_2_1.transform:SetParent(arg_2_5.transform)
		end

		if arg_2_6 then
			transformhelper.setLocalPos(var_2_1.transform, arg_2_6.x or 0, arg_2_6.y or 0, 0)
		end

		gohelper.setActive(var_2_1, true)
	else
		local var_2_2 = gohelper.create2d(not gohelper.isNil(arg_2_5) and arg_2_5 or arg_2_0.go, var_2_0)

		if arg_2_6 then
			transformhelper.setLocalPos(var_2_2.transform, arg_2_6.x or 0, arg_2_6.y or 0, 0)
		end

		arg_2_0.effectGoDic[var_2_0] = var_2_2

		AssassinStealthGameEffectMgr.instance:getEffectRes(var_2_0, var_2_2)
	end

	local var_2_3 = AssassinConfig.instance:getAssassinEffectAudioId(arg_2_1)

	if var_2_3 and var_2_3 ~= 0 then
		AudioMgr.instance:trigger(var_2_3)
	end

	local var_2_4 = AssassinConfig.instance:getAssassinEffectDuration(arg_2_1)

	if var_2_4 and var_2_4 > 0 then
		if not string.nilorempty(arg_2_7) then
			AssassinHelper.lockScreen(arg_2_7, true)
		end

		arg_2_0._effectCheckDict[var_2_0] = {
			effectId = arg_2_1,
			startTime = Time.realtimeSinceStartup,
			duration = var_2_4,
			finishCb = arg_2_2,
			finishCbObj = arg_2_3,
			finishCbParam = arg_2_4,
			blockKey = arg_2_7
		}
	end

	arg_2_0.showingEffDict[arg_2_1] = true

	if next(arg_2_0._effectCheckDict) and not arg_2_0._checkTaskRunning then
		arg_2_0._checkTaskRunning = true

		TaskDispatcher.runRepeat(arg_2_0._checkEffectFinish, arg_2_0, 0.1)
	end
end

function var_0_0._checkEffectFinish(arg_3_0)
	if not arg_3_0._effectCheckDict or not next(arg_3_0._effectCheckDict) then
		arg_3_0:_cancelCheckTask()

		return
	end

	local var_3_0 = {}
	local var_3_1 = Time.realtimeSinceStartup

	for iter_3_0, iter_3_1 in pairs(arg_3_0._effectCheckDict) do
		if var_3_1 - iter_3_1.startTime >= iter_3_1.duration then
			var_3_0[#var_3_0 + 1] = iter_3_0
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		local var_3_2 = arg_3_0.effectGoDic[iter_3_3]

		gohelper.setActive(var_3_2, false)

		local var_3_3 = arg_3_0._effectCheckDict[iter_3_3]
		local var_3_4 = var_3_3 and var_3_3.finishCb

		if var_3_4 then
			local var_3_5 = var_3_3.finishCbObj
			local var_3_6 = var_3_3.finishCbParam

			if var_3_5 then
				var_3_4(var_3_5, var_3_6)
			else
				var_3_4(var_3_6)
			end
		end

		if not string.nilorempty(var_3_3 and var_3_3.blockKey) then
			AssassinHelper.lockScreen(var_3_3.blockKey, false)
		end

		arg_3_0.showingEffDict[var_3_3.effectId] = nil
		arg_3_0._effectCheckDict[iter_3_3] = nil
	end
end

function var_0_0._cancelCheckTask(arg_4_0)
	if arg_4_0._effectCheckDict then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._effectCheckDict) do
			if not string.nilorempty(iter_4_1.blockKey) then
				AssassinHelper.lockScreen(iter_4_1.blockKey, false)
			end
		end
	end

	arg_4_0._effectCheckDict = {}

	TaskDispatcher.cancelTask(arg_4_0._checkEffectFinish, arg_4_0)

	arg_4_0._checkTaskRunning = false
end

function var_0_0.removeEffect(arg_5_0, arg_5_1)
	if not arg_5_0.showingEffDict[arg_5_1] then
		return
	end

	local var_5_0 = AssassinConfig.instance:getAssassinEffectDuration(arg_5_1)

	if not var_5_0 or var_5_0 == 0 then
		local var_5_1 = AssassinConfig.instance:getAssassinEffectResName(arg_5_1)
		local var_5_2 = arg_5_0.effectGoDic[var_5_1]

		gohelper.setActive(var_5_2, false)

		arg_5_0.showingEffDict[arg_5_1] = nil
	end
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:_cancelCheckTask()
end

return var_0_0
