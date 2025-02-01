module("modules.logic.reddot.model.RedDotGroupMo", package.seeall)

slot0 = pureTable("RedDotGroupMo")

function slot0.init(slot0, slot1)
	slot0.id = tonumber(slot1.defineId)
	slot0.infos = slot0:_buildDotInfo(slot1.infos)
	slot0.replaceAll = slot1.replaceAll
end

function slot0._buildDotInfo(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		RedDotInfoMo.New():init(slot7)
	end

	return {
		[tonumber(slot7.id)] = slot8
	}
end

function slot0._resetDotInfo(slot0, slot1)
	if slot1.replaceAll then
		slot0.infos = {}
	end

	for slot5, slot6 in ipairs(slot1.infos) do
		if slot0.infos[tonumber(slot6.id)] then
			slot0.infos[tonumber(slot6.id)]:reset(slot6)
		else
			slot7 = RedDotInfoMo.New()

			slot7:init(slot6)

			slot0.infos[tonumber(slot6.id)] = slot7
		end
	end

	slot0.replaceAll = slot1.replaceAll
end

return slot0
