module("modules.common.global.gamestate.GameLangFont", package.seeall)

local var_0_0 = class("GameLangFont")
local var_0_1 = typeof(ZProj.LangFont)

function var_0_0.refreshFontAsset(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_1:GetComponent(var_0_1).id
	local var_1_1 = arg_1_0._id2TmpFontAssetDict[var_1_0]

	if var_1_1 then
		arg_1_1.font = var_1_1
	end
end

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.ctor(arg_2_0)
	arg_2_0._hasInit = true
	arg_2_0._loadStatus = var_0_2
	arg_2_0._SettingStatus = var_0_2
	arg_2_0._registerFontDict = {}
	arg_2_0._id2TmpFontUrlDict = {}
	arg_2_0._id2TextFontUrlDict = {}
	arg_2_0._id2TmpFontAssetDict = {}
	arg_2_0._id2TextFontAssetDict = {}

	arg_2_0:_loadFontAsset()
	ZProj.LangFontAssetMgr.Instance:SetLuaCallback(arg_2_0._callback, arg_2_0)
end

function var_0_0._callback(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		arg_3_0._registerFontDict[arg_3_1] = true

		if arg_3_0._loadStatus == var_0_4 then
			arg_3_0:_setFontAsset(arg_3_1)
		else
			arg_3_0:_loadFontAsset()
		end
	else
		arg_3_0._registerFontDict[arg_3_1] = nil

		local var_3_0 = arg_3_1.id

		if var_3_0 > 0 and (not string.nilorempty(arg_3_1.str1) or arg_3_1.instanceMaterial) then
			local var_3_1 = arg_3_1.tmpText
			local var_3_2 = arg_3_0._id2TmpFontAssetDict[var_3_0]

			if var_3_1 and (var_3_2 == nil or var_3_2.material ~= var_3_1.fontSharedMaterial) then
				gohelper.destroy(var_3_1.fontSharedMaterial)
			end
		end
	end
end

function var_0_0.changeFontAsset(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._hasInit then
		if arg_4_1 then
			arg_4_1(arg_4_2)
		end

		return
	end

	arg_4_0._loadStatus = var_0_2
	arg_4_0._loadFontAssetCallback = arg_4_1
	arg_4_0._loadFontAssetcallbackObj = arg_4_2

	arg_4_0:_loadFontAsset()
end

function var_0_0._loadFontAsset(arg_5_0)
	if arg_5_0._loadStatus ~= var_0_2 then
		return
	end

	arg_5_0._loadStatus = var_0_3

	local var_5_0 = {}

	arg_5_0._id2TmpFontUrlDict = {}
	arg_5_0._id2TextFontUrlDict = {}

	local var_5_1 = LangSettings.shortcutTab[GameConfig:GetCurLangType()]
	local var_5_2 = lua_setting_lang.configDict[var_5_1]

	for iter_5_0 = 1, 2 do
		local var_5_3 = "fontasset" .. iter_5_0

		if not string.nilorempty(var_5_2[var_5_3]) then
			local var_5_4 = string.format("font/meshpro/%s.asset", var_5_2[var_5_3])

			table.insert(var_5_0, var_5_4)

			arg_5_0._id2TmpFontUrlDict[iter_5_0] = var_5_4
		end

		local var_5_5 = "textfontasset" .. iter_5_0

		if not string.nilorempty(var_5_2[var_5_5]) then
			local var_5_6 = string.format("font/%s", var_5_2[var_5_5])

			table.insert(var_5_0, var_5_6)

			arg_5_0._id2TextFontUrlDict[iter_5_0] = var_5_6
		end
	end

	if arg_5_0._loader then
		arg_5_0._loader:dispose()
	end

	arg_5_0._loader = MultiAbLoader.New()

	arg_5_0._loader:setPathList(var_5_0)
	arg_5_0._loader:startLoad(arg_5_0._onFontLoaded, arg_5_0)
end

function var_0_0._onFontLoaded(arg_6_0)
	arg_6_0._loadStatus = var_0_4
	arg_6_0._id2TmpFontAssetDict = {}
	arg_6_0._id2TextFontAssetDict = {}

	local var_6_0 = arg_6_0._loader:getAssetItemDict()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		for iter_6_2, iter_6_3 in pairs(arg_6_0._id2TmpFontUrlDict) do
			if iter_6_3 == iter_6_0 then
				arg_6_0._id2TmpFontAssetDict[iter_6_2] = iter_6_1:GetResource()
			end
		end

		for iter_6_4, iter_6_5 in pairs(arg_6_0._id2TextFontUrlDict) do
			if iter_6_5 == iter_6_0 then
				arg_6_0._id2TextFontAssetDict[iter_6_4] = iter_6_1:GetResource()
			end
		end
	end

	for iter_6_6, iter_6_7 in pairs(arg_6_0._registerFontDict) do
		arg_6_0:_setFontAsset(iter_6_6)
	end

	if arg_6_0._loadFontAssetCallback then
		arg_6_0._loadFontAssetCallback(arg_6_0._loadFontAssetcallbackObj)
	end

	arg_6_0._loadFontAssetCallback = nil
	arg_6_0._loadFontAssetcallbackObj = nil
end

function var_0_0._setFontAsset(arg_7_0, arg_7_1)
	if gohelper.isNil(arg_7_1) then
		return
	end

	local var_7_0 = arg_7_1.id

	if var_7_0 > 0 then
		local var_7_1 = arg_7_1.tmpText

		if var_7_1 then
			local var_7_2 = arg_7_0._id2TmpFontAssetDict[var_7_0]

			if var_7_2 then
				var_7_1.font = var_7_2
			end

			local var_7_3 = arg_7_1.str1

			if not string.nilorempty(var_7_3) or not string.nilorempty(arg_7_1.str2) then
				arg_7_1.instanceMaterial = true
			end

			local var_7_4 = var_7_1.fontSharedMaterial

			if arg_7_1.instanceMaterial then
				var_7_4 = UnityEngine.Object.Instantiate(var_7_1.fontSharedMaterial)
			end

			if not string.nilorempty(var_7_3) then
				local var_7_5 = SLFramework.UGUI.GuiHelper.ParseColor(var_7_3)

				var_7_1.outlineColor = UnityEngine.Color32.New(var_7_5.r * 255, var_7_5.g * 255, var_7_5.b * 255, var_7_5.a * 255), var_7_4:EnableKeyword("OUTLINE_ON")
				var_7_1.outlineWidth = arg_7_1.int1 / 1000
			end

			if not string.nilorempty(arg_7_1.str2) then
				local var_7_6 = string.split(arg_7_1.str2, "|||")
				local var_7_7 = SLFramework.UGUI.GuiHelper.ParseColor(var_7_6[1])

				var_7_4:EnableKeyword("UNDERLAY_ON")
				var_7_4:SetFloat("_UnderlayOffsetX", tonumber(var_7_6[2]))
				var_7_4:SetFloat("_UnderlayOffsetY", tonumber(var_7_6[3]))
				var_7_4:SetFloat("_UnderlayDilate", tonumber(var_7_6[4]))
				var_7_4:SetFloat("_UnderlaySoftness", tonumber(var_7_6[5]))
				var_7_4:SetColor("_UnderlayColor", var_7_7)
			end

			var_7_1.fontSharedMaterial = var_7_4
		else
			local var_7_8 = arg_7_1.tmpInputText

			if var_7_8 then
				local var_7_9 = arg_7_0._id2TmpFontAssetDict[var_7_0]

				if var_7_9 then
					var_7_8.fontAsset = var_7_9
				end
			end

			local var_7_10 = arg_7_1.tmpTextScene

			if var_7_10 then
				local var_7_11 = arg_7_0._id2TmpFontAssetDict[var_7_0]

				if var_7_11 then
					var_7_10.font = var_7_11
				end
			end
		end

		return
	end

	local var_7_12 = arg_7_1.textId

	if var_7_12 > 0 then
		local var_7_13 = arg_7_1.text

		if var_7_13 then
			local var_7_14 = arg_7_0._id2TextFontAssetDict[var_7_12]

			if var_7_14 then
				var_7_13.font = var_7_14
			end
		end
	end
end

function var_0_0.ControlDoubleEn(arg_8_0)
	if not arg_8_0._hasInit then
		return
	end

	local var_8_0 = ViewMgr.instance:getUIRoot()

	arg_8_0.languageMgr = SLFramework.LanguageMgr.Instance

	local var_8_1 = var_8_0:GetComponentsInChildren(typeof(SLFramework.LangCaptions), true)

	arg_8_0._comps = {}

	ZProj.AStarPathBridge.ArrayToLuaTable(var_8_1, arg_8_0._comps)
	TaskDispatcher.runRepeat(arg_8_0._onRepectSetEnActive, arg_8_0, 0)
end

function var_0_0._onRepectSetEnActive(arg_9_0)
	for iter_9_0 = 1, 100 do
		if #arg_9_0._comps > 0 then
			local var_9_0 = arg_9_0._comps[#arg_9_0._comps]

			table.remove(arg_9_0._comps, #arg_9_0._comps)

			if not gohelper.isNil(var_9_0) then
				arg_9_0.languageMgr:ApplyLangCaptions(var_9_0)
			end
		end
	end

	if #arg_9_0._comps == 0 then
		arg_9_0:_stopSetEnActive()
	end
end

function var_0_0._stopSetEnActive(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onRepectSetEnActive, arg_10_0)

	if arg_10_0._comps then
		arg_10_0._comps = nil
	end
end

return var_0_0
