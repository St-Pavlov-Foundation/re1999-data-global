local var_0_0 = _G.getGlobal
local var_0_1 = var_0_0("Partial_GMTool")
local var_0_2 = string.format
local var_0_3 = table.insert
local var_0_4 = table.concat
local var_0_5 = UnityEngine.Input
local var_0_6 = UnityEngine.KeyCode
local var_0_7 = _G.Time
local var_0_8 = {}

local function var_0_9()
	local var_1_0 = ""

	if SLFramework.FrameworkSettings.IsEditor then
		var_1_0 = "UnityEditor"
	elseif BootNativeUtil.isAndroid() then
		var_1_0 = "Android"
	elseif BootNativeUtil.isIOS() then
		var_1_0 = "iOS"
	elseif BootNativeUtil.isWindows() then
		var_1_0 = "Windows"
	elseif BootNativeUtil.isMacOS() then
		var_1_0 = "Mac OS"
	end

	return var_1_0
end

local function var_0_10()
	local var_2_0 = ServerTime.now()
	local var_2_1 = ServerTime.GetUTCOffsetStr()
	local var_2_2 = os.date("!*t", var_2_0 + ServerTime.serverUtcOffset())

	return (var_0_2("(%s) %04d-%02d-%02d %02d:%02d:%02d (%s)", var_2_0, var_2_2.year, var_2_2.month, var_2_2.day, var_2_2.hour, var_2_2.min, var_2_2.sec, var_2_1))
end

local function var_0_11()
	local var_3_0 = os.time()
	local var_3_1 = os.date("!*t", os.time())
	local var_3_2 = os.difftime(os.time(), os.time(var_3_1))
	local var_3_3 = var_0_2("UTC%+d", var_3_2 / 3600)

	return (var_0_2("(%s) %s (%s)", var_3_0, os.date("%Y-%m-%d %H:%M:%S", var_3_0), var_3_3))
end

function var_0_8.onClear(arg_4_0)
	arg_4_0._unscaledTime = 0
	arg_4_0._keyCodeDownCount = 0

	return arg_4_0
end

local var_0_12 = 2
local var_0_13 = 0.25

function var_0_8.onUpdate(arg_5_0)
	local var_5_0 = var_0_7.unscaledDeltaTime

	if var_0_5.GetKeyDown(var_0_6.LeftControl) then
		local var_5_1 = arg_5_0._unscaledTime - var_5_0 < var_0_13

		if var_5_1 then
			arg_5_0._keyCodeDownCount = arg_5_0._keyCodeDownCount + 1
		end

		if arg_5_0._keyCodeDownCount >= var_0_12 then
			arg_5_0:onClear()
			arg_5_0:_work()

			return
		end

		if not var_5_1 then
			arg_5_0:onClear()

			arg_5_0._keyCodeDownCount = 1
		end
	end

	arg_5_0._unscaledTime = arg_5_0._unscaledTime + var_5_0
end

local var_0_14 = "#FFFF00"
local var_0_15 = "#00FF00"
local var_0_16 = "#FFFFFF"

function var_0_8._work(arg_6_0)
	local var_6_0 = var_0_0("PlayerModel") and PlayerModel.instance:getPlayinfo() or {}
	local var_6_1 = var_0_1.util.setColorDesc(LoginModel.instance.channelUserId, var_0_14)
	local var_6_2 = var_0_1.util.setColorDesc(var_6_0.userId, var_0_14)
	local var_6_3 = var_0_1.util.setColorDesc(var_6_0.userName, var_0_14)
	local var_6_4 = var_0_1.util.setColorDesc(LoginModel.instance.serverName, var_0_14)
	local var_6_5 = var_0_1.util.setColorDesc(LoginModel.instance.serverId, var_0_14)
	local var_6_6 = var_0_1.util.setColorDesc(var_0_9(), var_0_14)
	local var_6_7 = var_0_1.util.setColorDesc(LangSettings.instance:getCurLangShortcut(), var_0_14)
	local var_6_8 = var_0_1.util.setColorDesc(SettingsModel.instance:getRegionShortcut(), var_0_14)
	local var_6_9 = var_0_1.util.setColorDesc(var_0_10(), var_0_14)
	local var_6_10 = var_0_1.util.setColorDesc(var_0_11(), var_0_14)
	local var_6_11 = var_0_1._input:_getOpeningViewNameList()
	local var_6_12 = {}

	var_0_3(var_6_12, "=============== Player Info ================")
	var_0_3(var_6_12, "account: " .. var_6_1)
	var_0_3(var_6_12, "uid/userId/playerId/roleId: " .. var_6_2)
	var_0_3(var_6_12, "serverName: " .. var_6_4)
	var_0_3(var_6_12, "serverId: " .. var_6_5)
	var_0_3(var_6_12, "userName: " .. var_6_3)
	var_0_3(var_6_12, "platform: " .. var_6_6)
	var_0_3(var_6_12, "curLanguage: " .. var_6_7)
	var_0_3(var_6_12, "curRegion: " .. var_6_8)
	var_0_3(var_6_12, "serverTime: " .. var_6_9)
	var_0_3(var_6_12, "clientTime: " .. var_6_10)

	for iter_6_0, iter_6_1 in ipairs(var_6_11 or {}) do
		if iter_6_0 == 1 then
			var_0_3(var_6_12, "dump view infos ========================= Begin")
		end

		local var_6_13 = ViewMgr.instance:getSetting(iter_6_1)
		local var_6_14 = var_0_1.util.setColorDesc(iter_6_1 or "<Unknown>", var_0_14)
		local var_6_15 = var_0_1.util.setColorDesc(var_6_13 and var_6_13.mainRes or "None", var_0_15)
		local var_6_16 = "[" .. tostring(iter_6_0) .. "]"

		var_6_16 = iter_6_0 == 1 and var_0_1.util.setColorDesc(var_6_16, var_0_16) or var_6_16

		var_0_3(var_6_12, "\t" .. var_6_16 .. " " .. var_6_14 .. ": " .. var_6_15)

		if iter_6_0 == #var_6_11 then
			var_0_3(var_6_12, "dump view infos ========================= End")
		end
	end

	local var_6_17 = var_0_4(var_6_12, "\n")

	logError(var_6_17)
	var_0_1.util.saveClipboard(var_6_17:gsub("%b<>", ""))
end

var_0_1._accountDummper = var_0_8:onClear()

return {}
