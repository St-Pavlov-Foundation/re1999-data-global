module("modules.logic.gm.model.GMMinusModel", package.seeall)

local var_0_0 = class("GMMinusModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._firstLoginDataDict = {}
end

function var_0_0.setFirstLogin(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._firstLoginDataDict[arg_3_1] = arg_3_2
end

function var_0_0.getFirstLogin(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._firstLoginDataDict[arg_4_1]

	return var_4_0 == nil and arg_4_2 or var_4_0
end

local var_0_1 = {}
local var_0_2 = {}

function var_0_0.setConst(arg_5_0, arg_5_1, arg_5_2)
	if var_0_1[arg_5_1] then
		return
	end

	var_0_1[arg_5_1] = true
	var_0_2[arg_5_1] = arg_5_2
end

function var_0_0.getConst(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_1[arg_6_1] then
		return arg_6_2
	end

	return var_0_2[arg_6_1]
end

function var_0_0.setToPlayer(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = PlayerModel.instance:getMyUserId()

	if not var_7_0 or var_7_0 == 0 then
		return
	end

	local var_7_1 = arg_7_1 .. "#" .. tostring(var_7_0)

	arg_7_0:setToUnity(var_7_1, arg_7_2)
end

function var_0_0.getFromPlayer(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = PlayerModel.instance:getMyUserId()

	if not var_8_0 or var_8_0 == 0 then
		return arg_8_2
	end

	local var_8_1 = arg_8_1 .. "#" .. tostring(var_8_0)

	return arg_8_0:getFromUnity(var_8_1, arg_8_2)
end

function var_0_0.setToUnity(arg_9_0, arg_9_1, arg_9_2)
	PlayerPrefsHelper._set(arg_9_1, arg_9_2)
end

function var_0_0.getFromUnity(arg_10_0, arg_10_1, arg_10_2)
	assert(arg_10_2 ~= nil)

	local var_10_0 = type(arg_10_2) == "number"

	return PlayerPrefsHelper._get(arg_10_1, arg_10_2, var_10_0)
end

function var_0_0.addBtnGM(arg_11_0, arg_11_1)
	local var_11_0 = GMController.instance:getGMNode("mainview", arg_11_1.viewGO)

	arg_11_1._btngm11235 = gohelper.findChildButtonWithAudio(var_11_0, "#btn_gm")

	return arg_11_1._btngm11235
end

local function var_0_3(arg_12_0)
	local var_12_0 = arg_12_0.class.__cname
	local var_12_1 = "GM_" .. var_12_0

	assert(ViewName[var_12_1], "please add customFunc when call btnGM_AddClickListener!!viewName not found: " .. var_12_1)
	ViewMgr.instance:openView(var_12_1)
end

function var_0_0.btnGM_AddClickListener(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1._btngm11235:AddClickListener(arg_13_2 or var_0_3, arg_13_1)
end

function var_0_0.btnGM_RemoveClickListener(arg_14_0, arg_14_1)
	arg_14_1._btngm11235:RemoveClickListener()
end

local var_0_4 = 20

local function var_0_5(arg_15_0, arg_15_1)
	return string.format("GM_%s_%s", arg_15_0.__cname, arg_15_1)
end

function var_0_0.saveOriginalFunc(arg_16_0, arg_16_1, arg_16_2)
	assert(type(arg_16_2) == "string")

	local var_16_0 = arg_16_1[arg_16_2]

	if var_16_0 == nil then
		local var_16_1 = arg_16_1
		local var_16_2 = var_0_4

		while var_16_1.super and var_16_0 == nil do
			if var_16_2 <= 0 then
				logError("stack overflow >= " .. tostring(var_0_4))

				break
			end

			var_16_0 = var_16_1[arg_16_2]
			var_16_1 = var_16_1.super
			var_16_2 = var_16_2 - 1
		end
	end

	assert(type(var_16_0) == "function", "type(func)=" .. type(var_16_0) .. " funcName=" .. arg_16_2)

	local var_16_3 = var_0_5(arg_16_1, arg_16_2)

	arg_16_0:setConst(var_16_3, var_16_0)
end

function var_0_0.loadOriginalFunc(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = var_0_5(arg_17_1, arg_17_2)
	local var_17_1 = arg_17_0:getConst(var_17_0, nil)

	if not var_17_1 then
		local var_17_2 = arg_17_1.super
		local var_17_3 = var_0_4

		while var_17_2 and var_17_1 == nil do
			if var_17_3 <= 0 then
				logError("stack overflow >= " .. tostring(var_0_4))

				break
			end

			local var_17_4 = var_0_5(var_17_2, arg_17_2)

			var_17_1 = arg_17_0:getConst(var_17_4, nil)
			var_17_1 = var_17_1 or var_17_2[arg_17_2]
			var_17_2 = var_17_2.super
			var_17_3 = var_17_3 - 1
		end
	end

	return var_17_1 or function()
		assert(false, string.format("undefine behaviour: '%s:%s'", arg_17_1.__cname, arg_17_2))
	end
end

function var_0_0.callOriginalSelfFunc(arg_19_0, arg_19_1, arg_19_2, ...)
	local var_19_0 = arg_19_1.class

	return arg_19_0:loadOriginalFunc(var_19_0, arg_19_2)(arg_19_1, ...)
end

function var_0_0.callOriginalStaticFunc(arg_20_0, arg_20_1, arg_20_2, ...)
	return arg_20_0:loadOriginalFunc(arg_20_1, arg_20_2)(...)
end

var_0_0.instance = var_0_0.New()

return var_0_0
