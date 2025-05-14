module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluView", package.seeall)

local var_0_0 = class("PeaceUluView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_lightspinecontrol")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_role/#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_Dialouge")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_Dialouge/#txt_DialougeEn")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom")
	arg_1_0._gobubble = gohelper.findChild(arg_1_0.viewGO, "#go_Bubble")
	arg_1_0._txtbubble = gohelper.findChildText(arg_1_0.viewGO, "#go_Bubble/node/#scroll_bubble/Viewport/Content/#txt_BubbleTips")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.tweenDuration = 0.3

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
	arg_2_0:addEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, arg_2_0._checkVoice, arg_2_0)
	arg_2_0:addEventCb(PeaceUluController.instance, PeaceUluEvent.playVoice, arg_2_0.playVoice, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
	arg_3_0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, arg_3_0._checkVoice, arg_3_0)
	arg_3_0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.playVoice, arg_3_0.playVoice, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.jumpparam = arg_4_0.viewParam.param

	arg_4_0:_updateHero(PeaceUluEnum.RoleID.Idle)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_arena_open)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._click = SLFramework.UGUI.UIClickListener.Get(arg_5_0._golightspinecontrol)

	arg_5_0._click:AddClickListener(arg_5_0._onClickHero, arg_5_0)
	gohelper.setActive(arg_5_0._gocontentbg, false)
	gohelper.setActive(arg_5_0._gobubble, false)
end

function var_0_0._updateHero(arg_6_0, arg_6_1)
	arg_6_0._skinId = arg_6_1

	local var_6_0 = HeroConfig.instance:getHeroCO(arg_6_0._heroId)
	local var_6_1 = SkinConfig.instance:getSkinCo(arg_6_0._skinId)

	arg_6_0._heroId = var_6_1.characterId
	arg_6_0._heroSkinConfig = var_6_1

	if not arg_6_0._uiSpine then
		arg_6_0._uiSpine = GuiModelAgent.Create(arg_6_0._golightspine, true)
	end

	arg_6_0._uiSpine:setResPath(var_6_1, arg_6_0._onLightSpineLoaded, arg_6_0)
end

function var_0_0._playVoice(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0._uiSpine or not arg_7_1 then
		return
	end

	if arg_7_0._uiSpine:isPlayingVoice() then
		arg_7_0._uiSpine:stopVoice()
	end

	if arg_7_2 then
		gohelper.setActive(arg_7_0._gobubble, false)
		arg_7_0._uiSpine:playVoice(arg_7_1, arg_7_3, arg_7_0._txtanacn, arg_7_0._txtanaen, arg_7_0._gocontentbg)
	else
		arg_7_0._uiSpine:playVoice(arg_7_1, arg_7_3, arg_7_0._txtbubble, nil, arg_7_0._gobubble, true)
	end
end

function var_0_0._onLightSpineLoaded(arg_8_0)
	arg_8_0._uiSpine:setModelVisible(true)

	arg_8_0._l2d = arg_8_0._uiSpine:_getLive2d()

	function arg_8_0._opencallack()
		TaskDispatcher.cancelTask(arg_8_0._opencallack, arg_8_0)

		local var_9_0 = arg_8_0:_getVoiceCoByType(PeaceUluEnum.VoiceType.FirstEnterView)

		gohelper.setActive(arg_8_0._gobubble, true)
		arg_8_0:_playVoice(var_9_0)
	end

	TaskDispatcher.runDelay(arg_8_0._opencallack, arg_8_0, 0.2)

	if arg_8_0.jumpparam == VersionActivity1_5Enum.ActivityId.PeaceUlu then
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
	end
end

function var_0_0._toSwitchTab(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._gobubble, false)

	if arg_10_0._uiSpine:isPlayingVoice() then
		arg_10_0._uiSpine:stopVoice()
	end

	if arg_10_1 == PeaceUluEnum.TabIndex.Game then
		arg_10_0._animator:Play("startin", 0, 0)
		arg_10_0._animator:Update(0)
	elseif arg_10_1 == PeaceUluEnum.TabIndex.Main then
		arg_10_0._animator:Play("open", 0, 0)
		arg_10_0._animator:Update(0)

		local var_10_0 = arg_10_0._animator:GetCurrentAnimatorStateInfo(0).length

		arg_10_0._animator:Play("open", 0, 0.3333333333333333 * var_10_0)
		arg_10_0._animator:Update(0)
	end
end

function var_0_0._getVoiceCoByType(arg_11_0, arg_11_1)
	local var_11_0 = PeaceUluConfig.instance:getVoiceConfigByType(arg_11_1)
	local var_11_1 = PeaceUluVoiceCo.New()

	var_11_1:init({
		content = var_11_0.content,
		motion = var_11_0.motion,
		displayTime = var_11_0.displayTime or 2
	})

	return var_11_1
end

function var_0_0.playVoice(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0:_getVoiceCoByType(arg_12_1)

	arg_12_0:_playVoice(var_12_0)
end

function var_0_0._checkVoice(arg_13_0)
	local var_13_0 = PeaceUluModel.instance:getGameHaveTimes() ~= 0 or PeaceUluModel.instance:checkCanRemove()

	if PeaceUluTaskModel.instance:checkAllTaskFinished() and var_13_0 then
		local var_13_1 = arg_13_0:_getVoiceCoByType(PeaceUluEnum.VoiceType.CanRemoveButFinish)

		arg_13_0:_playVoice(var_13_1)
	end
end

function var_0_0._onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.CommonPropView and PeaceUluModel.instance:checkBonusIds() then
		local function var_14_0()
			PeaceUluModel.instance:cleanBonusIds()
		end

		local var_14_1 = arg_14_0:_getVoiceCoByType(PeaceUluEnum.VoiceType.GetReward)

		arg_14_0:_playVoice(var_14_1, false, var_14_0)
	elseif arg_14_1 == ViewName.CommonPropView and PeaceUluModel.instance:checkTaskId() then
		if arg_14_0._uiSpine:isPlayingVoice() then
			return
		end

		local function var_14_2()
			PeaceUluModel.instance:cleanTaskId()
		end

		local var_14_3 = arg_14_0:_getVoiceCoByType(PeaceUluEnum.VoiceType.RemoveTask)

		arg_14_0:_playVoice(var_14_3, false, var_14_2)
	end
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._enterGameView, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._opencallack, arg_17_0)
	arg_17_0._click:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
