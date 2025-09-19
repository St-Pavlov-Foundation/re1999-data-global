module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessEffectComp", package.seeall)

local var_0_0 = class("AutoChessEffectComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goEffPointU = gohelper.findChild(arg_1_1, "eff_up")
	arg_1_0.goEffPointD = gohelper.findChild(arg_1_1, "eff_down")
	arg_1_0.effectGoDic = arg_1_0:getUserDataTb_()
end

function var_0_0.playEffect(arg_2_0, arg_2_1)
	local var_2_0 = lua_auto_chess_effect.configDict[arg_2_1]

	if var_2_0 then
		if var_2_0.soundId ~= 0 then
			AudioMgr.instance:trigger(var_2_0.soundId)
		end

		local var_2_1 = AutoChessEnum.EffectPos[var_2_0.position]

		if not string.nilorempty(var_2_0.offset) then
			var_2_1 = var_2_1 - string.splitToVector2(var_2_0.offset, ",")
		end

		arg_2_0:activeEffect(var_2_0, var_2_0.nameUp, var_2_1, arg_2_0.goEffPointU)
		arg_2_0:activeEffect(var_2_0, var_2_0.nameDown, var_2_1, arg_2_0.goEffPointD)

		return var_2_0.duration
	end

	return 0
end

function var_0_0.activeEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if string.nilorempty(arg_3_2) then
		return
	end

	local var_3_0 = arg_3_0.effectGoDic[arg_3_2]

	if var_3_0 then
		gohelper.setActive(var_3_0, true)
	else
		var_3_0 = gohelper.create2d(arg_3_4, arg_3_2)

		recthelper.setAnchor(var_3_0.transform, arg_3_3.x, arg_3_3.y)

		arg_3_0.effectGoDic[arg_3_2] = var_3_0

		AutoChessEffectMgr.instance:getEffectRes(arg_3_2, var_3_0)
	end

	if arg_3_1.loop ~= 1 then
		TaskDispatcher.cancelTask(var_0_0.hideEffect, var_3_0)
		TaskDispatcher.runDelay(var_0_0.hideEffect, var_3_0, arg_3_1.duration + 0.2)
	end
end

function var_0_0.hideEffect(arg_4_0)
	gohelper.setActive(arg_4_0, false)
end

function var_0_0.removeEffect(arg_5_0, arg_5_1)
	local var_5_0 = lua_auto_chess_effect.configDict[arg_5_1]

	if var_5_0 and var_5_0.loop == 1 then
		local var_5_1 = var_5_0.nameUp

		if not string.nilorempty(var_5_1) then
			local var_5_2 = arg_5_0.effectGoDic[var_5_1]

			gohelper.setActive(var_5_2, false)
		end

		local var_5_3 = var_5_0.nameDown

		if not string.nilorempty(var_5_3) then
			local var_5_4 = arg_5_0.effectGoDic[var_5_3]

			gohelper.setActive(var_5_4, false)
		end
	end
end

function var_0_0.moveEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.effectGoDic[arg_6_1]

	arg_6_2 = recthelper.rectToRelativeAnchorPos(arg_6_2, var_6_0.transform.parent)

	if var_6_0 then
		local var_6_1 = var_6_0.transform

		recthelper.setAnchor(var_6_1, 0, 0)
		ZProj.TweenHelper.DOAnchorPos(var_6_1, arg_6_2.x, arg_6_2.y, arg_6_3, nil, nil, nil, EaseType.Linear)
	else
		logError(string.format("异常:未加载特效%s", arg_6_1))
	end
end

function var_0_0.hideAll(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.effectGoDic) do
		gohelper.setActive(iter_7_1, false)
	end
end

return var_0_0
