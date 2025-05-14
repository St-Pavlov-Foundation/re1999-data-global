module("modules.logic.character.view.CharacterVoiceItem", package.seeall)

local var_0_0 = class("CharacterVoiceItem", ListScrollCellExtend)
local var_0_1 = "voiceview_item_in"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._itemclick = SLFramework.UGUI.UIClickListener.Get(arg_1_0.viewGO)
	arg_1_0._itemAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goplayicon = gohelper.findChild(arg_1_0.viewGO, "#go_playicon")
	arg_1_0._gostopicon = gohelper.findChild(arg_1_0.viewGO, "#go_stopicon")
	arg_1_0._golockicon = gohelper.findChild(arg_1_0.viewGO, "#go_lockicon")
	arg_1_0._govoice = gohelper.findChild(arg_1_0.viewGO, "voice")
	arg_1_0._govoicemask = gohelper.findChild(arg_1_0.viewGO, "voice/mask")
	arg_1_0._txtvoicename = gohelper.findChildText(arg_1_0.viewGO, "voice/mask/#txt_voicename")
	arg_1_0._golockvoice = gohelper.findChild(arg_1_0.viewGO, "lockvoice")
	arg_1_0._txtlockvoicename = gohelper.findChildText(arg_1_0.viewGO, "lockvoice/#txt_lockvoicename")
	arg_1_0._govoiceicon = gohelper.findChild(arg_1_0.viewGO, "#go_voiceicon")
	arg_1_0.moveduration = 1.5
	arg_1_0.gapduration = 0.5
	arg_1_0.backduration = 1.5

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._itemclick:AddClickListener(arg_2_0._itemOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.ChangeVoiceLang, arg_2_0._onChangeCharVoiceLang, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._itemclick:RemoveClickListener()
end

function var_0_0._itemOnClick(arg_4_0)
	if CharacterDataModel.instance:isCurHeroAudioLocked(arg_4_0._mo.id) then
		return
	end

	if CharacterDataModel.instance:isCurHeroAudioPlaying(arg_4_0._mo.id) then
		CharacterController.instance:dispatchEvent(CharacterEvent.StopVoice, arg_4_0._mo.id)
		arg_4_0:_checkplayingcallback()
	else
		arg_4_0:_checkplayingcallback()
		CharacterController.instance:dispatchEvent(CharacterEvent.PlayVoice, arg_4_0._mo.id)
	end
end

function var_0_0._checkplayingcallback(arg_5_0)
	if arg_5_0.playcallback then
		TaskDispatcher.cancelTask(arg_5_0.playcallback, arg_5_0)

		arg_5_0.playcallback = nil
	end

	ZProj.TweenHelper.KillByObj(arg_5_0._txtvoicename.transform)
	recthelper.setAnchorX(arg_5_0._txtvoicename.transform, 0)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	transformhelper.setLocalScale(arg_7_0._gostopicon.transform, 1, 1, 1)
	arg_7_0:_refreshItem()
end

function var_0_0._refreshItem(arg_8_0)
	arg_8_0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	if CharacterDataModel.instance:isCurHeroAudioLocked(arg_8_0._mo.id) then
		gohelper.setActive(arg_8_0._golockicon, true)
		gohelper.setActive(arg_8_0._goplayicon, false)
		gohelper.setActive(arg_8_0._gostopicon, false)
		gohelper.setActive(arg_8_0._govoiceicon, false)
		gohelper.setActive(arg_8_0._golockvoice, true)
		gohelper.setActive(arg_8_0._govoice, false)
		SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtvoicename, "#9D9D9D")

		local var_8_0 = HeroModel.instance:getByHeroId(arg_8_0._mo.heroId)

		arg_8_0._txtlockvoicename.text = CharacterDataConfig.instance:getConditionStringName(arg_8_0._mo)
	else
		gohelper.setActive(arg_8_0._golockvoice, false)
		gohelper.setActive(arg_8_0._govoice, true)

		local var_8_1 = CharacterDataModel.instance:isCurHeroAudioPlaying(arg_8_0._mo.id)

		gohelper.setActive(arg_8_0._golockicon, false)
		gohelper.setActive(arg_8_0._goplayicon, not var_8_1)
		gohelper.setActive(arg_8_0._gostopicon, var_8_1)
		gohelper.setActive(arg_8_0._govoiceicon, var_8_1)

		arg_8_0._txtvoicename.text = " " .. arg_8_0._mo.name

		if var_8_1 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtvoicename, "#C66030")
			arg_8_0:_checkloopVoiceName(var_8_1)
		else
			arg_8_0:_checkplayingcallback()
			SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtvoicename, "#E2E1DF")
		end
	end
end

function var_0_0._checkloopVoiceName(arg_9_0, arg_9_1)
	if arg_9_0.playcallback then
		return
	end

	function arg_9_0.playcallback()
		recthelper.setAnchorX(arg_9_0._txtvoicename.transform, 0)
		arg_9_0:_loopVoiceName()
	end

	if arg_9_1 then
		arg_9_0:_loopVoiceName()
	else
		recthelper.setAnchorX(arg_9_0._txtvoicename.transform, 0)
	end
end

function var_0_0._loopVoiceName(arg_11_0)
	local var_11_0 = recthelper.getWidth(arg_11_0._govoicemask.transform)
	local var_11_1 = recthelper.getWidth(arg_11_0._txtvoicename.transform)
	local var_11_2 = var_11_1 - var_11_0

	if var_11_0 < var_11_1 then
		ZProj.TweenHelper.DOLocalMoveX(arg_11_0._txtvoicename.transform, -var_11_2, arg_11_0.moveduration)
		TaskDispatcher.runDelay(arg_11_0.playcallback, arg_11_0, arg_11_0.moveduration + arg_11_0.gapduration)
	end
end

function var_0_0._onChangeCharVoiceLang(arg_12_0)
	arg_12_0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	arg_12_0._itemAnimator:Play(var_0_1, 0, 0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
