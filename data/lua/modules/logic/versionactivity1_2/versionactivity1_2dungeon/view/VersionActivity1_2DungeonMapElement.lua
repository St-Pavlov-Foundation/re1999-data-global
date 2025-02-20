module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapElement", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapElement", DungeonMapElement)

function slot0.ctor(slot0, slot1)
	slot0._config = slot1[1]
	slot0._mapScene = slot1[2]
	slot0._sceneElements = slot1[3]
end

function slot0.getElementId(slot0)
	return slot0._config.id
end

function slot0.init(slot0, slot1)
	slot0._wenhaoGo = slot0:getUserDataTb_()
	slot0._finishGo = slot0:getUserDataTb_()
	slot0._go = slot1
	slot0._transform = slot1.transform

	transformhelper.setLocalPos(slot0._transform, string.splitToNumber(slot0._config.pos, "#")[1] or 0, slot2[2] or 0, slot2[3] or 0)

	if slot0._resLoader then
		return
	end

	slot0._resLoader = MultiAbLoader.New()

	slot0._resLoader:addPath(slot0._config.res)

	slot0._effectPath = {}

	if not string.nilorempty(slot0._config.effect) then
		table.insert(slot0._effectPath, slot0._config.effect)
		slot0._resLoader:addPath(slot0._config.effect)
	end

	if slot0._config.type == DungeonEnum.ElementType.Activity1_2Building_Trap then
		slot3 = "scenes/m_s08_hddt/prefab/lhem_icon_qh.prefab"

		table.insert(slot0._effectPath, slot3)
		slot0._resLoader:addPath(slot3)
	elseif slot0._config.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		slot3 = "scenes/m_s08_hddt/prefab/lhem_icon_ck.prefab"

		table.insert(slot0._effectPath, slot3)
		slot0._resLoader:addPath(slot3)
	end

	slot0._resLoader:startLoad(slot0._onResLoaded, slot0)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0.show(slot0)
	gohelper.setActive(slot0._go, true)
end

function slot0.hasEffect(slot0)
	return slot0._effectPath
end

function slot0.showArrow(slot0)
	if slot0._config.type == DungeonEnum.ElementType.DailyEpisode then
		return slot0._go.activeInHierarchy
	end

	return slot0._config.showArrow == 1
end

function slot0.isValid(slot0)
	return not gohelper.isNil(slot0._go)
end

function slot0.setWenHaoVisible(slot0, slot1)
	if slot1 then
		slot0:setWenHaoAnim("wenhao_a_001_in")
	else
		slot2 = "wenhao_a_001_out"

		if (slot0._config.type == DungeonEnum.ElementType.Activity1_2Fight or VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot0._config.id)) and slot0._sceneElements.curSelectId == slot0._config.id then
			slot2 = "click"
			slot0._sceneElements.curSelectId = nil
		end

		slot0:setWenHaoAnim(slot2)
	end
end

function slot0.setWenHaoAnim(slot0, slot1)
	slot0._wenhaoAnimName = slot1

	if #slot0._wenhaoGo > 0 then
		for slot5, slot6 in ipairs(slot0._wenhaoGo) do
			if not gohelper.isNil(slot6) and slot6.activeInHierarchy then
				SLFramework.AnimatorPlayer.Get(slot6):Play(slot1, slot0._wenHaoAnimDone, slot0)
			end
		end
	end
end

function slot0._wenHaoAnimDone(slot0)
	if slot0._wenhaoAnimName == "finish" then
		gohelper.destroy(slot0._go)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFinishAndDisposeElement, slot0._config)
	end
end

function slot0._destroyGo(slot0)
	gohelper.destroy(slot0._go)
end

function slot0._destroyItemGo(slot0)
	gohelper.destroy(slot0._itemGo)
end

function slot0.setFinish(slot0)
	if #slot0._wenhaoGo == 0 then
		slot0:_destroyGo()

		return
	end

	slot0:removeEventListeners()
	slot0:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(slot0._destroyItemGo, slot0, 0.77)
	TaskDispatcher.runDelay(slot0._destroyGo, slot0, 1.6)
end

function slot0.setFinishAndDotDestroy(slot0)
	if #slot0._wenhaoGo == 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)

	if #slot0._finishGo > 0 then
		for slot4, slot5 in ipairs(slot0._finishGo) do
			gohelper.setActive(slot5, true)

			if slot5.activeInHierarchy then
				SLFramework.AnimatorPlayer.Get(slot5):Play(UIAnimationName.Open, slot0.setFinishAndDotDestroyAnimationDone, slot0)
			end
		end
	else
		slot0:dispose()
	end
end

function slot0.setFinishAndDotDestroyAnimationDone(slot0)
	slot0.animatorPlayer:Play(UIAnimationName.Idle, function ()
	end, slot0)
	slot0:dispose()
end

function slot0.onDown(slot0)
	slot0:_onDown()
end

function slot0._onDown(slot0)
	slot0._sceneElements:setElementDown(slot0)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
	slot0._sceneElements:clickElement(slot0._config.id)
end

function slot0._onResLoaded(slot0)
	slot0._itemGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._config.res):GetResource(slot0._config.res), slot0._go)

	if slot0._config.resScale and slot3 ~= 0 then
		transformhelper.setLocalScale(slot0._itemGo.transform, slot3, slot3, 1)
	end

	gohelper.setLayer(slot0._itemGo, UnityLayer.Scene, true)
	DungeonMapElement.addBoxColliderListener(slot0._itemGo, slot0._onDown, slot0)
	transformhelper.setLocalPos(slot0._itemGo.transform, 0, 0, -1)

	if #slot0._effectPath > 0 then
		for slot7, slot8 in ipairs(slot0._effectPath) do
			gohelper.addChild(slot0._go, UnityEngine.GameObject.New("effect" .. slot7))

			slot0._offsetX = string.splitToNumber(slot0._config.tipOffsetPos, "#")[1] or 0
			slot0._offsetY = slot10[2] or 0
			slot11 = slot0._effectPath[slot7]
			slot14 = gohelper.clone(slot0._resLoader:getAssetItem(slot11):GetResource(slot11), slot9, "root")

			DungeonMapElement.addBoxColliderListener(slot14, slot0._onDown, slot0)
			transformhelper.setLocalPos(slot14.transform, slot0._offsetX, slot0._offsetY, -3)

			if gohelper.findChildComponent(slot14, "ani", typeof(UnityEngine.Animator)) then
				slot15:Play("lhem_icon_loop", 0, math.random(0, 100) / 100)
			end

			slot16 = gohelper.findChild(slot14, "ani/yuanjian_new_07/gou")

			gohelper.setActive(slot16, false)

			if slot16 then
				table.insert(slot0._finishGo, slot16)
			end

			if slot0._mapScene:showInteractiveItem() then
				slot0:setWenHaoVisible(false)
			elseif slot0._wenhaoAnimName then
				slot0:setWenHaoAnim(slot0._wenhaoAnimName)
			end

			if string.find(slot11, "hddt_front_lubiao_a_002") then
				slot19 = gohelper.findChild(slot14, "ani/plane"):GetComponent(typeof(UnityEngine.Renderer)).material
				slot20 = slot19:GetVector("_Frame")
				slot20.w = DungeonEnum.ElementTypeIconIndex[string.format("%s0", slot0._config.type)]

				slot19:SetVector("_Frame", slot20)
			end

			slot20 = slot14

			table.insert(slot0._wenhaoGo, slot20)

			for slot20 = 1, 2 do
				if gohelper.findChild(slot14, string.format("ani/icon%d/anim/biaoti/txt", slot20)) then
					slot21:GetComponent(typeof(TMPro.TextMeshPro)).text = slot0._config.title

					if slot0._config.type == DungeonEnum.ElementType.DailyEpisode and VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(slot0._config.id) then
						slot22.text = slot23.name
					end
				end
			end
		end
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.addElementItem, slot0._config.id)

	if FightModel.instance:getFightParam() and slot4.episodeId then
		if DungeonConfig.instance:getEpisodeCO(slot5) and slot6.chapterId == 12701 then
			return
		end

		if slot0._config.param == tostring(slot5) then
			DungeonMapModel.instance.lastElementBattleId = nil

			if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipClickElement) then
				return
			end

			DungeonMapModel.instance.directFocusElement = true

			slot0:onClick()

			DungeonMapModel.instance.directFocusElement = false
		end
	end
end

function slot0._onSetEpisodeListVisible(slot0, slot1)
	slot0:setWenHaoVisible(slot1)
end

function slot0._afterCollectLastShow(slot0)
end

function slot0.addEventListeners(slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.afterCollectLastShow, slot0._afterCollectLastShow, slot0)
end

function slot0.removeEventListeners(slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)
end

function slot0.onStart(slot0)
end

function slot0.addBoxCollider2D(slot0)
	slot1 = ZProj.BoxColliderClickListener.Get(slot0)
	slot2 = gohelper.onceAddComponent(slot0, typeof(UnityEngine.BoxCollider2D))
	slot2.enabled = true
	slot2.size = Vector2(1.5, 1.5)

	slot1:SetIgnoreUI(true)

	return slot1
end

function slot0.addBoxColliderListener(slot0, slot1, slot2)
	DungeonMapElement.addBoxCollider2D(slot0):AddClickListener(slot1, slot2)
end

function slot0.dispose(slot0)
	slot0._itemGo = nil
	slot0._go = nil
	slot0.animatorPlayer = nil

	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._destroyItemGo, slot0)
	TaskDispatcher.cancelTask(slot0._destroyGo, slot0)
end

function slot0.onDestroy(slot0)
	if slot0._itemGo then
		gohelper.destroy(slot0._itemGo)

		slot0._itemGo = nil
	end

	if slot0._wenhaoGo then
		for slot4, slot5 in ipairs(slot0._wenhaoGo) do
			gohelper.destroy(slot5)
		end
	end

	if slot0._go then
		gohelper.destroy(slot0._go)

		slot0._go = nil
	end

	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	if slot0.animatorPlayer then
		slot0.animatorPlayer = nil
	end

	TaskDispatcher.cancelTask(slot0._destroyItemGo, slot0)
	TaskDispatcher.cancelTask(slot0._destroyGo, slot0)
end

return slot0
