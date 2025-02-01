module("modules.logic.dungeon.view.map.DungeonMapFinishElement", package.seeall)

slot0 = class("DungeonMapFinishElement", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._config = slot1[1]
	slot0._mapScene = slot1[2]
	slot0._sceneElements = slot1[3]
	slot0._existGo = slot1[4]
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

	transformhelper.setLocalPos(slot0._transform, string.splitToNumber(slot0._config.pos, "#")[1] or 0, slot2[2] or 0, slot2[3] or 0)

	slot0.resPath = slot0._config.res
	slot0.effectPath = slot0._config.effect

	if slot0._existGo then
		slot0._itemGo = gohelper.findChild(slot0._go, slot0:getPathName(slot0.resPath) .. "(Clone)")

		uv0.addBoxColliderListener(slot0._itemGo, slot0._onDown, slot0)

		if not string.nilorempty(slot0.effectPath) then
			slot0._effectGo = gohelper.findChild(slot0._go, slot0:getPathName(slot0.effectPath) .. "(Clone)")

			uv0.addBoxColliderListener(slot0._effectGo, slot0._onDown, slot0)
		end
	else
		if slot0._resLoader then
			return
		end

		slot0._resLoader = MultiAbLoader.New()

		slot0._resLoader:addPath(slot0.resPath)

		if not string.nilorempty(slot0.effectPath) then
			slot0._resLoader:addPath(slot0.effectPath)
		end

		slot0._resLoader:startLoad(slot0._onResLoaded, slot0)
	end
end

function slot0._onResLoaded(slot0)
	slot0._itemGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0.resPath):GetResource(slot0.resPath), slot0._go)

	if slot0._config.resScale and slot3 ~= 0 then
		transformhelper.setLocalScale(slot0._itemGo.transform, slot3, slot3, 1)
	end

	gohelper.setLayer(slot0._itemGo, UnityLayer.Scene, true)
	uv0.addBoxColliderListener(slot0._itemGo, slot0._onDown, slot0)
	transformhelper.setLocalPos(slot0._itemGo.transform, 0, 0, -1)

	if not string.nilorempty(slot0.effectPath) then
		slot0._offsetX = string.splitToNumber(slot0._config.tipOffsetPos, "#")[1] or 0
		slot0._offsetY = slot4[2] or 0
		slot0._effectGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0.effectPath):GetResource(slot0.effectPath), slot0._go)

		uv0.addBoxColliderListener(slot0._effectGo, slot0._onDown, slot0)
		transformhelper.setLocalPos(slot0._effectGo.transform, slot0._offsetX, slot0._offsetY, -3)

		if gohelper.findChild(slot0._effectGo, "ani/yuanjian_new_07/gou") then
			gohelper.setActive(slot5, true)
			slot5:GetComponent(typeof(UnityEngine.Animator)):Play("idle")
		end
	end
end

function slot0.onDown(slot0)
	slot0:_onDown()
end

function slot0._onDown(slot0)
	slot0._sceneElements:setElementDown(slot0)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot0._config.type == DungeonEnum.ElementType.PuzzleGame then
		ViewMgr.instance:openView(ViewName.VersionActivityPuzzleView, {
			isFinish = true,
			elementCo = slot0._config
		})

		return
	end

	if lua_chapter_map_fragment.configDict[slot0._config.fragment] and slot1.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
		ViewMgr.instance:openView(ViewName.VersionActivityNewsView, {
			fragmentId = slot1.id
		})
	end
end

function slot0._onSetEpisodeListVisible(slot0, slot1)
	gohelper.setActive(slot0._go, slot1)
end

function slot0.addEventListeners(slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)
end

function slot0.removeEventListeners(slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)
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
	uv0.addBoxCollider2D(slot0):AddClickListener(slot1, slot2)
end

function slot0.isValid(slot0)
	return not gohelper.isNil(slot0._go)
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
end

function slot0.getPathName(slot0, slot1)
	slot2 = string.split(string.split(slot1, ".")[1], "/")

	return slot2[#slot2]
end

return slot0
