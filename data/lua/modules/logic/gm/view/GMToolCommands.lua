local var_0_0 = {}
local var_0_1 = false
local var_0_2 = ""
local var_0_3 = {
	"boxlang",
	"showui"
}

function var_0_0._callByPerfix(arg_1_0, arg_1_1)
	if not var_0_2:find(arg_1_0) then
		return
	end

	local var_1_0 = tostring(arg_1_1:sub(#arg_1_0 + 1))
	local var_1_1 = string.trim(var_1_0)

	var_0_0[arg_1_0](var_1_1)
end

function var_0_0.sendGM(arg_2_0)
	arg_2_0 = string.trim(arg_2_0)

	if string.nilorempty(arg_2_0) then
		return
	end

	GMCommandHistoryModel.instance:addCommandHistory(arg_2_0)

	var_0_1 = false
	var_0_2 = string.lower(arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(var_0_3) do
		var_0_0._callByPerfix(iter_2_1, arg_2_0)

		if var_0_1 then
			break
		end
	end

	return var_0_1
end

function var_0_0.boxlang(arg_3_0)
	local var_3_0 = string.split(arg_3_0, " ")
	local var_3_1 = ""
	local var_3_2 = ""

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if not string.nilorempty(iter_3_1) then
			local var_3_3

			if iter_3_1:find("language_") then
				var_3_3 = LangConfig.instance:getLangTxt(nil, iter_3_1)
			else
				var_3_3 = luaLang(iter_3_1)
			end

			if var_3_1 ~= "" then
				var_3_1 = var_3_1 .. "\n"
			end

			if var_3_2 ~= "" then
				var_3_2 = var_3_2 .. "\n"
			end

			var_3_1 = var_3_1 .. var_3_3
			var_3_2 = var_3_2 .. string.format("%s\n\t%s", iter_3_1, var_3_3)
		end
	end

	if not string.nilorempty(var_3_1) then
		var_3_2 = "\n" .. var_3_2

		MessageBoxController.instance:showMsgBoxByStr(var_3_1, MsgBoxEnum.BoxType.Yes, function()
			logNormal(var_3_2)
		end, nil)

		var_0_1 = true
	end
end

local function var_0_4(arg_5_0)
	function SettingsModel.initResolutionRationDataList(arg_6_0)
		SettingsModel.instance:initRateAndSystemSize()

		local var_6_0 = arg_5_0.skipIndex

		arg_6_0._resolutionRatioDataList = {}

		local var_6_1 = UnityEngine.Screen.currentResolution.width

		if arg_6_0._resolutionRatioDataList and #arg_6_0._resolutionRatioDataList >= 1 and arg_6_0._resolutionRatioDataList[1] == var_6_1 then
			return
		end

		local var_6_2 = math.floor(var_6_1 / arg_6_0._curRate)

		arg_6_0:_appendResolutionData(var_6_1, var_6_2, true)

		for iter_6_0, iter_6_1 in ipairs(SettingsModel.ResolutionRatioWidthList) do
			if var_6_0 < iter_6_0 then
				local var_6_3 = math.floor(iter_6_1 / arg_6_0._curRate)

				arg_6_0:_appendResolutionData(iter_6_1, var_6_3, false)
			end
		end

		local var_6_4, var_6_5 = arg_6_0:getCurrentDropDownIndex()

		if var_6_5 then
			local var_6_6, var_6_7, var_6_8 = arg_6_0:getCurrentResolutionWHAndIsFull()

			arg_6_0:_appendResolutionData(var_6_6, var_6_7, var_6_8)
		end
	end
end

local function var_0_5()
	function SettingsGraphicsView._editableInitView(arg_8_0)
		arg_8_0:_refreshDropdownList()
		gohelper.setActive(arg_8_0._drop.gameObject, true)
		gohelper.setActive(arg_8_0._goscreen.gameObject, true)
		gohelper.setActive(arg_8_0._goenergy.gameObject, false)

		if SDKNativeUtil.isShowShareButton() then
			gohelper.setActive(arg_8_0._goscreenshot, true)
		else
			gohelper.setActive(arg_8_0._goscreenshot, false)
		end

		gohelper.addUIClickAudio(arg_8_0._btnframerateswitch.gameObject, AudioEnum.UI.UI_Mission_switch)
	end
end

function var_0_0.showui(arg_9_0)
	local var_9_0 = false
	local var_9_1 = string.split(arg_9_0, " ")
	local var_9_2 = var_9_1[1]

	if not var_9_2 then
		return
	end

	local var_9_3 = ViewName[var_9_2]

	if not var_9_3 then
		logNormal("no define ViewName." .. var_9_2)

		return
	end

	local var_9_4

	if var_9_3 == ViewName.SettingsPCSystemView or var_9_3 == ViewName.SettingsView then
		local var_9_5 = var_9_1[2]
		local var_9_6 = 0

		if var_9_5 then
			local var_9_7 = string.lower(var_9_5)

			if var_9_7 == "8k" then
				var_9_6 = 1
			elseif var_9_7 == "4k" then
				var_9_6 = 2
			elseif var_9_7 == "2k" then
				var_9_6 = 3
			elseif var_9_7 == "1k" then
				var_9_6 = 4
			else
				logNormal("not support " .. var_9_7)
			end
		end

		local var_9_8 = {
			skipIndex = var_9_6
		}

		var_0_4(var_9_8)

		function SettingsModel.setResolutionRatio()
			return
		end
	end

	if var_9_3 == ViewName.SettingsView then
		var_9_0 = true

		function BootNativeUtil.isWindows()
			return true
		end

		var_0_5()
		SettingsController.instance:openView()
	end

	if not var_9_0 then
		ViewMgr.instance:openView(var_9_3, var_9_4)
	end

	var_0_1 = true
end

require("modules/logic/gm/GMTool")

return var_0_0
