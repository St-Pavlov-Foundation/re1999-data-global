module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapElement", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapElement", DungeonMapElement)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1[1]
	arg_1_0._mapScene = arg_1_1[2]
	arg_1_0._sceneElements = arg_1_1[3]
end

function var_0_0.getElementId(arg_2_0)
	return arg_2_0._config.id
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._wenhaoGo = arg_3_0:getUserDataTb_()
	arg_3_0._finishGo = arg_3_0:getUserDataTb_()
	arg_3_0._go = arg_3_1
	arg_3_0._transform = arg_3_1.transform

	local var_3_0 = string.splitToNumber(arg_3_0._config.pos, "#")

	transformhelper.setLocalPos(arg_3_0._transform, var_3_0[1] or 0, var_3_0[2] or 0, var_3_0[3] or 0)

	if arg_3_0._resLoader then
		return
	end

	arg_3_0._resLoader = MultiAbLoader.New()

	arg_3_0._resLoader:addPath(arg_3_0._config.res)

	arg_3_0._effectPath = {}

	if not string.nilorempty(arg_3_0._config.effect) then
		table.insert(arg_3_0._effectPath, arg_3_0._config.effect)
		arg_3_0._resLoader:addPath(arg_3_0._config.effect)
	end

	if arg_3_0._config.type == DungeonEnum.ElementType.Activity1_2Building_Trap then
		local var_3_1 = "scenes/m_s08_hddt/prefab/lhem_icon_qh.prefab"

		table.insert(arg_3_0._effectPath, var_3_1)
		arg_3_0._resLoader:addPath(var_3_1)
	elseif arg_3_0._config.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		local var_3_2 = "scenes/m_s08_hddt/prefab/lhem_icon_ck.prefab"

		table.insert(arg_3_0._effectPath, var_3_2)
		arg_3_0._resLoader:addPath(var_3_2)
	end

	arg_3_0._resLoader:startLoad(arg_3_0._onResLoaded, arg_3_0)
end

function var_0_0.hide(arg_4_0)
	gohelper.setActive(arg_4_0._go, false)
end

function var_0_0.show(arg_5_0)
	gohelper.setActive(arg_5_0._go, true)
end

function var_0_0.hasEffect(arg_6_0)
	return arg_6_0._effectPath
end

function var_0_0.showArrow(arg_7_0)
	if arg_7_0._config.type == DungeonEnum.ElementType.DailyEpisode then
		return arg_7_0._go.activeInHierarchy
	end

	return arg_7_0._config.showArrow == 1
end

function var_0_0.isValid(arg_8_0)
	return not gohelper.isNil(arg_8_0._go)
end

function var_0_0.setWenHaoVisible(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0:setWenHaoAnim("wenhao_a_001_in")
	else
		local var_9_0 = "wenhao_a_001_out"

		if (arg_9_0._config.type == DungeonEnum.ElementType.Activity1_2Fight or VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(arg_9_0._config.id)) and arg_9_0._sceneElements.curSelectId == arg_9_0._config.id then
			var_9_0 = "click"
			arg_9_0._sceneElements.curSelectId = nil
		end

		arg_9_0:setWenHaoAnim(var_9_0)
	end
end

function var_0_0.setWenHaoAnim(arg_10_0, arg_10_1)
	arg_10_0._wenhaoAnimName = arg_10_1

	if #arg_10_0._wenhaoGo > 0 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._wenhaoGo) do
			if not gohelper.isNil(iter_10_1) and iter_10_1.activeInHierarchy then
				SLFramework.AnimatorPlayer.Get(iter_10_1):Play(arg_10_1, arg_10_0._wenHaoAnimDone, arg_10_0)
			end
		end
	end
end

function var_0_0._wenHaoAnimDone(arg_11_0)
	if arg_11_0._wenhaoAnimName == "finish" then
		gohelper.destroy(arg_11_0._go)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFinishAndDisposeElement, arg_11_0._config)
	end
end

function var_0_0._destroyGo(arg_12_0)
	gohelper.destroy(arg_12_0._go)
end

function var_0_0._destroyItemGo(arg_13_0)
	gohelper.destroy(arg_13_0._itemGo)
end

function var_0_0.setFinish(arg_14_0)
	if #arg_14_0._wenhaoGo == 0 then
		arg_14_0:_destroyGo()

		return
	end

	arg_14_0:removeEventListeners()
	arg_14_0:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(arg_14_0._destroyItemGo, arg_14_0, 0.77)
	TaskDispatcher.runDelay(arg_14_0._destroyGo, arg_14_0, 1.6)
end

function var_0_0.setFinishAndDotDestroy(arg_15_0)
	if #arg_15_0._wenhaoGo == 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)

	if #arg_15_0._finishGo > 0 then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._finishGo) do
			gohelper.setActive(iter_15_1, true)

			if iter_15_1.activeInHierarchy then
				SLFramework.AnimatorPlayer.Get(iter_15_1):Play(UIAnimationName.Open, arg_15_0.setFinishAndDotDestroyAnimationDone, arg_15_0)
			end
		end
	else
		arg_15_0:dispose()
	end
end

function var_0_0.setFinishAndDotDestroyAnimationDone(arg_16_0)
	arg_16_0.animatorPlayer:Play(UIAnimationName.Idle, function()
		return
	end, arg_16_0)
	arg_16_0:dispose()
end

function var_0_0.onDown(arg_18_0)
	arg_18_0:_onDown()
end

function var_0_0._onDown(arg_19_0)
	arg_19_0._sceneElements:setElementDown(arg_19_0)
end

function var_0_0.onClick(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
	arg_20_0._sceneElements:clickElement(arg_20_0._config.id)
end

function var_0_0._onResLoaded(arg_21_0)
	local var_21_0 = arg_21_0._resLoader:getAssetItem(arg_21_0._config.res):GetResource(arg_21_0._config.res)

	arg_21_0._itemGo = gohelper.clone(var_21_0, arg_21_0._go)

	local var_21_1 = arg_21_0._config.resScale

	if var_21_1 and var_21_1 ~= 0 then
		transformhelper.setLocalScale(arg_21_0._itemGo.transform, var_21_1, var_21_1, 1)
	end

	gohelper.setLayer(arg_21_0._itemGo, UnityLayer.Scene, true)
	DungeonMapElement.addBoxColliderListener(arg_21_0._itemGo, arg_21_0._onDown, arg_21_0)
	transformhelper.setLocalPos(arg_21_0._itemGo.transform, 0, 0, -1)

	if #arg_21_0._effectPath > 0 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._effectPath) do
			local var_21_2 = UnityEngine.GameObject.New("effect" .. iter_21_0)

			gohelper.addChild(arg_21_0._go, var_21_2)

			local var_21_3 = string.splitToNumber(arg_21_0._config.tipOffsetPos, "#")

			arg_21_0._offsetX = var_21_3[1] or 0
			arg_21_0._offsetY = var_21_3[2] or 0

			local var_21_4 = arg_21_0._effectPath[iter_21_0]
			local var_21_5 = arg_21_0._resLoader:getAssetItem(var_21_4):GetResource(var_21_4)
			local var_21_6 = gohelper.clone(var_21_5, var_21_2, "root")

			DungeonMapElement.addBoxColliderListener(var_21_6, arg_21_0._onDown, arg_21_0)
			transformhelper.setLocalPos(var_21_6.transform, arg_21_0._offsetX, arg_21_0._offsetY, -3)

			local var_21_7 = gohelper.findChildComponent(var_21_6, "ani", typeof(UnityEngine.Animator))

			if var_21_7 then
				local var_21_8 = math.random(0, 100)

				var_21_7:Play("lhem_icon_loop", 0, var_21_8 / 100)
			end

			local var_21_9 = gohelper.findChild(var_21_6, "ani/yuanjian_new_07/gou")

			gohelper.setActive(var_21_9, false)

			if var_21_9 then
				table.insert(arg_21_0._finishGo, var_21_9)
			end

			if arg_21_0._mapScene:showInteractiveItem() then
				arg_21_0:setWenHaoVisible(false)
			elseif arg_21_0._wenhaoAnimName then
				arg_21_0:setWenHaoAnim(arg_21_0._wenhaoAnimName)
			end

			if string.find(var_21_4, "hddt_front_lubiao_a_002") then
				local var_21_10 = gohelper.findChild(var_21_6, "ani/plane"):GetComponent(typeof(UnityEngine.Renderer)).material
				local var_21_11 = var_21_10:GetVector("_Frame")

				var_21_11.w = DungeonEnum.ElementTypeIconIndex[string.format("%s0", arg_21_0._config.type)]

				var_21_10:SetVector("_Frame", var_21_11)
			end

			table.insert(arg_21_0._wenhaoGo, var_21_6)

			for iter_21_2 = 1, 2 do
				local var_21_12 = gohelper.findChild(var_21_6, string.format("ani/icon%d/anim/biaoti/txt", iter_21_2))

				if var_21_12 then
					local var_21_13 = var_21_12:GetComponent(typeof(TMPro.TextMeshPro))

					var_21_13.text = arg_21_0._config.title

					if arg_21_0._config.type == DungeonEnum.ElementType.DailyEpisode then
						local var_21_14 = VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(arg_21_0._config.id)

						if var_21_14 then
							var_21_13.text = var_21_14.name
						end
					end
				end
			end
		end
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.addElementItem, arg_21_0._config.id)

	local var_21_15 = FightModel.instance:getFightParam()
	local var_21_16 = var_21_15 and var_21_15.episodeId

	if var_21_16 then
		local var_21_17 = DungeonConfig.instance:getEpisodeCO(var_21_16)

		if var_21_17 and var_21_17.chapterId == 12701 then
			return
		end

		if arg_21_0._config.param == tostring(var_21_16) then
			DungeonMapModel.instance.lastElementBattleId = nil

			if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipClickElement) then
				return
			end

			DungeonMapModel.instance.directFocusElement = true

			arg_21_0:onClick()

			DungeonMapModel.instance.directFocusElement = false
		end
	end
end

function var_0_0._onSetEpisodeListVisible(arg_22_0, arg_22_1)
	arg_22_0:setWenHaoVisible(arg_22_1)
end

function var_0_0._afterCollectLastShow(arg_23_0)
	return
end

function var_0_0.addEventListeners(arg_24_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, arg_24_0._onSetEpisodeListVisible, arg_24_0)
	arg_24_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.afterCollectLastShow, arg_24_0._afterCollectLastShow, arg_24_0)
end

function var_0_0.removeEventListeners(arg_25_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, arg_25_0._onSetEpisodeListVisible, arg_25_0)
end

function var_0_0.onStart(arg_26_0)
	return
end

function var_0_0.addBoxCollider2D(arg_27_0)
	local var_27_0 = ZProj.BoxColliderClickListener.Get(arg_27_0)
	local var_27_1 = gohelper.onceAddComponent(arg_27_0, typeof(UnityEngine.BoxCollider2D))

	var_27_1.enabled = true
	var_27_1.size = Vector2(1.5, 1.5)

	var_27_0:SetIgnoreUI(true)

	return var_27_0
end

function var_0_0.addBoxColliderListener(arg_28_0, arg_28_1, arg_28_2)
	DungeonMapElement.addBoxCollider2D(arg_28_0):AddClickListener(arg_28_1, arg_28_2)
end

function var_0_0.dispose(arg_29_0)
	arg_29_0._itemGo = nil
	arg_29_0._go = nil
	arg_29_0.animatorPlayer = nil

	if arg_29_0._resLoader then
		arg_29_0._resLoader:dispose()

		arg_29_0._resLoader = nil
	end

	TaskDispatcher.cancelTask(arg_29_0._destroyItemGo, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._destroyGo, arg_29_0)
end

function var_0_0.onDestroy(arg_30_0)
	if arg_30_0._itemGo then
		gohelper.destroy(arg_30_0._itemGo)

		arg_30_0._itemGo = nil
	end

	if arg_30_0._wenhaoGo then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0._wenhaoGo) do
			gohelper.destroy(iter_30_1)
		end
	end

	if arg_30_0._go then
		gohelper.destroy(arg_30_0._go)

		arg_30_0._go = nil
	end

	if arg_30_0._resLoader then
		arg_30_0._resLoader:dispose()

		arg_30_0._resLoader = nil
	end

	if arg_30_0.animatorPlayer then
		arg_30_0.animatorPlayer = nil
	end

	TaskDispatcher.cancelTask(arg_30_0._destroyItemGo, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._destroyGo, arg_30_0)
end

return var_0_0
