module("modules.logic.seasonver.act123.view2_1.Season123_2_1EquipHeroSpineView", package.seeall)

slot0 = class("Season123_2_1EquipHeroSpineView", BaseView)

function slot0.onInitView(slot0)
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_normal/left/#go_herocontainer/dynamiccontainer/#go_spine")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._uiSpine = GuiSpine.Create(slot0._gospine, true)

	slot0:createSpine()
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.createSpine(slot0)
	slot0._uiSpine:setResPath(ResUrl.getRolesCgStory(Activity104Enum.MainRoleSkinPath), slot0.onSpineLoaded, slot0)
end

function slot0.onSpineLoaded(slot0)
	slot0._spineLoaded = true

	if slot0._uiSpine then
		slot0._uiSpine:changeLookDir(SpineLookDir.Left)
		slot0._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "idle", true, 0)
	end
end

return slot0
