module("modules.logic.explore.map.unit.ExplorePipeUnit", package.seeall)

slot0 = class("ExplorePipeUnit", ExploreBaseDisplayUnit)

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
	slot0:addComp("pipeComp", ExplorePipeComp)
end

function slot0.setupMO(slot0)
	uv0.super.setupMO(slot0)
	slot0.pipeComp:initData()
end

function slot0.onRotateFinish(slot0)
	ExploreController.instance:getMapPipe():initColors()
end

return slot0
