module("modules.logic.versionactivity1_4.act129.view.Activity129HeroView", package.seeall)

slot0 = class("Activity129HeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._goRole = gohelper.findChild(slot0.viewGO, "#goRole")
	slot0._golightspinecontrol = gohelper.findChild(slot0._goRole, "#go_lightspinecontrol")
	slot0._gospinescale = gohelper.findChild(slot0._goRole, "#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_Dialouge")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_Dialouge/#txt_DialougeEn")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom")
	slot0.clickcd = 5

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, slot0.onEnterPool, slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnClickEmptyPool, slot0.onClickEmptyPool, slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, slot0.onLotterySuccess, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, slot0.onEnterPool, slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnClickEmptyPool, slot0.onClickEmptyPool, slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, slot0.onLotterySuccess, slot0)
end

function slot0.onOpen(slot0)
	slot0:_updateHero(306601)
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._golightspinecontrol)

	slot0._click:AddClickListener(slot0._onClick, slot0)
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

function slot0._onLightSpineLoaded(slot0)
	slot0._uiSpine:setModelVisible(true)

	slot0._l2d = slot0._uiSpine:_getLive2d()

	slot0:playVoice(uv0.getShopVoice(Activity129Enum.VoiceType.EnterShop, slot0._heroId, slot0._skinId))
	slot0._l2d:setActionEventCb(slot0._onAnimEnd, slot0)
end

function slot0._onAnimEnd(slot0)
end

function slot0.isPlayingVoice(slot0)
	if not slot0._uiSpine then
		return false
	end

	return slot0._uiSpine:isPlayingVoice()
end

function slot0._onClick(slot0)
	if not slot0._interactionStartTime or slot0.clickcd < Time.time - slot0._interactionStartTime then
		slot0._interactionStartTime = Time.time

		slot0:playVoice(uv0.getShopVoice(Activity129Enum.VoiceType.ClickHero, slot0._heroId, slot0._skinId))
	end
end

function slot0.onEnterPool(slot0)
	if not Activity129Model.instance:getSelectPoolId() then
		return
	end

	slot0:playVoice(uv0.getShopVoice(Activity129Enum.VoiceType.ClickPool, slot0._heroId, slot0._skinId, function (slot0)
		for slot5, slot6 in pairs(string.splitToNumber(slot0.param, "#")) do
			if slot6 == uv0 then
				return true
			end
		end

		return false
	end))
end

function slot0.onClickEmptyPool(slot0)
	slot0:playVoice(uv0.getShopVoice(Activity129Enum.VoiceType.ClickEmptyPool, slot0._heroId, slot0._skinId))
end

function slot0.onLotterySuccess(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = {}
	slot3 = {}

	for slot7 = 1, #slot1 do
		if not slot2[slot1[slot7][1]] then
			slot2[slot8[1]] = {}
		end

		slot2[slot8[1]][slot8[2]] = true
		slot3[ItemModel.instance:getItemConfigAndIcon(slot8[1], slot8[2]).rare] = true
	end

	slot7 = {}

	if uv0.getShopVoices({
		Activity129Enum.VoiceType.DrawGoosById,
		Activity129Enum.VoiceType.DrawGoodsByRare
	}, slot0._heroId, slot0._skinId, {
		function (slot0)
			if slot0.type ~= Activity129Enum.VoiceType.DrawGoosById then
				return true
			end

			return uv0[string.splitToNumber(slot0.param, "#")[1]] and uv0[slot1[1]][slot1[2]] and true or false
		end,
		function (slot0)
			if slot0.type ~= Activity129Enum.VoiceType.DrawGoodsByRare then
				return true
			end

			for slot5, slot6 in pairs(string.splitToNumber(slot0.param, "#")) do
				if uv0[slot6] then
					return true
				end
			end

			return false
		end
	}) then
		for slot11, slot12 in ipairs(slot6) do
			slot13 = 4

			if slot12.type == Activity129Enum.VoiceType.DrawGoosById then
				slot14 = string.splitToNumber(slot12.param, "#")

				if ItemModel.instance:getItemConfig(slot14[1], slot14[2]).rare > 3 then
					slot13 = 1
				else
					slot13 = 3
				end
			elseif slot12.type == Activity129Enum.VoiceType.DrawGoodsByRare then
				slot15 = nil

				for slot19, slot20 in ipairs(string.splitToNumber(slot12.param, "#")) do
					if not slot15 or slot15 < slot20 then
						slot15 = slot20
					end
				end

				slot13 = slot15 > 3 and 2 or 4
			end

			table.insert(slot7, {
				order = slot13,
				voice = slot12
			})
		end
	end

	slot8 = nil

	if #slot7 > 1 then
		table.sort(slot7, SortUtil.keyLower("order"))
	end

	if slot7[1] then
		slot9 = {}

		for slot13, slot14 in ipairs(slot7) do
			if slot14.order == slot8.order then
				table.insert(slot9, slot14)
			end
		end

		slot8 = uv0.getHeightWeight(slot9)
	end

	if slot8 then
		slot0:playVoice(slot8.voice)
	end
end

function slot0.playVoice(slot0, slot1)
	if not slot0._uiSpine then
		return
	end

	if not slot1 then
		return
	end

	slot0:stopVoice()
	slot0._uiSpine:playVoice(slot1, nil, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
end

function slot0.getShopVoice(slot0, slot1, slot2, slot3, slot4)
	slot5 = WeatherModel.instance:getNowDate()
	slot5.hour = 0
	slot5.min = 0
	slot5.sec = 0
	slot6 = os.time(slot5)
	slot7 = os.time()
	slot9 = Activity129Model.instance:getShopVoiceConfig(slot1, slot0, function (slot0)
		if GameUtil.splitString2(slot0.time, false, "|", "#") and #slot1 > 0 then
			for slot5, slot6 in ipairs(slot1) do
				if uv0._checkTime(slot6, uv1, uv2) then
					return true
				end
			end

			return false
		end

		return true
	end, slot2)

	if slot3 then
		slot10 = {}

		if slot9 then
			for slot14, slot15 in ipairs(slot9) do
				if slot3(slot15) then
					table.insert(slot10, slot15)
				end
			end
		end

		slot9 = slot10
	end

	if slot4 then
		table.sort(slot9, slot4)

		return slot9[1]
	end

	return uv0.getHeightWeight(slot9)
end

function slot0.getShopVoices(slot0, slot1, slot2, slot3)
	slot4 = WeatherModel.instance:getNowDate()
	slot4.hour = 0
	slot4.min = 0
	slot4.sec = 0
	slot5 = os.time(slot4)
	slot6 = os.time()
	slot8 = {}

	for slot12, slot13 in ipairs(slot0) do
		if Activity129Model.instance:getShopVoiceConfig(slot1, slot13, function (slot0)
			if GameUtil.splitString2(slot0.time, false, "|", "#") and #slot1 > 0 then
				for slot5, slot6 in ipairs(slot1) do
					if uv0._checkTime(slot6, uv1, uv2) then
						return true
					end
				end

				return false
			end

			return true
		end, slot2) then
			slot15 = {}

			for slot19, slot20 in ipairs(slot14) do
				slot21 = true

				if slot3 then
					for slot25, slot26 in ipairs(slot3) do
						if not slot26(slot20) then
							slot21 = false

							break
						end
					end
				end

				if slot21 then
					table.insert(slot15, slot20)
				end
			end

			tabletool.addValues(slot8, slot15)
		end
	end

	return slot8
end

function slot0.getHeightWeight(slot0)
	return slot0[math.random(1, #slot0)]
end

function slot0._checkTime(slot0, slot1, slot2)
	if #string.splitToNumber(slot0[1], ":") == 5 then
		slot5, slot6, slot7, slot8, slot9 = unpack(slot3)
		slot10, slot11, slot12, slot13, slot14 = unpack(string.splitToNumber(slot0[2], ":"))

		return os.time({
			year = slot5,
			month = slot6,
			day = slot7,
			hour = slot8,
			min = slot9
		}) <= slot2 and slot2 <= os.time({
			year = slot10,
			month = slot11,
			day = slot12,
			hour = slot13,
			min = slot14
		})
	else
		slot5 = tonumber(slot3[2])
		slot6 = tonumber(slot0[2])

		if not tonumber(slot3[1]) or not slot5 or not slot6 then
			return false
		end

		slot7 = slot1 + (slot4 * 60 + slot5) * 60

		return slot7 <= slot2 and slot2 <= slot7 + slot6 * 3600
	end
end

function slot0.onClose(slot0)
	slot0._click:RemoveClickListener()
	slot0:stopVoice()
end

function slot0.stopVoice(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_system_voc)

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
