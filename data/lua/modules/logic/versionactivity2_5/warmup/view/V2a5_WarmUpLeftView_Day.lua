module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUpLeftView_Day", package.seeall)

slot0 = class("V2a5_WarmUpLeftView_Day", RougeSimpleItemBase)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	uv0.super.ctor(slot0, slot1)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

function slot0._internal_setEpisode(slot0, slot1)
	slot0._episodeId = slot1
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

return slot0
