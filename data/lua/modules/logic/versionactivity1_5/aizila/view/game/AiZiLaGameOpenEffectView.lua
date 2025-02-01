module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameOpenEffectView", package.seeall)

slot0 = class("AiZiLaGameOpenEffectView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "ani/#simage_FullBG")
	slot0._txtInfo = gohelper.findChildText(slot0.viewGO, "ani/Title/#txt_Info")
	slot0._txtdaydesc = gohelper.findChildText(slot0.viewGO, "ani/Title/image_Info/#txt_daydesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onEscape, slot0)
	end

	slot0._callback = slot0.viewParam and slot0.viewParam.callback
	slot0._callbackObj = slot0.viewParam and slot0.viewParam.callbackObj

	TaskDispatcher.runDelay(slot0._onAnimFinish, slot0, AiZiLaEnum.AnimatorTime.EffectViewOpen)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, AiZiLaEnum.AnimatorTime.EffectViewOpen + 0.1)
	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_transition)
end

function slot0._onEscape(slot0)
end

function slot0.onClose(slot0)
end

function slot0._onAnimFinish(slot0)
	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj)
		else
			slot0._callback()
		end

		slot0._callbackObj = nil
		slot0._callback = nil
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onAnimFinish, slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

function slot0.refreshUI(slot0)
	if not AiZiLaGameModel.instance:getEpisodeMO() then
		return
	end

	slot0._txtInfo.text = slot1:getConfig() and slot2.name
	slot0._txtdaydesc.text = formatLuaLang("v1a5_aizila_day_explore", slot1.day)
end

function slot0.playViewAnimator(slot0, slot1)
end

return slot0
