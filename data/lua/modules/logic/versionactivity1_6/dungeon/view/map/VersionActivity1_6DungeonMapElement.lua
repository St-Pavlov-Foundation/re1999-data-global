module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapElement", package.seeall)

slot0 = class("VersionActivity1_6DungeonMapElement", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._config = slot1[1]
	slot0._sceneElements = slot1[2]
end

function slot0.getElementId(slot0)
	return slot0._config.id
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0.show(slot0)
	gohelper.setActive(slot0._go, true)
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._transform = slot1.transform

	slot0:updatePos()

	if slot0._resLoader then
		return
	end

	slot0._resLoader = MultiAbLoader.New()
	slot0._resPath = slot0._config.res
	slot0._effectPath = slot0._config.effect

	if not string.nilorempty(slot0._resPath) then
		slot0._resLoader:addPath(slot0._resPath)
	end

	if not string.nilorempty(slot0._effectPath) then
		slot0._resLoader:addPath(slot0._effectPath)
	end

	slot0._resLoader:startLoad(slot0._onResLoaded, slot0)
end

function slot0._onResLoaded(slot0)
	slot0:createMainPrefab()
	slot0:createEffectPrefab()
	slot0:autoPopInteractView()
	slot0:tryHideSelf()
end

function slot0.createMainPrefab(slot0)
	if string.nilorempty(slot0._resPath) then
		return
	end

	slot0._itemGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._resPath):GetResource(slot0._resPath), slot0._go)
	slot0.posTransform = slot0._itemGo.transform

	if slot0._config.resScale and slot3 ~= 0 then
		transformhelper.setLocalScale(slot0.posTransform, slot3, slot3, 1)
	end

	gohelper.setLayer(slot0._itemGo, UnityLayer.Scene, true)
	slot0.addBoxColliderListener(slot0._itemGo, slot0._onClickDown, slot0)
	transformhelper.setLocalPos(slot0.posTransform, 0, 0, -1)
end

function slot0.createEffectPrefab(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		slot2 = slot0._config.tipOffsetPos

		if string.nilorempty(slot0._effectPath) then
			return
		end
	end

	slot0._offsetX = string.splitToNumber(slot2, "#")[1] or 0
	slot0._offsetY = slot3[2] or 0
	slot0._effectGo = gohelper.clone(slot0._resLoader:getAssetItem(slot1):GetResource(slot1), slot0._go)
	slot0.posTransform = slot0._effectGo.transform

	transformhelper.setLocalPos(slot0._effectGo.transform, slot0._offsetX, slot0._offsetY, -3)
	slot0.addBoxColliderListener(slot0._effectGo, slot0._onClickDown, slot0)

	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		slot0:hideElement()
	end
end

function slot0.updatePos(slot0)
	transformhelper.setLocalPos(slot0._transform, string.splitToNumber(slot0._config.pos, "#")[1] or 0, slot1[2] or 0, slot1[3] or 0)
end

function slot0.getTransform(slot0)
	return slot0._transform
end

function slot0.getElementPos(slot0)
	if not slot0.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(slot0.posTransform)
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0._onClickDown(slot0)
	slot0._sceneElements:setMouseElementDown(slot0)
end

function slot0.onClick(slot0)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnClickElement, slot0)
end

function slot0.showElement(slot0)
	slot0:playEffectAnim("wenhao_a_001_in")
end

function slot0.hideElement(slot0)
	slot0:playEffectAnim("wenhao_a_001_out")
end

function slot0.playEffectAnim(slot0, slot1)
	slot0._wenhaoAnimName = slot1

	if gohelper.isNil(slot0._effectGo) then
		return
	end

	if not slot0._effectGo.activeInHierarchy then
		return
	end

	if gohelper.isNil(slot0._effectAnimator) then
		slot0._effectAnimator = SLFramework.AnimatorPlayer.Get(slot0._effectGo)
	end

	if not gohelper.isNil(slot0._effectAnimator) then
		slot0._effectAnimator:Play(slot1, slot0._effectAnimDone, slot0)
	end
end

function slot0._effectAnimDone(slot0)
	logNormal("effect anim done")
end

function slot0.addBoxColliderListener(slot0, slot1, slot2)
	gohelper.addBoxCollider2D(slot0, Vector2(1.5, 1.5))

	slot3 = ZProj.BoxColliderClickListener.Get(slot0)

	slot3:SetIgnoreUI(true)
	slot3:AddClickListener(slot1, slot2)
end

function slot0.isValid(slot0)
	return not gohelper.isNil(slot0._go)
end

function slot0.setFinish(slot0)
	if not slot0._effectGo then
		gohelper.destroy(slot0._itemGo)

		slot0._itemGo = nil

		return
	end

	slot0:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(slot0.onFinishAnimDone, slot0, 1.6)
end

function slot0.onFinishAnimDone(slot0)
	slot0:onDestroy()
end

function slot0.autoPopInteractView(slot0)
	if not DungeonMapModel.instance.lastElementBattleId then
		return
	end

	if tonumber(slot0._config.param) == DungeonMapModel.instance.lastElementBattleId then
		slot0:onClick()

		DungeonMapModel.instance.lastElementBattleId = nil
	end
end

function slot0.tryHideSelf(slot0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		slot0:hideElement()
	end
end

function slot0.onDestroy(slot0)
	gohelper.setActive(slot0._go, true)

	if slot0._effectGo then
		gohelper.destroy(slot0._effectGo)

		slot0._effectGo = nil
	end

	if slot0._itemGo then
		gohelper.destroy(slot0._itemGo)

		slot0._itemGo = nil
	end

	if slot0._go then
		gohelper.destroy(slot0._go)

		slot0._go = nil
	end

	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	slot0.destroyed = true
end

return slot0
