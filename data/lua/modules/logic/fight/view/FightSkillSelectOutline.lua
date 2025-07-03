module("modules.logic.fight.view.FightSkillSelectOutline", package.seeall)

local var_0_0 = class("FightSkillSelectOutline", BaseView)
local var_0_1 = "_OutlineWidth"
local var_0_2 = "buff/buff_outline"

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._effectWrapDict = {}
	arg_2_0._matDict = arg_2_0:getUserDataTb_()
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnStageChange, arg_3_0._onStageChange, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.AutoToSelectSkillTarget, arg_3_0._hideOutlineEffect, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_3_0._onSelectSkillTarget, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, arg_3_0._beforeEntityDestroy, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_3_0._onCameraFocusChanged, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenView, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.onCloseView, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnStageChange, arg_4_0._onStageChange, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.AutoToSelectSkillTarget, arg_4_0._hideOutlineEffect, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_4_0._onSelectSkillTarget, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, arg_4_0._beforeEntityDestroy, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_4_0._onCameraFocusChanged, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_4_0._onSkillPlayStart, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0.onOpenView, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onCloseView, arg_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0._onStageChange(arg_6_0, arg_6_1)
	if arg_6_1 == FightEnum.Stage.ClothSkill then
		return
	end

	if arg_6_1 ~= FightEnum.Stage.Card then
		arg_6_0:_hideOutlineEffect()
	end
end

function var_0_0._onSkillPlayStart(arg_7_0)
	arg_7_0:_hideOutlineEffect()
end

function var_0_0._onCameraFocusChanged(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0:_hideOutlineEffect()
	else
		arg_8_0:_onSelectSkillTarget(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function var_0_0.onOpenView(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.FightEnemyActionView then
		arg_9_0:_hideOutlineEffect()
	end
end

function var_0_0.onCloseView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.FightEnemyActionView then
		arg_10_0:_onSelectSkillTarget(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function var_0_0._beforeEntityDestroy(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1.id

	if var_11_0 and arg_11_0._effectWrapDict[var_11_0] then
		arg_11_0._effectWrapDict[var_11_0] = nil
	end
end

function var_0_0._hideOutlineEffect(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._effectWrapDict) do
		if not gohelper.isNil(iter_12_1.containerGO) then
			iter_12_1:setActive(false)
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(iter_12_0, iter_12_1)

			arg_12_0._effectWrapDict[iter_12_0] = nil
		end
	end
end

function var_0_0._onSelectSkillTarget(arg_13_0, arg_13_1)
	if FightModel.instance:isAuto() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if not arg_13_0._effectWrapDict[arg_13_1] then
		local var_13_0 = FightHelper.getEntity(arg_13_1)

		if var_13_0 and var_13_0.effect then
			local var_13_1 = var_13_0.effect:addHangEffect(var_0_2, ModuleEnum.SpineHangPointRoot, nil, nil, nil, true)

			var_13_1:setLocalPos(0, 0, 0)

			if gohelper.isNil(var_13_1.effectGO) then
				var_13_1:setCallback(function()
					arg_13_0:_setOutlineWidth(arg_13_1)
				end)
			else
				arg_13_0:_setOutlineWidth(arg_13_1)
			end

			arg_13_0._effectWrapDict[arg_13_1] = var_13_1

			FightRenderOrderMgr.instance:onAddEffectWrap(arg_13_1, var_13_1)
		end
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0._effectWrapDict) do
		if not gohelper.isNil(iter_13_1.containerGO) then
			iter_13_1:setActive(iter_13_0 == arg_13_1)

			if iter_13_0 == arg_13_1 then
				arg_13_0:_setOutlineWidth(iter_13_0)
			end
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(iter_13_0, iter_13_1)

			arg_13_0._effectWrapDict[arg_13_1] = nil
		end
	end
end

function var_0_0._setOutlineWidth(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._matDict[arg_15_1]

	if not var_15_0 then
		local var_15_1 = arg_15_0._effectWrapDict[arg_15_1]

		if var_15_1 and not gohelper.isNil(var_15_1.effectGO) then
			local var_15_2 = gohelper.findChildComponent(var_15_1.effectGO, "diamond/root/diamond", typeof(UnityEngine.Renderer))

			if var_15_2 then
				var_15_0 = var_15_2.material

				if var_15_0 then
					arg_15_0._matDict[arg_15_1] = var_15_0

					if not arg_15_0._defaultOutlineWidth then
						arg_15_0._defaultOutlineWidth = var_15_0:GetFloat(var_0_1)
					end
				else
					logError("outline material not found")
				end
			else
				logError("outline render not found")
			end
		end
	end

	if var_15_0 then
		local var_15_3 = FightDataHelper.entityMgr:getById(arg_15_1)
		local var_15_4 = var_15_3 and var_15_3.skin and lua_monster_skin.configDict[var_15_3.skin]
		local var_15_5 = var_15_4 and var_15_4.outlineWidth

		if var_15_5 and var_15_5 > 0 then
			var_15_0:SetFloat(var_0_1, var_15_5)
		else
			var_15_0:SetFloat(var_0_1, arg_15_0._defaultOutlineWidth)
		end
	end
end

return var_0_0
