module("modules.logic.versionactivity1_4.act129.view.Activity129HeroView", package.seeall)

local var_0_0 = class("Activity129HeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goRole = gohelper.findChild(arg_1_0.viewGO, "#goRole")
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0._goRole, "#go_lightspinecontrol")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0._goRole, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_Dialouge")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_Dialouge/#txt_DialougeEn")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom")
	arg_1_0.clickcd = 5

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, arg_2_0.onEnterPool, arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnClickEmptyPool, arg_2_0.onClickEmptyPool, arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, arg_2_0.onLotterySuccess, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, arg_3_0.onEnterPool, arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnClickEmptyPool, arg_3_0.onClickEmptyPool, arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, arg_3_0.onLotterySuccess, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_updateHero(306601)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._click = SLFramework.UGUI.UIClickListener.Get(arg_5_0._golightspinecontrol)

	arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
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

function var_0_0._onLightSpineLoaded(arg_7_0)
	arg_7_0._uiSpine:setModelVisible(true)

	arg_7_0._l2d = arg_7_0._uiSpine:_getLive2d()

	local var_7_0 = var_0_0.getShopVoice(Activity129Enum.VoiceType.EnterShop, arg_7_0._heroId, arg_7_0._skinId)

	arg_7_0:playVoice(var_7_0)
	arg_7_0._l2d:setActionEventCb(arg_7_0._onAnimEnd, arg_7_0)
end

function var_0_0._onAnimEnd(arg_8_0)
	return
end

function var_0_0.isPlayingVoice(arg_9_0)
	if not arg_9_0._uiSpine then
		return false
	end

	return arg_9_0._uiSpine:isPlayingVoice()
end

function var_0_0._onClick(arg_10_0)
	if not arg_10_0._interactionStartTime or Time.time - arg_10_0._interactionStartTime > arg_10_0.clickcd then
		arg_10_0._interactionStartTime = Time.time

		local var_10_0 = var_0_0.getShopVoice(Activity129Enum.VoiceType.ClickHero, arg_10_0._heroId, arg_10_0._skinId)

		arg_10_0:playVoice(var_10_0)
	end
end

function var_0_0.onEnterPool(arg_11_0)
	local var_11_0 = Activity129Model.instance:getSelectPoolId()

	if not var_11_0 then
		return
	end

	local function var_11_1(arg_12_0)
		local var_12_0 = string.splitToNumber(arg_12_0.param, "#")

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			if iter_12_1 == var_11_0 then
				return true
			end
		end

		return false
	end

	local var_11_2 = var_0_0.getShopVoice(Activity129Enum.VoiceType.ClickPool, arg_11_0._heroId, arg_11_0._skinId, var_11_1)

	arg_11_0:playVoice(var_11_2)
end

function var_0_0.onClickEmptyPool(arg_13_0)
	local var_13_0 = var_0_0.getShopVoice(Activity129Enum.VoiceType.ClickEmptyPool, arg_13_0._heroId, arg_13_0._skinId)

	arg_13_0:playVoice(var_13_0)
end

function var_0_0.onLotterySuccess(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0 = 1, #arg_14_1 do
		local var_14_2 = arg_14_1[iter_14_0]

		if not var_14_0[var_14_2[1]] then
			var_14_0[var_14_2[1]] = {}
		end

		var_14_0[var_14_2[1]][var_14_2[2]] = true
		var_14_1[ItemModel.instance:getItemConfigAndIcon(var_14_2[1], var_14_2[2]).rare] = true
	end

	local function var_14_3(arg_15_0)
		if arg_15_0.type ~= Activity129Enum.VoiceType.DrawGoosById then
			return true
		end

		local var_15_0 = string.splitToNumber(arg_15_0.param, "#")

		return var_14_0[var_15_0[1]] and var_14_0[var_15_0[1]][var_15_0[2]] and true or false
	end

	local function var_14_4(arg_16_0)
		if arg_16_0.type ~= Activity129Enum.VoiceType.DrawGoodsByRare then
			return true
		end

		local var_16_0 = string.splitToNumber(arg_16_0.param, "#")

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			if var_14_1[iter_16_1] then
				return true
			end
		end

		return false
	end

	local var_14_5 = var_0_0.getShopVoices({
		Activity129Enum.VoiceType.DrawGoosById,
		Activity129Enum.VoiceType.DrawGoodsByRare
	}, arg_14_0._heroId, arg_14_0._skinId, {
		var_14_3,
		var_14_4
	})
	local var_14_6 = {}

	if var_14_5 then
		for iter_14_1, iter_14_2 in ipairs(var_14_5) do
			local var_14_7 = 4

			if iter_14_2.type == Activity129Enum.VoiceType.DrawGoosById then
				local var_14_8 = string.splitToNumber(iter_14_2.param, "#")

				if ItemModel.instance:getItemConfig(var_14_8[1], var_14_8[2]).rare > 3 then
					var_14_7 = 1
				else
					var_14_7 = 3
				end
			elseif iter_14_2.type == Activity129Enum.VoiceType.DrawGoodsByRare then
				local var_14_9 = string.splitToNumber(iter_14_2.param, "#")
				local var_14_10

				for iter_14_3, iter_14_4 in ipairs(var_14_9) do
					if not var_14_10 or var_14_10 < iter_14_4 then
						var_14_10 = iter_14_4
					end
				end

				var_14_7 = var_14_10 > 3 and 2 or 4
			end

			table.insert(var_14_6, {
				order = var_14_7,
				voice = iter_14_2
			})
		end
	end

	local var_14_11

	if #var_14_6 > 1 then
		table.sort(var_14_6, SortUtil.keyLower("order"))
	end

	local var_14_12 = var_14_6[1]

	if var_14_12 then
		local var_14_13 = {}

		for iter_14_5, iter_14_6 in ipairs(var_14_6) do
			if iter_14_6.order == var_14_12.order then
				table.insert(var_14_13, iter_14_6)
			end
		end

		var_14_12 = var_0_0.getHeightWeight(var_14_13)
	end

	if var_14_12 then
		arg_14_0:playVoice(var_14_12.voice)
	end
end

function var_0_0.playVoice(arg_17_0, arg_17_1)
	if not arg_17_0._uiSpine then
		return
	end

	if not arg_17_1 then
		return
	end

	arg_17_0:stopVoice()
	arg_17_0._uiSpine:playVoice(arg_17_1, nil, arg_17_0._txtanacn, arg_17_0._txtanaen, arg_17_0._gocontentbg)
end

function var_0_0.getShopVoice(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
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

	local var_18_4 = Activity129Model.instance:getShopVoiceConfig(arg_18_1, arg_18_0, var_18_3, arg_18_2)

	if arg_18_3 then
		local var_18_5 = {}

		if var_18_4 then
			for iter_18_0, iter_18_1 in ipairs(var_18_4) do
				if arg_18_3(iter_18_1) then
					table.insert(var_18_5, iter_18_1)
				end
			end
		end

		var_18_4 = var_18_5
	end

	if arg_18_4 then
		table.sort(var_18_4, arg_18_4)

		return var_18_4[1]
	end

	return (var_0_0.getHeightWeight(var_18_4))
end

function var_0_0.getShopVoices(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = WeatherModel.instance:getNowDate()

	var_20_0.hour = 0
	var_20_0.min = 0
	var_20_0.sec = 0

	local var_20_1 = os.time(var_20_0)
	local var_20_2 = os.time()

	local function var_20_3(arg_21_0)
		local var_21_0 = GameUtil.splitString2(arg_21_0.time, false, "|", "#")

		if var_21_0 and #var_21_0 > 0 then
			for iter_21_0, iter_21_1 in ipairs(var_21_0) do
				if var_0_0._checkTime(iter_21_1, var_20_1, var_20_2) then
					return true
				end
			end

			return false
		end

		return true
	end

	local var_20_4 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
		local var_20_5 = Activity129Model.instance:getShopVoiceConfig(arg_20_1, iter_20_1, var_20_3, arg_20_2)

		if var_20_5 then
			local var_20_6 = {}

			for iter_20_2, iter_20_3 in ipairs(var_20_5) do
				local var_20_7 = true

				if arg_20_3 then
					for iter_20_4, iter_20_5 in ipairs(arg_20_3) do
						if not iter_20_5(iter_20_3) then
							var_20_7 = false

							break
						end
					end
				end

				if var_20_7 then
					table.insert(var_20_6, iter_20_3)
				end
			end

			tabletool.addValues(var_20_4, var_20_6)
		end
	end

	return var_20_4
end

function var_0_0.getHeightWeight(arg_22_0)
	return arg_22_0[math.random(1, #arg_22_0)]
end

function var_0_0._checkTime(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = string.splitToNumber(arg_23_0[1], ":")

	if #var_23_0 == 5 then
		local var_23_1 = string.splitToNumber(arg_23_0[2], ":")
		local var_23_2, var_23_3, var_23_4, var_23_5, var_23_6 = unpack(var_23_0)
		local var_23_7, var_23_8, var_23_9, var_23_10, var_23_11 = unpack(var_23_1)
		local var_23_12 = os.time({
			year = var_23_2,
			month = var_23_3,
			day = var_23_4,
			hour = var_23_5,
			min = var_23_6
		})
		local var_23_13 = os.time({
			year = var_23_7,
			month = var_23_8,
			day = var_23_9,
			hour = var_23_10,
			min = var_23_11
		})

		return var_23_12 <= arg_23_2 and arg_23_2 <= var_23_13
	else
		local var_23_14 = tonumber(var_23_0[1])
		local var_23_15 = tonumber(var_23_0[2])
		local var_23_16 = tonumber(arg_23_0[2])

		if not var_23_14 or not var_23_15 or not var_23_16 then
			return false
		end

		local var_23_17 = arg_23_1 + (var_23_14 * 60 + var_23_15) * 60
		local var_23_18 = var_23_17 + var_23_16 * 3600

		return var_23_17 <= arg_23_2 and arg_23_2 <= var_23_18
	end
end

function var_0_0.onClose(arg_24_0)
	arg_24_0._click:RemoveClickListener()
	arg_24_0:stopVoice()
end

function var_0_0.stopVoice(arg_25_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_system_voc)

	if arg_25_0._uiSpine then
		arg_25_0._uiSpine:stopVoice()
	end
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
