module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapHoleView", package.seeall)

slot0 = class("HeroInvitationDungeonMapHoleView", DungeonMapHoleView)

function slot0.refreshHoles(slot0)
	if not slot0.loadSceneDone or gohelper.isNil(slot0.mat) then
		return
	end

	slot1 = {}

	for slot5, slot6 in pairs(slot0.holdCoList) do
		slot7 = slot6[4]
		slot12 = math.sqrt((slot0.mainCameraPosY - (slot6[2] + slot0.sceneWorldPosY - slot0.defaultSceneWorldPosY))^2)

		if math.sqrt((slot0.mainCameraPosX - (slot6[1] + slot0.sceneWorldPosX - slot0.defaultSceneWorldPosX))^2) <= slot0._mapHalfWidth + math.abs(slot6[3]) and slot12 <= slot0._mapHalfHeight + slot10 then
			if slot7 and slot7 > 0 then
				-- Nothing
			end

			table.insert(slot1, {
				finish = 0,
				distance = -(slot11 * slot11 + slot12 * slot12),
				pos = {
					slot8,
					slot9,
					slot6[3]
				},
				id = slot7 or 0,
				finish = DungeonMapModel.instance:elementIsFinished(slot7) and 0 or 1
			})
		end
	end

	if #slot1 > 1 then
		table.sort(slot1, SortUtil.tableKeyUpper({
			"finish",
			"distance",
			"id"
		}))
	end

	for slot5 = 1, 5 do
		if slot1[slot5] then
			slot0.tempVector4:Set(slot6.pos[1], slot6.pos[2], slot6.pos[3])
			slot0.mat:SetVector(slot0.shaderParamList[slot5], slot0.tempVector4)
		else
			slot0.tempVector4:Set(0, 0, 0)
			slot0.mat:SetVector(slot0.shaderParamList[slot5], slot0.tempVector4)
		end
	end
end

return slot0
