module("modules.logic.story.view.StoryActivityChapterBase", package.seeall)

slot0 = class("StoryActivityChapterBase", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.rootGO = gohelper.create2d(slot1, "chapter")
	slot2 = slot0.rootGO.transform
	slot2.anchorMin = RectTransformDefine.Anchor.LeftBottom
	slot2.anchorMax = RectTransformDefine.Anchor.RightUp
	slot2.sizeDelta = RectTransformDefine.Anchor.LeftBottom

	slot0:onCtor()
end

function slot0.loadPrefab(slot0)
	if not slot0.assetPath then
		return
	end

	if not slot0._resLoader then
		slot0._resLoader = PrefabInstantiate.Create(slot0.rootGO)
	end

	slot0._resLoader:startLoad(slot0.assetPath, slot0.onLoaded, slot0)
end

function slot0.onLoaded(slot0)
	slot0.viewGO = slot0._resLoader:getInstGO()

	slot0:onInitView()
	slot0:onUpdateView()
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1

	if not slot0.viewGO then
		slot0:loadPrefab()

		return
	end

	gohelper.setActive(slot0.rootGO, true)
	slot0:onUpdateView()
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.rootGO, false)
	slot0:onHide()
end

function slot0.onCtor(slot0)
end

function slot0.onInitView(slot0)
end

function slot0.onUpdateView(slot0)
end

function slot0.onHide(slot0)
end

function slot0.onDestory(slot0)
	if slot0._resloader then
		slot0._resloader:dispose()

		slot0._resloader = nil
	end

	if slot0.rootGO then
		gohelper.destroy(slot0.rootGO)

		slot0.rootGO = nil
	end

	slot0:__onDispose()
end

return slot0
