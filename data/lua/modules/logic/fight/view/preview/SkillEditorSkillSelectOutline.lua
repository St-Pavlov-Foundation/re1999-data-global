module("modules.logic.fight.view.preview.SkillEditorSkillSelectOutline", package.seeall)

local var_0_0 = class("SkillEditorSkillSelectOutline", BaseView)
local var_0_1 = "buff/buff_outline"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._effectWrapDict = {}
	arg_1_0._enableOutline = false
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectEntity, arg_2_0._onSelectEntity, arg_2_0)
	arg_2_0:addEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnClickOutline, arg_2_0._onClickOutline, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, arg_2_0._beforeEntityDestroy, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectEntity, arg_3_0._onSelectEntity, arg_3_0)
	arg_3_0:removeEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnClickOutline, arg_3_0._onClickOutline, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, arg_3_0._beforeEntityDestroy, arg_3_0)
end

function var_0_0._beforeEntityDestroy(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1.id

	if var_4_0 and arg_4_0._effectWrapDict[var_4_0] then
		arg_4_0._effectWrapDict[var_4_0] = nil
	end
end

function var_0_0._onClickOutline(arg_5_0)
	arg_5_0._enableOutline = not arg_5_0._enableOutline

	if arg_5_0._enableOutline then
		arg_5_0:_updateOutline()
	else
		for iter_5_0, iter_5_1 in pairs(arg_5_0._effectWrapDict) do
			if not gohelper.isNil(iter_5_1.containerGO) then
				iter_5_1:setActive(false)
			else
				FightRenderOrderMgr.instance:onRemoveEffectWrap(iter_5_0, iter_5_1)

				arg_5_0._effectWrapDict[iter_5_0] = nil
			end
		end
	end
end

function var_0_0._onSpineLoaded(arg_6_0, arg_6_1, arg_6_2)
	TaskDispatcher.cancelTask(arg_6_0._refreshOnLoad, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._refreshOnLoad, arg_6_0, 0.1)
end

function var_0_0._refreshOnLoad(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._effectWrapDict) do
		if not gohelper.isNil(iter_7_1.containerGO) and iter_7_1.containerGO.activeSelf then
			iter_7_1:setActive(false)
			iter_7_1:setActive(true)
		end
	end
end

function var_0_0._onSelectEntity(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._enableOutline then
		return
	end

	if arg_8_1 ~= FightEnum.EntitySide.EnemySide then
		return
	end

	arg_8_0:_updateOutline()
end

function var_0_0._updateOutline(arg_9_0)
	local var_9_0 = GameSceneMgr.instance:getCurScene().entityMgr:getEntityByPosId(SceneTag.UnitMonster, SkillEditorView.selectPosId[FightEnum.EntitySide.EnemySide]).id
	local var_9_1 = FightHelper.getEntity(var_9_0)

	if not arg_9_0._effectWrapDict[var_9_0] then
		local var_9_2 = FightHelper.getEntity(var_9_0)

		if var_9_2 and var_9_2.effect then
			local var_9_3 = var_9_2.effect:addHangEffect(var_0_1, ModuleEnum.SpineHangPointRoot, nil, nil, nil, true)

			var_9_3:setLocalPos(0, 0, 0)

			arg_9_0._effectWrapDict[var_9_0] = var_9_3

			FightRenderOrderMgr.instance:onAddEffectWrap(var_9_0, var_9_3)
		end
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._effectWrapDict) do
		if not gohelper.isNil(iter_9_1.containerGO) then
			iter_9_1:setActive(iter_9_0 == var_9_0)
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(iter_9_0, iter_9_1)

			arg_9_0._effectWrapDict[var_9_0] = nil
		end
	end
end

return var_0_0
