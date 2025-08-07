module("modules.logic.fight.view.expoint.FightExPointAdrenalineView", package.seeall)

local var_0_0 = class("FightExPointAdrenalineView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.entityMo = arg_1_1
	arg_1_0.entityId = arg_1_1.id
end

var_0_0.AnchorX = 31.3
var_0_0.AnchorY = -21.8

function var_0_0.onInitView(arg_2_0)
	local var_2_0 = arg_2_0.viewGO:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(var_2_0, var_0_0.AnchorX, var_0_0.AnchorY)

	arg_2_0.itemGo = gohelper.findChild(arg_2_0.viewGO, "epiitem")

	gohelper.setActive(arg_2_0.itemGo, false)

	arg_2_0.itemList = {}
	arg_2_0.playingAnimItemList = {}
	arg_2_0.clientAddAdrenaline = 0
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnExpointMaxAdd, arg_5_0.onExPointMaxAdd, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.UpdateExPoint, arg_5_0.clientUpdateExPoint, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnExPointChange, arg_5_0.onServerExPointChange, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_5_0.onPlayHandCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_5_0.onResetCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_5_0.onStageChange, arg_5_0)
	arg_5_0:refreshAdrenaline()
end

function var_0_0.onExPointMaxAdd(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0.entityId then
		return
	end

	arg_6_0:refreshAdrenaline()
end

function var_0_0.clientUpdateExPoint(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0.entityId then
		return
	end

	arg_7_0:refreshAdrenaline()
end

function var_0_0.onStageChange(arg_8_0)
	arg_8_0.clientAddAdrenaline = 0

	arg_8_0:refreshAdrenaline()
end

function var_0_0.onResetCard(arg_9_0)
	arg_9_0.clientAddAdrenaline = 0

	arg_9_0:refreshAdrenaline()
end

local var_0_1 = 100004

function var_0_0.onPlayHandCard(arg_10_0, arg_10_1)
	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Normal then
		return
	end

	if arg_10_1.uid ~= arg_10_0.entityId then
		return
	end

	local var_10_0 = lua_skill.configDict[arg_10_1.skillId]

	if not var_10_0 then
		return
	end

	for iter_10_0 = 1, FightEnum.MaxBehavior do
		local var_10_1 = var_10_0["behavior" .. iter_10_0]

		if not string.nilorempty(var_10_1) then
			local var_10_2 = FightStrUtil.instance:getSplitString2Cache(var_10_1, true)

			for iter_10_1, iter_10_2 in ipairs(var_10_2) do
				if iter_10_2[1] == var_0_1 then
					arg_10_0.clientAddAdrenaline = arg_10_0.clientAddAdrenaline + iter_10_2[2]
				end
			end
		end
	end

	local var_10_3 = arg_10_0.entityMo:getMaxExPoint()
	local var_10_4 = arg_10_0:getCurAdrenaline()
	local var_10_5 = math.min(var_10_3, var_10_4 + arg_10_0.clientAddAdrenaline)

	for iter_10_3 = var_10_4 + 1, var_10_5 do
		local var_10_6 = arg_10_0.itemList[iter_10_3]

		if var_10_6 then
			var_10_6:setActive(true)
			var_10_6:playAnim("add_loop")
		end
	end
end

function var_0_0.onServerExPointChange(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 ~= arg_11_0.entityId then
		return
	end

	if arg_11_2 == arg_11_3 then
		return
	end

	if arg_11_2 < arg_11_3 then
		for iter_11_0 = arg_11_2 + 1, arg_11_3 do
			local var_11_0 = arg_11_0.itemList[iter_11_0]

			if var_11_0 then
				var_11_0:playAnim("open")
			end
		end
	else
		for iter_11_1 = arg_11_3 + 1, arg_11_2 do
			local var_11_1 = arg_11_0.itemList[iter_11_1]

			if var_11_1 then
				var_11_1:playAnim("close")
			end
		end
	end
end

function var_0_0.getCurAdrenaline(arg_12_0)
	return arg_12_0.entityMo.exPoint
end

function var_0_0.refreshAdrenaline(arg_13_0)
	local var_13_0 = arg_13_0.entityMo:getMaxExPoint()
	local var_13_1 = arg_13_0:getCurAdrenaline()

	for iter_13_0 = 1, var_13_0 do
		local var_13_2 = arg_13_0.itemList[iter_13_0] or arg_13_0:createItem()

		var_13_2:setActive(true)
		var_13_2:refresh(iter_13_0, iter_13_0 <= var_13_1)
	end

	for iter_13_1 = var_13_0 + 1, #arg_13_0.itemList do
		arg_13_0.itemList[iter_13_1]:setActive(false)
	end
end

function var_0_0.createItem(arg_14_0)
	local var_14_0 = FightExPointAdrenalineItem.New()

	var_14_0:init(gohelper.cloneInPlace(arg_14_0.itemGo))
	table.insert(arg_14_0.itemList, var_14_0)

	return var_14_0
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0.itemList = nil
end

return var_0_0
