module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_BasicInfoItem", package.seeall)

slot0 = class("V2a4_WarmUp_DialogueView_BasicInfoItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "bg/#txt_title")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#txt_dec")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0.setData(slot0, slot1)
	slot3 = V2a4_WarmUpConfig.instance:textInfoCO(slot1)
	slot0._txttitle.text = slot3.name
	slot0._txtdec.text = slot3.value
end

return slot0
