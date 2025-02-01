module("modules.logic.explore.map.unit.ExploreDichroicPrismUnit", package.seeall)

slot0 = class("ExploreDichroicPrismUnit", ExplorePrismUnit)

function slot0.addLights(slot0)
	slot0.lightComp:addLight(slot0.mo.unitDir - 45)
	slot0.lightComp:addLight(slot0.mo.unitDir + 45)
end

return slot0
