module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameStatusMo", package.seeall)

slot0 = pureTable("YaXianGameStatusMo")

function slot0.NewFunc()
	return uv0.New()
end

function slot0.resetFunc(slot0)
	slot0.status = nil
	slot0.directionList = nil
end

function slot0.releaseFunc(slot0)
	slot0:resetFunc()
end

function slot0.addStatus(slot0, slot1, slot2)
	slot0.status = slot1

	if slot2 then
		slot0.directionList = slot0.directionList or {}

		if not tabletool.indexOf(slot0.directionList, slot2) then
			table.insert(slot0.directionList, slot2)
		end
	end
end

return slot0
