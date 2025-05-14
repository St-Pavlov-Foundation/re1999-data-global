module("modules.logic.fight.view.work.FightReadyAttackWork", package.seeall)

local var_0_0 = class("FightReadyAttackWork", BaseWork)
local var_0_1 = 0.5
local var_0_2 = 1
local var_0_3 = Color.New(2.119, 1.353, 0.821, 1)
local var_0_4 = Color.white

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._count = 3
	arg_1_0._hasAddEvent = false
	arg_1_0._entity = arg_1_1

	if FightDataHelper.entityMgr:getById(arg_1_0._entity.id) and arg_1_0._entity and arg_1_0._entity.spine and not arg_1_0._entity.spine:hasAnimation(SpineAnimState.posture) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0._entity.spineRenderer:getReplaceMat()

	arg_1_0._oldColor = MaterialUtil.GetMainColor(var_1_0)

	if not arg_1_0._oldColor then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 2, var_0_1 / FightModel.instance:getSpeed(), arg_1_0._onFrameSetColor, arg_1_0._checkDone, arg_1_0)

	local var_1_1 = arg_1_1.buff:getBuffAnim()

	if string.nilorempty(var_1_1) then
		if arg_1_0._entity.spine:hasAnimation(SpineAnimState.change) then
			arg_1_0._changeActName = FightHelper.processEntityActionName(arg_1_0._entity, SpineAnimState.change)

			arg_1_0._entity.spine:addAnimEventCallback(arg_1_0._onChangeAnimEvent, arg_1_0)
			arg_1_0._entity.spine:play(arg_1_0._changeActName, false, true, true)

			arg_1_0._hasAddEvent = true
		else
			arg_1_0:_playPostureAnim()
		end
	else
		arg_1_0:_checkDone()
	end

	arg_1_0._effectWrap = arg_1_0._entity.effect:addHangEffect(FightPreloadEffectWork.buff_zhunbeigongji, ModuleEnum.SpineHangPoint.mountbottom)

	arg_1_0._effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_1_0._entity.id, arg_1_0._effectWrap)
	TaskDispatcher.runDelay(arg_1_0._checkDone, arg_1_0, var_0_2 / FightModel.instance:getSpeed())
end

function var_0_0._onFrameSetColor(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 < 1 and arg_2_1 or 2 - arg_2_1

	var_0_4.r = Mathf.Lerp(arg_2_0._oldColor.r, var_0_3.r, var_2_0)
	var_0_4.g = Mathf.Lerp(arg_2_0._oldColor.g, var_0_3.g, var_2_0)
	var_0_4.b = Mathf.Lerp(arg_2_0._oldColor.b, var_0_3.b, var_2_0)

	arg_2_0:_setMainColor(var_0_4)
end

function var_0_0._setMainColor(arg_3_0, arg_3_1)
	local var_3_0 = FightModel.instance:getCurStage()

	if var_3_0 == FightEnum.Stage.Card or var_3_0 == FightEnum.Stage.AutoCard then
		local var_3_1 = arg_3_0._entity.spineRenderer:getReplaceMat()

		if not gohelper.isNil(var_3_1) then
			MaterialUtil.setMainColor(var_3_1, arg_3_1)
		end
	end
end

function var_0_0._onChangeAnimEvent(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == arg_4_0._changeActName and arg_4_2 == SpineAnimEvent.ActionComplete then
		arg_4_0:_playPostureAnim()
	end
end

function var_0_0._playPostureAnim(arg_5_0)
	if arg_5_0._hasAddEvent then
		arg_5_0._entity.spine:removeAnimEventCallback(arg_5_0._onChangeAnimEvent, arg_5_0)

		arg_5_0._hasAddEvent = false
	end

	arg_5_0._entity.spine:play(SpineAnimState.posture, true, true)
	arg_5_0:_checkDone()
end

function var_0_0._checkDone(arg_6_0)
	arg_6_0._count = arg_6_0._count - 1

	if arg_6_0._count <= 0 then
		arg_6_0:_setMainColor(arg_6_0._oldColor)

		arg_6_0._tweenId = nil

		arg_6_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_7_0)
	if arg_7_0._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_7_0._entity.id, arg_7_0._effectWrap)
		arg_7_0._entity.effect:removeEffect(arg_7_0._effectWrap)

		arg_7_0._effectWrap = nil
	end

	if arg_7_0._hasAddEvent then
		arg_7_0._entity.spine:removeAnimEventCallback(arg_7_0._onChangeAnimEvent, arg_7_0)

		arg_7_0._hasAddEvent = false
	end

	if arg_7_0._tweenId then
		ZProj.TweenHelper.KillById(arg_7_0._tweenId)

		arg_7_0._tweenId = nil

		if arg_7_0._oldColor then
			arg_7_0:_setMainColor(arg_7_0._oldColor)
		end
	end

	arg_7_0._entity = nil

	TaskDispatcher.cancelTask(arg_7_0._checkDone, arg_7_0)
end

return var_0_0
