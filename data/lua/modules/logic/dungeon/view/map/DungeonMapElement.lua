module("modules.logic.dungeon.view.map.DungeonMapElement", package.seeall)

local var_0_0 = class("DungeonMapElement", LuaCompBase)

var_0_0.InAnimName = "wenhao_a_001_in"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1[1]
	arg_1_0._mapScene = arg_1_1[2]
	arg_1_0._sceneElements = arg_1_1[3]
end

function var_0_0.getElementId(arg_2_0)
	return arg_2_0._config.id
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._go = arg_3_1
	arg_3_0._transform = arg_3_1.transform

	local var_3_0 = string.splitToNumber(arg_3_0._config.pos, "#")

	transformhelper.setLocalPos(arg_3_0._transform, var_3_0[1] or 0, var_3_0[2] or 0, var_3_0[3] or 0)

	if arg_3_0._resLoader then
		return
	end

	arg_3_0._resLoader = MultiAbLoader.New()

	if not string.nilorempty(arg_3_0._config.res) then
		arg_3_0._resLoader:addPath(arg_3_0._config.res)
	end

	arg_3_0._effectPath = arg_3_0._config.effect

	if not string.nilorempty(arg_3_0._effectPath) then
		arg_3_0._resLoader:addPath(arg_3_0._effectPath)
	end

	arg_3_0._exEffectPath = DungeonEnum.ElementExEffectPath[arg_3_0:getElementId()]

	if arg_3_0._exEffectPath then
		arg_3_0._resLoader:addPath(arg_3_0._exEffectPath)
	end

	arg_3_0._resLoader:startLoad(arg_3_0._onResLoaded, arg_3_0)
end

function var_0_0.hide(arg_4_0)
	gohelper.setActive(arg_4_0._go, false)
end

function var_0_0.show(arg_5_0)
	gohelper.setActive(arg_5_0._go, true)
end

function var_0_0.getVisible(arg_6_0)
	return not gohelper.isNil(arg_6_0._go) and arg_6_0._go.activeSelf
end

function var_0_0.hasEffect(arg_7_0)
	return arg_7_0._effectPath
end

function var_0_0.showArrow(arg_8_0)
	return arg_8_0._config.showArrow == 1
end

function var_0_0.isValid(arg_9_0)
	return not gohelper.isNil(arg_9_0._go)
end

function var_0_0.setWenHaoGoVisible(arg_10_0, arg_10_1)
	arg_10_0._wenhaoVisible = arg_10_1

	gohelper.setActive(arg_10_0._wenhaoGo, arg_10_1)
end

function var_0_0.setWenHaoVisible(arg_11_0, arg_11_1)
	if arg_11_0._config.type == DungeonEnum.ElementType.ToughBattle then
		return
	end

	arg_11_0._itemGoVisible = arg_11_1

	if arg_11_1 then
		arg_11_0:setWenHaoAnim(var_0_0.InAnimName)
	else
		gohelper.setActive(arg_11_0._itemGo, arg_11_0._itemGoVisible)
		arg_11_0:setWenHaoAnim("wenhao_a_001_out")
	end
end

function var_0_0.setWenHaoAnim(arg_12_0, arg_12_1)
	arg_12_0._wenhaoAnimName = arg_12_1

	if gohelper.isNil(arg_12_0._wenhaoGo) then
		return
	end

	if not arg_12_0._wenhaoGo.activeInHierarchy then
		arg_12_0:_wenHaoAnimDone()

		return
	end

	if arg_12_0._wenhaoAnimator == nil then
		if arg_12_0._wenhaoGo:GetComponent(typeof(UnityEngine.Animator)) then
			arg_12_0._wenhaoAnimator = SLFramework.AnimatorPlayer.Get(arg_12_0._wenhaoGo)
		else
			arg_12_0._wenhaoAnimator = false
		end
	end

	if arg_12_0._wenhaoAnimator and arg_12_0._wenhaoAnimator.animator:HasState(0, UnityEngine.Animator.StringToHash(arg_12_1)) then
		arg_12_0._wenhaoAnimator:Play(arg_12_1, arg_12_0._wenHaoAnimDone, arg_12_0)
	else
		arg_12_0:_wenHaoAnimDone()
	end
end

function var_0_0._wenHaoAnimDone(arg_13_0)
	if arg_13_0._wenhaoAnimator then
		arg_13_0._wenhaoAnimator.animator.enabled = true
	end

	if arg_13_0._wenhaoAnimName == "finish" then
		gohelper.destroy(arg_13_0._go)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFinishAndDisposeElement, arg_13_0._config)
	end

	if arg_13_0._wenhaoAnimName == var_0_0.InAnimName then
		gohelper.setActive(arg_13_0._itemGo, arg_13_0._itemGoVisible)
	end
end

function var_0_0._destroyGo(arg_14_0)
	gohelper.destroy(arg_14_0._go)
end

function var_0_0._destroyItemGo(arg_15_0)
	gohelper.destroy(arg_15_0._itemGo)
end

function var_0_0.getItemGo(arg_16_0)
	return arg_16_0._itemGo
end

function var_0_0.setFinish(arg_17_0)
	if not arg_17_0._wenhaoGo or arg_17_0._config and arg_17_0._config.type == DungeonEnum.ElementType.ToughBattle then
		arg_17_0:_destroyGo()

		return
	end

	arg_17_0:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(arg_17_0._destroyItemGo, arg_17_0, 0.77)
	TaskDispatcher.runDelay(arg_17_0._destroyGo, arg_17_0, 1.6)
end

function var_0_0.setFinishAndDotDestroy(arg_18_0)
	if not arg_18_0._wenhaoGo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)

	if arg_18_0.finishGo then
		gohelper.setActive(arg_18_0.finishGo, true)

		arg_18_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_18_0.finishGo)

		arg_18_0.animatorPlayer:Play(UIAnimationName.Open, arg_18_0.setFinishAndDotDestroyAnimationDone, arg_18_0)
	else
		arg_18_0:dispose()
	end
end

function var_0_0.setFinishAndDotDestroyAnimationDone(arg_19_0)
	arg_19_0.animatorPlayer:Play(UIAnimationName.Idle, function()
		return
	end, arg_19_0)
	arg_19_0:dispose()
end

function var_0_0.onDown(arg_21_0)
	arg_21_0:_onDown()
end

function var_0_0._onDown(arg_22_0)
	arg_22_0._sceneElements:setElementDown(arg_22_0)
end

function var_0_0.onClick(arg_23_0)
	arg_23_0._sceneElements:clickElement(arg_23_0._config.id)
end

function var_0_0._onResLoaded(arg_24_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, arg_24_0._onSetEpisodeListVisible, arg_24_0)

	if not string.nilorempty(arg_24_0._config.res) then
		local var_24_0 = arg_24_0._resLoader:getAssetItem(arg_24_0._config.res):GetResource(arg_24_0._config.res)

		arg_24_0._itemGo = gohelper.clone(var_24_0, arg_24_0._go)

		local var_24_1 = arg_24_0._config.resScale

		if var_24_1 and var_24_1 ~= 0 then
			transformhelper.setLocalScale(arg_24_0._itemGo.transform, var_24_1, var_24_1, 1)
		end

		gohelper.setLayer(arg_24_0._itemGo, UnityLayer.Scene, true)
		var_0_0.addBoxColliderListener(arg_24_0._itemGo, arg_24_0._onDown, arg_24_0)
		transformhelper.setLocalPos(arg_24_0._itemGo.transform, 0, 0, -1)
	end

	if not string.nilorempty(arg_24_0._effectPath) then
		local var_24_2 = string.splitToNumber(arg_24_0._config.tipOffsetPos, "#")

		arg_24_0._offsetX = var_24_2[1] or 0
		arg_24_0._offsetY = var_24_2[2] or 0
		arg_24_0._offsetZ = var_24_2[3] or -3

		local var_24_3 = arg_24_0._resLoader:getAssetItem(arg_24_0._effectPath):GetResource(arg_24_0._effectPath)

		arg_24_0._wenhaoGo = gohelper.clone(var_24_3, arg_24_0._go)

		if arg_24_0._wenhaoVisible == false then
			arg_24_0:setWenHaoGoVisible(false)
		end

		var_0_0.addBoxColliderListener(arg_24_0._wenhaoGo, arg_24_0._onDown, arg_24_0)
		transformhelper.setLocalPos(arg_24_0._wenhaoGo.transform, arg_24_0._offsetX, arg_24_0._offsetY, arg_24_0._offsetZ)

		arg_24_0.finishGo = gohelper.findChild(arg_24_0._wenhaoGo, "ani/yuanjian_new_07/gou")

		gohelper.setActive(arg_24_0.finishGo, false)

		if arg_24_0._mapScene:showInteractiveItem() then
			arg_24_0:setWenHaoVisible(false)
		elseif arg_24_0._wenhaoAnimName then
			arg_24_0:setWenHaoAnim(arg_24_0._wenhaoAnimName)
		end

		if string.find(arg_24_0._effectPath, "hddt_front_lubiao_a_002") then
			local var_24_4 = gohelper.findChild(arg_24_0._wenhaoGo, "ani/plane"):GetComponent(typeof(UnityEngine.Renderer)).material
			local var_24_5 = var_24_4:GetVector("_Frame")

			var_24_5.w = DungeonEnum.ElementTypeIconIndex[string.format("%s0", arg_24_0._config.type)]

			var_24_4:SetVector("_Frame", var_24_5)
		end
	end

	if arg_24_0._exEffectPath then
		local var_24_6 = arg_24_0._resLoader:getAssetItem(arg_24_0._exEffectPath):GetResource(arg_24_0._exEffectPath)

		arg_24_0._exEffectGo = gohelper.clone(var_24_6, arg_24_0._go)

		transformhelper.setLocalPos(arg_24_0._exEffectGo.transform, 0, 0, 0)
	end

	if arg_24_0._config.param == tostring(DungeonMapModel.instance.lastElementBattleId) then
		DungeonMapModel.instance.lastElementBattleId = nil

		arg_24_0:_clickDirect()
	end
end

function var_0_0._onAddAnimDone(arg_25_0)
	if arg_25_0._config.type == DungeonEnum.ElementType.ToughBattle then
		if (tonumber(arg_25_0._config.param) or 0) == 0 then
			if ToughBattleModel.instance:getStoryInfo() then
				arg_25_0:_checkToughBattleIsFinish()
			else
				arg_25_0._waitId = SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(arg_25_0._checkToughBattleIsFinish, arg_25_0)
			end
		elseif ToughBattleModel.instance:getIsJumpActElement() then
			arg_25_0:_delayClick(1)
		end
	end
end

function var_0_0._checkToughBattleIsFinish(arg_26_0)
	arg_26_0._waitId = nil

	if ToughBattleModel.instance:isStoryFinish() then
		arg_26_0:_delayClick(0.5)
	end
end

function var_0_0._delayClick(arg_27_0, arg_27_1)
	UIBlockHelper.instance:startBlock("DungeonMapElementDelayClick", arg_27_1, ViewName.DungeonMapView)
	TaskDispatcher.runDelay(arg_27_0._clickDirect, arg_27_0, arg_27_1)
end

function var_0_0._clickDirect(arg_28_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipClickElement) then
		return
	end

	DungeonMapModel.instance.directFocusElement = true

	arg_28_0:onClick()

	DungeonMapModel.instance.directFocusElement = false
end

function var_0_0._onSetEpisodeListVisible(arg_29_0, arg_29_1)
	arg_29_0:setWenHaoVisible(arg_29_1)
end

function var_0_0.addEventListeners(arg_30_0)
	return
end

function var_0_0.removeEventListeners(arg_31_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, arg_31_0._onSetEpisodeListVisible, arg_31_0)
end

function var_0_0.onStart(arg_32_0)
	return
end

function var_0_0.addBoxCollider2D(arg_33_0)
	local var_33_0 = ZProj.BoxColliderClickListener.Get(arg_33_0)
	local var_33_1 = arg_33_0:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if not var_33_1 then
		var_33_1 = gohelper.onceAddComponent(arg_33_0, typeof(UnityEngine.BoxCollider2D))
		var_33_1.size = Vector2(1.5, 1.5)
	end

	var_33_1.enabled = true

	var_33_0:SetIgnoreUI(true)

	return var_33_0
end

function var_0_0.addBoxColliderListener(arg_34_0, arg_34_1, arg_34_2)
	var_0_0.addBoxCollider2D(arg_34_0):AddClickListener(arg_34_1, arg_34_2)
end

function var_0_0.getTransform(arg_35_0)
	return arg_35_0._transform
end

function var_0_0.dispose(arg_36_0)
	arg_36_0._itemGo = nil
	arg_36_0._wenhaoGo = nil
	arg_36_0._go = nil
	arg_36_0.animatorPlayer = nil

	if arg_36_0._resLoader then
		arg_36_0._resLoader:dispose()

		arg_36_0._resLoader = nil
	end

	TaskDispatcher.cancelTask(arg_36_0._destroyItemGo, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._destroyGo, arg_36_0)
end

function var_0_0.onDestroy(arg_37_0)
	if arg_37_0._itemGo then
		gohelper.destroy(arg_37_0._itemGo)

		arg_37_0._itemGo = nil
	end

	if arg_37_0._wenhaoGo then
		gohelper.destroy(arg_37_0._wenhaoGo)

		arg_37_0._wenhaoGo = nil
	end

	if arg_37_0._go then
		gohelper.destroy(arg_37_0._go)

		arg_37_0._go = nil
	end

	if arg_37_0._resLoader then
		arg_37_0._resLoader:dispose()

		arg_37_0._resLoader = nil
	end

	if arg_37_0.animatorPlayer then
		arg_37_0.animatorPlayer = nil
	end

	if arg_37_0._waitId then
		SiegeBattleRpc.instance:removeCallbackById(arg_37_0._waitId)

		arg_37_0._waitId = nil
	end

	TaskDispatcher.cancelTask(arg_37_0._clickDirect, arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._destroyItemGo, arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._destroyGo, arg_37_0)
end

return var_0_0
