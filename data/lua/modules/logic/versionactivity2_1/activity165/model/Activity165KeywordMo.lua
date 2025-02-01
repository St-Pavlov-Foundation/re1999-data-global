module("modules.logic.versionactivity2_1.activity165.model.Activity165KeywordMo", package.seeall)

slot0 = class("Activity165KeywordMo")

function slot0.ctor(slot0)
	slot0.keywordCo = nil
	slot0.keywordId = nil
	slot0.isUsed = nil
end

function slot0.onInit(slot0, slot1)
	slot0.keywordCo = slot1
	slot0.keywordId = slot1.keywordId
end

function slot0.setUsed(slot0, slot1)
	slot0.isUsed = slot1
end

function slot0.onReset(slot0)
	slot0.isUsed = nil
end

return slot0
