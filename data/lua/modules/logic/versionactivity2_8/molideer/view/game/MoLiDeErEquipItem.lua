module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEquipItem", package.seeall)

local var_0_0 = class("MoLiDeErEquipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._simageProp = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Prop")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#txt_Num")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Detail")
	arg_1_0._goUseFx = gohelper.findChild(arg_1_0.viewGO, "#use")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._imageProp = gohelper.findChildImage(arg_2_0.viewGO, "#simage_Prop")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnDetail:AddClickListener(arg_3_0.onDetailClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnDetail:RemoveClickListener()
end

function var_0_0.onDetailClick(arg_5_0)
	local var_5_0 = arg_5_0.itemId

	if var_5_0 == MoLiDeErGameModel.instance:getSelectItemId() then
		return
	end

	MoLiDeErGameModel.instance:setSelectItemId(var_5_0)
end

function var_0_0.setData(arg_6_0, arg_6_1)
	arg_6_0.itemId = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.setActive(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0.viewGO, arg_7_1)
end

function var_0_0.reset(arg_8_0)
	arg_8_0.itemId = nil

	arg_8_0:setActive(false)
end

function var_0_0.setUseFxState(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goUseFx, arg_9_1)
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = MoLiDeErGameModel.instance:getCurGameInfo()
	local var_10_1 = arg_10_0.itemId
	local var_10_2 = var_10_0:getEquipInfo(var_10_1)
	local var_10_3 = MoLiDeErConfig.instance:getItemConfig(var_10_1)

	if var_10_2 == nil or var_10_3 == nil then
		logError("莫莉德尔 角色活动 不存在的道具id" .. var_10_1)

		return
	end

	arg_10_0._itemConfig = var_10_3
	arg_10_0._txtNum.text = tostring(var_10_2.quantity)

	if not string.nilorempty(var_10_3.picture) then
		arg_10_0._simageProp:LoadImage(var_10_3.picture)
	end

	local var_10_4

	if var_10_2.quantity <= 0 then
		var_10_4 = MoLiDeErEnum.EventBgColor.Dispatching
	else
		var_10_4 = MoLiDeErEnum.EventBgColor.Normal
	end

	UIColorHelper.set(arg_10_0._imageProp, var_10_4)
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0
