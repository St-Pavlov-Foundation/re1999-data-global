module("modules.logic.survival.view.map.comp.SurvivalFlashTxtComp", package.seeall)

local var_0_0 = class("SurvivalFlashTxtComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txt = gohelper.findChildTextMesh(arg_1_1, "")
end

function var_0_0.setNormalTxt(arg_2_0, arg_2_1)
	arg_2_0._normalTxt = arg_2_1

	if not arg_2_0._flashTxt then
		arg_2_0._txt.text = arg_2_1
	end
end

function var_0_0.setFlashTxt(arg_3_0, arg_3_1)
	arg_3_0._flashTxt = arg_3_1

	if arg_3_1 then
		if arg_3_0.isShowFlashTxt then
			arg_3_0._txt.text = arg_3_0._flashTxt
		end

		TaskDispatcher.runRepeat(arg_3_0._autoFlashTxt, arg_3_0, 2)
	else
		TaskDispatcher.cancelTask(arg_3_0._autoFlashTxt, arg_3_0)
		TaskDispatcher.cancelTask(arg_3_0._autoFlashTxt2, arg_3_0)
		ZProj.TweenHelper.KillByObj(arg_3_0._txt)

		local var_3_0 = arg_3_0._txt.color

		var_3_0.a = 1
		arg_3_0._txt.color = var_3_0
		arg_3_0.isShowFlashTxt = false
		arg_3_0._txt.text = arg_3_0._normalTxt
	end
end

function var_0_0._autoFlashTxt(arg_4_0)
	if not arg_4_0._txt then
		TaskDispatcher.cancelTask(arg_4_0._autoFlashTxt, arg_4_0)

		return
	end

	ZProj.TweenHelper.DoFade(arg_4_0._txt, 1, 0, 0.4)
	TaskDispatcher.runDelay(arg_4_0._autoFlashTxt2, arg_4_0, 0.4)
end

function var_0_0._autoFlashTxt2(arg_5_0)
	if not arg_5_0._txt then
		return
	end

	arg_5_0.isShowFlashTxt = not arg_5_0.isShowFlashTxt

	if arg_5_0.isShowFlashTxt then
		arg_5_0._txt.text = arg_5_0._flashTxt
	else
		arg_5_0._txt.text = arg_5_0._normalTxt
	end

	ZProj.TweenHelper.DoFade(arg_5_0._txt, 0, 1, 0.4)
end

function var_0_0.onDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._autoFlashTxt, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._autoFlashTxt2, arg_6_0)
	ZProj.TweenHelper.KillByObj(arg_6_0._txt)
end

return var_0_0
