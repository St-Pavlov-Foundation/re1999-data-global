module("modules.logic.versionactivity2_3.dungeon.view.map.VersionActivity2_3DungeonMapFinishElement", package.seeall)

slot0 = class("VersionActivity2_3DungeonMapFinishElement", DungeonMapFinishElement)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._transform = slot1.transform

	transformhelper.setLocalPos(slot0._transform, string.splitToNumber(slot0._config.pos, "#")[1] or 0, slot2[2] or 0, slot2[3] or 0)

	slot0.resPath = slot0._config.res
	slot0.effectPath = slot0._config.effect

	if slot0._existGo then
		if not string.nilorempty(slot0.resPath) then
			slot0._itemGo = gohelper.findChild(slot0._go, slot0:getPathName(slot0.resPath) .. "(Clone)")

			DungeonMapFinishElement.addBoxColliderListener(slot0._itemGo, slot0._onDown, slot0)
		end

		if not string.nilorempty(slot0.effectPath) then
			slot0._effectGo = gohelper.findChild(slot0._go, slot0:getPathName(slot0.effectPath) .. "(Clone)")

			DungeonMapFinishElement.addBoxColliderListener(slot0._effectGo, slot0._onDown, slot0)
		end
	else
		if slot0._resLoader then
			return
		end

		slot0._resLoader = MultiAbLoader.New()

		if not string.nilorempty(slot0.resPath) then
			slot0._resLoader:addPath(slot0.resPath)
		end

		if not string.nilorempty(slot0.effectPath) then
			slot0._resLoader:addPath(slot0.effectPath)
		end

		slot0._resLoader:startLoad(slot0._onResLoaded, slot0)
	end
end

function slot0._onResLoaded(slot0)
	if not string.nilorempty(slot0.resPath) then
		slot0._itemGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0.resPath):GetResource(slot0.resPath), slot0._go)

		if slot0._config.resScale and slot3 ~= 0 then
			transformhelper.setLocalScale(slot0._itemGo.transform, slot3, slot3, 1)
		end

		gohelper.setLayer(slot0._itemGo, UnityLayer.Scene, true)
		DungeonMapFinishElement.addBoxColliderListener(slot0._itemGo, slot0._onDown, slot0)
		transformhelper.setLocalPos(slot0._itemGo.transform, 0, 0, -1)
	end

	if not string.nilorempty(slot0.effectPath) then
		slot0._offsetX = string.splitToNumber(slot0._config.tipOffsetPos, "#")[1] or 0
		slot0._offsetY = slot1[2] or 0
		slot0._effectGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0.effectPath):GetResource(slot0.effectPath), slot0._go)

		DungeonMapFinishElement.addBoxColliderListener(slot0._effectGo, slot0._onDown, slot0)
		transformhelper.setLocalPos(slot0._effectGo.transform, slot0._offsetX, slot0._offsetY, -3)

		if gohelper.findChild(slot0._effectGo, "ani/yuanjian_new_07/gou") then
			gohelper.setActive(slot4, true)
			slot4:GetComponent(typeof(UnityEngine.Animator)):Play("idle")
		end
	end
end

function slot0.onDown(slot0)
	slot0:_onDown()
end

function slot0._onDown(slot0)
	slot0._sceneElements:setMouseElementDown(slot0)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot0._config.type == DungeonEnum.ElementType.None and slot0._config.fragment > 0 then
		ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
			notShowToast = true,
			fragmentId = slot0._config.fragment,
			elementId = slot0._config.id
		})
	end
end

return slot0
