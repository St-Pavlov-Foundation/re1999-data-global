module("modules.logic.gm.model.GMLogModel", package.seeall)

slot0 = class("GMLogModel", BaseModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0.errorModel = ListScrollModel.New()
end

function slot0.addMsg(slot0, slot1, slot2, slot3)
	if ({
		msg = string.gsub(string.gsub(slot1, "<color[^>]+>", ""), "</color>", ""),
		stackTrace = string.gsub(string.gsub(slot2, "<color[^>]+>", ""), "</color>", ""),
		type = slot3,
		time = ServerTime.now()
	}).type == 0 then
		slot0.errorModel:addAtFirst(slot4)
	end
end

slot0.instance = slot0.New()

return slot0
