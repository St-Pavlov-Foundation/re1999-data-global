module("modules.logic.survival.view.map.SurvivalInitNpcView", package.seeall)

local var_0_0 = class("SurvivalInitNpcView", SurvivalInitTeamView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_0._root, "Title/txt_Partner/#txt_MemberNum")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0._root, "Scroll View/Viewport/#go_content")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onViewClose, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNPCInTeamChange, arg_2_0._modifyNPCList, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNPCInTeamChange, arg_3_0._modifyNPCList, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._initGroupMo = SurvivalMapModel.instance:getInitGroup()

	arg_4_0:_initNPCItemList()
	arg_4_0:_updateNPCList()
end

function var_0_0.onViewShow(arg_5_0)
	arg_5_0:_updateNPCList()

	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_5_1 = var_5_0.clientData.data.npcCount
	local var_5_2 = arg_5_0._initGroupMo:getCarryNPCCount()

	if var_5_1 ~= var_5_2 then
		var_5_0.clientData.data.npcCount = var_5_2

		var_5_0.clientData:saveDataToServer()
	end
end

function var_0_0._initNPCItemList(arg_6_0)
	if arg_6_0._npcItemList then
		return
	end

	arg_6_0._npcItemList = arg_6_0:getUserDataTb_()

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes.initNpcItem
	local var_6_1 = arg_6_0._initGroupMo:getCarryNPCCount()
	local var_6_2 = math.max(var_6_1, arg_6_0._initGroupMo:getCarryNPCMax())

	for iter_6_0 = 1, var_6_2 do
		local var_6_3 = arg_6_0:getResInst(var_6_0, arg_6_0._gocontent)

		var_6_3.name = "item_" .. tostring(iter_6_0)

		local var_6_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_3, SurvivalInitNPCItem)

		var_6_4:setIndex(iter_6_0)
		var_6_4:setIsLock(var_6_1 < iter_6_0)
		var_6_4:setParentView(arg_6_0)
		table.insert(arg_6_0._npcItemList, var_6_4)
	end
end

function var_0_0._updateNPCList(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = SurvivalShelterModel.instance:getWeekInfo().clientData.data.npcCount
	local var_7_2 = arg_7_0._initGroupMo:getCarryNPCCount()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._npcItemList) do
		if not iter_7_1._isLock then
			local var_7_3 = arg_7_0._initGroupMo.allSelectNpcs[iter_7_0]
			local var_7_4 = arg_7_0._isModify and var_7_3 and iter_7_1:getNpcMo() ~= var_7_3

			iter_7_1:onUpdateMO(var_7_3)
			iter_7_1:setNew(var_7_1 < iter_7_0 and iter_7_0 <= var_7_2)

			if var_7_4 then
				iter_7_1:showSelectEffect()
			end

			if var_7_3 then
				var_7_0 = var_7_0 + 1
			end
		end
	end

	arg_7_0._txtnum.text = string.format("(%d/%d)", var_7_0, arg_7_0._initGroupMo:getCarryNPCCount())

	arg_7_0.viewContainer:setWeightNum()
end

function var_0_0._onViewClose(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.SurvivalNPCSelectView then
		arg_8_0:_modifyNPCList()
	end
end

function var_0_0._modifyNPCList(arg_9_0)
	arg_9_0._isModify = true

	arg_9_0:_updateNPCList()

	arg_9_0._isModify = false
end

return var_0_0
