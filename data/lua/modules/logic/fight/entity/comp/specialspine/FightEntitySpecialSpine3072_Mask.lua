module("modules.logic.fight.entity.comp.specialspine.FightEntitySpecialSpine3072_Mask", package.seeall)

local var_0_0 = class("FightEntitySpecialSpine3072_Mask", UserDataDispose)
local var_0_1 = 30720101

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._entity = arg_1_1

	arg_1_0:_initSpine()
	arg_1_0:addEventCb(FightController.instance, FightEvent.SetEntityAlpha, arg_1_0._onSetEntityAlpha, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, arg_1_0._onFightReconnectLastWork, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.TimelinePlayEntityAni, arg_1_0._onTimelinePlayEntityAni, arg_1_0)
end

function var_0_0._onBuffUpdate(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 ~= arg_2_0._entity.id then
		return
	end

	if arg_2_3 ~= var_0_1 then
		return
	end

	arg_2_0:_detectMaskBuff()
end

function var_0_0._detectMaskBuff(arg_3_0)
	local var_3_0 = false
	local var_3_1 = arg_3_0._entity:getMO()

	if var_3_1 then
		local var_3_2 = var_3_1:getBuffDic()

		for iter_3_0, iter_3_1 in pairs(var_3_2) do
			if iter_3_1.buffId == var_0_1 then
				var_3_0 = true

				break
			end
		end
	end

	arg_3_0._showMask = var_3_0

	arg_3_0:_refreshMaskVisible()
end

function var_0_0._refreshMaskVisible(arg_4_0)
	if not gohelper.isNil(arg_4_0._spineRoot) then
		local var_4_0 = true

		if not arg_4_0._showMask then
			var_4_0 = false
		end

		if arg_4_0._entity.marked_alpha == 0 then
			var_4_0 = false
		end

		if arg_4_0._playingSkill then
			var_4_0 = false
		end

		if arg_4_0._playingAni then
			var_4_0 = false
		end

		transformhelper.setLocalPos(arg_4_0._spineRootTransform, var_4_0 and 0 or 20000, 0, 0)

		if var_4_0 then
			arg_4_0:_correctAniTime()
		end
	end
end

function var_0_0._onSetEntityAlpha(arg_5_0, arg_5_1)
	arg_5_0:_refreshMaskVisible()
end

function var_0_0._initSpine(arg_6_0)
	arg_6_0._spineRoot = gohelper.create3d(arg_6_0._entity.go, "specialSpine")
	arg_6_0._spineRootTransform = arg_6_0._spineRoot.transform
	arg_6_0._spine = MonoHelper.addLuaComOnceToGo(arg_6_0._spineRoot, UnitSpine, arg_6_0._entity)

	local var_6_0 = arg_6_0._entity:getMO()
	local var_6_1
	local var_6_2 = var_6_0.skin == 307203 and "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab" or string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", var_6_0.skin, var_6_0.skin)

	arg_6_0._spine:setResPath(var_6_2, arg_6_0._onSpineLoaded, arg_6_0)
end

function var_0_0._onSpineLoaded(arg_7_0, arg_7_1)
	if arg_7_0._layer then
		arg_7_0:setLayer(arg_7_0._layer, arg_7_0._recursive)
	end

	if arg_7_0._order then
		arg_7_0:setRenderOrder(arg_7_0._order, true)
	end

	if arg_7_0._isActive ~= nil then
		arg_7_0:setActive(arg_7_0._isActive)
	end

	arg_7_0._spine._skeletonAnim.freeze = arg_7_0._entity.spine._bFreeze
	arg_7_0._spine._skeletonAnim.timeScale = arg_7_0._entity.spine._timeScale

	local var_7_0 = arg_7_0._entity.spine

	if var_7_0._skeletonAnim.state:GetCurrent(0) and arg_7_0._spine._skeletonAnim then
		arg_7_0:playAnim(var_7_0:getAnimState(), var_7_0._isLoop, true)
	end

	arg_7_0:_detectMaskBuff()
	arg_7_0:_refreshMaskVisible()
end

function var_0_0._correctAniTime(arg_8_0)
	local var_8_0 = arg_8_0._entity.spine._skeletonAnim.state:GetCurrent(0)

	if var_8_0 and arg_8_0._spine._skeletonAnim then
		arg_8_0._spine._skeletonAnim:Jump2Time(var_8_0.TrackTime)
	end
end

function var_0_0.playAnim(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0._spine and arg_9_0._spine._skeletonAnim and arg_9_0._spine:hasAnimation(arg_9_1) then
		arg_9_0._spine:playAnim(arg_9_1, arg_9_2, arg_9_3)
	end
end

function var_0_0.setFreeze(arg_10_0, arg_10_1)
	if arg_10_0._spine then
		arg_10_0._spine:setFreeze(arg_10_1)
	end
end

function var_0_0.setTimeScale(arg_11_0, arg_11_1)
	if arg_11_0._spine then
		arg_11_0._spine:setTimeScale(arg_11_1)
	end
end

function var_0_0.setLayer(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._layer = arg_12_1
	arg_12_0._recursive = arg_12_2

	if arg_12_0._spine and arg_12_1 then
		arg_12_0._spine:setLayer(arg_12_1, arg_12_2)
	end
end

function var_0_0.setRenderOrder(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._order = arg_13_1

	if arg_13_0._spine and arg_13_1 then
		arg_13_0._spine:setRenderOrder(arg_13_1 + 1, arg_13_2)
	end
end

function var_0_0.changeLookDir(arg_14_0, arg_14_1)
	if arg_14_0._spine then
		arg_14_0._spine:changeLookDir(arg_14_1)
	end
end

function var_0_0._changeLookDir(arg_15_0)
	if arg_15_0._spine then
		arg_15_0._spine:_changeLookDir()
	end
end

function var_0_0.setActive(arg_16_0, arg_16_1)
	arg_16_0._isActive = arg_16_1

	if arg_16_0._spine then
		arg_16_0._spine:setActive(arg_16_1)
	end
end

function var_0_0.setAnimation(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0._spine then
		arg_17_0._spine:setAnimation(arg_17_1, arg_17_2, arg_17_3)
	end
end

function var_0_0._onSkillPlayStart(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1.id == arg_18_0._entity.id then
		arg_18_0._playingSkill = true

		arg_18_0:_refreshMaskVisible()
	end
end

function var_0_0._onSkillPlayFinish(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1.id == arg_19_0._entity.id then
		arg_19_0._playingSkill = false

		arg_19_0:_refreshMaskVisible()
	end
end

function var_0_0._onTimelinePlayEntityAni(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == arg_20_0._entity.id then
		arg_20_0._playingAni = arg_20_2

		arg_20_0:_refreshMaskVisible()
	end
end

function var_0_0._onFightReconnectLastWork(arg_21_0)
	arg_21_0:_onBuffUpdate(arg_21_0._entity.id, nil, var_0_1)
end

function var_0_0.releaseSelf(arg_22_0)
	if arg_22_0._spineRoot then
		gohelper.destroy(arg_22_0._spineRoot)
	end

	arg_22_0._entity = nil

	arg_22_0:__onDispose()
end

return var_0_0
