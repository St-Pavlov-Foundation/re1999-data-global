module("projbooter.lang.BootLangFontMgr", package.seeall)

slot0 = class("BootLangFontMgr")

function slot0.init(slot0, slot1)
	slot0._font = slot1

	ZProj.LangFontAssetMgr.Instance:SetLuaCallback(slot0._setFontAsset, slot0)
end

function slot0._setFontAsset(slot0, slot1, slot2)
	if slot2 then
		slot1.text.font = slot0._font
	end
end

function slot0.dispose(slot0)
	slot0._font = nil
end

slot0.instance = slot0.New()

return slot0
