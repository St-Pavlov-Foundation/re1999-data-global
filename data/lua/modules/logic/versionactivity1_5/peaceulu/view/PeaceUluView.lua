module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluView", package.seeall)

slot0 = class("PeaceUluView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._golightspinecontrol = gohelper.findChild(slot0.viewGO, "#go_role/#go_lightspinecontrol")
	slot0._gospinescale = gohelper.findChild(slot0.viewGO, "#go_role/#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0.viewGO, "#go_role/#go_spine_scale/lightspine/#go_lightspine")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_Dialouge")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_Dialouge/#txt_DialougeEn")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom")
	slot0._gobubble = gohelper.findChild(slot0.viewGO, "#go_Bubble")
	slot0._txtbubble = gohelper.findChildText(slot0.viewGO, "#go_Bubble/node/#scroll_bubble/Viewport/Content/#txt_BubbleTips")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.tweenDuration = 0.3

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, slot0._toSwitchTab, slot0)
	slot0:addEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, slot0._checkVoice, slot0)
	slot0:addEventCb(PeaceUluController.instance, PeaceUluEvent.playVoice, slot0.playVoice, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, slot0._toSwitchTab, slot0)
	slot0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, slot0._checkVoice, slot0)
	slot0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.playVoice, slot0.playVoice, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.onOpen(slot0)
	slot0.jumpparam = slot0.viewParam.param

	slot0:_updateHero(PeaceUluEnum.RoleID.Idle)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_arena_open)
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._golightspinecontrol)

	slot0._click:AddClickListener(slot0._onClickHero, slot0)
	gohelper.setActive(slot0._gocontentbg, false)
	gohelper.setActive(slot0._gobubble, false)
end

function slot0._updateHero(slot0, slot1)
	slot0._skinId = slot1
	slot2 = HeroConfig.instance:getHeroCO(slot0._heroId)
	slot3 = SkinConfig.instance:getSkinCo(slot0._skinId)
	slot0._heroId = slot3.characterId
	slot0._heroSkinConfig = slot3

	if not slot0._uiSpine then
		slot0._uiSpine = GuiModelAgent.Create(slot0._golightspine, true)
	end

	slot0._uiSpine:setResPath(slot3, slot0._onLightSpineLoaded, slot0)
end

function slot0._playVoice(slot0, slot1, slot2, slot3)
	if not slot0._uiSpine or not slot1 then
		return
	end

	if slot0._uiSpine:isPlayingVoice() then
		slot0._uiSpine:stopVoice()
	end

	if slot2 then
		gohelper.setActive(slot0._gobubble, false)
		slot0._uiSpine:playVoice(slot1, slot3, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
	else
		slot0._uiSpine:playVoice(slot1, slot3, slot0._txtbubble, nil, slot0._gobubble, true)
	end
end

function slot0._onLightSpineLoaded(slot0)
	slot0._uiSpine:setModelVisible(true)

	slot0._l2d = slot0._uiSpine:_getLive2d()

	function slot0._opencallack()
		TaskDispatcher.cancelTask(uv0._opencallack, uv0)
		gohelper.setActive(uv0._gobubble, true)
		uv0:_playVoice(uv0:_getVoiceCoByType(PeaceUluEnum.VoiceType.FirstEnterView))
	end

	TaskDispatcher.runDelay(slot0._opencallack, slot0, 0.2)

	if slot0.jumpparam == VersionActivity1_5Enum.ActivityId.PeaceUlu then
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
	end
end

function slot0._toSwitchTab(slot0, slot1)
	gohelper.setActive(slot0._gobubble, false)

	if slot0._uiSpine:isPlayingVoice() then
		slot0._uiSpine:stopVoice()
	end

	if slot1 == PeaceUluEnum.TabIndex.Game then
		slot0._animator:Play("startin", 0, 0)
		slot0._animator:Update(0)
	elseif slot1 == PeaceUluEnum.TabIndex.Main then
		slot0._animator:Play("open", 0, 0)
		slot0._animator:Update(0)
		slot0._animator:Play("open", 0, 0.3333333333333333 * slot0._animator:GetCurrentAnimatorStateInfo(0).length)
		slot0._animator:Update(0)
	end
end

function slot0._getVoiceCoByType(slot0, slot1)
	slot2 = PeaceUluConfig.instance:getVoiceConfigByType(slot1)
	slot3 = PeaceUluVoiceCo.New()

	slot3:init({
		content = slot2.content,
		motion = slot2.motion,
		displayTime = slot2.displayTime or 2
	})

	return slot3
end

function slot0.playVoice(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:_playVoice(slot0:_getVoiceCoByType(slot1))
end

function slot0._checkVoice(slot0)
	if PeaceUluTaskModel.instance:checkAllTaskFinished() and (PeaceUluModel.instance:getGameHaveTimes() ~= 0 or PeaceUluModel.instance:checkCanRemove()) then
		slot0:_playVoice(slot0:_getVoiceCoByType(PeaceUluEnum.VoiceType.CanRemoveButFinish))
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView and PeaceUluModel.instance:checkBonusIds() then
		slot0:_playVoice(slot0:_getVoiceCoByType(PeaceUluEnum.VoiceType.GetReward), false, function ()
			PeaceUluModel.instance:cleanBonusIds()
		end)
	elseif slot1 == ViewName.CommonPropView and PeaceUluModel.instance:checkTaskId() then
		if slot0._uiSpine:isPlayingVoice() then
			return
		end

		slot0:_playVoice(slot0:_getVoiceCoByType(PeaceUluEnum.VoiceType.RemoveTask), false, function ()
			PeaceUluModel.instance:cleanTaskId()
		end)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._enterGameView, slot0)
	TaskDispatcher.cancelTask(slot0._opencallack, slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
end

return slot0
