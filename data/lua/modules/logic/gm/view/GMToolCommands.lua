slot1 = false
slot2 = ""
slot3 = {
	"boxlang",
	"showui"
}

function slot4(slot0)
	function SettingsModel.initResolutionRationDataList(slot0)
		SettingsModel.instance:initRateAndSystemSize()

		slot1 = uv0.skipIndex
		slot0._resolutionRatioDataList = {}
		slot3 = UnityEngine.Screen.currentResolution.width

		if slot0._resolutionRatioDataList and #slot0._resolutionRatioDataList >= 1 and slot0._resolutionRatioDataList[1] == slot3 then
			return
		end

		slot8 = math.floor(slot3 / slot0._curRate)
		slot9 = true

		slot0:_appendResolutionData(slot3, slot8, slot9)

		for slot8, slot9 in ipairs(SettingsModel.ResolutionRatioWidthList) do
			if slot1 < slot8 then
				slot0:_appendResolutionData(slot9, math.floor(slot9 / slot0._curRate), false)
			end
		end

		slot5, slot6 = slot0:getCurrentDropDownIndex()

		if slot6 then
			slot7, slot8, slot9 = slot0:getCurrentResolutionWHAndIsFull()

			slot0:_appendResolutionData(slot7, slot8, slot9)
		end
	end
end

function slot5()
	function SettingsGraphicsView._editableInitView(slot0)
		slot0:_refreshDropdownList()
		gohelper.setActive(slot0._drop.gameObject, true)
		gohelper.setActive(slot0._goscreen.gameObject, true)
		gohelper.setActive(slot0._goenergy.gameObject, false)

		if SDKNativeUtil.isShowShareButton() then
			gohelper.setActive(slot0._goscreenshot, true)
		else
			gohelper.setActive(slot0._goscreenshot, false)
		end

		gohelper.addUIClickAudio(slot0._btnframerateswitch.gameObject, AudioEnum.UI.UI_Mission_switch)
	end
end

require("modules/logic/gm/GMTool")

return {
	_callByPerfix = function (slot0, slot1)
		if not uv0:find(slot0) then
			return
		end

		uv1[slot0](string.trim(tostring(slot1:sub(#slot0 + 1))))
	end,
	sendGM = function (slot0)
		if string.nilorempty(string.trim(slot0)) then
			return
		end

		uv0 = false
		uv1 = string.lower(slot0)

		for slot4, slot5 in ipairs(uv2) do
			uv3._callByPerfix(slot5, slot0)

			if uv0 then
				break
			end
		end

		return uv0
	end,
	boxlang = function (slot0)
		slot2 = ""
		slot3 = ""

		for slot7, slot8 in ipairs(string.split(slot0, " ")) do
			if not string.nilorempty(slot8) then
				slot9 = nil
				slot9 = (not slot8:find("language_") or LangConfig.instance:getLangTxt(nil, slot8)) and luaLang(slot8)

				if slot2 ~= "" then
					slot2 = slot2 .. "\n"
				end

				if slot3 ~= "" then
					slot3 = slot3 .. "\n"
				end

				slot2 = slot2 .. slot9
				slot3 = slot3 .. string.format("%s\n\t%s", slot8, slot9)
			end
		end

		if not string.nilorempty(slot2) then
			slot3 = "\n" .. slot3

			MessageBoxController.instance:showMsgBoxByStr(slot2, MsgBoxEnum.BoxType.Yes, function ()
				logNormal(uv0)
			end, nil)

			uv0 = true
		end
	end,
	showui = function (slot0)
		slot1 = false

		if not string.split(slot0, " ")[1] then
			return
		end

		if not ViewName[slot3] then
			logNormal("no define ViewName." .. slot3)

			return
		end

		slot5 = nil

		if slot4 == ViewName.SettingsPCSystemView or slot4 == ViewName.SettingsView then
			slot7 = 0

			if slot2[2] then
				if string.lower(slot6) == "8k" then
					slot7 = 1
				elseif slot6 == "4k" then
					slot7 = 2
				elseif slot6 == "2k" then
					slot7 = 3
				elseif slot6 == "1k" then
					slot7 = 4
				else
					logNormal("not support " .. slot6)
				end
			end

			uv0({
				skipIndex = slot7
			})

			function SettingsModel.setResolutionRatio()
			end
		end

		if slot4 == ViewName.SettingsView then
			slot1 = true

			function BootNativeUtil.isWindows()
				return true
			end

			uv1()
			SettingsController.instance:openView()
		end

		if not slot1 then
			ViewMgr.instance:openView(slot4, slot5)
		end

		uv2 = true
	end
}
