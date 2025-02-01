module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyDescItem", package.seeall)

slot0 = class("Season166InformationAnalyDescItem", Season166InformationAnalyDetailItemBase)

function slot0.onInit(slot0)
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.go, "#txt_Descr")
	slot0.goLine = gohelper.findChild(slot0.go, "#txt_Descr/image_Line")
end

function slot0.onUpdate(slot0)
	if slot0.txtFadeIn and slot0.txtFadeIn:isPlaying() then
		slot0.txtFadeIn:conFinished()
		slot0.txtFadeIn:onDestroy()
	end

	slot0.txtDesc.text = slot0.data.config.content
end

function slot0.playFadeIn(slot0)
	if not slot0.txtFadeIn then
		slot0.txtFadeIn = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.txtDesc.gameObject, TMPFadeInWithScroll)
	end

	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_feichi_yure_caption)
	slot0.txtFadeIn:playNormalText(slot0.data.config.content, slot0.onTextFinish, slot0)
end

function slot0.onTextFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season166.stop_ui_feichi_yure_caption)
end

function slot0.onDestroy(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season166.stop_ui_feichi_yure_caption)
	uv0.super.onDestroy(slot0)
end

return slot0
