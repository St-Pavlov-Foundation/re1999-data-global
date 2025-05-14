module("modules.logic.fight.view.FightGMRecordView", package.seeall)

local var_0_0 = class("FightGMRecordView", BaseView)
local var_0_1 = "保存战斗录像"

function var_0_0.ctor(arg_1_0)
	arg_1_0._goGM = nil
	arg_1_0._btnGM = nil
end

function var_0_0.onOpen(arg_2_0)
	if not isDebugBuild and not GMBattleModel.instance.enableGMFightRecord then
		return
	end

	arg_2_0._goGM = GMController.instance:getGMNode("mainview", arg_2_0.viewGO)
	arg_2_0._goGM.name = "gm_fight_record"

	if arg_2_0._goGM then
		local var_2_0 = gohelper.findChildImage(arg_2_0._goGM, "#btn_gm")

		recthelper.setWidth(var_2_0.transform, 200)

		arg_2_0._txtName = gohelper.findChildText(arg_2_0._goGM, "#btn_gm/Text")
		arg_2_0._txtName.text = var_0_1
		arg_2_0._btnGM = gohelper.findChildClickWithAudio(arg_2_0._goGM, "#btn_gm")

		arg_2_0._btnGM:AddClickListener(arg_2_0._onClickGM, arg_2_0)
	end
end

function var_0_0._onClickGM(arg_3_0)
	var_0_0.saveRecord()
end

function var_0_0.saveRecord()
	if GMBattleModel.instance.fightRecordMsg then
		local var_4_0 = ProtoTestCaseMO.New()

		var_4_0:initFromProto(-12599, GMBattleModel.instance.fightRecordMsg)

		local var_4_1 = var_4_0:serialize()

		var_4_1.struct = "FightWithRecordAllRequest"

		local var_4_2 = {}

		for iter_4_0, iter_4_1 in pairs(FightModel.instance:getFightParam()) do
			if type(iter_4_1) ~= "table" then
				var_4_2[iter_4_0] = iter_4_1
			end
		end

		var_4_1.fightParam = var_4_2

		local var_4_3 = cjson.encode(var_4_1)

		WindowsUtil.saveContentToFile(var_0_1, var_4_3, "fightrecord", "json")
	end
end

function var_0_0.removeEvents(arg_5_0)
	if arg_5_0._btnGM then
		arg_5_0._btnGM:RemoveClickListener()
	end
end

return var_0_0
