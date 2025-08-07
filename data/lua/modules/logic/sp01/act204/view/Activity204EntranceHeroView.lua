module("modules.logic.sp01.act204.view.Activity204EntranceHeroView", package.seeall)

local var_0_0 = class("Activity204EntranceHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goRole = gohelper.findChild(arg_1_0.viewGO, "#goRole")
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0._goRole, "#go_lightspinecontrol")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_Dialouge")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0._goRole, "#go_lightspinecontrol")

	gohelper.setActive(arg_1_0._gocontentbg, false)

	arg_1_0.clickcd = 5

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.PlayTalk, arg_2_0.onPlayTalk, arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.UpdateTask, arg_2_0.onUpdateTask, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenViewCb, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.onPlayTalk(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = lua_actvity204_voice.configDict[arg_4_1]

	arg_4_0:playVoice(var_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:_updateHero()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.refreshParam(arg_7_0)
	arg_7_0.actId = ActivityEnum.Activity.V2a9_Act204
end

function var_0_0._updateHero(arg_8_0)
	if not arg_8_0._uiSpine then
		arg_8_0._uiSpine = GuiSpine.Create(arg_8_0._golightspine, true)
		arg_8_0._uiSpine._spineVoice = SpineVoice.New()

		function arg_8_0._uiSpine._spineVoice._spineVoiceBody.setNormal(arg_9_0)
			if arg_9_0._appointIdleName then
				arg_9_0:setBodyAnimation(arg_9_0._appointIdleName, true, arg_9_0._appointIdleMixTime)

				arg_9_0._appointIdleMixTime = nil

				return
			end

			local var_9_0 = "b_daoju"

			arg_9_0:setBodyAnimation(var_9_0, true)
		end

		local var_8_0 = arg_8_0._uiSpine._spineVoice._spineVoiceText.onVoiceStop

		function arg_8_0._uiSpine._spineVoice._spineVoiceText.onVoiceStop(arg_10_0)
			var_8_0(arg_10_0)
			arg_8_0:onVoiceStop()
		end
	end

	arg_8_0._uiSpine:setResPath(Activity204Enum.RolePath, arg_8_0._onLightSpineLoaded, arg_8_0)
end

function var_0_0._onLightSpineLoaded(arg_11_0)
	arg_11_0._isSpineLoadDone = true

	arg_11_0._uiSpine:showModel()
	arg_11_0:playVoiceOnOpenFinish()
end

function var_0_0.onOpenFinish(arg_12_0)
	arg_12_0:playVoiceOnOpenFinish()
end

function var_0_0.playVoiceOnOpenFinish(arg_13_0)
	if not arg_13_0._isSpineLoadDone or not arg_13_0._has_onOpenFinish then
		return
	end

	local var_13_0 = var_0_0.getShopVoice(Activity204Enum.VoiceType.EnterView, var_0_0.checkParam, arg_13_0.actId)

	arg_13_0:playVoice(var_13_0)
	arg_13_0._uiSpine:setActionEventCb(arg_13_0._onAnimEnd, arg_13_0)
end

function var_0_0._onAnimEnd(arg_14_0)
	return
end

function var_0_0.isPlayingVoice(arg_15_0)
	if not arg_15_0._uiSpine then
		return false
	end

	return arg_15_0._uiSpine:isPlayingVoice()
end

function var_0_0._onClick(arg_16_0)
	arg_16_0:interactHeroVoice(Activity204Enum.VoiceType.ClickSkin)
end

function var_0_0.onUpdateTask(arg_17_0)
	arg_17_0:interactHeroVoice(Activity204Enum.VoiceType.UpdateMainTask)
end

function var_0_0.interactHeroVoice(arg_18_0, arg_18_1)
	if not arg_18_0._interactionStartTime or Time.time - arg_18_0._interactionStartTime > arg_18_0.clickcd then
		arg_18_0._interactionStartTime = Time.time

		local var_18_0 = var_0_0.getShopVoice(arg_18_1, var_0_0.checkParam, arg_18_0.actId)

		arg_18_0:playVoice(var_18_0)
	end
end

function var_0_0.playVoice(arg_19_0, arg_19_1)
	if not arg_19_0._uiSpine then
		return
	end

	if not arg_19_1 then
		return
	end

	arg_19_0:stopVoice()
	arg_19_0._uiSpine:playVoice(arg_19_1, nil, arg_19_0._txtanacn, nil, arg_19_0._gocontentbg)
end

function var_0_0.onVoiceStop(arg_20_0)
	return
end

function var_0_0.getShopVoice(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = WeatherModel.instance:getNowDate()

	var_21_0.hour = 0
	var_21_0.min = 0
	var_21_0.sec = 0

	local var_21_1 = os.time(var_21_0)
	local var_21_2 = os.time()

	local function var_21_3(arg_22_0)
		local var_22_0 = GameUtil.splitString2(arg_22_0.time, false, "|", "#")

		if var_22_0 and #var_22_0 > 0 then
			for iter_22_0, iter_22_1 in ipairs(var_22_0) do
				if var_0_0._checkTime(iter_22_1, var_21_1, var_21_2) then
					return true
				end
			end

			return false
		end

		return true
	end

	local var_21_4 = Activity204Config.instance:getVoiceConfig(arg_21_0, var_21_3)

	if arg_21_1 then
		local var_21_5 = Activity204Model.instance:getById(arg_21_2)
		local var_21_6 = {}

		if var_21_4 then
			for iter_21_0, iter_21_1 in ipairs(var_21_4) do
				if arg_21_1(iter_21_1, var_21_5) then
					table.insert(var_21_6, iter_21_1)
				end
			end
		end

		var_21_4 = var_21_6
	end

	if arg_21_3 then
		table.sort(var_21_4, arg_21_3)

		return var_21_4[1]
	end

	return (var_0_0.getHeightWeight(var_21_4))
end

function var_0_0.getHeightWeight(arg_23_0)
	return arg_23_0[math.random(1, #arg_23_0)]
end

function var_0_0._checkTime(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = string.splitToNumber(arg_24_0[1], ":")

	if #var_24_0 == 5 then
		local var_24_1 = string.splitToNumber(arg_24_0[2], ":")
		local var_24_2, var_24_3, var_24_4, var_24_5, var_24_6 = unpack(var_24_0)
		local var_24_7, var_24_8, var_24_9, var_24_10, var_24_11 = unpack(var_24_1)
		local var_24_12 = os.time({
			year = var_24_2,
			month = var_24_3,
			day = var_24_4,
			hour = var_24_5,
			min = var_24_6
		})
		local var_24_13 = os.time({
			year = var_24_7,
			month = var_24_8,
			day = var_24_9,
			hour = var_24_10,
			min = var_24_11
		})

		return var_24_12 <= arg_24_2 and arg_24_2 <= var_24_13
	else
		local var_24_14 = tonumber(var_24_0[1])
		local var_24_15 = tonumber(var_24_0[2])
		local var_24_16 = tonumber(arg_24_0[2])

		if not var_24_14 or not var_24_15 or not var_24_16 then
			return false
		end

		local var_24_17 = arg_24_1 + (var_24_14 * 60 + var_24_15) * 60
		local var_24_18 = var_24_17 + var_24_16 * 3600

		return var_24_17 <= arg_24_2 and arg_24_2 <= var_24_18
	end
end

function var_0_0.checkParam(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.param

	if string.nilorempty(var_25_0) then
		return true
	end

	local var_25_1 = string.splitToNumber(var_25_0, "#")
	local var_25_2 = var_25_1[1]

	if var_25_2 == 1 then
		local var_25_3 = var_25_1[2]

		return arg_25_1.currentStage == var_25_3
	elseif var_25_2 == 2 then
		return Activity204Controller.instance:isAnyActCanGetReward()
	elseif var_25_2 == 3 then
		return arg_25_1:hasCanRewardTask()
	elseif var_25_2 == 4 then
		local var_25_4 = var_25_1[2]
	end

	return true
end

function var_0_0.onOpenViewCb(arg_26_0, arg_26_1)
	if arg_26_1 == arg_26_0.viewName then
		return
	end

	arg_26_0:stopVoice()
end

function var_0_0.onClose(arg_27_0)
	arg_27_0:stopVoice()
end

function var_0_0.stopVoice(arg_28_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_system_voc)

	if arg_28_0._uiSpine then
		arg_28_0._uiSpine:stopVoice()
		arg_28_0._uiSpine:play(StoryAnimName.B_IDLE, true)
	end
end

function var_0_0.onDestroyView(arg_29_0)
	return
end

return var_0_0
