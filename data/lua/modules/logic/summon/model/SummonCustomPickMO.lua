module("modules.logic.summon.model.SummonCustomPickMO", package.seeall)

slot0 = pureTable("SummonCustomPickMO")

function slot0.ctor(slot0)
	slot0.pickHeroIds = nil
	slot0._haveFirstSSR = false
end

function slot0.update(slot0, slot1)
	slot0.pickHeroIds = {}

	if slot1.UpHeroIds then
		for slot5 = 1, #slot1.UpHeroIds do
			table.insert(slot0.pickHeroIds, slot1.UpHeroIds[slot5])
		end
	end

	if SummonEnum.ChooseNeedFirstHeroIds then
		for slot5, slot6 in ipairs(SummonEnum.ChooseNeedFirstHeroIds) do
			for slot10, slot11 in ipairs(slot0.pickHeroIds) do
				if slot11 == slot6 then
					table.remove(slot0.pickHeroIds, slot10)
					table.insert(slot0.pickHeroIds, 1, slot6)

					break
				end
			end
		end
	end

	if slot1.usedFirstSSRGuarantee ~= nil then
		slot0._haveFirstSSR = slot1.usedFirstSSRGuarantee
	end
end

function slot0.isPicked(slot0, slot1)
	return slot0.pickHeroIds ~= nil and SummonCustomPickModel.instance:getMaxSelectCount(slot1) <= #slot0.pickHeroIds
end

function slot0.isHaveFirstSSR(slot0)
	return slot0._haveFirstSSR
end

return slot0
