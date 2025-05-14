module("modules.logic.gm.view.fight.FightGmNameUIComp", package.seeall)

local var_0_0 = class("FightGmNameUIComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

var_0_0.GmNameUIPath = "ui/viewres/gm/gmnameui.prefab"
var_0_0.SideAnchorY = {
	[FightEnum.EntitySide.MySide] = 93,
	[FightEnum.EntitySide.EnemySide] = 147
}

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.goContainer = arg_2_1
	arg_2_0.loaded = false

	loadAbAsset(var_0_0.GmNameUIPath, true, arg_2_0.onLoadDone, arg_2_0)
end

function var_0_0.onLoadDone(arg_3_0, arg_3_1)
	arg_3_0.assetItem = arg_3_1

	arg_3_0.assetItem:Retain()

	arg_3_0.go = gohelper.clone(arg_3_1:GetResource(), arg_3_0.goContainer)
	arg_3_0.labelText = gohelper.findChildText(arg_3_0.go, "label")
	arg_3_0.labelText.text = ""

	local var_3_0 = arg_3_0.entity:getMO().side

	recthelper.setAnchorY(arg_3_0.go.transform, var_0_0.SideAnchorY[var_3_0] or 0)
	arg_3_0:hide()

	arg_3_0.loaded = true

	arg_3_0:_startStatBuffType()
end

function var_0_0.show(arg_4_0)
	gohelper.setActive(arg_4_0.go, true)
end

function var_0_0.hide(arg_5_0)
	gohelper.setActive(arg_5_0.go, false)
end

function var_0_0.startStatBuffType(arg_6_0, arg_6_1)
	arg_6_0.buffTypeId = arg_6_1

	arg_6_0:_startStatBuffType()
end

function var_0_0._startStatBuffType(arg_7_0)
	if not arg_7_0.loaded then
		return
	end

	if not arg_7_0.buffTypeId then
		return
	end

	arg_7_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_7_0.refreshLabel, arg_7_0)
	arg_7_0:show()
	arg_7_0:refreshLabel()
end

function var_0_0.stopStatBuffType(arg_8_0)
	arg_8_0.buffTypeId = nil

	arg_8_0:hide()
	arg_8_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_8_0.refreshLabel, arg_8_0)
end

function var_0_0.refreshLabel(arg_9_0)
	local var_9_0 = arg_9_0.entity:getMO():getBuffList()
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1:getCO().typeId == arg_9_0.buffTypeId then
			var_9_1 = var_9_1 + 1
		end
	end

	arg_9_0.labelText.text = string.format("%s : %s", arg_9_0.buffTypeId, var_9_1)
end

function var_0_0.onDestroy(arg_10_0)
	removeAssetLoadCb(var_0_0.GmNameUIPath, arg_10_0.onLoadDone, arg_10_0)

	arg_10_0.entity = nil

	if arg_10_0.assetItem then
		arg_10_0.assetItem:Release()
	end
end

return var_0_0
