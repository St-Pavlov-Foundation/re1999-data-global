module("modules.logic.fight.entity.comp.FightNameUIVisibleComp", package.seeall)

local var_0_0 = class("FightNameUIVisibleComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._showBySkillStart = {}
	arg_1_0._hideByEntity = {}
	arg_1_0._showByTimeline = {}
	arg_1_0._hideByTimeline = {}
end

function var_0_0.addEventListeners(arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	FightController.instance:registerCallback(FightEvent.SetEntityVisibleByTimeline, arg_2_0._setEntityVisibleByTimeline, arg_2_0)
	FightController.instance:registerCallback(FightEvent.SetNameUIVisibleByTimeline, arg_2_0._setNameUIVisibleByTimeline, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, arg_2_0._forceEndSkillStep, arg_2_0, LuaEventSystem.High)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.beforeDestroy(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityVisibleByTimeline, arg_3_0._setEntityVisibleByTimeline, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.SetNameUIVisibleByTimeline, arg_3_0._setNameUIVisibleByTimeline, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, arg_3_0._forceEndSkillStep, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.FightQuitTipView and arg_4_0.entity.nameUI then
		arg_4_0.entity.nameUI:setActive(false)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.FightQuitTipView then
		arg_5_0:_checkVisible()
	end
end

local var_0_1 = {
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function var_0_0._onSkillPlayStart(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if FightHelper.getRelativeEntityIdDict(arg_6_3, var_0_1)[arg_6_0.entity.id] then
		table.insert(arg_6_0._showBySkillStart, arg_6_3)
	end

	arg_6_0:_checkVisible()
end

function var_0_0._onSkillPlayFinish(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	tabletool.removeValue(arg_7_0._showBySkillStart, arg_7_3)
	tabletool.removeValue(arg_7_0._hideByEntity, arg_7_3)
	tabletool.removeValue(arg_7_0._showByTimeline, arg_7_3)
	tabletool.removeValue(arg_7_0._hideByTimeline, arg_7_3)

	local var_7_0
	local var_7_1 = FightHelper.getAllEntitys()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.skill and iter_7_1.skill:sameSkillPlaying() then
			var_7_0 = true

			break
		end
	end

	if var_7_0 then
		return
	end

	arg_7_0:_checkVisible()
end

function var_0_0._forceEndSkillStep(arg_8_0, arg_8_1)
	tabletool.removeValue(arg_8_0._hideByEntity, arg_8_1)
end

function var_0_0._setEntityVisibleByTimeline(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0.entity.id ~= arg_9_1.id then
		return
	end

	tabletool.removeValue(arg_9_0._hideByEntity, arg_9_2)

	if not arg_9_3 then
		table.insert(arg_9_0._hideByEntity, arg_9_2)
	end

	arg_9_0:_checkVisible()
end

function var_0_0._setNameUIVisibleByTimeline(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0.entity.id ~= arg_10_1.id then
		return
	end

	if arg_10_3 then
		if not tabletool.indexOf(arg_10_0._showByTimeline, arg_10_2) then
			table.insert(arg_10_0._showByTimeline, arg_10_2)
		end
	elseif not tabletool.indexOf(arg_10_0._hideByTimeline, arg_10_2) then
		table.insert(arg_10_0._hideByTimeline, arg_10_2)
	end

	arg_10_0:_checkVisible()
end

function var_0_0._checkVisible(arg_11_0)
	if arg_11_0.entity.nameUI then
		if FightSkillMgr.instance:isPlayingAnyTimeline() then
			if #arg_11_0._hideByEntity > 0 then
				arg_11_0.entity.nameUI:setActive(false)
			elseif #arg_11_0._showByTimeline > 0 then
				arg_11_0.entity.nameUI:setActive(true)
			elseif #arg_11_0._hideByTimeline > 0 then
				arg_11_0.entity.nameUI:setActive(false)
			elseif #arg_11_0._showBySkillStart > 0 then
				arg_11_0.entity.nameUI:setActive(true)
			else
				arg_11_0.entity.nameUI:setActive(false)
			end
		else
			arg_11_0.entity.nameUI:setActive(true)
		end
	end
end

return var_0_0
