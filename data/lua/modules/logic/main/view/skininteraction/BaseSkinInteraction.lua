module("modules.logic.main.view.skininteraction.BaseSkinInteraction", package.seeall)

slot0 = class("BaseSkinInteraction")

function slot0.init(slot0, slot1, slot2)
	slot0._view = slot1
	slot0._skinId = slot2

	slot0:_onInit()
end

function slot0.getSkinId(slot0)
	return slot0._skinId
end

function slot0.needRespond(slot0)
	return false
end

function slot0.canPlay(slot0, slot1)
	return true
end

function slot0.isPlayingVoice(slot0)
	return false
end

function slot0.beginDrag(slot0)
end

function slot0.endDrag(slot0)
end

function slot0.onCloseFullView(slot0)
end

function slot0._checkPosInBound(slot0, slot1)
	return slot0._view:_checkPosInBound(slot1)
end

function slot0._clickDefault(slot0, slot1)
	slot0._view:_clickDefault(slot1)
end

function slot0._onInit(slot0)
end

function slot0.onClick(slot0, slot1)
	slot0:_onClick(slot1)
end

function slot0.beforePlayVoice(slot0, slot1)
	slot0:_beforePlayVoice(slot1)
end

function slot0._beforePlayVoice(slot0, slot1)
end

function slot0.afterPlayVoice(slot0, slot1)
	slot0:_afterPlayVoice(slot1)
end

function slot0._afterPlayVoice(slot0, slot1)
end

function slot0.playVoiceFinish(slot0, slot1)
	slot0:_onPlayVoiceFinish(slot1)
end

function slot0._onPlayVoiceFinish(slot0, slot1)
end

function slot0.playVoice(slot0, slot1)
	slot0._view:playVoice(slot1)
end

function slot0.onPlayVoice(slot0, slot1)
	slot0._voiceConfig = slot1

	slot0:_onPlayVoice()
end

function slot0._onPlayVoice(slot0)
end

function slot0.onStopVoice(slot0)
	slot0:_onStopVoice()
end

function slot0._onStopVoice(slot0)
end

function slot0._onClick(slot0, slot1)
end

function slot0.onDestroy(slot0)
	slot0:_onDestroy()
end

function slot0._onDestroy(slot0)
end

return slot0
