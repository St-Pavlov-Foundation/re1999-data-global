module("modules.common.global.screen.GameScreenTouch", package.seeall)

local var_0_0 = class("GameScreenTouch")
local var_0_1 = 120

function var_0_0.ctor(arg_1_0)
	arg_1_0._globalTouchGO = gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.Top), "GlobalTouch")
	arg_1_0._globalTouch = TouchEventMgrHepler.getTouchEventMgr(arg_1_0._globalTouchGO)

	arg_1_0._globalTouch:SetIgnoreUI(true)
	arg_1_0._globalTouch:SetOnlyTouch(true)
	arg_1_0._globalTouch:SetOnTouchDownCb(arg_1_0._onTouchDownCb, arg_1_0)
	arg_1_0._globalTouch:SetOnTouchUp(arg_1_0._onTouchUpCb, arg_1_0)

	arg_1_0._gamepadModel = SDKNativeUtil.isGamePad()

	arg_1_0:_loadEffect()
	TaskDispatcher.runRepeat(arg_1_0._onTick, arg_1_0, 5)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, arg_1_0._onApplicationPause, arg_1_0)
end

function var_0_0.playTouchEffect(arg_2_0, arg_2_1)
	arg_2_0:_playTouchEffect(arg_2_1)
end

function var_0_0._onTick(arg_3_0)
	local var_3_0 = Time.realtimeSinceStartup

	if arg_3_0._lastTime and var_3_0 - arg_3_0._lastTime > var_0_1 then
		arg_3_0._lastTime = var_3_0

		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, arg_3_0)
	end
end

function var_0_0._onApplicationPause(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0._lastTime = Time.realtimeSinceStartup
	end
end

function var_0_0._onTouchDownCb(arg_5_0)
	GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreen)

	if arg_5_0._gamepadModel == false and GMFightShowState.screenTouchEffect then
		arg_5_0._lastTime = Time.realtimeSinceStartup

		arg_5_0:_playTouchEffect()
	end
end

function var_0_0._onTouchUpCb(arg_6_0)
	GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreenUp)
end

function var_0_0._loadEffect(arg_7_0)
	arg_7_0._maxNum = 7
	arg_7_0._effectNum = 4
	arg_7_0._effectIndex = arg_7_0._maxNum
	arg_7_0._effectTabs = {}
	arg_7_0._effectUrl = "ui/viewres/common/common_click.prefab"
	arg_7_0._effectLoader = MultiAbLoader.New()

	arg_7_0._effectLoader:addPath(arg_7_0._effectUrl)
	arg_7_0._effectLoader:startLoad(arg_7_0._createEffect, arg_7_0)
end

function var_0_0._createEffect(arg_8_0, arg_8_1)
	arg_8_0._effectPrefab = arg_8_1:getAssetItem(arg_8_0._effectUrl):GetResource(arg_8_0._effectUrl)

	for iter_8_0 = 1, arg_8_0._effectNum do
		arg_8_0:_create(arg_8_0._effectPrefab)
	end
end

function var_0_0._create(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = gohelper.clone(arg_9_1, arg_9_0._globalTouchGO, "touchEffect")

	var_9_0.go = var_9_1

	function var_9_0.recycleFunc()
		arg_9_0:_recycleEffect(var_9_1)
	end

	local var_9_2 = gohelper.findChildImage(var_9_1, "image")
	local var_9_3 = var_9_2.material

	var_9_2.material = UnityEngine.Object.Instantiate(var_9_3)

	local var_9_4 = var_9_1:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_9_4.mas:Clear()
	var_9_4.mas:Add(var_9_2.material)
	gohelper.setActive(var_9_1, false)
	table.insert(arg_9_0._effectTabs, var_9_0)

	return var_9_0
end

function var_0_0._getEffect(arg_11_0)
	for iter_11_0 = 1, #arg_11_0._effectTabs do
		if arg_11_0._effectTabs[iter_11_0].go.activeInHierarchy == false then
			arg_11_0._effectIndex = iter_11_0

			return arg_11_0._effectTabs[iter_11_0]
		end
	end

	if #arg_11_0._effectTabs < arg_11_0._maxNum then
		if not arg_11_0._effectPrefab then
			return
		end

		return arg_11_0:_create(arg_11_0._effectPrefab)
	else
		arg_11_0._effectIndex = (arg_11_0._effectIndex + 1) % arg_11_0._maxNum

		if arg_11_0._effectIndex <= 0 then
			arg_11_0._effectIndex = arg_11_0._maxNum
		end

		arg_11_0:_recycleEffect(arg_11_0._effectTabs[arg_11_0._effectIndex].go)

		return arg_11_0._effectTabs[arg_11_0._effectIndex]
	end
end

function var_0_0._playTouchEffect(arg_12_0, arg_12_1)
	if not arg_12_0:_canShowEffect() then
		return
	end

	local var_12_0 = arg_12_0:_getEffect()

	if var_12_0 then
		local var_12_1 = var_12_0.go:GetComponent(typeof(UnityEngine.Animation))
		local var_12_2 = arg_12_1 or UnityEngine.Input.mousePosition
		local var_12_3 = recthelper.screenPosToAnchorPos(var_12_2, arg_12_0._globalTouchGO.transform)

		recthelper.setAnchor(var_12_0.go.transform, var_12_3.x, var_12_3.y)
		var_12_1:Stop()
		gohelper.setActive(var_12_0.go, true)
		var_12_1:Play()
		TaskDispatcher.runDelay(var_12_0.recycleFunc, arg_12_0, 0.7)
	end
end

function var_0_0._recycleEffect(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetComponent(typeof(UnityEngine.Animation))

	gohelper.setActive(arg_13_1, false)
	var_13_0:Stop()
	recthelper.setAnchor(arg_13_1.transform, 0, 0)
end

function var_0_0._canShowEffect(arg_14_0)
	local var_14_0 = ViewMgr.instance:getOpenViewNameList()

	if var_14_0[#var_14_0] == ViewName.DungeonView and DungeonModel.instance:getDungeonStoryState() or var_14_0[#var_14_0] == ViewName.FightView and FightModel.instance:getClickEnemyState() then
		return false
	end

	return true
end

return var_0_0
