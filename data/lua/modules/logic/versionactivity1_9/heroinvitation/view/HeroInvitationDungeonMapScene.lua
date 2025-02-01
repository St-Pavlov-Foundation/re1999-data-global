module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapScene", package.seeall)

slot0 = class("HeroInvitationDungeonMapScene", DungeonMapScene)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._setInitPos(slot0, slot1)
	if not slot0._mapCfg then
		return
	end

	if slot0.viewContainer.mapSceneElements._inRemoveElement then
		return
	end

	if not slot2._inRemoveElementId and DungeonConfig.instance:getMapElements(slot0._mapCfg.id) then
		for slot8, slot9 in ipairs(slot4) do
			if HeroInvitationModel.instance:getInvitationStateByElementId(slot9.id) ~= HeroInvitationEnum.InvitationState.TimeLocked and slot10 ~= HeroInvitationEnum.InvitationState.ElementLocked and DungeonMapModel.instance:getElementById(slot9.id) then
				slot3 = slot9.id

				break
			end
		end
	end

	if slot3 then
		DungeonMapModel.instance.directFocusElement = true

		slot0:_focusElementById(slot3)

		DungeonMapModel.instance.directFocusElement = false
	else
		slot4 = string.splitToNumber(slot0._mapCfg.initPos, "#")

		slot0:setScenePosSafety(Vector3(slot4[1], slot4[2], 0), slot1)
	end
end

function slot0._onOpenView(slot0, slot1)
end

function slot0._onCloseView(slot0, slot1)
end

return slot0
