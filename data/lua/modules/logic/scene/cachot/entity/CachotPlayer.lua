module("modules.logic.scene.cachot.entity.CachotPlayer", package.seeall)

local var_0_0 = class("CachotPlayer", BaseUnitSpawn)
local var_0_1 = {
	IdleToMove = "move2",
	MoveToIdle = "move2_2",
	Idle = "idle",
	MainSceneBorn = "born",
	RogueSceneBorn = "born2",
	TriggerIdle = "idle2",
	Move = "move2_1"
}
local var_0_2 = {
	[var_0_1.Idle] = true,
	[var_0_1.Move] = true
}

function var_0_0.Create(arg_1_0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.trans = arg_2_1.transform
	arg_2_0._effectDict = {}
	arg_2_0._effectContainer = gohelper.create3d(arg_2_0.go, "Effect")

	arg_2_0:loadSpine("roles/dilaoxiaoren/dilaoxiaoren.prefab")
end

function var_0_0.initComponents(arg_3_0)
	arg_3_0:addComp("spine", UnitSpine)
	arg_3_0:addComp("spineRenderer", UnitSpineRenderer)
	arg_3_0.spine:setLayer(UnityLayer.Scene)
end

function var_0_0.loadSpine(arg_4_0, arg_4_1)
	if arg_4_0.spine then
		arg_4_0.spine:setResPath(arg_4_1, arg_4_0._onSpineLoaded, arg_4_0)
	end
end

function var_0_0._onSpineLoaded(arg_5_0, arg_5_1)
	if arg_5_0.spineRenderer then
		arg_5_0.spineRenderer:setSpine(arg_5_1)
	end

	arg_5_0.spine:addAnimEventCallback(arg_5_0._onAnimEvent, arg_5_0)
	arg_5_0:playAnim(arg_5_0._cacheAnimName or var_0_1.Idle)
	transformhelper.setLocalScale(arg_5_1:getSpineTr(), 0.435, 0.435, 0.435)
	gohelper.setActive(arg_5_0.spine:getSpineGO(), arg_5_0._isActive)
end

function var_0_0.playAnim(arg_6_0, arg_6_1)
	arg_6_0._cacheAnimName = arg_6_1

	if arg_6_0.spine:getSpineGO() then
		arg_6_0.spine:play(arg_6_1, var_0_2[arg_6_1], not var_0_2[arg_6_1])
	end
end

function var_0_0.playEnterAnim(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0:playAnim(var_0_1.MainSceneBorn)
	else
		arg_7_0:playAnim(var_0_1.RogueSceneBorn)
		arg_7_0:showEffect(V1a6_CachotEnum.PlayerEffect.RoleBornEffect)
		TaskDispatcher.cancelTask(arg_7_0._delayHideEffect, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0._delayHideEffect, arg_7_0, 1.5)
	end
end

function var_0_0._delayHideEffect(arg_8_0)
	arg_8_0:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleBornEffect)
end

function var_0_0._onAnimEvent(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 == SpineAnimEvent.ActionComplete then
		if arg_9_1 == var_0_1.IdleToMove then
			arg_9_0:playAnim(var_0_1.Move)
		else
			arg_9_0:playAnim(var_0_1.Idle)
		end

		if arg_9_1 == var_0_1.RogueSceneBorn then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.CheckPlayStory)
		end
	end
end

function var_0_0.setIsMove(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_2 and arg_10_0._isMoving == arg_10_1 then
		return
	end

	arg_10_0._isMoving = arg_10_1

	if not arg_10_0:isCanMove() then
		return
	end

	if arg_10_0._cacheAnimName == var_0_1.Move and not arg_10_0._isMoving then
		arg_10_0:playAnim(var_0_1.MoveToIdle)
	elseif arg_10_0._cacheAnimName == var_0_1.Idle and arg_10_0._isMoving then
		arg_10_0:playAnim(var_0_1.IdleToMove)
	else
		arg_10_0:playAnim(arg_10_0._isMoving and var_0_1.Move or var_0_1.Idle)
	end
end

function var_0_0.playTriggerAnim(arg_11_0)
	arg_11_0:playAnim(var_0_1.TriggerIdle)
end

function var_0_0.isCanMove(arg_12_0)
	if not arg_12_0.spine:getSpineGO() or not arg_12_0.spine:getSpineGO().activeSelf then
		return
	end

	return arg_12_0._cacheAnimName == var_0_1.Idle or arg_12_0._cacheAnimName == var_0_1.Move or arg_12_0._cacheAnimName == var_0_1.MoveToIdle or arg_12_0._cacheAnimName == var_0_1.IdleToMove or not arg_12_0._cacheAnimName
end

function var_0_0.setDir(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_2 and arg_13_0._isLeft == arg_13_1 then
		return
	end

	arg_13_0._isLeft = arg_13_1

	transformhelper.setLocalScale(arg_13_0.trans, arg_13_1 and 1 or -1, 1, 1)
end

function var_0_0.showEffect(arg_14_0, arg_14_1)
	if arg_14_0._effectDict[arg_14_1] then
		return
	end

	local var_14_0 = GameSceneMgr.instance:getCurScene()

	arg_14_0._effectDict[arg_14_1] = var_14_0.preloader:getResInst(CachotScenePreloader[arg_14_1], arg_14_0._effectContainer)
end

function var_0_0.hideEffect(arg_15_0, arg_15_1)
	if arg_15_0._effectDict[arg_15_1] then
		gohelper.destroy(arg_15_0._effectDict[arg_15_1])

		arg_15_0._effectDict[arg_15_1] = nil
	end
end

function var_0_0.setActive(arg_16_0, arg_16_1)
	arg_16_0._isActive = arg_16_1

	gohelper.setActive(arg_16_0.spine:getSpineGO(), arg_16_1)
end

function var_0_0.getPos(arg_17_0)
	return arg_17_0.trans.position
end

function var_0_0.dispose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._delayHideEffect, arg_18_0)
	gohelper.destroy(arg_18_0._effectContainer)

	arg_18_0._effectContainer = nil
	arg_18_0._effectDict = {}
end

return var_0_0
