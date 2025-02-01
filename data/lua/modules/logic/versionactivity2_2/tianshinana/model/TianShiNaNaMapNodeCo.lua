module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapNodeCo", package.seeall)

slot0 = pureTable("TianShiNaNaMapNodeCo")

function slot0.init(slot0, slot1)
	slot0.x = slot1[1]
	slot0.y = slot1[2]
	slot0.nodeType = slot1[3]
	slot0.collapseRound = slot1[4]
	slot0.nodePath = slot1[5]
	slot0.walkable = slot1[6]
end

function slot0.isCollapse(slot0)
	if not slot0.collapseRound or slot0.collapseRound == 0 or TianShiNaNaModel.instance.nowRound < slot0.collapseRound then
		return false
	end

	return true
end

return slot0
