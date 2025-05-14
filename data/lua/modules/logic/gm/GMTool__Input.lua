local var_0_0 = string.format
local var_0_1 = table.insert
local var_0_2 = table.concat
local var_0_3 = _G.getGlobal
local var_0_4 = var_0_3("Partial_GMTool")
local var_0_5 = UnityEngine.Input
local var_0_6 = UnityEngine.KeyCode
local var_0_7 = SLFramework.GameObjectHelper
local var_0_8 = UnityEngine.EventSystems.EventSystem
local var_0_9 = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult
local var_0_10 = UnityEngine.EventSystems.PointerEventData
local var_0_11 = {}
local var_0_12 = "#00FF00"
local var_0_13 = "#FFFF00"
local var_0_14 = "_luaLang"
local var_0_15 = "_lang"
local var_0_16 = SLFramework.ResLogMgr.Instance

local function var_0_17(arg_1_0)
	local var_1_0 = var_0_3("GMRpc")

	if var_1_0 then
		var_1_0.instance:sendGMRequest(arg_1_0)
	end
end

local function var_0_18()
	local var_2_0 = var_0_3("LoginController")

	if var_2_0 then
		var_2_0.instance:logout()
	end
end

function var_0_11._super(arg_3_0)
	local var_3_0 = {
		"add hero all 1",
		"add material 10#10#100",
		"add material 2#5#1000000",
		"add allfaith 22222",
		"set level 60",
		"add equip 0#30#1",
		"set dungeon all"
	}

	for iter_3_0 = 1, #var_3_0 do
		var_0_17(var_3_0[iter_3_0])
	end
end

function var_0_11._showMouseClickGoName(arg_4_0)
	local var_4_0 = var_0_8.current

	if not var_4_0 or not var_4_0:IsPointerOverGameObject() then
		return
	end

	local var_4_1 = var_4_0.currentSelectedGameObject

	if gohelper.isNil(var_4_1) and var_0_3("CameraMgr") and CameraMgr.instance:getMainCamera() then
		local var_4_2 = var_0_5.mousePosition

		arg_4_0._pointerEventData = arg_4_0._pointerEventData or var_0_10.New(var_0_8.current)
		arg_4_0._pointerEventData.position = var_4_2
		arg_4_0._csList = arg_4_0._csList or var_0_9.New()

		var_4_0:RaycastAll(arg_4_0._pointerEventData, arg_4_0._csList)

		if arg_4_0._csList.Count > 0 then
			var_4_1 = arg_4_0._csList[0].gameObject
		end
	end

	if not gohelper.isNil(var_4_1) then
		logNormal(var_0_4.util.setColorDesc(var_0_7.GetPath(var_4_1), var_0_12))
	end
end

function var_0_11._getOpeningViewNameList(arg_5_0)
	local var_5_0 = ViewMgr.instance:getOpenViewNameList() or {}
	local var_5_1 = {}

	for iter_5_0 = #var_5_0, 1, -1 do
		local var_5_2 = var_5_0[iter_5_0]

		if ViewMgr.instance:getContainer(var_5_2) and not ViewHelper.instance:checkIsGlobalIgnore(var_5_2) then
			table.insert(var_5_1, var_5_2)
		end
	end

	return var_5_1
end

function var_0_11._showOpeningViewName(arg_6_0)
	local var_6_0 = arg_6_0:_getOpeningViewNameList()

	if #var_6_0 > 0 then
		local var_6_1 = {}

		table.insert(var_6_1, "GM [正在打开的UI]:")

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_2 = var_0_4.util.setColorDesc(iter_6_0, var_0_13) .. " " .. var_0_4.util.setColorDesc(iter_6_1, var_0_12)

			table.insert(var_6_1, var_6_2)
		end

		logError(var_0_2(var_6_1, "\n"))
	end
end

function var_0_11._hookLangSettings__luaLang_rawkey(arg_7_0, arg_7_1)
	return
end

function var_0_11._hookLangSettings__luaLang(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1 then
		var_8_0 = GMMinusModel.instance:loadOriginalFunc(LangSettings, var_0_14)
	else
		function var_8_0(arg_9_0, arg_9_1)
			return arg_9_1
		end
	end

	LangSettings[var_0_14] = var_8_0
end

function var_0_11._hookLangSettings__lang(arg_10_0, arg_10_1)
	local var_10_0

	if arg_10_1 then
		var_10_0 = GMMinusModel.instance:loadOriginalFunc(LangSettings, var_0_15)
	else
		function var_10_0(arg_11_0, arg_11_1)
			return arg_11_1
		end
	end

	LangSettings[var_0_15] = var_10_0
end

function var_0_11._switchLuaLang(arg_12_0)
	local var_12_0 = not arg_12_0._mlStringEnable

	arg_12_0:_hookLangSettings__luaLang(var_12_0)
	arg_12_0:_hookLangSettings__lang(var_12_0)

	arg_12_0._mlStringEnable = var_12_0
end

function var_0_11._switchResLog(arg_13_0)
	if arg_13_0._resLogEnable == nil then
		arg_13_0._resLogEnable = true
		var_0_16.Enable = true

		return
	end

	if arg_13_0._resLogEnable == true then
		local var_13_0 = SLFramework.ResLogMgr.Instance
		local var_13_1 = {}
		local var_13_2 = var_13_0:GetList()
		local var_13_3 = var_13_2.Count

		if var_13_3 > 0 then
			for iter_13_0 = 0, var_13_3 - 1 do
				local var_13_4 = var_13_2[iter_13_0]
				local var_13_5 = var_13_4.loadedTime - var_13_4.loadTime
				local var_13_6 = {
					cost = var_13_5,
					loadedTime = var_13_4.loadedTime,
					loadTime = var_13_4.loadTime,
					path = var_13_4.path,
					size = var_13_4.size,
					_id = iter_13_0
				}

				var_0_1(var_13_1, var_13_6)
			end
		end

		if #var_13_1 > 0 then
			table.sort(var_13_1, function(arg_14_0, arg_14_1)
				local var_14_0 = arg_14_0.loadTime
				local var_14_1 = arg_14_1.loadTime

				if var_14_0 ~= var_14_1 then
					return var_14_0 < var_14_1
				end

				local var_14_2 = arg_14_0.cost
				local var_14_3 = arg_14_1.cost

				if var_14_2 ~= var_14_3 then
					return var_14_3 < var_14_2
				end

				local var_14_4 = arg_14_0.size
				local var_14_5 = arg_14_1.size

				if var_14_4 ~= var_14_5 then
					return var_14_5 < var_14_4
				end

				return arg_14_0._id < arg_14_1._id
			end)
		end

		local var_13_7 = {}
		local var_13_8
		local var_13_9 = 0
		local var_13_10 = 0
		local var_13_11 = 0

		for iter_13_1, iter_13_2 in ipairs(var_13_1) do
			local var_13_12 = var_0_0("%.3fs", iter_13_2.cost)
			local var_13_13 = var_0_0("%.2f", iter_13_2.loadTime)

			if var_13_13 ~= var_13_8 then
				var_13_9 = var_13_9 + 1
				var_13_8 = var_13_13

				if iter_13_2.cost < 0 then
					return
				end

				if iter_13_2.cost < 10 then
					var_13_10 = var_13_10 + iter_13_2.cost
				end
			end

			local var_13_14 = tonumber(tostring(iter_13_2.size))
			local var_13_15 = var_0_0("%.4f MB", var_13_14 / 1024 / 1024)

			var_13_11 = var_13_11 + var_13_14

			local var_13_16 = var_0_0("%s (%s): cost=%s, size=%s, path=%s", iter_13_1, var_13_9, var_13_12, var_13_15, iter_13_2.path)

			var_0_1(var_13_7, var_13_16)
		end

		local var_13_17 = var_0_0("%.4f MB", var_13_11 / 1024 / 1024)

		var_0_1(var_13_7, 1, var_0_0("tot_cnt: %s, tot_size: %s, tot_cost: %s seconds", var_13_3, var_13_17, var_13_10))
		logError(var_0_2(var_13_7, "\n"))
	end

	arg_13_0._resLogEnable = not arg_13_0._resLogEnable
	var_0_16.Enable = arg_13_0._resLogEnable
end

function var_0_11.onClear(arg_15_0)
	arg_15_0._pointerEventData = nil
	arg_15_0._csList = nil
	arg_15_0._resLogEnable = nil

	if arg_15_0._mlStringEnable == false then
		arg_15_0:_switchLuaLang()
	else
		GMMinusModel.instance:saveOriginalFunc(LangSettings, var_0_14)
		GMMinusModel.instance:saveOriginalFunc(LangSettings, var_0_15)
	end

	arg_15_0._mlStringEnable = true
	var_0_16.Enable = false

	return arg_15_0
end

function var_0_11.onUpdate(arg_16_0)
	local var_16_0 = var_0_5.GetKey(var_0_6.LeftAlt)
	local var_16_1 = var_0_5.GetKey(var_0_6.RightAlt)
	local var_16_2 = var_16_0 or var_16_1
	local var_16_3 = var_0_5.GetKey(var_0_6.LeftShift)
	local var_16_4 = var_0_5.GetKey(var_0_6.RightShift)
	local var_16_5

	var_16_5 = var_16_3 or var_16_4

	local var_16_6 = var_0_5.GetKey(var_0_6.LeftControl)
	local var_16_7 = var_0_5.GetKey(var_0_6.RightControl)
	local var_16_8 = var_16_6 or var_16_7

	if var_0_5.GetKeyDown(var_0_6.F12) then
		logNormal("F12 logout")
		var_0_18()
	elseif var_16_8 and var_16_2 and var_0_5.GetKeyDown(var_0_6.Alpha4) then
		logNormal("Ctrl + Alt + 4 super")
		arg_16_0:_super()
	elseif var_16_8 and var_0_5.GetMouseButtonUp(0) then
		logNormal("Ctrl + Left Mouse Click")
		arg_16_0:_showMouseClickGoName()
	elseif var_16_8 and var_16_2 and var_0_5.GetKeyDown(var_0_6.Alpha1) then
		logNormal("Ctrl + Alt + 1")
		arg_16_0:_switchLuaLang()
	elseif var_16_8 and var_16_2 and var_0_5.GetKeyDown(var_0_6.Alpha2) then
		logNormal("Ctrl + Alt + 2")
		arg_16_0:_showOpeningViewName()
	elseif var_16_8 and var_16_2 and var_0_5.GetKeyDown(var_0_6.Alpha3) then
		logNormal("Ctrl + Alt + 3")
		arg_16_0:_switchResLog()
	end
end

var_0_4._input = var_0_11:onClear()

return {}
