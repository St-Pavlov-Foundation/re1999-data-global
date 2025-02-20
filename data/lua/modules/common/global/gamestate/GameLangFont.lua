module("modules.common.global.gamestate.GameLangFont", package.seeall)

slot0 = class("GameLangFont")
slot1 = typeof(ZProj.LangFont)

function slot0.refreshFontAsset(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._id2TmpFontAssetDict[slot1:GetComponent(uv0).id] then
		slot1.font = slot4
	end
end

slot2 = 1
slot3 = 2
slot4 = 3

function slot0.ctor(slot0)
	slot0._loadStatus = uv0
	slot0._SettingStatus = uv0
	slot0._registerFontDict = {}
	slot0._id2TmpFontUrlDict = {}
	slot0._id2TextFontUrlDict = {}
	slot0._id2TmpFontAssetDict = {}
	slot0._id2TextFontAssetDict = {}

	slot0:_loadFontAsset()
	ZProj.LangFontAssetMgr.Instance:SetLuaCallback(slot0._callback, slot0)
end

function slot0._callback(slot0, slot1, slot2)
	if slot2 then
		slot0._registerFontDict[slot1] = true

		if slot0._loadStatus == uv0 then
			slot0:_setFontAsset(slot1)
		else
			slot0:_loadFontAsset()
		end
	else
		slot0._registerFontDict[slot1] = nil

		if slot1.id > 0 and (not string.nilorempty(slot1.str1) or slot1.instanceMaterial) then
			slot5 = slot0._id2TmpFontAssetDict[slot3]

			if slot1.tmpText and (slot5 == nil or slot5.material ~= slot4.fontSharedMaterial) then
				gohelper.destroy(slot4.fontSharedMaterial)
			end
		end
	end
end

function slot0.changeFontAsset(slot0, slot1, slot2)
	slot0._loadStatus = uv0
	slot0._loadFontAssetCallback = slot1
	slot0._loadFontAssetcallbackObj = slot2

	slot0:_loadFontAsset()
end

function slot0._loadFontAsset(slot0)
	if slot0._loadStatus ~= uv0 then
		return
	end

	slot0._loadStatus = uv1
	slot0._id2TmpFontUrlDict = {}
	slot0._id2TextFontUrlDict = {}
	slot3 = lua_setting_lang.configDict[LangSettings.shortcutTab[GameConfig:GetCurLangType()]]

	for slot7 = 1, 2 do
		if not string.nilorempty(slot3["fontasset" .. slot7]) then
			slot9 = string.format("font/meshpro/%s.asset", slot3[slot8])

			table.insert({}, slot9)

			slot0._id2TmpFontUrlDict[slot7] = slot9
		end

		if not string.nilorempty(slot3["textfontasset" .. slot7]) then
			slot9 = string.format("font/%s", slot3[slot8])

			table.insert(slot1, slot9)

			slot0._id2TextFontUrlDict[slot7] = slot9
		end
	end

	if slot0._loader then
		slot0._loader:dispose()
	end

	slot0._loader = MultiAbLoader.New()

	slot0._loader:setPathList(slot1)
	slot0._loader:startLoad(slot0._onFontLoaded, slot0)
end

function slot0._onFontLoaded(slot0)
	slot0._loadStatus = uv0
	slot0._id2TmpFontAssetDict = {}
	slot0._id2TextFontAssetDict = {}

	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		for slot10, slot11 in pairs(slot0._id2TmpFontUrlDict) do
			if slot11 == slot5 then
				slot0._id2TmpFontAssetDict[slot10] = slot6:GetResource()
			end
		end

		for slot10, slot11 in pairs(slot0._id2TextFontUrlDict) do
			if slot11 == slot5 then
				slot0._id2TextFontAssetDict[slot10] = slot6:GetResource()
			end
		end
	end

	for slot5, slot6 in pairs(slot0._registerFontDict) do
		slot0:_setFontAsset(slot5)
	end

	if slot0._loadFontAssetCallback then
		slot0._loadFontAssetCallback(slot0._loadFontAssetcallbackObj)
	end

	slot0._loadFontAssetCallback = nil
	slot0._loadFontAssetcallbackObj = nil
end

function slot0._setFontAsset(slot0, slot1)
	if gohelper.isNil(slot1) then
		return
	end

	if slot1.id > 0 then
		if slot1.tmpText then
			if slot0._id2TmpFontAssetDict[slot2] then
				slot3.font = slot4
			end

			if not string.nilorempty(slot1.str1) or not string.nilorempty(slot1.str2) then
				slot1.instanceMaterial = true
			end

			slot6 = slot3.fontSharedMaterial

			if slot1.instanceMaterial then
				slot6 = UnityEngine.Object.Instantiate(slot3.fontSharedMaterial)
			end

			if not string.nilorempty(slot5) then
				slot7 = SLFramework.UGUI.GuiHelper.ParseColor(slot5)

				slot6:EnableKeyword("OUTLINE_ON")

				slot3.outlineColor = UnityEngine.Color32.New(slot7.r * 255, slot7.g * 255, slot7.b * 255, slot7.a * 255)
				slot3.outlineWidth = slot1.int1 / 1000
			end

			if not string.nilorempty(slot1.str2) then
				slot7 = string.split(slot1.str2, "|||")

				slot6:EnableKeyword("UNDERLAY_ON")
				slot6:SetFloat("_UnderlayOffsetX", tonumber(slot7[2]))
				slot6:SetFloat("_UnderlayOffsetY", tonumber(slot7[3]))
				slot6:SetFloat("_UnderlayDilate", tonumber(slot7[4]))
				slot6:SetFloat("_UnderlaySoftness", tonumber(slot7[5]))
				slot6:SetColor("_UnderlayColor", SLFramework.UGUI.GuiHelper.ParseColor(slot7[1]))
			end

			slot3.fontSharedMaterial = slot6
		else
			if slot1.tmpInputText and slot0._id2TmpFontAssetDict[slot2] then
				slot4.fontAsset = slot5
			end

			if slot1.tmpTextScene and slot0._id2TmpFontAssetDict[slot2] then
				slot5.font = slot6
			end
		end

		return
	end

	if slot1.textId > 0 and slot1.text and slot0._id2TextFontAssetDict[slot3] then
		slot4.font = slot5
	end
end

function slot0.ControlDoubleEn(slot0)
	slot0.languageMgr = SLFramework.LanguageMgr.Instance
	slot0._comps = {}

	ZProj.AStarPathBridge.ArrayToLuaTable(ViewMgr.instance:getUIRoot():GetComponentsInChildren(typeof(SLFramework.LangCaptions), true), slot0._comps)
	TaskDispatcher.runRepeat(slot0._onRepectSetEnActive, slot0, 0)
end

function slot0._onRepectSetEnActive(slot0)
	for slot4 = 1, 100 do
		if #slot0._comps > 0 then
			table.remove(slot0._comps, #slot0._comps)

			if not gohelper.isNil(slot0._comps[#slot0._comps]) then
				slot0.languageMgr:ApplyLangCaptions(slot5)
			end
		end
	end

	if #slot0._comps == 0 then
		slot0:_stopSetEnActive()
	end
end

function slot0._stopSetEnActive(slot0)
	TaskDispatcher.cancelTask(slot0._onRepectSetEnActive, slot0)

	if slot0._comps then
		slot0._comps = nil
	end
end

return slot0
