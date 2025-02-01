module("modules.logic.voice.VoiceChooseModel", package.seeall)

slot0 = class("VoiceChooseModel", ListScrollModel)

function slot0.initModel(slot0, slot1)
	slot3 = {}

	for slot8 = 1, #HotUpdateVoiceMgr.instance:getSupportVoiceLangs() do
		slot9 = slot2[slot8]
		slot11 = SLFramework.GameUpdate.OptionalUpdate.Instance:GetLocalVersion(slot9)

		if slot9 == GameConfig:GetDefaultVoiceShortcut() then
			table.insert(slot3, 1, {
				lang = slot9,
				choose = slot9 == slot1
			})
		elseif not string.nilorempty(slot11) then
			table.insert(slot3, {
				lang = slot9,
				choose = slot9 == slot1
			})
		end
	end

	slot0:setList(slot3)
end

function slot0.getChoose(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		if slot6.choose then
			return slot6.lang
		end
	end
end

function slot0.choose(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		slot7.choose = slot7.lang == slot1
	end

	slot0:onModelUpdate()
end

slot0.instance = slot0.New()

return slot0
