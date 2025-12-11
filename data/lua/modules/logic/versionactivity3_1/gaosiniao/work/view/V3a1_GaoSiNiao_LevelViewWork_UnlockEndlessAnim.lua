module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim", V3a1_GaoSiNiao_LevelViewFlow_WorkBase)

function var_0_0.s_create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	if arg_1_0 or arg_1_1 then
		var_1_0._viewObj = arg_1_0
		var_1_0._viewContainer = arg_1_1
	else
		local var_1_1 = ViewName.V3a1_GaoSiNiao_LevelView
		local var_1_2 = ViewMgr.instance:getContainer(var_1_1)

		if not var_1_2 then
			return nil
		end

		var_1_0._viewContainer = var_1_2
		var_1_0._viewObj = var_1_2:mainView()
	end

	if not var_1_0._viewObj then
		return nil
	end

	return var_1_0
end

function var_0_0.viewObj(arg_2_0)
	if arg_2_0._viewObj then
		return arg_2_0._viewObj
	end

	return var_0_0.super.viewObj(arg_2_0)
end

function var_0_0.baseViewContainer(arg_3_0)
	if arg_3_0._viewContainer then
		return arg_3_0._viewContainer
	end

	return var_0_0.super.baseViewContainer(arg_3_0)
end

function var_0_0.onStart(arg_4_0)
	arg_4_0:clearWork()

	local var_4_0 = arg_4_0:viewObj()

	if not var_4_0 then
		arg_4_0:onFail()

		return
	end

	if not arg_4_0:isSpEpisodeOpen() then
		arg_4_0:onSucc()

		return
	end

	if arg_4_0:hasPlayedUnlockedEndless() then
		var_4_0:playAnim_EndlessIdle()
		arg_4_0:onSucc()

		return
	end

	var_4_0:playAnim_EndlessUnlock(arg_4_0._onAnimDone, arg_4_0)
end

function var_0_0._onAnimDone(arg_5_0)
	arg_5_0:saveHasPlayedUnlockedEndless()
	arg_5_0:onSucc()
end

function var_0_0.clearWork(arg_6_0)
	arg_6_0._viewObj = nil
	arg_6_0._viewContainer = nil
	arg_6_0._needWaitCount = 0

	var_0_0.super.clearWork(arg_6_0)
end

return var_0_0
