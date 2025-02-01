module("modules.logic.versionactivity2_1.aergusi.model.AergusiClueMo", package.seeall)

slot0 = class("AergusiClueMo")

function slot0.ctor(slot0)
	slot0.clueId = 0
	slot0.status = 0
end

function slot0.init(slot0, slot1)
	slot0.clueId = slot1.clueId
	slot0.status = slot1.status
end

return slot0
