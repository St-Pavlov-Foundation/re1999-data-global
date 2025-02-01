module("modules.logic.common.view.CommonRainEffectView", package.seeall)

slot0 = class("CommonRainEffectView", BaseView)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._containerPath = slot1
end

function slot0.onInitView(slot0)
	slot0._goglowcontainer = gohelper.findChild(slot0.viewGO, slot0._containerPath)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._effectLoader = MultiAbLoader.New()

	slot0._effectLoader:addPath("ui/viewres/effect/ui_character_rain.prefab")
	slot0._effectLoader:startLoad(function (slot0)
		gohelper.clone(uv0._effectLoader:getAssetItem(uv1):GetResource(uv1), uv0._goglowcontainer)
	end)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._effectLoader then
		slot0._effectLoader:dispose()

		slot0._effectLoader = nil
	end
end

return slot0
