module("modules.logic.fight.view.FightGMRecordView", package.seeall)

slot0 = class("FightGMRecordView", BaseView)
slot1 = "保存战斗录像"

function slot0.ctor(slot0)
	slot0._goGM = nil
	slot0._btnGM = nil
end

function slot0.onOpen(slot0)
	if not isDebugBuild and not GMBattleModel.instance.enableGMFightRecord then
		return
	end

	slot0._goGM = GMController.instance:getGMNode("mainview", slot0.viewGO)
	slot0._goGM.name = "gm_fight_record"

	if slot0._goGM then
		recthelper.setWidth(gohelper.findChildImage(slot0._goGM, "#btn_gm").transform, 200)

		slot0._txtName = gohelper.findChildText(slot0._goGM, "#btn_gm/Text")
		slot0._txtName.text = uv0
		slot0._btnGM = gohelper.findChildClickWithAudio(slot0._goGM, "#btn_gm")

		slot0._btnGM:AddClickListener(slot0._onClickGM, slot0)
	end
end

function slot0._onClickGM(slot0)
	uv0.saveRecord()
end

function slot0.saveRecord()
	if GMBattleModel.instance.fightRecordMsg then
		slot0 = ProtoTestCaseMO.New()

		slot0:initFromProto(-12599, GMBattleModel.instance.fightRecordMsg)

		slot0:serialize().struct = "FightWithRecordAllRequest"
		slot5 = FightModel.instance
		slot7 = slot5

		for slot6, slot7 in pairs(slot5.getFightParam(slot7)) do
			if type(slot7) ~= "table" then
				-- Nothing
			end
		end

		slot1.fightParam = {
			[slot6] = slot7
		}

		WindowsUtil.saveContentToFile(uv0, cjson.encode(slot1), "fightrecord", "json")
	end
end

function slot0.removeEvents(slot0)
	if slot0._btnGM then
		slot0._btnGM:RemoveClickListener()
	end
end

return slot0
