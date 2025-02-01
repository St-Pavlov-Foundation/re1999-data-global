module("modules.logic.character.view.CharacterVoiceItem", package.seeall)

slot0 = class("CharacterVoiceItem", ListScrollCellExtend)
slot1 = "voiceview_item_in"

function slot0.onInitView(slot0)
	slot0._itemclick = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)
	slot0._itemAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goplayicon = gohelper.findChild(slot0.viewGO, "#go_playicon")
	slot0._gostopicon = gohelper.findChild(slot0.viewGO, "#go_stopicon")
	slot0._golockicon = gohelper.findChild(slot0.viewGO, "#go_lockicon")
	slot0._govoice = gohelper.findChild(slot0.viewGO, "voice")
	slot0._govoicemask = gohelper.findChild(slot0.viewGO, "voice/mask")
	slot0._txtvoicename = gohelper.findChildText(slot0.viewGO, "voice/mask/#txt_voicename")
	slot0._golockvoice = gohelper.findChild(slot0.viewGO, "lockvoice")
	slot0._txtlockvoicename = gohelper.findChildText(slot0.viewGO, "lockvoice/#txt_lockvoicename")
	slot0._govoiceicon = gohelper.findChild(slot0.viewGO, "#go_voiceicon")
	slot0.moveduration = 1.5
	slot0.gapduration = 0.5
	slot0.backduration = 1.5

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._itemclick:AddClickListener(slot0._itemOnClick, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.ChangeVoiceLang, slot0._onChangeCharVoiceLang, slot0)
end

function slot0.removeEvents(slot0)
	slot0._itemclick:RemoveClickListener()
end

function slot0._itemOnClick(slot0)
	if CharacterDataModel.instance:isCurHeroAudioLocked(slot0._mo.id) then
		return
	end

	if CharacterDataModel.instance:isCurHeroAudioPlaying(slot0._mo.id) then
		CharacterController.instance:dispatchEvent(CharacterEvent.StopVoice, slot0._mo.id)
		slot0:_checkplayingcallback()
	else
		slot0:_checkplayingcallback()
		CharacterController.instance:dispatchEvent(CharacterEvent.PlayVoice, slot0._mo.id)
	end
end

function slot0._checkplayingcallback(slot0)
	if slot0.playcallback then
		TaskDispatcher.cancelTask(slot0.playcallback, slot0)

		slot0.playcallback = nil
	end

	ZProj.TweenHelper.KillByObj(slot0._txtvoicename.transform)
	recthelper.setAnchorX(slot0._txtvoicename.transform, 0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	transformhelper.setLocalScale(slot0._gostopicon.transform, 1, 1, 1)
	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	slot0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	if CharacterDataModel.instance:isCurHeroAudioLocked(slot0._mo.id) then
		gohelper.setActive(slot0._golockicon, true)
		gohelper.setActive(slot0._goplayicon, false)
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._govoiceicon, false)
		gohelper.setActive(slot0._golockvoice, true)
		gohelper.setActive(slot0._govoice, false)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtvoicename, "#9D9D9D")

		slot1 = HeroModel.instance:getByHeroId(slot0._mo.heroId)
		slot0._txtlockvoicename.text = CharacterDataConfig.instance:getConditionStringName(slot0._mo)
	else
		gohelper.setActive(slot0._golockvoice, false)
		gohelper.setActive(slot0._govoice, true)

		slot1 = CharacterDataModel.instance:isCurHeroAudioPlaying(slot0._mo.id)

		gohelper.setActive(slot0._golockicon, false)
		gohelper.setActive(slot0._goplayicon, not slot1)
		gohelper.setActive(slot0._gostopicon, slot1)
		gohelper.setActive(slot0._govoiceicon, slot1)

		slot0._txtvoicename.text = " " .. slot0._mo.name

		if slot1 then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtvoicename, "#C66030")
			slot0:_checkloopVoiceName(slot1)
		else
			slot0:_checkplayingcallback()
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtvoicename, "#E2E1DF")
		end
	end
end

function slot0._checkloopVoiceName(slot0, slot1)
	if slot0.playcallback then
		return
	end

	function slot0.playcallback()
		recthelper.setAnchorX(uv0._txtvoicename.transform, 0)
		uv0:_loopVoiceName()
	end

	if slot1 then
		slot0:_loopVoiceName()
	else
		recthelper.setAnchorX(slot0._txtvoicename.transform, 0)
	end
end

function slot0._loopVoiceName(slot0)
	slot1 = recthelper.getWidth(slot0._govoicemask.transform)
	slot2 = recthelper.getWidth(slot0._txtvoicename.transform)

	if slot1 < slot2 then
		ZProj.TweenHelper.DOLocalMoveX(slot0._txtvoicename.transform, -(slot2 - slot1), slot0.moveduration)
		TaskDispatcher.runDelay(slot0.playcallback, slot0, slot0.moveduration + slot0.gapduration)
	end
end

function slot0._onChangeCharVoiceLang(slot0)
	slot0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	slot0._itemAnimator:Play(uv0, 0, 0)
end

function slot0.onDestroyView(slot0)
end

return slot0
