module("modules.ugui.uieffect.UIEffectManager", package.seeall)

local var_0_0 = class("UIEffectManager")

function var_0_0.ctor(arg_1_0)
	arg_1_0._effectDic = {}
end

function var_0_0.addEffect(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	if gohelper.isNil(arg_2_1) then
		return
	end

	arg_2_0._loadcallback = arg_2_7
	arg_2_0._callbackTarget = arg_2_8

	if not arg_2_3 or not arg_2_4 then
		logError(string.format("addEffect rt size error rtWidth:%s,rtHeight:%s", arg_2_3, arg_2_4))

		return
	end

	local var_2_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_1, UIEffectUnit)

	if var_2_0 then
		var_2_0:Refresh(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	end

	AudioEffectMgr.instance:playAudioByEffectPath(arg_2_2)
end

function var_0_0._getEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_0._effectDic[arg_3_1] then
		arg_3_0._effectDic[arg_3_1] = {}
	end

	local var_3_0 = string.format("%s_%s", arg_3_2, arg_3_3)
	local var_3_1 = arg_3_0._effectDic[arg_3_1][var_3_0]

	if not var_3_1 then
		var_3_1 = UIEffectLoader.New()

		var_3_1:Init(arg_3_1, arg_3_2, arg_3_3)

		arg_3_0._effectDic[arg_3_1][var_3_0] = var_3_1
	end

	var_3_1:getEffect(arg_3_4, arg_3_0._loadcallback, arg_3_0._callbackTarget)
end

function var_0_0.getEffectGo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0._effectDic[arg_4_1] then
		return
	end

	local var_4_0 = string.format("%s_%s", arg_4_2, arg_4_3)

	return arg_4_0._effectDic[arg_4_1][var_4_0]:getEffectGo()
end

function var_0_0._putEffect(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0._effectDic[arg_5_1] then
		return
	end

	local var_5_0 = string.format("%s_%s", arg_5_2, arg_5_3)
	local var_5_1 = arg_5_0._effectDic[arg_5_1][var_5_0]

	if var_5_1 then
		var_5_1:ReduceRef()
	end
end

function var_0_0._delEffectLoader(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0._effectDic[arg_6_1] then
		return
	end

	local var_6_0 = string.format("%s_%s", arg_6_2, arg_6_3)

	arg_6_0._effectDic[arg_6_1][var_6_0] = nil
end

function var_0_0.getUIEffect(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 then
		return nil
	end

	if arg_7_1:GetComponent(typeof(TMPro.TextMeshProUGUI)) then
		logError("TextMeshPro 不能和 UIEffect 一起使用")

		return nil
	end

	return gohelper.onceAddComponent(arg_7_1, arg_7_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
