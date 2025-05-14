module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectSeasonChangeHero", package.seeall)

local var_0_0 = class("FightEntitySpecialEffectSeasonChangeHero", FightEntitySpecialEffectBase)
local var_0_1 = "_OutlineWidth"

function var_0_0.initClass(arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.EnterOperateState, arg_1_0._onEnterOperateState, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.ExitOperateState, arg_1_0._onExitOperateState, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, arg_1_0._onSeasonSelectChangeHeroTarget, arg_1_0)

	arg_1_0._whiteLine = nil
	arg_1_0._orangeLine = nil
end

function var_0_0._onSeasonSelectChangeHeroTarget(arg_2_0, arg_2_1)
	arg_2_0:_releaseOrangeEffect()

	if arg_2_1 == arg_2_0._entity.id then
		arg_2_0._orangeLine = arg_2_0._entity.effect:addHangEffect("buff/buff_outline_orange", ModuleEnum.SpineHangPointRoot)

		arg_2_0._orangeLine:setLocalPos(0, 0, 0)

		if gohelper.isNil(arg_2_0._orangeLine.effectGO) then
			arg_2_0._orangeLine:setCallback(arg_2_0._setOrangeWidth, arg_2_0)
		else
			arg_2_0:_setOrangeWidth()
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(arg_2_0._entity.id, arg_2_0._orangeLine)
		arg_2_0._whiteLine:setActive(false)
	elseif arg_2_0._whiteLine then
		arg_2_0._whiteLine:setActive(true)
	end
end

function var_0_0._setOrangeWidth(arg_3_0)
	arg_3_0:_setOutlineWidth(arg_3_0._orangeLine)
end

function var_0_0._onExitOperateState(arg_4_0, arg_4_1)
	if arg_4_1 ~= FightStageMgr.OperateStateType.SeasonChangeHero then
		return
	end

	arg_4_0:releaseAllEffect()
end

function var_0_0._onEnterOperateState(arg_5_0, arg_5_1)
	if not arg_5_0._entity:isMySide() then
		return
	end

	if arg_5_1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		arg_5_0._whiteLine = arg_5_0._entity.effect:addHangEffect("buff/buff_outline_white", ModuleEnum.SpineHangPointRoot)

		arg_5_0._whiteLine:setLocalPos(0, 0, 0)

		if gohelper.isNil(arg_5_0._whiteLine.effectGO) then
			arg_5_0._whiteLine:setCallback(arg_5_0._setWhileWidth, arg_5_0)
		else
			arg_5_0:_setWhileWidth()
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(arg_5_0._entity.id, arg_5_0._whiteLine)
	end
end

function var_0_0._setWhileWidth(arg_6_0)
	arg_6_0:_setOutlineWidth(arg_6_0._whiteLine)
end

function var_0_0._setOutlineWidth(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0

	if arg_7_1 and not gohelper.isNil(arg_7_1.effectGO) then
		local var_7_1 = gohelper.findChildComponent(arg_7_1.effectGO, "diamond/root/diamond", typeof(UnityEngine.Renderer))

		if var_7_1 then
			var_7_0 = var_7_1.material

			if var_7_0 then
				if not arg_7_0._defaultOutlineWidth then
					arg_7_0._defaultOutlineWidth = var_7_0:GetFloat(var_0_1)
				end
			else
				logError("找不到描边材质")
			end
		else
			logError("找不到描边render")
		end
	end

	if var_7_0 then
		local var_7_2 = arg_7_0._entity:getMO()
		local var_7_3 = var_7_2 and var_7_2.skin and lua_monster_skin.configDict[var_7_2.skin]
		local var_7_4 = var_7_3 and var_7_3.outlineWidth

		if var_7_4 and var_7_4 > 0 then
			var_7_0:SetFloat(var_0_1, var_7_4)
		else
			var_7_0:SetFloat(var_0_1, arg_7_0._defaultOutlineWidth)
		end
	end
end

function var_0_0.releaseAllEffect(arg_8_0)
	arg_8_0:_releaseWhiteEffect()
	arg_8_0:_releaseOrangeEffect()
end

function var_0_0._releaseWhiteEffect(arg_9_0)
	if arg_9_0._whiteLine then
		arg_9_0._entity.effect:removeEffect(arg_9_0._whiteLine)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_9_0._entity.id, arg_9_0._whiteLine)

		arg_9_0._whiteLine = nil
	end
end

function var_0_0._releaseOrangeEffect(arg_10_0)
	if arg_10_0._orangeLine then
		arg_10_0._entity.effect:removeEffect(arg_10_0._orangeLine)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_10_0._entity.id, arg_10_0._orangeLine)

		arg_10_0._orangeLine = nil
	end
end

function var_0_0.releaseSelf(arg_11_0)
	arg_11_0:releaseAllEffect()
end

return var_0_0
