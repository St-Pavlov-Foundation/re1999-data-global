﻿module("modules.logic.versionactivity2_5.act186.view.Activity186HeroView", package.seeall)

local var_0_0 = class("Activity186HeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goRole = gohelper.findChild(arg_1_0.viewGO, "root/#goRole")
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0._goRole, "#go_lightspinecontrol")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0._goRole, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0._goRole, "bottom/#txt_Dialouge")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0._goRole, "bottom/#txt_Dialouge/#txt_DialougeEn")
	arg_1_0._txtnamecn = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#goRole/bottom/#go_name/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#goRole/bottom/#go_name/#txt_namecn/#txt_nameen")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0._goRole, "bottom")

	gohelper.setActive(arg_1_0._gocontentbg, false)

	arg_1_0.clickcd = 5

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.PlayTalk, arg_2_0.onPlayTalk, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onPlayTalk(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = lua_actvity186_voice.configDict[arg_4_1]

	arg_4_0:playVoice(var_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:_updateHero()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._click = SLFramework.UGUI.UIClickListener.Get(arg_6_0._golightspinecontrol)

	arg_6_0._click:AddClickListener(arg_6_0._onClick, arg_6_0)
end

function var_0_0.refreshParam(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam and arg_7_0.viewParam.actId
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

	arg_8_0._uiSpine:setResPath(Activity186Enum.RolePath, arg_8_0._onLightSpineLoaded, arg_8_0)

	arg_8_0._txtnamecn.text = luaLang("act186_hero_name")
	arg_8_0._txtnameen.text = "Han Zhang"
end

function var_0_0._onLightSpineLoaded(arg_11_0)
	arg_11_0._uiSpine:showModel()

	local var_11_0 = var_0_0.getShopVoice(Activity186Enum.VoiceType.EnterView, var_0_0.checkParam, arg_11_0.actId)

	arg_11_0:playVoice(var_11_0)
	arg_11_0._uiSpine:setActionEventCb(arg_11_0._onAnimEnd, arg_11_0)
end

function var_0_0._onAnimEnd(arg_12_0)
	return
end

function var_0_0.isPlayingVoice(arg_13_0)
	if not arg_13_0._uiSpine then
		return false
	end

	return arg_13_0._uiSpine:isPlayingVoice()
end

function var_0_0._onClick(arg_14_0)
	if not arg_14_0._interactionStartTime or Time.time - arg_14_0._interactionStartTime > arg_14_0.clickcd then
		arg_14_0._interactionStartTime = Time.time

		local var_14_0 = var_0_0.getShopVoice(Activity186Enum.VoiceType.ClickSkin, var_0_0.checkParam, arg_14_0.actId)

		arg_14_0:playVoice(var_14_0)
	end
end

function var_0_0.playVoice(arg_15_0, arg_15_1)
	if not arg_15_0._uiSpine then
		return
	end

	if not arg_15_1 then
		return
	end

	arg_15_0:stopVoice()
	arg_15_0._uiSpine:playVoice(arg_15_1, nil, arg_15_0._txtanacn, nil, arg_15_0._gocontentbg)
	arg_15_0:playUIEffect(arg_15_1)
end

function var_0_0.playUIEffect(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.viewEffect

	if var_16_0 and var_16_0 > 0 then
		ViewMgr.instance:openView(ViewName.Activity186EffectView, {
			effectId = var_16_0
		})
	end
end

function var_0_0.onVoiceStop(arg_17_0)
	ViewMgr.instance:closeView(ViewName.Activity186EffectView)
end

function var_0_0.getShopVoice(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = WeatherModel.instance:getNowDate()

	var_18_0.hour = 0
	var_18_0.min = 0
	var_18_0.sec = 0

	local var_18_1 = os.time(var_18_0)
	local var_18_2 = os.time()

	local function var_18_3(arg_19_0)
		local var_19_0 = GameUtil.splitString2(arg_19_0.time, false, "|", "#")

		if var_19_0 and #var_19_0 > 0 then
			for iter_19_0, iter_19_1 in ipairs(var_19_0) do
				if var_0_0._checkTime(iter_19_1, var_18_1, var_18_2) then
					return true
				end
			end

			return false
		end

		return true
	end

	local var_18_4 = Activity186Config.instance:getVoiceConfig(arg_18_0, var_18_3)

	if arg_18_1 then
		local var_18_5 = Activity186Model.instance:getById(arg_18_2)
		local var_18_6 = {}

		if var_18_4 then
			for iter_18_0, iter_18_1 in ipairs(var_18_4) do
				if arg_18_1(iter_18_1, var_18_5) then
					table.insert(var_18_6, iter_18_1)
				end
			end
		end

		var_18_4 = var_18_6
	end

	if arg_18_3 then
		table.sort(var_18_4, arg_18_3)

		return var_18_4[1]
	end

	return (var_0_0.getHeightWeight(var_18_4))
end

function var_0_0.getHeightWeight(arg_20_0)
	return arg_20_0[math.random(1, #arg_20_0)]
end

function var_0_0._checkTime(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = string.splitToNumber(arg_21_0[1], ":")

	if #var_21_0 == 5 then
		local var_21_1 = string.splitToNumber(arg_21_0[2], ":")
		local var_21_2, var_21_3, var_21_4, var_21_5, var_21_6 = unpack(var_21_0)
		local var_21_7, var_21_8, var_21_9, var_21_10, var_21_11 = unpack(var_21_1)
		local var_21_12 = os.time({
			year = var_21_2,
			month = var_21_3,
			day = var_21_4,
			hour = var_21_5,
			min = var_21_6
		})
		local var_21_13 = os.time({
			year = var_21_7,
			month = var_21_8,
			day = var_21_9,
			hour = var_21_10,
			min = var_21_11
		})

		return var_21_12 <= arg_21_2 and arg_21_2 <= var_21_13
	else
		local var_21_14 = tonumber(var_21_0[1])
		local var_21_15 = tonumber(var_21_0[2])
		local var_21_16 = tonumber(arg_21_0[2])

		if not var_21_14 or not var_21_15 or not var_21_16 then
			return false
		end

		local var_21_17 = arg_21_1 + (var_21_14 * 60 + var_21_15) * 60
		local var_21_18 = var_21_17 + var_21_16 * 3600

		return var_21_17 <= arg_21_2 and arg_21_2 <= var_21_18
	end
end

function var_0_0.checkParam(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.param

	if string.nilorempty(var_22_0) then
		return true
	end

	local var_22_1 = string.splitToNumber(var_22_0, "#")
	local var_22_2 = var_22_1[1]

	if var_22_2 == 1 then
		local var_22_3 = var_22_1[2]

		return arg_22_1.currentStage == var_22_3
	elseif var_22_2 == 2 then
		return arg_22_1:hasActivityReward()
	elseif var_22_2 == 3 then
		return arg_22_1:hasCanRewardTask()
	elseif var_22_2 == 4 then
		local var_22_4 = var_22_1[2]

		return arg_22_1:checkLikeEqual(var_22_4)
	end

	return true
end

function var_0_0.onClose(arg_23_0)
	arg_23_0._click:RemoveClickListener()
	arg_23_0:stopVoice()
end

function var_0_0.stopVoice(arg_24_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_system_voc)

	if arg_24_0._uiSpine then
		arg_24_0._uiSpine:stopVoice()
	end
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
