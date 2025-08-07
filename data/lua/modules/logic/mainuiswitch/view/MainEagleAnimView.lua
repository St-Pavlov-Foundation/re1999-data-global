module("modules.logic.mainuiswitch.view.MainEagleAnimView", package.seeall)

local var_0_0 = class("MainEagleAnimView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "right/#go_eaglespine")
	arg_1_0._goPointA = gohelper.findChild(arg_1_0.viewGO, "right/#btn_role/#go_eagleA")
	arg_1_0._goPointB = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_eagleB")
	arg_1_0._goPointC = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_eagleC")
	arg_1_0._gospinebottom = gohelper.findChild(arg_1_0.viewGO, "right/#go_eaglespine/bottom")
	arg_1_0._gospinetop = gohelper.findChild(arg_1_0.viewGO, "right/#go_eaglespine/top")
	arg_1_0._goeagleani = gohelper.findChild(arg_1_0.viewGO, "right/#go_eagleani")
	arg_1_0._goClick = gohelper.findChild(arg_1_0._gospine, "#go_eagleclick")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_0._goClick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onclick, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._onclick(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._normalAnimFinish, arg_4_0)

	local var_4_0 = MainUISwitchConfig.instance:getEagleAnim(arg_4_0._curAnimStep)

	if not var_4_0 or var_4_0.option_nextstep == 0 then
		return
	end

	arg_4_0._curAnimStep = var_4_0.option_nextstep

	arg_4_0:_beginAnim()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._uiSpine = GuiSpine.Create(arg_5_0._gospinetop, true)
	arg_5_0._uiBottomSpine = GuiSpine.Create(arg_5_0._gospinebottom, true)
	arg_5_0._locationParant = {
		[MainUISwitchEnum.EagleLocationType.A] = arg_5_0._goPointA,
		[MainUISwitchEnum.EagleLocationType.B] = arg_5_0._goPointB,
		[MainUISwitchEnum.EagleLocationType.C] = arg_5_0._goPointC
	}
	arg_5_0._animator = arg_5_0._gospine:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._anieagle = arg_5_0._goeagleani:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._loadSpine = false
	arg_6_0._loadBottomSpine = false

	local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.SkinId

	arg_6_0._animName = nil

	arg_6_0:refreshUI(var_6_0)
end

function var_0_0.refreshUI(arg_7_0, arg_7_1)
	TaskDispatcher.cancelTask(arg_7_0._normalAnimFinish, arg_7_0)

	arg_7_1 = arg_7_1 or MainUISwitchModel.instance:getCurUseUI()

	if arg_7_0._showSkinId == arg_7_1 then
		return
	end

	arg_7_0._showSkinId = arg_7_1

	local var_7_0 = arg_7_1 and arg_7_1 == MainUISwitchEnum.Skin.Sp01

	gohelper.setActive(arg_7_0._gospine, var_7_0)

	if var_7_0 then
		gohelper.setActive(arg_7_0._goeagleani, arg_7_0._animName == MainUISwitchEnum.EagleAnim.Hover)
		arg_7_0:_initBgSpine()
	else
		gohelper.setActive(arg_7_0._goeagleani, false)
	end
end

function var_0_0._initBgSpine(arg_8_0)
	if arg_8_0._loadSpine then
		arg_8_0:_startAnim()

		return
	end

	local var_8_0 = ResUrl.getRolesCgStory("scene_eagle_idle1", "s01_scene_eagle_idle1")

	arg_8_0._uiSpine:setResPath(var_8_0, arg_8_0._onSpineLoaded, arg_8_0)
	arg_8_0._uiBottomSpine:setResPath(var_8_0, arg_8_0._onSpineBpttomLoaded, arg_8_0)
end

function var_0_0._onSpineLoaded(arg_9_0)
	local var_9_0 = arg_9_0._uiSpine:getSpineTr()

	transformhelper.setLocalPos(var_9_0, 0, 0, 0)
	transformhelper.setLocalScale(var_9_0, 1, 1, 1)

	arg_9_0._spineSkeleton = arg_9_0._uiSpine:getSpineGo():GetComponent(GuiSpine.TypeSkeletonGraphic)

	arg_9_0._uiSpine:setActionEventCb(arg_9_0._onAnimEvent, arg_9_0)

	arg_9_0._loadSpine = true

	if arg_9_0._loadBottomSpine then
		arg_9_0:_startAnim()
	end
end

function var_0_0._onSpineBpttomLoaded(arg_10_0)
	transformhelper.setLocalPos(arg_10_0._uiBottomSpine:getSpineTr(), 0, 0, 0)
	transformhelper.setLocalScale(arg_10_0._uiBottomSpine:getSpineTr(), 1, 1, 1)

	arg_10_0._bottomSpineSkeleton = arg_10_0._uiBottomSpine:getSpineGo():GetComponent(GuiSpine.TypeSkeletonGraphic)

	if arg_10_0._bottomSpineSkeleton then
		arg_10_0._bottomSpineSkeleton.color = Color.black
	end

	arg_10_0._loadBottomSpine = true

	if arg_10_0._loadSpine then
		arg_10_0:_startAnim()
	end
end

function var_0_0._startAnim(arg_11_0)
	arg_11_0._curAnimStep = 1

	arg_11_0:_beginAnim()
end

function var_0_0._beginAnim(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._normalAnimFinish, arg_12_0)

	local var_12_0 = arg_12_0:_getOddNextStepId(arg_12_0._curAnimStep)

	if var_12_0 then
		arg_12_0:_beginStep(var_12_0)
	end
end

function var_0_0._getRandomStep(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_0 = iter_13_1[2] or 100

		if arg_13_2 <= var_13_0 then
			return iter_13_1[1]
		end

		arg_13_2 = arg_13_2 - var_13_0
	end
end

function var_0_0._beginStep(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	SLFramework.SLLogger.Log(string.format("MainEagleAnimView 当前步骤：%s", arg_14_1))

	local var_14_0 = MainUISwitchConfig.instance:getEagleAnim(arg_14_1)

	if not var_14_0 then
		logError("没有这个步骤" .. arg_14_1)

		return
	end

	arg_14_0._curAnimStep = arg_14_1

	local var_14_1 = 1

	if not string.nilorempty(var_14_0.times) then
		local var_14_2 = string.splitToNumber(var_14_0.times, "#")

		var_14_1 = math.random(var_14_2[1], var_14_2[2])
	end

	arg_14_0._neeedPlayAnimTimes = var_14_1
	arg_14_0._playedAnimTimes = 1

	if not string.nilorempty(var_14_0.location) then
		local var_14_3 = string.splitToNumber(var_14_0.location, "#")
		local var_14_4 = MainUISwitchEnum.EagleLocationType.A
		local var_14_5 = #var_14_3

		if var_14_5 == 1 then
			var_14_4 = var_14_3
		elseif var_14_5 > 1 then
			var_14_4 = var_14_3[math.random(1, var_14_5)]
		end

		local var_14_6 = arg_14_0._locationParant[var_14_4]

		if var_14_6 then
			gohelper.addChildPosStay(var_14_6, arg_14_0._gospine)
			transformhelper.setLocalPos(arg_14_0._gospine.transform, 0, 0, 0)
			transformhelper.setLocalScale(arg_14_0._gospine.transform, 1, 1, 1)
			gohelper.setActive(arg_14_0._gospine, true)
		else
			gohelper.setActive(arg_14_0._gospine, false)
		end
	end

	local var_14_7 = MainUISwitchEnum.EagleAnim.Hover

	if arg_14_0._animName then
		if arg_14_0._animName == var_14_7 and var_14_0.animName ~= var_14_7 then
			gohelper.setActive(arg_14_0._goeagleani, true)
			arg_14_0._anieagle:Play(MainUISwitchEnum.AnimName.Out, 0, 0)
		elseif arg_14_0._animName ~= var_14_7 and var_14_0.animName == var_14_7 then
			gohelper.setActive(arg_14_0._goeagleani, true)
			arg_14_0._anieagle:Play(MainUISwitchEnum.AnimName.In, 0, 0)
		end
	elseif var_14_0.animName == var_14_7 then
		gohelper.setActive(arg_14_0._goeagleani, true)
		arg_14_0._anieagle:Play(MainUISwitchEnum.AnimName.In, 0, 0)
	end

	if var_14_0.isSpineAnim == 1 then
		if arg_14_0._uiSpine then
			arg_14_0._animName = var_14_0.animName

			arg_14_0:_playSpineAnim(arg_14_0._animName)

			if arg_14_0._bottomSpineSkeleton then
				if var_14_0.isoutline == 1 then
					arg_14_0._bottomFadeTweenId = ZProj.TweenHelper.DoFade(arg_14_0._bottomSpineSkeleton, arg_14_0._bottomSpineSkeleton.color.a, 1, 0.5)
				else
					arg_14_0._bottomFadeTweenId = ZProj.TweenHelper.DoFade(arg_14_0._bottomSpineSkeleton, arg_14_0._bottomSpineSkeleton.color.a, 0, 0.5)
				end

				SLFramework.SLLogger.Log(string.format("MainEagleAnimView 播放动作：%s", arg_14_0._animName))
			end
		end
	elseif var_14_0.animName == var_14_7 then
		arg_14_0._animName = var_14_0.animName

		TaskDispatcher.runDelay(arg_14_0._normalAnimFinish, arg_14_0, 4 * arg_14_0._neeedPlayAnimTimes)
	end

	if arg_14_0._animator then
		if string.nilorempty(var_14_0.playfadeAnim) then
			arg_14_0._animator:Play(MainUISwitchEnum.AnimName.Idle, 0, 0)
		else
			arg_14_0._animator:Play(var_14_0.playfadeAnim, 0, 0)
		end
	end
end

function var_0_0._playSpineAnim(arg_15_0, arg_15_1)
	if arg_15_0._spineSkeleton then
		arg_15_0._spineSkeleton:PlayAnim(arg_15_1, false, true)
	end

	if arg_15_0._bottomSpineSkeleton then
		arg_15_0._bottomSpineSkeleton:PlayAnim(arg_15_1, false, true)
	end
end

function var_0_0._normalAnimFinish(arg_16_0)
	if not arg_16_0._curAnimStep then
		return
	end

	local var_16_0 = arg_16_0:_getOddNextStepId(arg_16_0._curAnimStep)

	if not var_16_0 then
		return
	end

	arg_16_0:_beginStep(var_16_0)
end

function var_0_0._getOddNextStepId(arg_17_0, arg_17_1)
	local var_17_0 = MainUISwitchConfig.instance:getEagleAnim(arg_17_1)

	if not var_17_0 or string.nilorempty(var_17_0.odds_nextstep) then
		return
	end

	local var_17_1 = GameUtil.splitString2(var_17_0.odds_nextstep, true)

	if not var_17_1 then
		return
	end

	local var_17_2 = math.random(1, 100)

	return (arg_17_0:_getRandomStep(var_17_1, var_17_2))
end

function var_0_0._onAnimEvent(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._showSkinId == 1 or not arg_18_0._animator then
		return
	end

	if arg_18_2 == SpineAnimEvent.ActionComplete then
		if arg_18_0._playedAnimTimes >= arg_18_0._neeedPlayAnimTimes then
			arg_18_0:_beginAnim()
		else
			arg_18_0._playedAnimTimes = arg_18_0._playedAnimTimes + 1

			arg_18_0:_playSpineAnim(arg_18_0._animName)
		end
	end
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._uiSpine then
		arg_19_0._uiSpine:onDestroy()

		arg_19_0._uiSpine = nil
	end

	if arg_19_0._uiBottomSpine then
		arg_19_0._uiBottomSpine:onDestroy()

		arg_19_0._uiBottomSpine = nil
	end

	if arg_19_0._bottomFadeTweenId then
		ZProj.TweenHelper.KillById(arg_19_0._bottomFadeTweenId)

		arg_19_0._bottomFadeTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_19_0._normalAnimFinish, arg_19_0)
end

return var_0_0
