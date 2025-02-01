module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotProgressListMO", package.seeall)

slot0 = pureTable("V1a6_CachotProgressListMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.id = slot2
	slot0.isLocked = slot3
end

function slot0.getLineWidth(slot0)
	if not slot0.isLocked then
		return V1a6_CachotEnum.UnLockedRewardItemWidth
	end

	slot3 = 0

	if V1a6_CachotProgressListModel.instance._scrollViews and slot1[1] then
		slot3 = recthelper.getWidth(slot2:getCsScroll().transform)
	end

	slot4 = V1a6_CachotEnum.LockedRewardItemWidth

	if (slot0.index - 1) * V1a6_CachotEnum.UnLockedRewardItemWidth - slot3 < 0 then
		slot4 = math.abs(slot5)
	end

	return slot4
end

function slot0.computeLockedItemWidth(slot0)
end

return slot0
