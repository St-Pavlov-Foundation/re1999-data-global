module("modules.logic.gm.view.GMFightSimulateRightItem", package.seeall)

local var_0_0 = class("GMFightSimulateRightItem", ListScrollCell)
local var_0_1 = Color.New(1, 0.8, 0.8, 1)
local var_0_2 = Color.white
local var_0_3

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_1, "btn")

	arg_1_0._btn:AddClickListener(arg_1_0._onClickItem, arg_1_0)

	arg_1_0._imgBtn = gohelper.findChildImage(arg_1_1, "btn")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "btn/Text")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._episodeCO = arg_2_1
	arg_2_0._txtName.text = arg_2_0._episodeCO.name
	arg_2_0._imgBtn.color = arg_2_0._episodeCO.id == var_0_3 and var_0_1 or var_0_2
end

function var_0_0._onClickItem(arg_3_0)
	var_0_3 = arg_3_0._episodeCO.id
	arg_3_0._imgBtn.color = var_0_1

	arg_3_0._view:closeThis()

	if DungeonModel.isBattleEpisode(arg_3_0._episodeCO) then
		JumpModel.instance.jumpFromFightSceneParam = "99"

		DungeonFightController.instance:enterFight(arg_3_0._episodeCO.chapterId, arg_3_0._episodeCO.id)
	else
		logError("GMToolView 不支持该类型的关卡" .. arg_3_0._episodeCO.id)
	end
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0._btn then
		arg_4_0._btn:RemoveClickListener()

		arg_4_0._btn = nil
	end
end

return var_0_0
