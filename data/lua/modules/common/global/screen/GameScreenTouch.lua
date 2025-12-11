module("modules.common.global.screen.GameScreenTouch", package.seeall)

local var_0_0 = class("GameScreenTouch")
local var_0_1 = 120

function var_0_0.ctor(arg_1_0)
	arg_1_0._prefabTb = {}
	arg_1_0._effectItemTb = {}
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
	arg_7_0._effectUrl = arg_7_0:_getClickResPath()
	arg_7_0._effectLoader = MultiAbLoader.New()

	arg_7_0._effectLoader:addPath(arg_7_0._effectUrl)
	arg_7_0._effectLoader:startLoad(arg_7_0._createEffect, arg_7_0)
end

function var_0_0.refreshEffect(arg_8_0)
	local var_8_0 = arg_8_0:getCurUseUIPrefabName()

	arg_8_0:_recycleEffects(var_8_0)

	if not arg_8_0._prefabTb[var_8_0] then
		arg_8_0:_loadEffect()

		return
	end

	arg_8_0._effectPrefab = arg_8_0._prefabTb[var_8_0]

	if not arg_8_0._effectItemTb[var_8_0] then
		arg_8_0._effectItemTb[var_8_0] = {}
	end
end

function var_0_0._recycleEffects(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._effectItemTb) do
		if iter_9_0 ~= arg_9_1 then
			for iter_9_2, iter_9_3 in pairs(iter_9_1) do
				arg_9_0:_recycleEffect(iter_9_3.go)
			end
		end
	end
end

function var_0_0._getClickResPath(arg_10_0)
	return (string.format(ClickUISwitchEnum.ClickUIPath, arg_10_0:getCurUseUIPrefabName()))
end

function var_0_0.getCurUseUIPrefabName(arg_11_0)
	if SurvivalMapHelper.instance:isInSurvivalScene() then
		return "laplace_click"
	end

	local var_11_0 = ClickUISwitchModel.instance:getCurUseUICo()

	if not var_11_0 or string.nilorempty(var_11_0.effect) then
		return ClickUISwitchEnum.DefaultClickUIPrefabName
	end

	return var_11_0.effect
end

function var_0_0._createEffect(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:_getClickResPath()
	local var_12_1 = arg_12_1:getAssetItem(var_12_0):GetResource(var_12_0)

	arg_12_0._effectPrefab = var_12_1

	for iter_12_0 = 1, arg_12_0._effectNum do
		arg_12_0:_create(arg_12_0._effectPrefab)
	end

	local var_12_2 = arg_12_0:getCurUseUIPrefabName()

	arg_12_0._prefabTb[var_12_2] = var_12_1
end

function var_0_0._create(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = gohelper.clone(arg_13_1, arg_13_0._globalTouchGO)

	var_13_0.go = var_13_1

	function var_13_0.recycleFunc()
		arg_13_0:_recycleEffect(var_13_1)
	end

	local var_13_2 = gohelper.findChildImage(var_13_1, "image")
	local var_13_3 = var_13_2.material

	var_13_2.material = UnityEngine.Object.Instantiate(var_13_3)

	local var_13_4 = var_13_1:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_13_4.mas:Clear()
	var_13_4.mas:Add(var_13_2.material)
	gohelper.setActive(var_13_1, false)

	local var_13_5 = arg_13_0:getCurUseUIPrefabName()

	if not arg_13_0._effectItemTb[var_13_5] then
		arg_13_0._effectItemTb[var_13_5] = {}
	end

	table.insert(arg_13_0._effectItemTb[var_13_5], var_13_0)

	return var_13_0
end

function var_0_0._getEffect(arg_15_0)
	local var_15_0 = arg_15_0:getCurUseUIPrefabName()
	local var_15_1 = arg_15_0._effectItemTb[var_15_0]

	if var_15_1 then
		for iter_15_0 = 1, #var_15_1 do
			if var_15_1[iter_15_0].go.activeInHierarchy == false then
				arg_15_0._effectIndex = iter_15_0

				return var_15_1[iter_15_0]
			end
		end

		if #var_15_1 < arg_15_0._maxNum then
			if not arg_15_0._prefabTb[var_15_0] then
				return
			end

			return arg_15_0:_create(arg_15_0._prefabTb[var_15_0])
		else
			arg_15_0._effectIndex = (arg_15_0._effectIndex + 1) % arg_15_0._maxNum

			if arg_15_0._effectIndex <= 0 then
				arg_15_0._effectIndex = arg_15_0._maxNum
			end

			arg_15_0:_recycleEffect(var_15_1[arg_15_0._effectIndex].go)

			return var_15_1[arg_15_0._effectIndex]
		end
	else
		arg_15_0:refreshEffect()
	end
end

function var_0_0._playTouchEffect(arg_16_0, arg_16_1)
	if not arg_16_0:_canShowEffect() then
		return
	end

	local var_16_0 = arg_16_0:_getEffect()

	if var_16_0 then
		local var_16_1 = var_16_0.go:GetComponent(typeof(UnityEngine.Animation))
		local var_16_2 = arg_16_1 or UnityEngine.Input.mousePosition
		local var_16_3 = recthelper.screenPosToAnchorPos(var_16_2, arg_16_0._globalTouchGO.transform)

		recthelper.setAnchor(var_16_0.go.transform, var_16_3.x, var_16_3.y)
		var_16_1:Stop()
		gohelper.setActive(var_16_0.go, true)
		var_16_1:Play()
		TaskDispatcher.runDelay(var_16_0.recycleFunc, arg_16_0, 0.7)
	end
end

function var_0_0._recycleEffect(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetComponent(typeof(UnityEngine.Animation))

	gohelper.setActive(arg_17_1, false)
	var_17_0:Stop()
	recthelper.setAnchor(arg_17_1.transform, 0, 0)
end

function var_0_0._canShowEffect(arg_18_0)
	local var_18_0 = ViewMgr.instance:getOpenViewNameList()

	if var_18_0[#var_18_0] == ViewName.DungeonView and DungeonModel.instance:getDungeonStoryState() or var_18_0[#var_18_0] == ViewName.FightView and FightModel.instance:getClickEnemyState() or var_18_0[#var_18_0] == ViewName.StoryFrontView and StoryModel.instance:isVersionActivityPV() then
		return false
	end

	return true
end

return var_0_0
