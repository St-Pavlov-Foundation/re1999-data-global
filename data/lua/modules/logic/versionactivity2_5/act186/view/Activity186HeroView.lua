module("modules.logic.versionactivity2_5.act186.view.Activity186HeroView", package.seeall)

slot0 = class("Activity186HeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._goRole = gohelper.findChild(slot0.viewGO, "root/#goRole")
	slot0._golightspinecontrol = gohelper.findChild(slot0._goRole, "#go_lightspinecontrol")
	slot0._gospinescale = gohelper.findChild(slot0._goRole, "#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0._goRole, "#go_spine_scale/lightspine/#go_lightspine")
	slot0._txtanacn = gohelper.findChildText(slot0._goRole, "bottom/#txt_Dialouge")
	slot0._txtanaen = gohelper.findChildText(slot0._goRole, "bottom/#txt_Dialouge/#txt_DialougeEn")
	slot0._txtnamecn = gohelper.findChildTextMesh(slot0.viewGO, "root/#goRole/bottom/#go_name/#txt_namecn")
	slot0._txtnameen = gohelper.findChildTextMesh(slot0.viewGO, "root/#goRole/bottom/#go_name/#txt_namecn/#txt_nameen")
	slot0._gocontentbg = gohelper.findChild(slot0._goRole, "bottom")

	gohelper.setActive(slot0._gocontentbg, false)

	slot0.clickcd = 5

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.PlayTalk, slot0.onPlayTalk, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onPlayTalk(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:playVoice(lua_actvity186_voice.configDict[slot1])
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:_updateHero()
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._golightspinecontrol)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.refreshParam(slot0)
	slot0.actId = slot0.viewParam and slot0.viewParam.actId
end

function slot0._updateHero(slot0)
	if not slot0._uiSpine then
		slot0._uiSpine = GuiSpine.Create(slot0._golightspine, true)
		slot0._uiSpine._spineVoice = SpineVoice.New()

		function slot0._uiSpine._spineVoice._spineVoiceBody.setNormal(slot0)
			if slot0._appointIdleName then
				slot0:setBodyAnimation(slot0._appointIdleName, true, slot0._appointIdleMixTime)

				slot0._appointIdleMixTime = nil

				return
			end

			slot0:setBodyAnimation("b_daoju", true)
		end

		slot1 = slot0._uiSpine._spineVoice._spineVoiceText.onVoiceStop

		function slot0._uiSpine._spineVoice._spineVoiceText.onVoiceStop(slot0)
			uv0(slot0)
			uv1:onVoiceStop()
		end
	end

	slot0._uiSpine:setResPath(Activity186Enum.RolePath, slot0._onLightSpineLoaded, slot0)

	slot0._txtnamecn.text = luaLang("act186_hero_name")
	slot0._txtnameen.text = "Han Zhang"
end

function slot0._onLightSpineLoaded(slot0)
	slot0._uiSpine:showModel()
	slot0:playVoice(uv0.getShopVoice(Activity186Enum.VoiceType.EnterView, uv0.checkParam, slot0.actId))
	slot0._uiSpine:setActionEventCb(slot0._onAnimEnd, slot0)
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

		slot0:playVoice(uv0.getShopVoice(Activity186Enum.VoiceType.ClickSkin, uv0.checkParam, slot0.actId))
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
	slot0._uiSpine:playVoice(slot1, nil, slot0._txtanacn, nil, slot0._gocontentbg)
	slot0:playUIEffect(slot1)
end

function slot0.playUIEffect(slot0, slot1)
	if slot1.viewEffect and slot2 > 0 then
		ViewMgr.instance:openView(ViewName.Activity186EffectView, {
			effectId = slot2
		})
	end
end

function slot0.onVoiceStop(slot0)
	ViewMgr.instance:closeView(ViewName.Activity186EffectView)
end

function slot0.getShopVoice(slot0, slot1, slot2, slot3)
	slot4 = WeatherModel.instance:getNowDate()
	slot4.hour = 0
	slot4.min = 0
	slot4.sec = 0
	slot5 = os.time(slot4)
	slot6 = os.time()
	slot8 = Activity186Config.instance:getVoiceConfig(slot0, function (slot0)
		if GameUtil.splitString2(slot0.time, false, "|", "#") and #slot1 > 0 then
			for slot5, slot6 in ipairs(slot1) do
				if uv0._checkTime(slot6, uv1, uv2) then
					return true
				end
			end

			return false
		end

		return true
	end)

	if slot1 then
		slot9 = Activity186Model.instance:getById(slot2)
		slot10 = {}

		if slot8 then
			for slot14, slot15 in ipairs(slot8) do
				if slot1(slot15, slot9) then
					table.insert(slot10, slot15)
				end
			end
		end

		slot8 = slot10
	end

	if slot3 then
		table.sort(slot8, slot3)

		return slot8[1]
	end

	return uv0.getHeightWeight(slot8)
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

function slot0.checkParam(slot0, slot1)
	if string.nilorempty(slot0.param) then
		return true
	end

	if string.splitToNumber(slot2, "#")[1] == 1 then
		return slot1.currentStage == slot3[2]
	elseif slot4 == 2 then
		return slot1:hasActivityReward()
	elseif slot4 == 3 then
		return slot1:hasCanRewardTask()
	elseif slot4 == 4 then
		return slot1:checkLikeEqual(slot3[2])
	end

	return true
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
