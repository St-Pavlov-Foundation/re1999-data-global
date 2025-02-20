module("modules.logic.fight.model.data.FightEntityEXDataMgr", package.seeall)

slot0 = FightDataBase("FightEntityEXDataMgr")

function slot0.ctor(slot0)
	slot0._exDataDic = {}
end

function slot0.getEntityEXData(slot0, slot1)
	return slot0._exDataDic[slot1]
end

function slot0.setEXDataAfterAddEntityMO(slot0, slot1)
	if not slot0._exDataDic[slot1.id] then
		slot0._exDataDic[slot1.id] = {}
	end

	tabletool.clear(slot2)
end

return slot0
