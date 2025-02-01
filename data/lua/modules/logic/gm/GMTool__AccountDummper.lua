slot2 = string.format
slot3 = table.insert
slot4 = table.concat
slot5 = UnityEngine.Input
slot6 = UnityEngine.KeyCode
slot7 = _G.Time

function slot9()
	slot0 = ""

	if SLFramework.FrameworkSettings.IsEditor then
		slot0 = "UnityEditor"
	elseif BootNativeUtil.isAndroid() then
		slot0 = "Android"
	elseif BootNativeUtil.isIOS() then
		slot0 = "iOS"
	elseif BootNativeUtil.isWindows() then
		slot0 = "Windows"
	elseif BootNativeUtil.isMacOS() then
		slot0 = "Mac OS"
	end

	return slot0
end

function slot10()
	slot0 = ServerTime.now()
	slot2 = os.date("!*t", slot0 + ServerTime.serverUtcOffset())

	return uv0("(%s) %04d-%02d-%02d %02d:%02d:%02d (%s)", slot0, slot2.year, slot2.month, slot2.day, slot2.hour, slot2.min, slot2.sec, ServerTime.GetUTCOffsetStr())
end

function slot11()
	slot0 = os.time()

	return uv0("(%s) %s (%s)", slot0, os.date("%Y-%m-%d %H:%M:%S", slot0), uv0("UTC%+d", os.difftime(os.time(), os.time(os.date("!*t", os.time()))) / 3600))
end

slot12 = 2
slot13 = 0.25
slot14 = "#FFFF00"
slot15 = "#00FF00"
slot16 = "#FFFFFF"
_G.getGlobal("Partial_GMTool")._accountDummper = ({
	onClear = function (slot0)
		slot0._unscaledTime = 0
		slot0._keyCodeDownCount = 0

		return slot0
	end,
	onUpdate = function (slot0)
		if uv1.GetKeyDown(uv2.LeftControl) then
			if slot0._unscaledTime - uv0.unscaledDeltaTime < uv3 then
				slot0._keyCodeDownCount = slot0._keyCodeDownCount + 1
			end

			if uv4 <= slot0._keyCodeDownCount then
				slot0:onClear()
				slot0:_work()

				return
			end

			if not slot3 then
				slot0:onClear()

				slot0._keyCodeDownCount = 1
			end
		end

		slot0._unscaledTime = slot0._unscaledTime + slot1
	end,
	_work = function (slot0)
		slot1 = uv0("PlayerModel") and PlayerModel.instance:getPlayinfo() or {}
		slot13 = {}

		uv6(slot13, "=============== Player Info ================")
		uv6(slot13, "account: " .. uv1.util.setColorDesc(LoginModel.instance.channelUserId, uv2))
		uv6(slot13, "uid/userId/playerId/roleId: " .. uv1.util.setColorDesc(slot1.userId, uv2))
		uv6(slot13, "serverName: " .. uv1.util.setColorDesc(LoginModel.instance.serverName, uv2))
		uv6(slot13, "serverId: " .. uv1.util.setColorDesc(LoginModel.instance.serverId, uv2))
		uv6(slot13, "userName: " .. uv1.util.setColorDesc(slot1.userName, uv2))
		uv6(slot13, "platform: " .. uv1.util.setColorDesc(uv3(), uv2))
		uv6(slot13, "curLanguage: " .. uv1.util.setColorDesc(LangSettings.instance:getCurLangShortcut(), uv2))
		uv6(slot13, "curRegion: " .. uv1.util.setColorDesc(SettingsModel.instance:getRegionShortcut(), uv2))
		uv6(slot13, "serverTime: " .. uv1.util.setColorDesc(uv4(), uv2))
		uv6(slot13, "clientTime: " .. uv1.util.setColorDesc(uv5(), uv2))

		for slot17, slot18 in ipairs(uv1._input:_getOpeningViewNameList() or {}) do
			if slot17 == 1 then
				uv6(slot13, "dump view infos ========================= Begin")
			end

			slot19 = ViewMgr.instance:getSetting(slot18)
			slot20 = uv1.util.setColorDesc(slot18 or "<Unknown>", uv2)
			slot21 = uv1.util.setColorDesc(slot19 and slot19.mainRes or "None", uv7)
			slot22 = "[" .. tostring(slot17) .. "]"

			if slot17 == 1 then
				slot22 = uv1.util.setColorDesc(slot22, uv8) or slot22
			end

			uv6(slot13, "\t" .. slot22 .. " " .. slot20 .. ": " .. slot21)

			if slot17 == #slot12 then
				uv6(slot13, "dump view infos ========================= End")
			end
		end

		slot14 = uv9(slot13, "\n")

		logError(slot14)
		uv1.util.saveClipboard(slot14:gsub("%b<>", ""))
	end
}):onClear()

return {}
