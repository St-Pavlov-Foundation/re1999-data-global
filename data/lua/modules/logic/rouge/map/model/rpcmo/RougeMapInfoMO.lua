module("modules.logic.rouge.map.model.rpcmo.RougeMapInfoMO", package.seeall)

slot0 = pureTable("RougeMapInfoMO")

function slot0.init(slot0, slot1)
	slot0.mapType = slot1.mapType
	slot0.layerId = slot1.layerId
	slot0.middleLayerId = slot1.middleLayerId
	slot0.curStage = slot1.curStage
	slot0.curNode = slot1.curNode
	slot0.nodeInfo = GameUtil.rpcInfosToList(slot1.nodeInfo, RougeNodeInfoMO)
	slot0.skillInfo = GameUtil.rpcInfosToList(slot1.mapSkill, RougeMapSkillMO)
end

return slot0
